<?php
require_once 'usuario.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['accion']) && $_POST['accion'] == 'crear') {
    $nombre = $_POST['nombre'];
    $apP = $_POST['apP'];
    $apM = $_POST['apM'];
    $email = $_POST['email'];
    $passw = $_POST['passw'];
    $dirc = $_POST['dirc'];
    $respuesta = crearUsuario($nombre, $apP, $apM, $email, $passw, $dirc);
    echo json_encode($respuesta);
}

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['accion']) && $_GET['accion'] == 'listar') {
    $usuarios = buscarUsuarios();
    echo json_encode($usuarios);
}

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['accion']) && $_GET['accion'] == 'buscar' && isset($_GET['id'])) {
    $id = $_GET['id'];
    $usuario = buscarUsuarioId($id);
    echo json_encode($usuario);
}

if ($_SERVER['REQUEST_METHOD'] === 'PUT' && isset($_GET['accion']) && $_GET['accion'] == 'actualizar' && isset($_GET['id'])) {
    $id = $_GET['id'];
    parse_str(file_get_contents("php://input"), $_PUT);

    $nombre = $_PUT['nombre'];
    $apP = $_PUT['apP'];
    $apM = $_PUT['apM'];
    $email = $_PUT['email'];
    $passw = $_PUT['passw'];
    $dirc = $_PUT['dirc'];

    $respuesta = actualizarUsuario($id, $nombre, $apP, $apM, $email, $passw, $dirc);
    echo json_encode($respuesta);
}

if ($_SERVER['REQUEST_METHOD'] === 'DELETE' && isset($_GET['accion']) && $_GET['accion'] == 'eliminar' && isset($_GET['id'])) {
    $id = $_GET['id'];
    $respuesta = eliminarUsuario($id);
    echo json_encode($respuesta);
}
