
<?php
declare(strict_types=1);
require_once __DIR__ . '/../helpers/connection.php';
use Firebase\JWT\JWT;
    
require_once $_SERVER["DOCUMENT_ROOT"] . '/comercio-backend-main/vendor/autoload.php';

class Cart{
    private int $id_usuario;
    private $connection;

    public function __construct(int $id_usuario) {
        $this->id_usuario = $id_usuario;
        $db = new Database();
        $this->connection = $db->connect_to_db();
    }
    
    public function getShoppingCart(): array {
        $query = "SELECT id_carrito, id_prod, cantidad, precio_unitario 
                  FROM carrito_compras 
                  WHERE id_usuario = ?";
        
        $stmt = $this->connection->prepare($query);
        if (!$stmt) {
            throw new Exception("Error preparando la consulta: " . $this->connection->error);
        }
    
        $stmt->bind_param("i", $this->id_usuario);
        $stmt->execute();
        $result = $stmt->get_result();
    
        return $result->fetch_all(MYSQLI_ASSOC);
    }

    public function updateCart($cantidad, $id_carrito, $id_usuario, $id_prod) {
        $query = "UPDATE carrito_compras SET cantidad = ? WHERE id_carrito = ? AND id_usuario = ? AND id_prod = ?";
        $stmt = $this->connection->prepare($query);
        $stmt->bind_param("iiii", $cantidad, $id_carrito, $id_usuario, $id_prod);
        return $stmt->execute();
    }

    public function deleteCartItem($id_carrito, $id_usuario, $id_prod) {
        $query = "DELETE FROM carrito_compras WHERE id_carrito = ? AND id_usuario = ? AND id_prod = ?";
        $stmt = $this->connection->prepare($query);
        $stmt->bind_param("iii", $id_carrito, $id_usuario, $id_prod);
        return $stmt->execute();
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
