<?php

declare(strict_types=1);
require_once __DIR__ . '/../helpers/connection.php';
use Firebase\JWT\JWT;

require_once 'C:/xampp/htdocs/comercio-backend/vendor/autoload.php';

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

      $stmt = $connection->prepare("SELECT * FROM usuario WHERE email = ? and passw = ?");
      $stmt->execute([$email, $passw]);
      $results = $stmt->get_result();

      $id_usuario = "";

      while($row = $results->fetch_row()){
        $id_usuario = $row[0];
      }

      print_r($id_usuario);

      $key = 'saliocabronelyk';
    
      $payload = [
        "email" => $email,
        "id" => $id_usuario,
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

      $stmt = $connection->prepare("SELECT COUNT(*) as count FROM usuario WHERE email = ?");
        $stmt->bind_param("s", $this->email);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        if ($row['count'] > 0) {
            throw new Exception("El email ya está en uso");
        }

      $stmt = $connection->prepare("INSERT INTO usuario(nombre, apeP, apeM, email, passw, direc) VALUES (?, ?, ?, ?, ?, ?)");
      $stmt->execute([$this->nombre, $this->apeP, $this->apeM, $this->email, $this->passw, $this->direc]);
      $result = $stmt->insert_id;
      return $result;
    } catch (\Throwable $th) {
      return $th;
    }
  }

  public static function get_user(string $token): array
{
    try {
        $key = 'saliocabronelyk';
        $decoded = JWT::decode($token, $key, ["HS256"]);
        $id_usuario = $decoded->id;

        $db = new Database();
        $connection = $db->connect_to_db();

        $stmt = $connection->prepare("SELECT * FROM usuario WHERE id = ?");
        $stmt->bind_param("i", $id_usuario);
        $stmt->execute();
        $result = $stmt->get_result();

        $rows = [];

        foreach ($result as $user) {
            array_push($rows, $user);
        }

        return $rows;
    } catch (\Throwable $th) {
        print_r($th);
        return [];
    }
}

}