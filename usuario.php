<?php
require_once 'IS_Conexion.php';

function crearUsuario($nombre, $apeP, $apeM, $email, $passw, $direc) {
    global $db;
    $query = "INSERT INTO USUARIO (nombre, apeP, apeM, email, passw, direc) VALUES ('$nombre', '$apeP', '$apeM', '$email', '$passw', '$direc')";
    $result = $db->query($query);

    if ($result) {
        return array('mensaje' => 'Usuario se ha creado de manera exitosa');
    } else {
        return array('error' => 'Error al crear el usuario');
    }
}

function buscarUsuarios() {
    $query = "SELECT * FROM USUARIO";
    global $db;
    $result = $db->query($query);
    $usuarios = array();
    while ($usuario = $result->fetch_assoc()) {
        $usuarios[] = $usuario;
    }

    return $usuarios;
}

function buscarUsuarioId($id_usuario) {
    $query = "SELECT * FROM USUARIO WHERE id_usuario = $id_usuario";
    $result = $db->query($query);

    if ($result->num_rows > 0) {
        return $result->fetch_assoc();
    } else {
        return array('error' => 'Usuario que buscas no se ha encontrado');
    }
}

function actualizarUsuario($id_usuario, $nombre, $apeP, $apeM, $email, $passw, $direc) {
    $query = "UPDATE USUARIO SET nombre = '$nombre', apeP = '$apeP', apeM = '$apeM', email = '$email', passw = '$passw', direc = '$direc' WHERE id_usuario = $id_usuario";
    $result = $db->query($query);

    if ($result) {
        return array('mensaje' => 'Los datos del usuario se han actualizado con éxito');
    } else {
        return array('error' => 'Error al actualizar el usuario');
    }
}

function eliminarUsuario($id_usuario) {
    $query = "DELETE FROM USUARIO WHERE id_usuario = $id_usuario";
    $result = $db->query($query);

    if ($result) {
        return array('mensaje' => 'Usuario eliminado con éxito');
    } else {
        return array('error' => 'Error al eliminar el usuario');
    }
}

function iniciarSesion($email, $passw) {
    global $db;
    $query = "SELECT * FROM USUARIO WHERE email = '$email'";
    $result = $db->query($query);

    if ($result->num_rows > 0) {
        $usuario = $result->fetch_assoc();
        if (password_verify($passw, $usuario['passw'])) {
            $token = uniqid('', true);
            $query = "UPDATE USUARIO SET token = '$token' WHERE id_usuario = $usuario[id_usuario]";
            $db->query($query);
            return array('token' => $token);
        } else {
            return array('error' => 'Datos incorrectos');
        }
    } else {
        return array('error' => 'Datos incorrectos');
    }
}

function validarToken($token) {
    global $db;
    $query = "SELECT * FROM USUARIO WHERE token = '$token'";
    $result = $db->query($query);
    if ($result->num_rows > 0) {
        return true;
    } else {
        return false;
    }
}