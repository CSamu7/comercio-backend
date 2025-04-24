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

    public static function updateCartItem()
    {
        try {
            $data = Flight::request()->data;

            $id_user = $data->id_user ?? null;
            $id_carrito = $data->id_carrito ?? null;
            $id_prod = $data->id_prod ?? null;
            $cantidad = $data->cantidad ?? null;

            if (!is_numeric($id_user) || !is_numeric($id_carrito) || !is_numeric($id_prod) || !is_numeric($cantidad)) {
                Flight::jsonHalt(['msg' => "Datos inválidos o incompletos"], 400);
            }

            $cart = new Cart((int)$id_user);
            $result = $cart->updateCart((int)$cantidad, (int)$id_carrito, (int)$id_prod);

            echo json_encode([
                "success" => $result,
                "msg" => $result ? "Cantidad actualizada correctamente" : "Error al actualizar cantidad"
            ]);
        } catch (\Throwable $th) {
            echo json_encode([
                "success" => false,
                "msg" => $th->getMessage()
            ]);
        }
    }

    public static function deleteCartItem()
    {
        try {
            $data = Flight::request()->data;

            $id_user = $data->id_user ?? null;
            $id_carrito = $data->id_carrito ?? null;
            $id_prod = $data->id_prod ?? null;

            if (!is_numeric($id_user) || !is_numeric($id_carrito) || !is_numeric($id_prod)) {
                Flight::jsonHalt(['msg' => "Datos inválidos o incompletos"], 400);
            }

            $cart = new Cart((int)$id_user);
            $result = $cart->deleteCartItem((int)$id_carrito, (int)$id_prod);

            echo json_encode([
                "success" => $result,
                "msg" => $result ? "Producto eliminado correctamente" : "Error al eliminar producto"
            ]);
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

            echo json_encode([
                "success" => $result,
                "msg" => $result ? "Carrito vaciado correctamente" : "Error al vaciar carrito"
            ]);
        } catch (\Throwable $th) {
            echo json_encode([
                "success" => false,
                "msg" => $th->getMessage()
            ]);
        }
    }
}