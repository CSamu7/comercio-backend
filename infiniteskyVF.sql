CREATE DATABASE infiniteskyVF;

USE infiniteskyVF;

CREATE TABLE USUARIO(
    id_usuario INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    apeP VARCHAR(45) NOT NULL,
    apeM VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL,
    passw VARCHAR(40) NOT NULL,
    direc TEXT NOT NULL
);

CREATE TABLE CATALOGO_METPAGO (
    id_catmet INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre_metpago VARCHAR(50) NOT NULL
);

CREATE TABLE USUARIO_METPAGO (
    id_usuario INT NOT NULL,
    id_catmet INT NOT NULL,
    PRIMARY KEY (id_usuario, id_catmet),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_catmet) REFERENCES CATALOGO_METPAGO(id_catmet)
);

CREATE TABLE MARCA(
    id_marca INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre_marca VARCHAR(45) NOT NULL,
    tel_marca VARCHAR(15) NOT NULL,
    correo_marca VARCHAR(100) NOT NULL
);

CREATE TABLE DEPARTAMENTO (
    id_departamento INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre_departamento VARCHAR(50) NOT NULL,
    sub_departamento VARCHAR(50) NOT NULL
);

CREATE TABLE OFERTA (
    id_oferta INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    fecha_in DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    descuento FLOAT NOT NULL
);

CREATE TABLE PRODUCTO (
    id_prod INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    nombre_prod TEXT NOT NULL,
    nombrecorto_prod VARCHAR(50) NOT NULL,
    descripcion_prod TEXT NOT NULL,
    precio INT NOT NULL,
    url_imagen TEXT NOT NULL,
    stock INT NOT NULL,
    id_departamento INT NOT NULL,
    id_marca INT NOT NULL,
    id_oferta INT,
    FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id_departamento),
    FOREIGN KEY (id_marca) REFERENCES MARCA(id_marca),
    FOREIGN KEY (id_oferta) REFERENCES OFERTA(id_oferta)
);


CREATE TABLE COMPRA (
    id_compra INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    fec_pedido DATE NOT NULL,
    fec_entrega DATE NOT NULL,
    entregado BIT NOT NULL,
    cantidad INT NOT NULL,
    precio_total FLOAT NOT NULL,
    impuesto FLOAT NOT NULL,
    subtotal FLOAT NOT NULL,
    id_prod INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_prod) REFERENCES PRODUCTO(id_prod),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE RESEÑA (
    id_reseña INT PRIMARY KEY IDENTITY(1,1) NOT NULL,  -- Nueva llave primaria
    id_usuario INT NOT NULL,
    id_prod INT NOT NULL,
    comentario TEXT NOT NULL,
    fec_res DATE NOT NULL,
    punt FLOAT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_prod) REFERENCES PRODUCTO(id_prod)
);

CREATE TABLE CARRITO_COMPRAS (
    id_carrito INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    id_usuario INT NOT NULL,
    id_prod INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario FLOAT NOT NULL,  -- Nuevo campo para el precio unitario
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_prod) REFERENCES PRODUCTO(id_prod)
);

-- Índice para mejorar búsquedas por nombre corto del producto --
CREATE INDEX idx_nombre_producto ON PRODUCTO (nombrecorto_prod);
 GO

-- Procedimiento para eliminar promociones expiradas
CREATE PROCEDURE eliminar_desc_expirados
AS
BEGIN
    DELETE FROM OFERTA
    WHERE fecha_fin < CAST(GETDATE() AS DATE);
END;
GO

-- Ejecutar el procedimiento
EXEC eliminar_desc_expirados;
GO