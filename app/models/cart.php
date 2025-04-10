<?php
    declare(strict_types=1);
    require_once __DIR__ . '/../helpers/connection.php';
    use Firebase\JWT\JWT;
    
    require_once $_SERVER["DOCUMENT_ROOT"] . '/comercio-backend-main/vendor/autoload.php';

class cart{
    private int $id_carrito;
    private int $id_usuario;
    private int $id_prod;
    private int $cantidad;
    private float $precio_unitario;

    public function __construct(object $data,) {
        $this->id_carrito = $data["id_carrito"];
        $this->id_usuario = $data["id_usuario"];
        $this->id_prod = $data["id_prod"];
        $this->cantidad = $data["cantidad"];
        $this->precio_unitario = $data["precio_unitario"];
      }
    
    public static function get_products($product_id){
        $db = new Database();
        $connection = $db->connect_to_db();
        $stmt = $connection->prepare("SELECT ID_CARRITO, ID_USUARIO, ID_PROD, CANTIDAD, PRECIO_UNITARIO FROM CARRITO_COMPRAS WHERE id_prod= ?");
        $params = array(
            array(
                "param_type" => "i",
                "param_value" => $product_id
            )
        );
        $stmt->execute([$this->product_id]);
        $cartResult = $stmt->get_result();
        return $cartResult;
    }

    public static function updateCart($cantidad, $id_carrito, $id_prod){
        $db = new Database();
        $connection = $db->connect_to_db();
        $stmt = $connection->prepare("UPDATE carrito_compras SET  cantidad = ? WHERE id_carrito= ? AND id_prod= ?");
        
        $params = array(
            array(
                "param_type" => "i",
                "param_value" => $cantidad
            ),
            array(
                "param_type" => "i",
                "param_value" => $id_carrito
            ),
            array(
                "param_type" => "i",
                "param_value" => $id_prod
            )
        );
        $stmt->execute();
        
    }

    function deleteCartItem($id_carrito)
    {
        $db = new Database();
        $connection = $db->connect_to_db();
        $stmt = $connection->prepare("DELETE FROM carrito_compras WHERE id_carrito = ?");
        
        $params = array(
            array(
                "param_type" => "i",
                "param_value" => $id_carrito
            )
        );
        
        $stmt->execute();
    }

}
