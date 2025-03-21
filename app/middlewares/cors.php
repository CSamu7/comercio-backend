<?php

class CorsMiddleware
{
  public function before(array $params): void
  {
    $response = Flight::response();
    if (isset($_SERVER['HTTP_ORIGIN'])) {
      $this->allowOrigins();
      $response->header('Access-Control-Allow-Credentials', 'true');
      $response->header('Access-Control-Max-Age', '86400');
    }

    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
      if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD'])) {
        $response->header(
          'Access-Control-Allow-Methods',
          'GET, POST, PUT, DELETE, PATCH, OPTIONS'
        );
      }
      if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS'])) {
        $response->header(
          "Access-Control-Allow-Headers",
          $_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']
        );
      }
      $response->send();
      exit(0);
    }
  }

  private function allowOrigins(): void
  {
    // customize your allowed hosts here.
    $allowed = [
      'http://localhost',
      'http://localhost:5173',
      'http://localhost:5173/'
    ];

    if (in_array($_SERVER['HTTP_ORIGIN'], $allowed)) {
      $response = Flight::response();
      $response->header("Access-Control-Allow-Origin", $_SERVER['HTTP_ORIGIN']);
    }
  }
}