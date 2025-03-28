<?php

declare(strict_types=1);
require_once __DIR__ . '/../helpers/connection.php';
use Firebase\JWT\JWT;

require_once 'C:/xampp/htdocs/comercio-backend/vendor/autoload.php';

class Product
{

  public function __construct(
    private string $nombre_prod,
    private string $nombrecorto_prod,
    private string $descripcion_prod,
    private int $precio,
    private string $url_imagen,
    private int $stock,
    private int $id_departamento,
    private int $id_marcha,
    private int $id_oferta,
  ) {
  }

  public static function get_product(int $id_prod): array
  {
    $db = new Database();
    $connection = $db->connect_to_db();
    $rows = [];

    $stmt = $connection->prepare("SELECT * FROM producto WHERE id_prod = ?");
    $stmt->bind_param("i", $id_prod);
    $stmt->execute();
    $result = $stmt->get_result();

    foreach ($result as $product) {
      array_push($rows, $product);
    }

    return $rows;
  }
}