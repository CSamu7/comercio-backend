<?php
require_once __DIR__ . '/../models/Product.php';

class ProductController
{
  public static function getProduct(int $id_prod)
  {
    try {
      $product = Product::get_product($id_prod);
      $row = [];

      foreach ($product as $data) {
        $json = new stdClass;
        $json->nombre_prod = $data["nombre_prod"];
        $json->nombrecorto_prod = $data["nombrecorto_prod"];
        $json->descripcion_prod = $data["descripcion_prod"];
        $json->precio = $data["precio"];
        $json->url_imagen = $data["url_imagen"];
        $json->stock = $data["stock"];
        $json->id_departamento = $data["id_departamento"];
        $json->id_marca = $data["id_marca"];
        $json->id_oferta = $data["id_oferta"];

        array_push($row, $json);
      }

      echo json_encode($row);
    } catch (\Throwable $th) {
      echo json_encode(["msg" => $th->getMessage()]);
    }
  }

  public static function getProducts()
  {
      try {
          $products = Product::get_products();
          echo json_encode($products);
      } catch (\Throwable $th) {
          echo json_encode(["msg" => $th->getMessage()]);
      }
  }
  }