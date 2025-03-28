-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-03-2025 a las 00:25:51
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `infiniteskyvf`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_desc_expirados` ()   BEGIN
    DELETE FROM OFERTA
    WHERE fecha_fin < CURDATE();
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito_compras`
--

CREATE TABLE `carrito_compras` (
  `id_carrito` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_prod` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_metpago`
--

CREATE TABLE `catalogo_metpago` (
  `id_catmet` int(11) NOT NULL,
  `nombre_metpago` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra`
--

CREATE TABLE `compra` (
  `id_compra` int(11) NOT NULL,
  `fec_pedido` date NOT NULL,
  `fec_entrega` date NOT NULL,
  `entregado` tinyint(1) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_total` float NOT NULL,
  `impuesto` float NOT NULL,
  `subtotal` float NOT NULL,
  `id_prod` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `id_departamento` int(11) NOT NULL,
  `nombre_departamento` varchar(50) NOT NULL,
  `sub_departamento` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`id_departamento`, `nombre_departamento`, `sub_departamento`) VALUES
(1, 'Telescopios', 'Equipos principales'),
(2, 'Binoculares', 'Observación terrestre y astronómica'),
(3, 'Accesorios', 'Componentes y complementos'),
(4, 'Libros/Mapas', 'Material educativo'),
(5, 'Fotografía', 'Equipo de astrofotografía'),
(6, 'Subcategorías', 'Instrumentos especializados');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE `marca` (
  `id_marca` int(11) NOT NULL,
  `nombre_marca` varchar(45) NOT NULL,
  `tel_marca` varchar(15) DEFAULT NULL,
  `correo_marca` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `marca`
--

INSERT INTO `marca` (`id_marca`, `nombre_marca`, `tel_marca`, `correo_marca`) VALUES
(1, 'Celestron', '+18008536236', 'support@celestron.com'),
(2, 'Orion', '+18004474466', 'customercare@telescope.com'),
(3, 'Tele Vue', '+18454532485', 'info@televue.com'),
(5, 'Sky-Watcher', '+18556699877', 'info@skywatcherusa.com'),
(6, 'ZWO', '+8657188735728', 'service@zwoastro.com'),
(7, 'Meade', '+18006263333', 'support@meade.com'),
(8, 'Nikon', '+18006456655', 'support@nikon.com'),
(9, 'Explore Scientific', '+18774038003', 'info@explorescientific.com'),
(10, 'Coronado', '+18006263333', 'support@meade.com'),
(11, 'Bushnell', '+18004236845', 'support@bushnell.com'),
(12, 'Davis Instruments', '+18006782438', 'support@davisinstruments.com'),
(13, 'RTL-SDR', '+85281754149', 'support@rtl-sdr.com'),
(14, 'Genérico', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oferta`
--

CREATE TABLE `oferta` (
  `id_oferta` int(11) NOT NULL,
  `fecha_in` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `descuento` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_prod` int(11) NOT NULL,
  `nombre_prod` text NOT NULL,
  `nombrecorto_prod` varchar(50) NOT NULL,
  `descripcion_prod` text NOT NULL,
  `precio` int(11) NOT NULL,
  `url_imagen` text NOT NULL,
  `stock` int(11) NOT NULL,
  `id_departamento` int(11) NOT NULL,
  `id_marca` int(11) NOT NULL,
  `id_oferta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_prod`, `nombre_prod`, `nombrecorto_prod`, `descripcion_prod`, `precio`, `url_imagen`, `stock`, `id_departamento`, `id_marca`, `id_oferta`) VALUES
(1, 'Telescopio Celestron NexStar 8SE', 'NexStar 8SE', 'Telescopio computarizado 8\" con GoTo', 1599, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrJciTD-GllUePcKGhSV33KV99L2beBy2smg&s', 8, 1, 1, NULL),
(2, 'Telescopio Refractor Sky-Watcher 120mm', 'SkyWatcher 120', 'Refractor profesional 120mm', 899, 'https://m.media-amazon.com/images/I/711XoZ4AvOL.jpg', 5, 1, 5, NULL),
(3, 'Telescopio Dobson Orion SkyQuest XT10', 'Orion XT10', 'Dobsoniano 10\" para cielo profundo', 699, 'https://www.sbkmexico.com/catalogo/images/OR08947.jpg', 6, 1, 2, NULL),
(4, 'Telescopio Meade LX200 12\"', 'Meade LX200', 'Telescopio ACF 12\" con GPS', 3499, 'https://www.meade.com.mx/wp-content/uploads/2016/06/lx200_12in_leftside_1210-60-03-671x1030.jpg', 3, 1, 7, NULL),
(5, 'Telescopio Portátil Celestron Travel Scope', 'Travel Scope', 'Refractor 70mm portátil', 99, 'https://www.celestronmexico.com/wp-content/uploads/2020/02/22035_Travel_Scope_70_DX_v1.jpg', 15, 1, 1, NULL),
(6, 'Binoculares Orion 20x80 Astronomy', 'Orion 20x80', 'Binoculares astronómicos profesionales', 199, 'https://m.media-amazon.com/images/I/71-qQZQB0PL._AC_UF894,1000_QL80_.jpg', 12, 2, 2, NULL),
(7, 'Binoculares Celestron SkyMaster 15x70', 'SkyMaster 15x70', 'Prismas BAK-4, ideal para astronomía', 129, 'https://vyorsa.com.mx/media/catalog/product/cache/5c9671fc3539eb4576835b6f9295a2cf/1/4/1461167325_283197.jpg', 10, 2, 1, NULL),
(8, 'Binoculares Nikon Aculon A211 10x50', 'Nikon 10x50', 'Óptica de alta transmisión lumínica', 89, 'https://m.media-amazon.com/images/I/416F-nh3u2L.jpg', 18, 2, 8, NULL),
(9, 'Ocular Tele Vue Nagler 13mm', 'Nagler 13mm', 'Campo ultra ancho 82°', 599, 'https://m.media-amazon.com/images/I/61IpSjmyRyL.jpg', 5, 3, 3, NULL),
(10, 'Filtro Lunar Celestron', 'Filtro Lunar', 'Reduce brillo lunar', 29, 'https://www.celestronmexico.com/wp-content/uploads/2021/11/94105_Filtro-lunar-neutral.jpg', 20, 3, 1, NULL),
(11, 'Montura Orion Atlas Pro', 'Atlas Pro', 'Montura ecuatorial computerizada', 1999, 'https://www.astroshop.es/Produktbilder/zoom/46557_1/Orion-Montura-Atlas-Pro-AZ-EQ-G-SynScan-GoTo.jpg', 4, 3, 2, NULL),
(12, 'Batería PowerTank 12V', 'PowerTank', 'Batería portátil para equipos', 89, 'https://m.media-amazon.com/images/I/61+xg8Vl-tL._AC_UF894,1000_QL80_.jpg', 12, 3, 1, NULL),
(13, 'Reductor Focal f/6.3', 'Reductor f/6.3', 'Para astrofotografía', 149, 'https://m.media-amazon.com/images/I/71BalOnEL5L.jpg', 7, 3, 1, NULL),
(14, 'Libro \"Cosmos\" de Carl Sagan', 'Cosmos', 'Clásico de divulgación científica', 25, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXPUYXaACfje7xd7GdhjkB6wndbhM8gWAgAA&s', 30, 4, 14, NULL),
(15, 'Mapa Estelar Rotario', 'Mapa Estelar', 'Mapa ajustable para constelaciones', 12, 'https://m.media-amazon.com/images/I/61mWQNpMoZL._AC_UC200,200_CACC,200,200_QL85_.jpg?aicid=community-reviews', 25, 4, 14, NULL),
(16, 'Guía de Campo para las Estrellas', 'Guía Estrellas', 'Manual de observación', 18, 'https://m.media-amazon.com/images/I/81TRn-YU9KL._AC_UF894,1000_QL80_.jpg', 25, 4, 14, NULL),
(17, 'Cámara ZWO ASI 294MC Pro', 'ASI 294MC', 'Cámara CMOS para cielo profundo', 1099, 'https://m.media-amazon.com/images/I/81TlJG3W4jL._AC_UF894,1000_QL80_.jpg', 6, 5, 6, NULL),
(18, 'Cámara Canon EOS Ra', 'EOS Ra', 'Réflex full spectrum modificada', 2499, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRr5ILew35gyvj1ermvdHbneuJexj0RLoTNg&s', 3, 5, 14, NULL),
(19, 'Intervalómetro para DSLR', 'Intervalómetro', 'Control para larga exposición', 39, 'https://m.media-amazon.com/images/I/61-6qMT8DAL.jpg', 15, 5, 14, NULL),
(20, 'Telescopio Celestron AstroMaster 130EQ', 'AstroMaster 130', 'Reflector 130mm con montura ecuatorial', 299, 'https://www.celestronmexico.com/wp-content/uploads/2018/10/CPC_1100_GPS_11075-XLT.jpg', 8, 1, 1, NULL),
(21, 'Binoculares SkyMaster 25x100', 'SkyMaster 25x100', 'Binoculares gigantes para astronomía', 399, 'https://m.media-amazon.com/images/I/61jT-esP7PL._AC_UF894,1000_QL80_.jpg', 4, 2, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reseña`
--

CREATE TABLE `reseña` (
  `id_reseña` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_prod` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `fec_res` date NOT NULL,
  `punt` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apeP` varchar(45) NOT NULL,
  `apeM` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `passw` varchar(40) NOT NULL,
  `direc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `apeP`, `apeM`, `email`, `passw`, `direc`) VALUES
(1, 'Samuel', 'Peréz', 'De Gante', 'samuelpdg2003@gmail.com', 'joseeschingon', '20 de Noviembre, Ciudad de México'),
(2, 'José', 'Rodríguez', 'Ocón', 'jos333-@hotmail.com', 'xamppesmrda', 'Bosques de África, Estado de México');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_metpago`
--

CREATE TABLE `usuario_metpago` (
  `id_usuario` int(11) NOT NULL,
  `id_catmet` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito_compras`
--
ALTER TABLE `carrito_compras`
  ADD PRIMARY KEY (`id_carrito`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_prod` (`id_prod`);

--
-- Indices de la tabla `catalogo_metpago`
--
ALTER TABLE `catalogo_metpago`
  ADD PRIMARY KEY (`id_catmet`);

--
-- Indices de la tabla `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `id_prod` (`id_prod`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`id_departamento`);

--
-- Indices de la tabla `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`id_marca`);

--
-- Indices de la tabla `oferta`
--
ALTER TABLE `oferta`
  ADD PRIMARY KEY (`id_oferta`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_prod`),
  ADD KEY `id_departamento` (`id_departamento`),
  ADD KEY `id_marca` (`id_marca`),
  ADD KEY `id_oferta` (`id_oferta`),
  ADD KEY `idx_nombre_producto` (`nombrecorto_prod`);

--
-- Indices de la tabla `reseña`
--
ALTER TABLE `reseña`
  ADD PRIMARY KEY (`id_reseña`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_prod` (`id_prod`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `usuario_metpago`
--
ALTER TABLE `usuario_metpago`
  ADD PRIMARY KEY (`id_usuario`,`id_catmet`),
  ADD KEY `id_catmet` (`id_catmet`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito_compras`
--
ALTER TABLE `carrito_compras`
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `catalogo_metpago`
--
ALTER TABLE `catalogo_metpago`
  MODIFY `id_catmet` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `compra`
--
ALTER TABLE `compra`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `id_departamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `id_marca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `oferta`
--
ALTER TABLE `oferta`
  MODIFY `id_oferta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_prod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `reseña`
--
ALTER TABLE `reseña`
  MODIFY `id_reseña` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito_compras`
--
ALTER TABLE `carrito_compras`
  ADD CONSTRAINT `carrito_compras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `carrito_compras_ibfk_2` FOREIGN KEY (`id_prod`) REFERENCES `producto` (`id_prod`);

--
-- Filtros para la tabla `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`id_prod`) REFERENCES `producto` (`id_prod`),
  ADD CONSTRAINT `compra_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id_departamento`),
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`id_marca`) REFERENCES `marca` (`id_marca`),
  ADD CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`id_oferta`) REFERENCES `oferta` (`id_oferta`);

--
-- Filtros para la tabla `reseña`
--
ALTER TABLE `reseña`
  ADD CONSTRAINT `reseña_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `reseña_ibfk_2` FOREIGN KEY (`id_prod`) REFERENCES `producto` (`id_prod`);

--
-- Filtros para la tabla `usuario_metpago`
--
ALTER TABLE `usuario_metpago`
  ADD CONSTRAINT `usuario_metpago_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `usuario_metpago_ibfk_2` FOREIGN KEY (`id_catmet`) REFERENCES `catalogo_metpago` (`id_catmet`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
