<?php
require_once __DIR__ . '/../models/cart.php';

class ShoppingCartController
{
  public static function getShoppingCart($id_user){
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

  public static function addCartItem()
    {
        try {
            $data = Flight::request()->data;

            $id_user = $data->id_user ?? null;
            $id_carrito = $data->id_carrito ?? null;
            $id_prod = $data->id_prod ?? null;
            $cantidad = $data->cantidad ?? null;
            $precio_unitario = $data->precio_unitario ?? null;

            if (!is_numeric($id_user) || !is_numeric($id_carrito) || !is_numeric($id_prod) || !is_numeric($cantidad) || !is_numeric($precio_unitario)) {
                Flight::jsonHalt(['msg' => "Datos inválidos o incompletos"], 400);
            }

            $cart = new Cart((int)$id_user);
            $result = $cart->addCartItem((int)$id_carrito, (int)$id_prod, (int)$cantidad, (float)$precio_unitario);

            echo json_encode([
                "success" => $result,
                "msg" => $result ? "Producto agregado correctamente" : "Error al agregar producto"
            ]);
        } catch (\Throwable $th) {
            echo json_encode([
                "success" => false,
                "msg" => $th->getMessage()
            ]);
        }
    }

    public static function updateCartItem($id_user)
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

    public static function deleteCartItem($id_user)
    {
        try {
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

    public static function clearCart()
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