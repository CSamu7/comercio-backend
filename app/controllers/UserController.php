<?php
require_once $_SERVER["DOCUMENT_ROOT"] . "/backend/app/models/User.php";

class UserController
{
  public static function authUser(){
    try {
      $email = Flight::request()->data->email;
      $passw = Flight::request()->data->passw;

      $token = User::auth_user($email, $passw);

      echo json_encode(["token" => $token]);
    } catch (\Throwable $th) {
      echo json_encode(["msg" => $th->getMessage()]);
    }
  }

  public static function postUser()
  {
    try {
      $data = Flight::request()->data;
      $idClients = [];

      foreach ($data as $info) {
        $user = new User($info["nombre"], $info["apeP"], $info["apeM"], $info["email"], $info["passw"], $info["direc"]);
        array_push($idClients, $user->post_user());
      }

      echo json_encode($idClients);
    } catch (\Throwable $th) {
      echo json_encode(["msg" => $th]);
    }
  }
}