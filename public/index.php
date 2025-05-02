<?php
require_once __DIR__ . '/../app/middlewares/cors.php';
require_once __DIR__ . '/../app/controllers/UserController.php';
require_once __DIR__ . '/../app/controllers/ProductController.php';
require_once __DIR__ . '/../app/controllers/ShoppingCartController.php';
require_once __DIR__ . '/../app/controllers/CheckoutController.php';
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

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

Flight::group("/user", function () {
  Flight::route("GET /", 'UserController->getUser');
  Flight::route("POST /auth", 'UserController->authUser');
  Flight::route("POST /", 'UserController->postUser');
});

Flight::group("/product", function () {
  Flight::route("GET /", ['ProductController', 'getProducts']);
  Flight::route("GET /@id_prod", ['ProductController', 'getProduct']);
});

Flight::group("/shopping-cart", function() {
	Flight::route("GET /@id_user", ['ShoppingCartController', 'getShoppingCart']);
	Flight::route("POST /", ['ShoppingCartController', 'addCartItem']);
	Flight::route("PUT /@id_user", ['ShoppingCartController', 'updateCartItem']);
	Flight::route("DELETE /@id_user", ['ShoppingCartController', 'deleteCartItem']);
	Flight::route("DELETE /clear", ['ShoppingCartController', 'clearCart']);
});

Flight::group("/checkout-session", function(){
	Flight::route("POST /", ["CheckoutController", "createCheckout"]);
});

Flight::start();
