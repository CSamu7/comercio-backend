<?php 
require_once __DIR__ . '/../models/Sale.php';
require_once __DIR__ . '/../helpers/token.php';

class SaleController{
  public function createSale(){
    //Middleware
    $token = Flight::request()->header("Authorization");
    $token_decoded = Token::decode_token($token);
    $id_user = $token_decoded->id;
    
    $products = Flight::request()->data->products;
    $total = array_reduce($products, function($acc, $product){
      $acc += $product["cantidad"] * $product["precio"];
      return $acc;
    });

    try {
      $sale = new Sale($id_user);
      $sale->createSale($total);

      Flight::response()->status(200);
      echo json_encode(["msg"=>"Todo bien"]);
    } catch (\Throwable $th) {
      echo json_encode(["msg" => $th->getMessage()]);
    }
  }

  public function processSale($id_user, $total){
    $updatedSale = [
      "total" => $total,
      "sale_date" => date("Y-m-d"),
      "delivery_date" => date("Y-m-d", mktime(0,0,0, date("m"), date("d") + 7, date("y"))),
      "status" => "Completado"
    ];

    $sale = new Sale($id_user);
    $sale->updateSale($updatedSale);
  }
  
  public function createSaleDetails($id_sale, $products){
    $sale = new Sale($id_user);
    $sale->createSaleDetails($id_sale, $products);

  }

}