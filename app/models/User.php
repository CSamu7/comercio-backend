<?php
declare(strict_types=1);
require_once __DIR__ . '/../helpers/connection.php';
require_once __DIR__ . '/../helpers/token.php';

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

require_once $_SERVER["DOCUMENT_ROOT"] . '/backend/vendor/autoload.php';

class User
{
  private string $nombre;
  private string $apeP;
  private string $apeM;
  private string $email;
  private string $passw;
  private string $direc;

  public function __construct(
    object $data,
  ) {
    $this->nombre = $data["nombre"];
    $this->apeP = $data["apeP"];
    $this->apeM = $data["apeM"];
    $this->email = $data["email"];
    $this->passw = $data["passw"];
    $this->direc = $data["direc"];
  }

  public static function auth_user(string $email, string $passw) {
    try {
      $db = new Database();
      $connection = $db->connect_to_db();

      $stmt = $connection->prepare("SELECT * FROM usuario WHERE email = ? and passw = ?");
      $stmt->execute([$email, $passw]);
      $results = $stmt->get_result();

      if($results->num_rows <= 0){
        Flight::jsonHalt(['msg'=>"Contraseña/Correo incorrectos"], 400);
      }

      $id_usuario = "";

      while($row = $results->fetch_row()){
        $id_usuario = $row[0];
      }

      $key = 'ykesuncabron';
    
      $payload = [
        "email" => $email,
        "id" => $id_usuario,
      ];

      $jwt = JWT::encode($payload, $key, "HS256");

      return $jwt;
    } catch (\Throwable $th) {
      throw $th;
    }
  }

  private function is_email_available($connection): bool {
    $stmt = $connection->prepare("SELECT email FROM usuario WHERE email = ?");
    $stmt->execute([$this->email]);
    $result = $stmt->get_result();
  
    return $result->num_rows > 0;
  }

  public function post_user(): int
  {
      $db = new Database();
      $connection = $db->connect_to_db();
      
      if(!is_email_available($connection)){
        Flight::jsonHalt(['msg'=>"Este correo no esta disponible"], 409);
      }

      $stmt = $connection->prepare("INSERT INTO usuario(nombre, apeP, apeM, email, passw, direc) VALUES (?, ?, ?, ?, ?, ?)");
      $stmt->execute([$this->nombre, $this->apeP, $this->apeM, $this->email, $this->passw, $this->direc]);
      $result = $stmt->insert_id;
      return $result;
  }

  public static function get_user(string $token): array
  {
    $decoded = Token::decode_token($token);

    $db = new Database();
    $connection = $db->connect_to_db();
    $rows = [];

    $stmt = $connection->prepare("SELECT * FROM usuario WHERE email = ?");
    $stmt->execute([$decoded->email]);
    $result = $stmt->get_result();

        foreach ($result as $user) {
            array_push($rows, $user);
        }

        return $rows;
    }
}