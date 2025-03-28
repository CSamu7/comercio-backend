<?php
require_once __DIR__ . '/../app/middlewares/cors.php';
require_once __DIR__ . '/../app/controllers/UserController.php';
require __DIR__ . '/../vendor/autoload.php';

$CorsUtil = new CorsUtil();
Flight::before('start', [ $CorsUtil, 'setupCors' ]);

Flight::route("GET /hello-world/@name", function($name) {
  echo '<h1>Hello world! Oh hey ' . $name . '!</h1>';
});

Flight::group("/api", function () {
  Flight::route("GET /user/email/@email", ['UserController', 'getUser']);
  Flight::route("POST /auth", ['UserController', 'authUser']);
  Flight::route("POST /user", ['UserController', 'postUser']);
});

Flight::start();
