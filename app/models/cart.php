<?php

declare(strict_types=1);
require_once __DIR__ . '/../helpers/connection.php';
use Firebase\JWT\JWT;
    
require_once $_SERVER["DOCUMENT_ROOT"] . '/backend/vendor/autoload.php';

class Cart{
    private int $id_usuario;
    private $connection;

    public function __construct(int $id_usuario) {
        $this->id_usuario = $id_usuario;
        $db = new Database();
        $this->connection = $db->connect_to_db();
    }
    
    public function getShoppingCart(): array {
        $rows = [];

        $query = "SELECT c.id_prod, c.cantidad, p.precio, p.nombre_prod AS nombre, p.precio, p.url_imagen,p.stock
                  FROM carrito_compras c
                  INNER JOIN 
                  producto p ON c.id_prod = p.id_prod
                  WHERE id_usuario = ?" ;

        $stmt = $this->connection->prepare($query);
        $stmt->execute([$this->id_usuario]);
    
        if (!$stmt) {
            throw new Exception("Error preparando la consulta: " . $this->connection->error);
        }
    
        $shopping_cart = $stmt->get_result();

        foreach ($shopping_cart as $product) {
            array_push($rows, $product);
        }

        return $rows;
    }

    public function updateCart($cantidad, $id_prod) {
        //No esta checando el stack
        $rows = [];

        $query = "UPDATE carrito_compras SET cantidad = ? WHERE id_usuario = ? AND id_prod = ?";
        $stmt = $this->connection->prepare($query);
        $stmt->bind_param("iii", $cantidad, $this->id_usuario, $id_prod);
        $stmt->execute();

        $rows = $this->getShoppingCart();

        return $rows;
    }

    public function deleteCartItem($id_prod) {
        $query = "DELETE FROM carrito_compras WHERE id_usuario = ? AND id_prod = ?";
        $stmt = $this->connection->prepare($query);
        $stmt->bind_param("ii", $this->id_usuario, $id_prod);
        $stmt->execute();

        $rows = $this->getShoppingCart();

        return $rows;
    }
    
    public function addCartItem($id_carrito, $id_usuario, $id_prod, $cantidad, $precio_unitario) {
        $checkQuery = "SELECT cantidad FROM carrito_compras WHERE id_carrito = ? AND id_usuario = ? AND id_prod = ?";
        $stmt = $this->connection->prepare($checkQuery);
        $stmt->bind_param("iii", $id_carrito, $id_usuario, $id_prod);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $nuevaCantidad = $row['cantidad'] + $cantidad;

            $updateQuery = "UPDATE carrito_compras SET cantidad = ?, precio_unitario = ? WHERE id_carrito = ? AND id_usuario = ? AND id_prod = ?";
            $stmtUpdate = $this->connection->prepare($updateQuery);
            $stmtUpdate->bind_param("diiii", $nuevaCantidad, $precio_unitario, $id_carrito, $id_usuario, $id_prod);
            return $stmtUpdate->execute();
        } else {
            $insertQuery = "INSERT INTO carrito_compras (id_carrito, id_usuario, id_prod, cantidad, precio_unitario) VALUES (?, ?, ?, ?, ?)";
            $stmtInsert = $this->connection->prepare($insertQuery);
            $stmtInsert->bind_param("iiiid", $id_carrito, $id_usuario, $id_prod, $cantidad, $precio_unitario);
            return $stmtInsert->execute();
        }
    }

    public function clearCart($id_carrito, $id_usuario) {
        $query = "DELETE FROM carrito_compras WHERE id_carrito = ? AND id_usuario = ?";
        $stmt = $this->connection->prepare($query);
        $stmt->bind_param("ii", $id_carrito, $id_usuario);
        return $stmt->execute();
    }

}
