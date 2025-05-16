<?php
require_once __DIR__ . '/SaleController.php';

class WebhookController {
  public function observeEvent(){
    $stripe = new \Stripe\StripeClient($_ENV["STRIPE_SECRET_KEY"]);

    $body = Flight::request()->getBody();
    $event = null;

    try{
      $event = \Stripe\Event::constructFrom(
        json_decode($body, true)
      );
    }catch(\UnexpectedValueException $e){
      Flight::response()->status(400);
    }

    switch($event->type){
      case 'checkout.session.completed':
        $session = $stripe->checkout->sessions->retrieve(
          $event->data->object->id,
          ['expand' => ["line_items.data.price.product"]]
        );

        $total = $event->data->object->amount_total / 100;
        $id_user = $event->data->object->metadata->id_user;

        $sale = new SaleController();
        $id_sale = $sale->processSale((int) $id_user, $total);
        // $sale->createSaleDetails($id_sale, $session->line_items->data);

      case 'checkout.session.expired':

        break;
        default:
          echo 'Received unknown event type ' . $event->type; 
    }
      
    Flight::response()->status(200);
  }
}