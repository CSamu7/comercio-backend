<?php

declare(strict_types=1);
require_once __DIR__ . '/../helpers/connection.php';
use Firebase\JWT\JWT;

require_once $_SERVER["DOCUMENT_ROOT"] . '/backend/vendor/autoload.php';

class Product
{
  public function __construct(
    private string $nombre,
    private string $nombrecorto,
    private string $descripcion,
    private int $precio,
    private string $url_imagen,
    private int $stock,
    private int $id_departamento,
    private int $id_marcha,
    private int $id_oferta,
  ) {
  }

  public static function get_product(int $id): array
{
    $db = new Database();
    $connection = $db->connect_to_db();
    $rows = [];

    $stmt = $connection->prepare("
        SELECT 
            p.id_prod,
            p.nombre_prod, 
            p.nombrecorto_prod, 
            p.descripcion_prod, 
            p.precio, 
            p.url_imagen, 
            p.stock, 
            d.nombre_departamento AS nombre_departamento, 
            m.nombre_marca AS nombre_marca, 
            o.descuento AS descuento,
            COALESCE(r.rating_promedio, 0) AS rating
        FROM 
            producto p
        INNER JOIN 
            departamento d ON p.id_departamento = d.id_departamento
        INNER JOIN 
            marca m ON p.id_marca = m.id_marca
        LEFT JOIN
            oferta o ON p.id_oferta = o.id_oferta
        LEFT JOIN 
            (
                SELECT 
                    id_prod,
                    AVG(punt) AS rating_promedio
                FROM 
                    reseña
                GROUP BY 
                    id_prod
            ) r ON p.id_prod = r.id_prod
        WHERE 
            p.id_prod = ?
    ");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();

    foreach ($result as $product) {
        array_push($rows, $product);
    }

    return $rows;
}


  public static function get_products(): array
  {
    $db = new Database();
    $connection = $db->connect_to_db();
    $rows = [];

    $stmt = $connection->prepare("
        SELECT 
            p.id_prod,
            p.nombre_prod, 
            p.nombrecorto_prod, 
            p.descripcion_prod, 
            p.precio, 
            p.url_imagen, 
            p.stock, 
            d.nombre_departamento AS nombre_departamento, 
            m.nombre_marca AS nombre_marca, 
            o.descuento AS descuento,
            COALESCE(r.rating_promedio, 0) AS rating
        FROM 
            producto p
        INNER JOIN 
            departamento d ON p.id_departamento = d.id_departamento
        INNER JOIN 
            marca m ON p.id_marca = m.id_marca
        LEFT JOIN
            oferta o ON p.id_oferta = o.id_oferta
        LEFT JOIN 
            (
                SELECT 
                    id_prod,
                    AVG(punt) AS rating_promedio
                FROM 
                    reseña
                GROUP BY 
                    id_prod
            ) r ON p.id_prod = r.id_prod
    ");
    $stmt->execute();
    $result = $stmt->get_result();

    foreach ($result as $product) {
        array_push($rows, $product);
    }

    return $rows;
  }
}