
<?php
declare(strict_types=1);
require_once __DIR__ . '/../helpers/connection.php';
use Firebase\JWT\JWT;
    
require_once $_SERVER["DOCUMENT_ROOT"] . '/comercio-backend-main/vendor/autoload.php';

class Cart{
    private int $id_usuario;

    public function __construct(int $id_usuario) {
        $this->id_usuario = $id_usuario;
    }
    
    public function getShoppingCart(){
        $db = new Database();
        $connection = $db->connect_to_db();
        $query="SELECT id_carrito, id_usuario, id_prod, cantidad, precio_unitario FROM carrito_compras WHERE id_usuario = ?";

        $stmt = $connection->prepare($query);
        $stmt->execute([this->$id_usuario]);
        $results = $stmt->get_result();

        if($results->num_rows <= 0){
          Flight::jsonHalt(['msg'=>"No existe este usuario"], 400);
        }

        return $results;
    }

    public static function updateCart($cantidad, $id_carrito, $id_prod){
        $query = "UPDATE carrito_compras SET  cantidad = ? WHERE id_carrito= ? AND id_prod= ?";
        
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
        
        $this->updateDB($query, $params);
    }

    function deleteCartItem($id_carrito)
    {
        $query = "DELETE FROM carrito_compras WHERE id_carrito = ?";
        
        $params = array(
            array(
                "param_type" => "i",
                "param_value" => $id_carrito
            )
        );
        
        $this->updateDB($query, $params);
    }

}
