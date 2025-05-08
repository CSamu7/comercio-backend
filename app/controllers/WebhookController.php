<?php
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

        print_r($session);
        break;
        default:
        echo 'Received unknown event type ' . $event->type; 
      }
      
    Flight::response()->status(200);
  }
}