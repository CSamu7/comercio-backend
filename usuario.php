<?php
require_once 'IS_Conexion.php';

function crearUsuario($nombre, $apP, $apM, $email, $passw, $dirc) {
    global $db;
    $query = "INSERT INTO usuario (nombre, apP, apM, email, passw, dirc) VALUES ('$nombre', '$apP', '$apM', '$email', '$passw', '$dirc')";
    $result = $db->query($query);

    if ($result) {
        return array('mensaje' => 'Usuario se ha creado de manera exitosa');
    } else {
        return array('error' => 'Error al crear el usuario');
    }
}

function buscarUsuarios() {
    $query = "SELECT * FROM usuario";
    global $db;
    $result = $db->query($query);
    $usuarios = array();
    while ($usuario = $result->fetch_assoc()) {
        $usuarios[] = $usuario;
    }

    return $usuarios;
}

function buscarUsuarioId($id) {
    $query = "SELECT * FROM usuario WHERE id_usuario = $id";
    $result = $db->query($query);

    if ($result->num_rows > 0) {
        return $result->fetch_assoc();
    } else {
        return array('error' => 'Usuario que buscas no se ha encontrado');
    }
}

function actualizarUsuario($id, $nombre, $apP, $apM, $email, $passw, $dirc) {
    $query = "UPDATE usuario SET nombre = '$nombre', apP = '$apP', apM = '$apM', email = '$email', passw = '$passw', dirc = '$dirc' WHERE id_usuario = $id";
    $result = $db->query($query);

    if ($result) {
        return array('mensaje' => 'Los datos del usuario se han actualizado con éxito');
    } else {
        return array('error' => 'Error al actualizar el usuario');
    }
}

function eliminarUsuario($id) {
    $query = "DELETE FROM usuario WHERE id_usuario = $id";
    $result = $db->query($query);

    if ($result) {
        return array('mensaje' => 'Usuario eliminado con éxito');
    } else {
        return array('error' => 'Error al eliminar el usuario');
    }
}
