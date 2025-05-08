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

        $query = "SELECT p.nombre_prod AS nombre, p.id_prod, p.precio, p.url_imagen,p.stock, c.cantidad
                  FROM carrito c
                  INNER JOIN 
                  producto p ON p.id_prod = c.id_producto
                  WHERE c.id_usuario = ?" ;

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
        $rows = [];

        $query = "UPDATE carrito SET cantidad = ? WHERE id_usuario = ? AND id_producto = ?";
        $stmt = $this->connection->prepare($query);
        $stmt->bind_param("iii", $cantidad, $this->id_usuario, $id_prod);
        $stmt->execute();

        $rows = $this->getShoppingCart();

        return $rows;
    }

    public function deleteCartItem($id_prod) {
        $query = "DELETE FROM carrito WHERE id_usuario = ? AND id_producto = ?";
        $stmt = $this->connection->prepare($query);
        $stmt->bind_param("ii", $this->id_usuario, $id_prod);
        $stmt->execute();
        $result = $stmt->get_result();

        $rows = $this->getShoppingCart();

        return $rows;
    }
    
    public function addCartItem($id_prod, $cantidad) {
        $checkQuery = "SELECT cantidad FROM carrito WHERE id_usuario = ? AND id_producto = ?";
        $stmt = $this->connection->prepare($checkQuery);
        $stmt->bind_param("ii", $this->id_usuario, $id_prod);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $nuevaCantidad = $row['cantidad'] + $cantidad;

            $rows = $this->updateCart($nuevaCantidad, $id_prod);
            return $rows;
        } 
        
        $insertQuery = "INSERT INTO carrito (id_usuario, id_producto, cantidad) VALUES (?, ?, ?)";
        $stmtInsert = $this->connection->prepare($insertQuery);
        $stmtInsert->bind_param("iii", $this->id_usuario, $id_prod, $cantidad);
        
        return $stmtInsert->execute();
    }

    public function clearCart($id_carrito, $id_usuario) {
        $query = "DELETE FROM carrito WHERE id_usuario = ?";
        $stmt = $this->connection->prepare($query);
        $stmt->bind_param("ii", $id_carrito, $id_usuario);
        return $stmt->execute();
    }

    private function isProductInCart(){
        
    }
}
