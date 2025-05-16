<?php
require_once __DIR__ . '/../helpers/connection.php';

class Sale{
    private int $id_usuario;
    private $connection;

    public function __construct(int $id_usuario) {
        $this->id_usuario = $id_usuario;
        $db = new Database();
        $this->connection = $db->connect_to_db();
    }

    public function createSale($total){
      $rows = [];
      $query = "INSERT INTO venta(id_usuario, estatus, total) VALUES (?, ?, ?)";

      $stmt = $this->connection->prepare($query);
      $stmt->execute([$this->id_usuario, 'Procesando', $total]);
      $results = $stmt->get_result();
    }

    public function updateSale($updatedSale){
      $id_sale = $this->findSale($this->id_usuario, $updatedSale["total"]);
      
      $rows = [];
      $query = "UPDATE venta 
                SET fecha_venta = ?, 
                fecha_entrega = ?,
                estatus = 'Completado'
                WHERE id_venta = ?";
      
      $stmt = $this->connection->prepare($query);
      $stmt->execute([$updatedSale["sale_date"], $updatedSale["delivery_date"], $id_sale]);
      $results = $stmt->get_result();

      return $id_sale;
    }

    public function findSale($id_usuario, $total){
      $query = "SELECT * FROM `venta` WHERE id_usuario = ? AND total = ? AND estatus = 'Procesando' ORDER BY id_venta DESC";

      $stmt = $this->connection->prepare($query);
      $stmt->execute([$this->id_usuario, $total]);
      $results = $stmt->get_result();

      $row = $results->fetch_array(MYSQLI_NUM);

      return $row[0];
    }

    public function createSaleDetails($id_sale, $product){
      $query = "INSERT INTO detalles_venta(id_venta, id_producto, id_cantidad, total) VALUES (?, ?, ?, ?)";

      foreach ($products as $key => $product) {
        $stmt = $this->connection->prepare($query);
        $stmt->execute([$this->id_usuario, $total]);
        $results = $stmt->get_result();
      }
    }
}