<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/backend/vendor/autoload.php';


class CheckoutController
{
  public function createCheckout()
  {
    $shoppingCart = Flight::request()->data->shoppingCart;
    Stripe\Stripe::setApiKey($_ENV["STRIPE_SECRET_KEY"]);

    try {
      $line_items = $this->createLineItems($shoppingCart);

      $checkout_session = \Stripe\Checkout\Session::create([
        "mode" => "payment",
        "success_url" => "http://localhost:5173/payment-success",
        "line_items" => $line_items
      ]);

      echo json_encode($checkout_session);
    } catch (\Throwable $th) {
      echo json_encode(["msg" => $th->getMessage()]);
    }
  }

  public function createLineItems($shoppingItems){
    $line_items = [];

    foreach($shoppingItems as $shoppingItem){
      $item = [
        "quantity" => $shoppingItem["cantidad"],
        "price_data" => [
          "currency" => "mxn",
          "unit_amount" => $shoppingItem["precio"] * 100,
          "product_data" => [
            "name" => $shoppingItem["nombre"]
          ]
        ]
      ];

      array_push($line_items, $item);
    }

    return $line_items;
  }
}