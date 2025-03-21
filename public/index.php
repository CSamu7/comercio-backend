<?php
echo dirname(__DIR__);
echo __DIR__;
echo $_SERVER["DOCUMENT_ROOT"];

require_once $_SERVER["DOCUMENT_ROOT"] . "/backend/app/middlewares/cors.php";
require_once $_SERVER["DOCUMENT_ROOT"] . "/backend/app/controllers/UserController.php";
require $_SERVER["DOCUMENT_ROOT"] . '/vendor/autoload.php';

Flight::path(__DIR__ . '/../app/controllers/');

Flight::group("", function () {
  Flight::route("GET /user", ['UserController', 'getUser']);
  Flight::route("POST /user", ['UserController', 'postUser']);
  Flight::route("POST /user/auth", ['UserController', 'authUser']);

}, [new CorsMiddleware()]);

Flight::start();