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
        $rows = [];

        foreach ($products as $product) {
            $json = new stdClass;
            $json->nombre = $product["nombre_prod"];
            $json->nombrecorto = $product["nombrecorto_prod"];
            $json->descripcion = $product["descripcion_prod"];
            $json->precio = $product["precio"];
            $json->url_imagen = $product["url_imagen"];
            $json->stock = $product["stock"];
            $json->departamento = $product["nombre_departamento"];
            $json->marca = $product["nombre_marca"];
            $json->descuento = $product["descuento"];

            array_push($rows, $json);
        }

        echo json_encode($rows);
    } catch (\Throwable $th) {
        echo json_encode(["msg" => $th->getMessage()]);
    }
}

  }