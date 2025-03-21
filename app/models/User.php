<?php

declare(strict_types=1);
require_once $_SERVER["DOCUMENT_ROOT"] . "/backend/app/helpers/connection.php";
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class User
{

  public function __construct(
    private string $nombre,
    private string $apeP,
    private string $apeM,
    private string $email,
    private string $passw,
    private string $direc,
  ) {
  }

  public static function auth_user(string $email, string $passw) {
    try {
      $db = new Database();
      $connection = $db->connect_to_db();
      
      $e = $email;
      $p = $passw;

      $stmt = $connection->prepare("SELECT email, passw FROM usuario WHERE email = ? and passw = ?");
      $stmt->execute([$email, $passw]);
      $result = $stmt->id_usuario;

      $key = 'saliocabronelyk';
    
      $payload = [
        "email" => $email,
        "id" => $result
      ];

      $jwt = JWT::encode($payload, $key, "HS256");

      return $jwt;
    } catch (\Throwable $th) {
      print_r($th);
      return $th;
    }
  }

  public function post_user(): int
  {
    try {
      $db = new Database();
      $connection = $db->connect_to_db();

      $stmt = $connection->prepare("INSERT INTO usuario(nombre_Cliente, apellidos_Cliente, curp, telefono, direccion) VALUES (?, ?, ?, ?, ?)");
      $stmt->execute([$this->name, $this->lastname, $this->curp, $this->phoneNumber, $this->address]);
      $result = $stmt->insert_id;
      return $result;
    } catch (\Throwable $th) {
      return $th;
    }
  }

  public static function get_user(string $email): array
  {
    $db = new Database();
    $connection = $db->connect_to_db();
    $rows = [];

    $stmt = $connection->prepare("SELECT * FROM Cliente WHERE email = ?");
    $stmt->bind_param("d", $id_user);
    $stmt->execute();
    $result = $stmt->get_result();

    foreach ($result as $user) {
      array_push($rows, $user);
    }

    return $rows;
  }
}