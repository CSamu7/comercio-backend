<?php
require_once __DIR__ . '/../models/cart.php';

class ShoppingCartController
{
  public static function getShoppingCart(){
    try {
      $id_user = Flight::request()->data->id_user;

      $cart = new Cart();
      
      echo json_encode(["token" => $token]);
    } catch (\Throwable $th) {
      echo json_encode(["msg" => $th->getMessage()]);
    }
  }

  public static function postUser()
{
    try {
        $data = Flight::request()->data;

        // Validación del correo electrónico
        $email = filter_var($data->email, FILTER_VALIDATE_EMAIL);
        if (!$email) {
            Flight::jsonHalt(['msg' => "Correo inválido"], 400);
        }

        $user = new User($data);
        $response = $user->post_user();

        echo json_encode(["id" => $response]);
    } catch (\Throwable $th) {
        echo json_encode(["msg" => $th->getMessage()]);
    }
}
}