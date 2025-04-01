<?php
require_once __DIR__ . '/../models/Product.php';

class ProductController
{
  public static function getProduct(int $id)
  {
    try {
      $product = Product::get_product($id);
      $row = [];

      foreach ($product as $data) {
        $json = new stdClass;
        $json->nombre = $data["nombre_prod"];
        $json->nombrecorto = $data["nombrecorto_prod"];
        $json->descripcion = $data["descripcion_prod"];
        $json->precio = $data["precio"];
        $json->url_imagen = $data["url_imagen"];
        $json->stock = $data["stock"];
        $json->departamento = $data["nombre_departamento"];
        $json->marca = $data["nombre_marca"];
        $json->descuento = $data["descuento"];

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