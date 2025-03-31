<?php
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class Token{
  public static function encode_token(array $payload){
    $key = 'ykesuncabron'; //Sacar llave del .env
  
    $jwt = JWT::encode($payload, $key, "HS256");
  }

  public static function decode_token(string $token){
    try {
      $split_token = explode(" ", $token);
      $jwt = $split_token[1];
  
      $decoded = JWT::decode($jwt, new Key("ykesuncabron", "HS256"));
    
      return $decoded;
    } catch (\Throwable $th) {
      throw new ErrorException("El token no es valido.");
    }
  }
}