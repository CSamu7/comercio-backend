<?php
require_once 'usuario.php';
require_once 'producto.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion']) && $_POST['accion'] == 'crear') {
    $nombre = $_POST['nombre'];
    $apeP = $_POST['apeP'];
    $apeM = $_POST['apeM'];
    $email = $_POST['email'];
    $passw = $_POST['passw'];
    $direc = $_POST['direc'];
    $respuesta = crearUsuario($nombre, $apeP, $apeM, $email, $passw, $direc);
    echo json_encode($respuesta);
}

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['accion']) && $_GET['accion'] == 'listar') {
    $usuarios = buscarUsuarios();
    echo json_encode($usuarios);
}

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['accion']) && $_GET['accion'] == 'buscar' && isset($_GET['id_usuario'])) {
    $id_usuario = $_GET['id_usuario'];
    $usuario = buscarUsuarioId($id_usuario);
    echo json_encode($usuario);
}

if ($_SERVER['REQUEST_METHOD'] === 'PUT' && isset($_GET['accion']) && $_GET['accion'] == 'actualizar' && isset($_GET['id_usuario'])) {
    $id_usuario = $_GET['id_usuario'];
    parse_str(file_get_contents("php://input"), $_PUT);

    $nombre = $_PUT['nombre'];
    $apeP = $_PUT['apeP'];
    $apeM = $_PUT['apeM'];
    $email = $_PUT['email'];
    $passw = $_PUT['passw'];
    $direc = $_PUT['direc'];

    $respuesta = actualizarUsuario($id_usuario, $nombre, $apeP, $apeM, $email, $passw, $direc);
    echo json_encode($respuesta);
}

if ($_SERVER['REQUEST_METHOD'] === 'DELETE' && isset($_GET['accion']) && $_GET['accion'] == 'eliminar' && isset($_GET['id_usuario'])) {
    $id_usuario = $_GET['id_usuario'];
    $respuesta = eliminarUsuario($id_usuario);
    echo json_encode($respuesta);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion']) && $_POST['accion'] == 'iniciarSesion') {
    $email = $_POST['email'];
    $passw = $_POST['passw'];
    $respuesta = iniciarSesion($email, $passw);
    echo json_encode($respuesta);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion']) && $_POST['accion'] == 'crearProducto') {
    $nombre = $_POST['nombre'];
    $nombrecorto = $_POST['nombrecorto'];
    $descripcion = $_POST['descripcion'];
    $precio = $_POST['precio'];
    $url_imagen = $_POST['url_imagen'];
    $stock = $_POST['stock'];
    $id_departamento = $_POST['id_departamento'];
    $id_marca = $_POST['id_marca'];
    $id_oferta = isset($_POST['id_oferta']) ? $_POST['id_oferta'] : null;
    $respuesta = crearProducto($nombre, $nombrecorto, $descripcion, $precio, $url_imagen, $stock, $id_departamento, $id_marca, $id_oferta);
    echo json_encode($respuesta);
}

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['accion']) && $_GET['accion'] == 'listaProductos') {
    $productos = buscarProductos();
    echo json_encode($productos);
}

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['accion']) && $_GET['accion'] == 'buscarProducto' && isset($_GET['id_prod'])) {
    $id_prod = $_GET['id_prod'];
    $producto = buscarProductoId($id_prod);
    echo json_encode($producto);
}

if ($_SERVER['REQUEST_METHOD'] === 'PUT' && isset($_GET['accion']) && $_GET['accion'] == 'actualizarProducto' && isset($_GET['id_prod'])) {
    $id_prod = $_GET['id_prod'];
    parse_str(file_get_contents("php://input"), $_PUT);
    $nombre = $_PUT['nombre'];
    $nombrecorto = $_PUT['nombrecorto'];
    $descripcion = $_PUT['descripcion'];
    $precio = $_PUT['precio'];
    $url_imagen = $_PUT['url_imagen'];
    $stock = $_PUT['stock'];
    $id_departamento = $_PUT['id_departamento'];
    $id_marca = $_PUT['id_marca'];
    $id_oferta = isset($_PUT['id_oferta']) ? $_PUT['id_oferta'] : null;
    $respuesta = actualizarProducto($id_prod, $nombre, $nombrecorto, $descripcion, $precio, $url_imagen, $stock, $id_departamento, $id_marca, $id_oferta);
    echo json_encode($respuesta);
}

if ($_SERVER['REQUEST_METHOD'] === 'DELETE' && isset($_GET['accion']) && $_GET['accion'] == 'eliminarProducto' && isset($_GET['id_prod'])) {
    $id_prod = $_GET['id_prod'];
    $respuesta = eliminarProducto($id_prod);
    echo json_encode($respuesta);
}