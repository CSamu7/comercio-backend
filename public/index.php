<?php
require_once __DIR__ . '/../app/middlewares/cors.php';
require_once __DIR__ . '/../app/controllers/UserController.php';
require_once __DIR__ . '/../app/controllers/ProductController.php';
require __DIR__ . '/../vendor/autoload.php';

if (isset($_SERVER['HTTP_ORIGIN'])) {
	header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
	header('Access-Control-Allow-Credentials: true');
	header('Access-Control-Max-Age: 86400');
}

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
	if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD'])) {
		header(
			'Access-Control-Allow-Methods: GET, POST, PUT, DELETE, PATCH, OPTIONS'
		);
	}
	if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS'])) {
		header(
			"Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}"
		);
	}
	exit(0);
}

Flight::group("/user", function () {
  Flight::route("GET /", 'UserController->getUser');
  Flight::route("POST /auth", 'UserController->authUser');
  Flight::route("POST /", 'UserController->postUser');
});

Flight::group("/product", function () {
  Flight::route("GET /", ['ProductController', 'getProducts']);
  Flight::route("GET /@id_prod", ['ProductController', 'getProduct']);
});


Flight::start();
