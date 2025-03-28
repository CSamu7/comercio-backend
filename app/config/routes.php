<?php

use app\controllers\UserController;
use app\controllers\ApiExampleController;
use flight\Engine;
use flight\net\Router;

/* 
 * @var Router $router 
 * @var Engine $app
 
$router->get('/', function() use ($app) {
	$app->render('welcome', [ 'message' => 'You are gonna do great things!' ]);
});

$router->get('/hello-world/@name', function($nombre) {
	echo '<h1>Hello world! Oh hey '.$nombre.'!</h1>';
});

$router->group('/api', function() use ($router, $app) {
	$User_Controller = new UserController($app);

	$router->post('/auth', [$User_Controller, 'authUser']);
	$router->post('/user', [$User_Controller, 'postUser']);
	$router->get('/user/email/@email', [$User_Controller, 'getUser']);
});
*/