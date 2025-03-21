<?php
echo dirname(__DIR__);
echo __DIR__;
echo $_SERVER["DOCUMENT_ROOT"];

require_once $_SERVER["DOCUMENT_ROOT"] . "/backend/app/middlewares/cors.php";
require_once $_SERVER["DOCUMENT_ROOT"] . "/backend/app/controllers/UserController.php";
require $_SERVER["DOCUMENT_ROOT"] . '/vendor/autoload.php';

$CorsUtil = new CorsUtil();
Flight::before('start', [ $CorsUtil, 'setupCors' ]);

Flight::path(__DIR__ . '/../app/controllers/');


// This needs to be run before start runs.

Flight::group("", function () {
  Flight::route("GET /user", ['UserController', 'getUser']);
  Flight::route("POST /user", ['UserController', 'postUser']);
  Flight::route("POST /user/auth", ['UserController', 'authUser']);

});

Flight::start();