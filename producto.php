<?php
require_once 'IS_Conexion.php';

function crearProducto($nombre, $nombrecorto, $descripcion, $precio, $url_imagen, $stock, $id_departamento, $id_marca, $id_oferta = null) {
    global $db;
    if ($id_oferta) {
        $query = "INSERT INTO PRODUCTO (nombre_prod, nombrecorto_prod, descripcion_prod, precio, url_imagen, stock, id_departamento, id_marca, id_oferta) VALUES ('$nombre', '$nombrecorto', '$descripcion', $precio, '$url_imagen', $stock, $id_departamento, $id_marca, $id_oferta)";
    } else {
        $query = "INSERT INTO PRODUCTO (nombre_prod, nombrecorto_prod, descripcion_prod, precio, url_imagen, stock, id_departamento, id_marca) VALUES ('$nombre', '$nombrecorto', '$descripcion', $precio, '$url_imagen', $stock, $id_departamento, $id_marca)";
    }
    $result = $db->query($query);
    if ($result) {
        return array('mensaje' => 'El prooducto se ha creado con éxito');
    } else {
        return array('error' => 'Error al crear el producto');
    }
}

function buscarProductos() {
    global $db;
    $query = "SELECT * FROM PRODUCTO";
    $result = $db->query($query);
    $productos = array();
    while ($producto = $result->fetch_assoc()) {
        $productos[] = $producto;
    }
    return $productos;
}

function buscarProductoId($id_prod) {
    global $db;
    $query = "SELECT * FROM PRODUCTO WHERE id_prod = $id_prod";
    $result = $db->query($query);
    if ($result->num_rows > 0) {
        return $result->fetch_assoc();
    } else {
        return array('error' => 'Producto no encontrado');
    }
}

function actualizarProducto($id_prod, $nombre, $nombrecorto, $descripcion, $precio, $url_imagen, $stock, $id_departamento, $id_marca, $id_oferta = null) {
    global $db;
    if ($id_oferta) {
        $query = "UPDATE PRODUCTO SET nombre_prod = '$nombre', nombrecorto_prod = '$nombrecorto', descripcion_prod = '$descripcion', precio = $precio, url_imagen = '$url_imagen', stock = $stock, id_departamento = $id_departamento, id_marca = $id_marca, id_oferta = $id_oferta WHERE id_prod = $id";
    } else {
        $query = "UPDATE PRODUCTO SET nombre_prod = '$nombre', nombrecorto_prod = '$nombrecorto', descripcion_prod = '$descripcion', precio = $precio, url_imagen = '$url_imagen', stock = $stock, id_departamento = $id_departamento, id_marca = $id_marca WHERE id_prod = $id";
    }
    $result = $db->query($query);
    if ($result) {
        return array('mensaje' => 'Producto actualizado con éxito');
    } else {
        return array('error' => 'Error al actualizar el producto');
    }
}

function eliminarProducto($id_prod) {
    global $db;
    $query = "DELETE FROM PRODUCTO WHERE id_prod = $id_prod";
    $result = $db->query($query);
    if ($result) {
        return array('mensaje' => 'Producto eliminado con éxito');
    } else {
        return array('error' => 'Error al eliminar el producto');
    }
}
