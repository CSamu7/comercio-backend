<?php
require_once __DIR__ . '/../models/User.php';

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
      $idUsuarios = [];

      $user = new User($data);
      $user->post_user();

      // foreach ($data as $info) {
      //   echo $info;
      //     $user = new User($info["nombre"], $info["apeP"], $info["apeM"], $info["email"], $info["passw"], $info["direc"]);
      //     $resultado = $user->post_user();

      //     if (is_int($resultado)) {
      //         array_push($idUsuarios, $resultado);
      //     } else {
      //         if ($resultado instanceof Exception) {
      //             array_push($errores, ["email" => $info["email"], "msg" => $resultado->getMessage()]);
      //         } else {
      //             array_push($errores, ["email" => $info["email"], "msg" => "Error al crear usuario. Es posible que el correo que ingresaste no se encuentre disponible."]);
      //         }
      //     }
      // }

      // if (!empty($errores)) {
      //     echo json_encode(["errores" => $errores, "id" => $idUsuarios]);
      // } else {
      //     echo json_encode($idUsuarios);
      // }
  } catch (\Throwable $th) {
      echo $th;
      echo json_encode(["msg" => $th->getMessage()]);
  }
  }

  public static function getUser()
  {
    try {
      $token = Flight::request()->header("Authorization");

      if(!$token){
        Flight::jsonHalt([
          "message" => "Token required"
        ], 400);
      }

      $user = User::get_user($token);
      $row = [];

      foreach ($user as $data) {
        $json = new stdClass;
        $json->nombre = $data["nombre"];
        $json->apeP = $data["apeP"];
        $json->apeM = $data["apeM"];
        $json->email = $data["email"];
        $json->direc = $data["direc"];

        array_push($row, $json);
      }

      echo json_encode($row);
    } catch (\Throwable $th) {
      echo json_encode(["msg" => $th->getMessage()]);
    }
  }

}