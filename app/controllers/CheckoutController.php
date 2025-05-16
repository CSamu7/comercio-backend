<?php
require_once $_SERVER["DOCUMENT_ROOT"] . '/backend/vendor/autoload.php';
require_once __DIR__ . '/../helpers/token.php';

class CheckoutController
{
  public function createCheckout()
  {
    $token = Flight::request()->header("Authorization");
    $token_decoded = Token::decode_token($token);
    $id_user = $token_decoded->id;

    $shoppingCart = Flight::request()->data;
    Stripe\Stripe::setApiKey($_ENV["STRIPE_SECRET_KEY"]);

    try {
      $line_items = $this->createLineItems($shoppingCart);

      $checkout_session = \Stripe\Checkout\Session::create([
        "mode" => "payment",
        "success_url" => "http://localhost:5173/payment-success",
        "line_items" => $line_items,
        "metadata" => [
          "id_user" => $id_user
        ]
      ]);

      echo json_encode($checkout_session);
    } catch (\Throwable $th) {
      echo json_encode(["msg" => $th->getMessage()]);
    }
  }

  private function createLineItems($shoppingItems){
    $line_items = [];

    foreach($shoppingItems as $shoppingItem){
      $item = [
        "quantity" => $shoppingItem["cantidad"],
        "price_data" => [
          "currency" => "mxn",
          "unit_amount" => $shoppingItem["precio"] * 100,
          "product_data" => [
            "name" => $shoppingItem["nombre"],
            "metadata" => ["id" => $shoppingItem["id_prod"]]
          ]
        ],
      ];

      array_push($line_items, $item);
    }

    return $line_items;
  }
}