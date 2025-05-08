<?php
require_once __DIR__ . '/../models/cart.php';
require_once __DIR__ . '/../helpers/token.php';

class ShoppingCartController{
  public function getShoppingCart($id_user){
    try {
      $user_cart = [];

      $cart = new Cart((int) $id_user);
      $products = $cart->getShoppingCart();

      foreach ($products as $product) {
        array_push($user_cart, $product);
      }
      
      echo json_encode($user_cart);
    } catch (\Throwable $th) {
      echo json_encode(["msg" => $th->getMessage()]);
    }
  }

    public function addCartItem(){
        try {
            $token = Flight::request()->header("Authorization");
            $data = Flight::request()->data;
            $id_prod = $data->id_prod ?? null;
            $cantidad = $data->cantidad ?? null;

            $token_decoded = Token::decode_token($token);
            $id_user = $token_decoded->id;
            
            $cart = new Cart($id_user);
            $result = $cart->addCartItem((int)$id_prod, (int)$cantidad);

            echo json_encode($result);
        } catch (\Throwable $th) {
            echo json_encode([
                "success" => false,
                "msg" => $th->getMessage()
            ]);
        }
    }

    public function updateCartItem($id_user)
    {
        try {
            $id_prod = Flight::request()->data->id_prod;
            $cantidad = Flight::request()->data->cantidad;

            $cart = new Cart($id_user);
            $result = $cart->updateCart($cantidad, $id_prod);

            echo json_encode($result);
        } catch (\Throwable $th) {
            echo json_encode([
                "success" => false,
                "msg" => $th->getMessage()
            ]);
        }
    }

    public function deleteCartItem()
    {
        try {
            $token = Flight::request()->header("Authorization");
            $data = Flight::request()->data;
            $token_decoded = Token::decode_token($token);
            $id_user = $token_decoded->id;

            $id_prod = Flight::request()->data->id_prod;

            $cart = new Cart($id_user);
            $result = $cart->deleteCartItem($id_prod);

            echo json_encode($result);
        } catch (\Throwable $th) {
            echo json_encode([
                "success" => false,
                "msg" => $th->getMessage()
            ]);
        }
    }

    public function clearCart()
    {
        try {
            $data = Flight::request()->data;

            $id_user = $data->id_user ?? null;
            $id_carrito = $data->id_carrito ?? null;

            if (!is_numeric($id_user) || !is_numeric($id_carrito)) {
                Flight::jsonHalt(['msg' => "Datos inválidos o incompletos"], 400);
            }

            $cart = new Cart((int)$id_user);
            $result = $cart->clearCart((int)$id_carrito);

            echo json_encode($result);
        } catch (\Throwable $th) {
            echo json_encode([
                "success" => false,
                "msg" => $th->getMessage()
            ]);
        }
    }
}