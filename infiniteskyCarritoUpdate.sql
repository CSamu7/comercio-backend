-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-05-2025 a las 04:24:17
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
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id_carrito` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `total` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`id_carrito`, `id_usuario`, `fecha_creacion`, `total`, `estado`) VALUES
(1, 2, '2025-05-01 20:18:31', 450, 'sin pago');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito_detalle`
--

CREATE TABLE `carrito_detalle` (
  `id_detalle` int(11) NOT NULL,
  `id_carrito` int(11) NOT NULL,
  `id_prod` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrito_detalle`
--

INSERT INTO `carrito_detalle` (`id_detalle`, `id_carrito`, `id_prod`, `cantidad`, `precio`) VALUES
(1, 1, 2, 1, 120),
(2, 1, 4, 2, 90),
(3, 1, 7, 1, 150);

--
-- Disparadores `carrito_detalle`
--
DELIMITER $$
CREATE TRIGGER `actualizar_total_carrito` AFTER INSERT ON `carrito_detalle` FOR EACH ROW BEGIN
  UPDATE carrito
  SET total = (
    SELECT SUM(cantidad * precio)
    FROM carrito_detalle
    WHERE id_carrito = NEW.id_carrito
  )
  WHERE id_carrito = NEW.id_carrito;
END
$$
DELIMITER ;

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
  `nombrecorto_prod` text NOT NULL,
  `descripcion_prod` text NOT NULL,
  `precio` float NOT NULL,
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
(1, 'Celestron - Telescopio NexStar 8SE - Telescopio computarizado para principiantes y usuarios avanzados - Montura Goto totalmente automatizada - Tecnología SkyAlign - Más de 40,000 objetos celestes - Espejo primario de 8 pulgadas.', 'Celestron - Telescopio NexStar 8SE - Más de 40,000 objetos celestes - Espejo primario de 8 pulgadas.\r\n', 'El NexStar 8SE es un telescopio computarizado de alto rendimiento que combina tecnología avanzada con facilidad de uso. Su espejo primario de 8 pulgadas (203mm) ofrece imágenes brillantes y detalladas de planetas, nebulosas y galaxias. La montura motorizada Goto permite localizar automáticamente más de 40,000 objetos celestes con solo presionar un botón, gracias a su sistema SkyAlign para alineamiento rápido. Incluye ocular de 25mm, controlador manual y software educativo. Ideal para observadores intermedios y avanzados que buscan precisión y portabilidad.', 30501, 'https://m.media-amazon.com/images/I/51J8qwQGSgL._AC_SL1200_.jpg\r\nhttps://m.media-amazon.com/images/I/51qhlc57kEL._AC_SL1200_.jpg\r\nhttps://m.media-amazon.com/images/I/61tl+4zwslL._AC_SL1500_.jpg', 8, 1, 1, NULL),
(2, 'Sky-Watcher - Telescopio Refractor 120mm EQ3 - Telescopio refractor para principiantes y aficionados - Montura ecuatorial para seguimiento preciso - Lente de alta calidad de 120mm - Ideal para observación lunar y planetaria.', 'SkyWatcher - Telescopio Refractor 120mm EQ3- Ideal para observación lunar y planetaria.', 'Este telescopio refractor profesional destaca por su lente acromática de 120mm, que reduce aberraciones cromáticas para imágenes nítidas. La montura ecuatorial EQ3 ofrece seguimiento preciso de planetas, la Luna y estrellas dobles. Perfecto para aficionados que desean adentrarse en la astronomía óptica, con capacidad limitada para astrofotografía básica.', 22451, 'https://skyshop.mx/wp-content/uploads/2021/09/120-skywatcher.jpg\r\nhttps://espacioceleste.es/wp-content/uploads/2021/03/skywatcher_newton_150_750_eq3_manual.png\r\nhttps://skyshop.mx/wp-content/uploads/2021/09/120-skyswatcher-7.jpg\r\n', 5, 1, 5, NULL),
(3, 'Orion - Telescopio Dobsoniano SkyQuest XT10 Clásico - Telescopio reflector para astrónomos principiantes y avanzados - Diseño dobsoniano de fácil manejo - Gran apertura de 254mm (10\") para imágenes brillantes - Base altazimutal suave y estable - Ideal para observación de espacio profundo', 'Orion XT10 -  Telescopio Dobsoniano SkyQuest XT10 Clásico - Ideal para observación de espacio profundo.\r\n\r\n', 'El Telescopio Dobsoniano SkyQuest XT10 Clásico de Orion es un instrumento de gran apertura diseñado para revelar el universo con claridad excepcional. Su espejo parabólico de 10 pulgadas (254mm) recoge hasta un 77% más de luz que un telescopio de 8\", permitiendo observar galaxias, nebulosas y cúmulos estelares con ricos detalles', 20600, 'https://m.media-amazon.com/images/I/81mMAu7XMjL.__AC_SX300_SY300_QL70_ML2_.jpg\r\nhttps://m.media-amazon.com/images/I/81mMAu7XMjL.__AC_SX300_SY300_QL70_ML2_.jpg\r\nhttps://m.media-amazon.com/images/I/91d-T5IjWKL._AC_SL1500_.jpg\r\n\r\n', 6, 1, 2, NULL),
(4, 'Meade - Telescopio LX200 12\" - Telescopio avanzado Schmidt-Cassegrain para astrónomos expertos - Montura computerizada altazimutal/ecuatorial - Apertura ultra-grande de 304mm (12\") ', 'Meade - Telescopio LX200 12\" - Telescopio avanzado Schmidt-Cassegrain - Ideal para la observación de objetos celestes con detalles.', 'El Telescopio LX200 12\" ACF de Meade representa la cúspide de la tecnología astronómica amateur, combinando un sistema óptico Advanced Coma-Free (ACF) de 12\" (304mm) con una montura computerizada de alta precisión. Este instrumento está diseñado para astrofotografía de largo alcance y observación de objetos celestes con detalles sin precedentes.', 40700, 'https://www.sbkmexico.com/catalogo/images/ME1210-60-03-a.jpg\r\nhttps://www.sbkmexico.com/catalogo/images/ME1210-60-03-c.jpg\r\nhttps://www.sbkmexico.com/catalogo/images/ME1210-60-03-c.jpg', 3, 1, 7, NULL),
(5, 'Celestron - Telescopio Portátil Travel Scope \"80mm - Telescopio refractor ultraportátil para viajes y observación casual - Apertura de 70mm -  Montura altazimutal ligera de mesa.', 'Celestron - Telescopio Portátil Travel Scope \"80mm - para viajes y observación casual - Ideal para observación lunar.', 'Telescopio refractor ultraportátil (70mm u 80mm) diseñado para excursionistas y viajeros. Viene con mochila resistente, trípode de mesa y adaptador para smartphone para fotografía básica. Los oculares de 20mm y 10mm permiten aumentos versátiles, mientras que su lente multicapa mejora el contraste. Ideal para observación lunar, aves o paisajes, con un peso mínimo (1.5 kg el modelo 70mm).', 18671, 'https://m.media-amazon.com/images/I/61U+hQsbuML._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/61hBR9MEKgL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/615GxSQ6rGL._AC_SX522_.jpg', 15, 1, 1, NULL),
(6, 'Orion - Binoculares Astronómicos 20x80 - Binoculares profesionales para observación astronómica y terrestre - Aumentos 20x con lentes de 80mm de apertura - Prismas BaK-4 para imágenes brillantes y de alto contraste.', 'Orion - Binoculares Astronómicos 20x80 - Aumentos 20x con lentes de 80mm de apertura - ideal para escanear la Vía Láctea.  ', 'Binoculares de alta gama con aumento 20x y lentes de 80mm, equipados con prismas BaK-4 y revestimiento Fully Multi-Coated para máxima claridad. Su campo de visión de 3.2° es ideal para escanear la Vía Láctea, cúmulos como las Pléyades o la Luna. Incluyen adaptador para trípode (necesario por su peso de 1.8 kg) y estuche rígido. Recomendados para astrónomos que buscan una alternativa a telescopios.', 9900, 'https://m.media-amazon.com/images/I/71-qQZQB0PL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/61b2KhhFCjL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/710gaZwnHxL._AC_SX522_.jpg', 12, 2, 2, NULL),
(7, 'Celestron - Binoculares SkyMaster 15x70 - Binoculares astronómicos profesionales de alto rendimiento - 15x aumentos - Lentes de 70mm - Prismas BaK-4 - Revestimiento multicapa - Incluye adaptador para trípode - Ideal para astronomía y observación terrestre.', 'Celestron - Binoculares SkyMaster 15x70 - 15x aumentos - Lentes de 70mm - Ideal para astronomía y observación terrestre.', 'Los Binoculares Celestron SkyMaster 15x70 son instrumentos ópticos profesionales diseñados para observación astronómica y terrestre. Con 15x aumentos y lentes de 70mm, ofrecen imágenes brillantes y detalladas gracias a sus prismas BaK-4 y revestimiento multicapa que maximizan la transmisión de luz. Su amplio campo de visión de 4.4° permite explorar cúmulos estelares, la Luna y objetos de espacio profundo, mientras que su diseño sellado al nitrógeno los hace resistentes a la humedad. ', 13560, 'https://m.media-amazon.com/images/I/51OwHKeZOEL.__AC_SY300_SX300_QL70_ML2_.jpg\r\nhttps://m.media-amazon.com/images/I/51KVxaYoi8L._AC_SY879_.jpg\r\nhttps://m.media-amazon.com/images/I/41uTOS1xI2L._AC_SX522_.jpg', 10, 2, 1, NULL),
(8, 'Nikon - Binoculares Aculon A211 10x50 - Binoculares versátiles para observación terrestre y astronomía básica - 10x aumentos - Lentes de 50mm - Prismas BaK-4 - Revestimiento multicapa - Campo de visión de 6.5° - Diseño ergonómico y ligero.', 'Nikon - Binoculares Aculon A211 10x50 - 10x aumentos - Lentes de 50mm - Ideal para naturaleza y astronomía básica.', 'Los Binoculares Nikon Aculon A211 10x50 son un instrumento óptico versátil y accesible, perfecto para observación terrestre y astronomía básica. Con 10x aumentos y lentes de 50mm, ofrecen un equilibrio perfecto entre potencia y luminosidad. Sus prismas BaK-4 y revestimiento multicapa garantizan imágenes nítidas y brillantes, incluso en condiciones de poca luz.', 9500, 'https://m.media-amazon.com/images/I/51c5yielqZL.__AC_SX300_SY300_QL70_ML2_.jpg\r\nhttps://m.media-amazon.com/images/I/514Lx-amsSL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/61bZ-rnw-ZL._AC_SX522_.jpg', 18, 2, 8, NULL),
(9, 'Tele Vue - Ocular Nagler 13mm Tipo 6 - Ocular ultra gran angular de 82° para astronomía profesional - Diseño de 7 elementos con lentes de alta transmisión - Distancia de eye relief de 12mm - Compatible con telescopios de 1.25\" y 2\" - Ideal para observación de cielo profundo y planetaria.', 'Tele Vue - Ocular Nagler 13mm - Ultra gran angular 82° - Para observación profesional - Ideal para observación de cielo profundo y planetaria.', 'El Ocular Tele Vue Nagler 13mm Tipo 6 es un ocular premium diseñado para astrónomos exigentes. Con su campo aparente ultra amplio de 82°, ofrece una experiencia de observación inmersiva, perfecta para explorar cúmulos estelares, nebulosas y planetas con gran detalle.', 2501, 'https://m.media-amazon.com/images/I/61yfsUQX7ZL._AC_SX679_.jpg', 5, 3, 3, NULL),
(10, 'Celestron - Filtro Lunar 1.25\" - Filtro óptico premium para observación lunar - Reduce el brillo y mejora el contraste - Densidad neutra (ND-96) - Elimina el deslumbramiento - Compatible con todos los oculares 1.25\" - Ideal para telescopios y binoculares astronómicos.\r\n\r\n', 'Celestron - Filtro Lunar 1.25\" - Reduce brillo y mejora detalles lunares - Ideal para telescopios y binoculares astronómicos.', 'El Filtro Lunar Celestron 1.25\" es un accesorio esencial para observadores lunares, diseñado para reducir la intensidad de la luz y revelar detalles superficiales con claridad. Tecnología ND-96 (0.9 densidad neutra) filtra un 82% de la luz, eliminando el deslumbramiento durante las fases de Luna llena.', 701, 'https://www.celestronmexico.com/wp-content/uploads/2021/11/94105_Filtro-lunar-neutral.jpg', 20, 3, 1, NULL),
(11, 'Orion - Montura Ecuatorial Atlas Pro AZ/EQ-G - Montura computerizada profesional para astrofotografía - Capacidad de carga 45 kg - Modos ecuatorial/altazimutal - Compatible con WiFi/PC.', 'Orion - Montura Atlas Pro AZ/EQ-G - Doble modo ecuatorial/altazimutal - 45kg capacidad - Incluye controlador Atlas Pro y trípode de acero.', 'La montura Orion Atlas Pro AZ/EQ-G es una solución profesional para observación y astrofotografía avanzada. Con su diseño híbrido, funciona en modo ecuatorial (para astrofotografía de larga exposición) y altazimutal (para observación visual rápida).', 40300, 'https://www.astroshop.es/Produktbilder/zoom/46557_1/Orion-Montura-Atlas-Pro-AZ-EQ-G-SynScan-GoTo.jpg\r\nhttps://www.astroshop.es/Produktbilder/zoom/46557_5/Orion-Montura-Atlas-Pro-AZ-EQ-G-SynScan-GoTo.jpg\r\nhttps://www.astroshop.es/Produktbilder/zoom/46557_6/Orion-Montura-Atlas-Pro-AZ-EQ-G-SynScan-GoTo.jpg', 4, 3, 2, NULL),
(12, 'Celestron - Batería PowerTank 12V 7Ah - Fuente de alimentación portátil para telescopios - Batería recargable de ciclo profundo - Salidas 12V DC (5A) y USB (2.1A) - Incluye cables para monturas Celestron/Meade - Luz LED integrada -', 'Celestron - PowerTank 12V - Alimentación portátil para telescopios - 7Ah de capacidad.', 'La Batería PowerTank 12V de Celestron es una solución de energía portátil diseñada específicamente para telescopios computerizados y accesorios astronómicos. Con su batería de plomo-ácido sellada de 7Ah, proporciona hasta 20 horas de uso continuo con monturas como la NexStar SE o CG-4.', 2801, 'https://m.media-amazon.com/images/I/61+xg8Vl-tL._AC_SX300_SY300_.jpg\r\nhttps://m.media-amazon.com/images/I/61EXS3m9irL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/71Wcfa3xkSL._AC_SX522_.jpg', 12, 3, 1, NULL),
(13, 'Celestron - Reductor de Focal f/6.3 para telescopios Schmidt-Cassegrain - Aumenta campo de visión y reduce tiempo de exposición - Compatible con modelos C5/C6/C8/C9.25/C11 - Conexión estándar 1.25\" y 2\" - Ideal para astrofotografía y observación de cielo profundo.', 'Celestron - Reductor Focal f/6.3 - Para telescopios SCT - Mejora campo visual y luminosidad.', 'El Reductor Focal f/6.3 de Celestron es un accesorio óptico diseñado para telescopios Schmidt-Cassegrain, que reduce la relación focal de f/10 a f/6.3. Aumenta el campo de visión un 37% (ideal para objetos extensos como la Nebulosa de Orión), reduce el tiempo de exposición en astrofotografía (4x más rápido que en f/10) y mejora la luminosidad para observación visual de nebulosas y galaxias.', 3864, 'https://m.media-amazon.com/images/I/71BalOnEL5L.jpg\r\nhttps://m.media-amazon.com/images/I/710v21bt6bL._AC_SY879_.jpg\r\nhttps://m.media-amazon.com/images/I/21xqFBUfSjL._AC_.jpg\r\n', 7, 3, 1, NULL),
(14, 'Libro Cosmos de Carl Sagan - Obra maestra de divulgación científica - Edición actualizada con prólogo de Neil deGrasse Tyson - Incluye ilustraciones a todo color y nuevos hallazgos astronómicos - 384 páginas - Editorial Planeta - ISBN 978-8408198901.', 'Libro Cosmos - Carl Sagan - Clásico de astronomía y ciencia - Editorial Planeta - ISBN 978-8408198901.', '\"Cosmos\", la obra icónica de Carl Sagan, es un viaje literario a través del universo que combina astronomía, filosofía e historia de la ciencia. Esta edición especial incluye:\r\n13 capítulos que exploran desde el Big Bang hasta el origen de la vida, actualizaciones científicas basadas en descubrimientos recientes e ilustraciones a color de nebulosas, planetas y telescopios espaciales', 251, 'https://static0planetadelibroscommx.cdnstatics.com/usuaris/libros/fotos/408/original/portada_cosmos_carl-sagan_202409272100.jpg\r\nhttps://static0planetadelibroscommx.cdnstatics.com/usuaris/libros/fotos/408/m_prensa/407270_Libro-Cosmos-Carl-Sagan.jpg\r\nhttps://static0planetadelibroscommx.cdnstatics.com/usuaris/libros/fotos/408/m_prensa/cosmos_9786075698380_3d_202411191802.png\r\n', 30, 4, 14, NULL),
(15, 'Mapa Espacial del Universo Observable - Poster Astronómico Educativo - Incluye 500+ objetos celestes (galaxias, nebulosas, cúmulos) - Proyección 3D de la Vía Láctea - Escala de distancias en años luz - Datos técnicos de planetas y estrellas - Tamaño 90x60 cm - Material laminado resistente.', 'Mapa del Universo Observable - Poster educativo con 500+ objetos celestes - Tamaño 90x60 cm - Material laminado resistente.', 'Este mapa espacial es una herramienta visual única que combina arte y ciencia, mostrando el universo conocido en cuatro niveles de escala:\r\nCapas principales:\r\nSistema Solar: Órbitas planetarias a escala  lunas destacadas\r\nVecindario estelar: 100 estrellas dentro de 50 años luz (Próxima Centauri, Sirio)\r\nVía Láctea: Estructura espiral con posición del Sol y nebulosas clave (Orión, Águila)', 201, 'https://thingsofthestars.com/cdn/shop/files/78aa3241-0d3c-490e-b913-88b431ed61e3.jpg?v=1695068534&width=713\r\nhttps://thingsofthestars.com/cdn/shop/files/Zoomed2.jpg?v=1695068534&width=713\r\nhttps://thingsofthestars.com/cdn/shop/files/Zommed1.jpg?v=1695068534&width=713', 25, 4, 14, NULL),
(16, '\"Guía Astronómica 2024 (Edición Española)\" - Anuario completo para observación del cielo - Efemérides mensuales y mapas estelares - Posiciones planetarias y eventos celestes - Incluye lluvias de meteoros, eclipses y conjunciones - Datos ISS y satélites visibles - 196 páginas - Editorial AstroPrint - ISBN 978-84-123456-7-8', 'Guía Astronómica 2024 - Anuario con efemérides y mapas celestes  - 196 páginas - Editorial AstroPrint - ISBN 978-84-123456-7-8.', 'La Guía Astronómica 2024 es la herramienta esencial para planificar tus observaciones a lo largo del año. Esta edición en español ofrece:\r\nContenido organizado por meses:\r\nEfemérides diarias: Salida/puesta de Sol/Luna, fases lunares\r\nPlanetas visibles: Mejores horas de observación (Júpiter, Saturno, etc.)\r\nEventos destacados:', 100, 'https://m.media-amazon.com/images/I/61zJzP8RRoL._SY466_.jpg\r\nhttps://m.media-amazon.com/images/I/61WKsJNDjrL.jpg', 25, 4, 14, NULL),
(17, 'ZWO - Cámara Astronómica ASI 294MC Pro - Cámara CMOS color para astrofotografía - Sensor Sony IMX294 de 11.7MP (4/3\") - Resolución 4144x2822 - Tamaño de píxel 4.63µm - Modos de alta sensibilidad (Ganancia 0-450) - Ventana Peltier y diseño refrigerado - Incluye software ASICap y drivers - Compatible con telescopios y lentes.', 'ZWO ASI 294MC Pro - Cámara CMOS color para astrofotografía profunda - Incluye software ASICap y drivers - Compatible con telescopios y lentes.', 'La ASI 294MC Pro de ZWO es una cámara astronómica profesional que combina alta sensibilidad y resolución ideal para capturar:\r\nNebulosas de emisión (M42, M8) con su amplio FOV.\r\nGalaxias brillantes (M31, M81) gracias a su baja relación de lectura.\r\nPlanetas (Júpiter, Saturno) en modo ROI de alta velocidad.', 22099, 'https://m.media-amazon.com/images/I/81TlJG3W4jL.__AC_SX300_SY300_QL70_ML2_.jpg\r\nhttps://m.media-amazon.com/images/I/71qdP0neGIL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/71bJjNl5KaL._AC_SL1500_.jpg\r\n', 6, 5, 6, NULL),
(18, 'Canon - Cámara EOS Ra (Edición Astrofotografía) - Cuerpo full-frame modificado para espectro H-alfa - Sensor CMOS de 30.3MP - Doble Pixel RAW 4K - Modo Astro (amplificación ISO 400-3200) - Compatible con lentes EF/EF-S - Pantalla articulada táctil - WiFi/GPS integrado - Incluye software DPP4.', 'Canon EOS Ra - Cámara full-frame modificada para astrofotografía - Pantalla articulada táctil - WiFi/GPS integrado - Incluye software DPP4.', 'La Canon EOS Ra es una versión especializada de la EOS R, optimizada para capturar nebulosas de emisión gracias a su:\r\nModificaciones clave:\r\nFiltro IR ampliado: Transmite 4x más H-alfa (656nm) que modelos estándar.\r\nModo Astro: Reducción de ruido en largas exposiciones (hasta 30min).\r\nLiveView mejorado: Visualización en tiempo real con amplificación de señal.', 24099, 'https://www.cyberpuerta.mx/img/product/M/CP-CANON-5811C022AA-9daae6.jpg\r\nhttps://www.cyberpuerta.mx/img/product/M/CP-CANON-5811C022AA-5a3b16.jpg\r\nhttps://www.cyberpuerta.mx/img/product/M/CP-CANON-5811C022AA-88217d.jpg\r\n', 3, 5, 14, NULL),
(19, 'Intervalómetro Profesional para DSLR/Mirrorless - Disparador remoto con temporizador programable - Pantalla LCD retroiluminada - Funciones: Time-Lapse, Bulb, Exposiciones prolongadas - Compatible con Canon/Nikon/Sony/Fuji - Incluye cable de 1.5m y soporte de montaje - Rango: 1seg a 99h59m59s - Alimentación por batería CR2032.', 'Intervalómetro para DSLR - Disparador programable para time-lapse y larga exposición - Alimentación por batería CR2032.', 'Este intervalómetro universal es un accesorio esencial para astrofotografía y fotografía creativa, que permite:\r\nFunciones clave:\r\nModo Bulb: Control preciso de exposiciones >30seg (ideal para trazas estelares) Time-Lapse.Programación de:\r\nIntervalos (1seg a 24h).\r\nNúmero de disparos (1-399).\r\nRetardo inicial (0-99h).\r\nExposición múltiple: Hasta 9 disparos consecutivos.', 620, 'https://m.media-amazon.com/images/I/71rpgxpKE2L.__AC_SX300_SY300_QL70_ML2_.jpg\r\nhttps://m.media-amazon.com/images/I/71xc2-68tYL._AC_SL1500_.jpg\r\nhttps://m.media-amazon.com/images/I/71FPjtjgXyL._AC_SL1500_.jpg', 1230, 5, 14, NULL),
(20, 'Celestron - Telescopio AstroMaster 130EQ - Telescopio reflector Newtoniano para principiantes - Montura ecuatorial manual - Apertura de 130mm (5.1\") - Distancia focal 650mm (f/5) - Incluye 2 oculares (20mm y 10mm) - Trípode de acero ajustable - Buscador StarPointer - Ideal para observación lunar y planetaria.', 'Celestron AstroMaster 130EQ - Telescopio reflector 130mm con montura ecuatorial -  Ideal para observación lunar y planetaria.', 'El AstroMaster 130EQ es un telescopio reflector de entrada a intermedio que ofrece un equilibrio perfecto entre potencia y facilidad de uso. Su diseño Newtoniano proporciona imágenes brillantes de:\r\nLuna: Cráteres de hasta 3 km de diámetro.\r\nPlanetas: Bandas de Júpiter, anillos de Saturno.\r\nObjetos brillantes de espacio profundo: Nebulosa de Orión (M42), Cúmulo de Hércules (M13).', 12860, 'https://m.media-amazon.com/images/I/61U0ojgVDtL._AC_SL1500_.jpg\r\nhttps://m.media-amazon.com/images/I/71WxwgVI3DL._AC_SL1500_.jpg\r\nhttps://m.media-amazon.com/images/I/61zobALwYXL._AC_SL1500_.jpg\r\n', 8, 1, 1, NULL),
(21, 'Celestron - Binoculares SkyMaster 25x100 Pro - Binoculares astronómicos profesionales de alta potencia - 25x aumentos - Objetivos de 100mm de apertura - Prismas BaK-4 con revestimiento multicapa - Estructura sellada al nitrógeno - Trípode adaptable - Incluye estuche rígido y tapas protectoras - Ideal para observación de cielo profundo.', 'Celestron SkyMaster 25x100 - Binoculares gigantes para astronomía profesional - Objetivos de 100mm de apertura - Prismas BaK-4 con revestimiento multicapa - Ideal para observación de cielo profundo', 'Los SkyMaster 25x100 son binoculares de gama alta diseñados para observación astronómica seria. Con sus lentes de 100mm, capturan un 150% más de luz que modelos de 70mm, revelando:\r\nCúmulos globulares: Resolución de estrellas individuales en M13.\r\nNebulosas brillantes: Estructura completa de la Nebulosa de Orión.\r\nGalaxias cercanas: Brazos espirales de M31 (Andrómeda).\r\nDetalles lunares: Cráteres de <2km con buena estabilidad.', 8751, 'https://m.media-amazon.com/images/I/71Q-X9UvsRL.__AC_SX300_SY300_QL70_ML2_.jpg\r\nhttps://m.media-amazon.com/images/I/71Q-X9UvsRL.__AC_SX300_SY300_QL70_ML2_.jpg\r\nhttps://m.media-amazon.com/images/I/51MMKZ3X-yL._AC_SX522_.jpg\r\n', 4, 2, 1, NULL),
(22, 'Meade - Telescopio LX85 8\" ACF - Telescopio Schmidt-Cassegrain profesional con montura computerizada - Sistema óptico Advanced Coma-Free (ACF) - Apertura de 203mm (8\") - Relación focal f/10 - Incluye controlador Autostar GPS y trípode de acero.', 'Meade  - Telescopio LX85 8\" ACF - Incluye controlador Autostar GPS y trípode de acero.', 'El LX85 8\" ACF combina óptica avanzada y montura computerizada en un sistema completo. Su diseño Advanced Coma-Free elimina aberraciones en todo el campo visual, ideal para:\r\n\r\nAstrofotografía de cielo profundo: Captura nebulosas y galaxias con detalles nítidos hasta los bordes\r\n\r\nPlanetaria: Resolución de 0.57 arc-seg para bandas de Júpiter y casquetes polares de Marte\r\n', 30850, 'https://www.cosentinostore.com.ar/Image/0/1500_1500-55893.jpeg\r\nhttps://www.cosentinostore.com.ar/Image/0/1500_1500-217000_alt01.jpeg\r\nhttps://www.cosentinostore.com.ar/Image/0/700_700-217000_alt02.jpeg', 12, 1, 7, NULL),
(23, 'Orion 130ST - Telescopio reflector Newtoniano de 130mm (5.1\") f/5 - Diseño compacto y portátil - Ideal para observación de cielo profundo y planetaria - Incluye montura ecuatorial y accesorios - Perfecto para astrónomos principiantes e intermedios.', 'Orion 130ST - Telescopio reflector de 130mm  -Ideal para observación de cielo profundo y planetaria.', 'El Orion 130ST es un telescopio reflector Newtoniano de 130mm (5.1\") y relación focal f/5, diseñado para ofrecer imágenes brillantes y detalladas tanto de objetos celestes como planetarios. Su diseño compacto y montura ecuatorial lo hacen ideal para observación avanzada de: \r\nPlanetas: Detalles de las bandas de Júpiter, anillos de Saturno y fases de Venus.\r\nCielo profundo: Nebulosas como M42 (Orión) y galaxias como M31 (Andrómeda).\r\nCúmulos estelares: Resolución de estrellas en M13 (Cúmulo de Hércules).\r\nLuna: Cráteres de ~1.5 km con claridad bajo buenas condiciones.', 37208, 'https://m.media-amazon.com/images/I/71+cV1ZAnBL._AC_SL1500_.jpg\r\nhttps://m.media-amazon.com/images/I/71d-LuSE6XL._AC_SL1500_.jpg\r\nhttps://m.media-amazon.com/images/I/61bGRHEqdtL._AC_SL1500_.jpg', 5, 1, 2, NULL),
(24, 'Sky-Watcher - Evostar 72ED - Telescopio refractor apocromático de 72mm (f/5.8) - Doblete ED (vidrio de baja dispersión) - Ideal para observación y astrofotografía de cielo profundo - Diseño ultraportátil y robusto - Incluye portaocular de 2\" y anillos de montaje - Compatible con reductores de focal y filtros.', 'Sky-Watcher Evostar 72ED - Refractor apocromático para astrofotografía - Diseño ultraportátil y robusto - Compatible con reductores de focal y filtros.', 'El Evostar 72ED es un telescopio refractor de 72mm de apertura y relación focal f/5.8, diseñado con óptica doblete ED (Extra-low Dispersion) para eliminar aberraciones cromáticas y ofrecer imágenes nítidas y de alto contraste. Perfecto para:\r\nCielo profundo: Nebulosas extensas (M42, M8) y galaxias (M31, M33) con gran campo de visión.\r\nCúmulos estelares: Detalle en M45 (Pléyades) y M11 (Patos Salvajes).\r\nPlanetas: Aunque no es su enfoque principal, revela bandas de Júpiter y anillos de Saturno.\r\nAstrofotografía: Captura de vastas regiones nebulosas y vía láctea gracias a su gran corrección de color.', 21560, 'https://m.media-amazon.com/images/I/61VAeFS24wL._AC_SL1500_.jpg\r\nhttps://m.media-amazon.com/images/I/61PN-ZYI36L._AC_SL1500_.jpg\r\nhttps://m.media-amazon.com/images/I/710itDaKmgL._AC_SL1500_.jpg\r\n', 9, 1, 5, NULL),
(25, 'Oberwerk - Binoculares Mariner 10x50 - Binoculares robustos y estancos para uso marino y terrestre - Prismas BaK-4 con revestimiento multicapa - Resistente a salpicaduras y niebla (purga de nitrógeno) - Campo de visión amplio (6.5°) - Incluye correa, tapas y estuche resistente - Ideales para navegación, observación de vida silvestre y astronomía básica.', 'Oberwerk Mariner 10x50 - Binoculares estancos para aventuras al aire libre - Ideales para navegación, observación de vida silvestre y astronomía básica.', 'Los Oberwerk Mariner 10x50 son binoculares diseñados para condiciones exigentes, con 10 aumentos y objetivos de 50mm, combinando portabilidad y rendimiento óptico superior. \r\nUsos destacados:\r\nNavegación marítima: Resistencia a salpicaduras y niebla interna (purga de nitrógeno).\r\nObservación terrestre: Vida silvestre, paisajes y deportes al aire libre.\r\nAstronomía básica: Visión de cúmulos estelares (Pléyades, Doble Cúmulo de Perseo) y la Luna (cráteres ≥3 km).', 9999, 'https://oberwerk.com/wp-content/uploads/2015/10/10x50ufcaps.jpg\r\nhttps://oberwerk.com/wp-content/uploads/2015/10/10x50edu-closeup-rotated.jpg\r\nhttps://oberwerk.com/wp-content/uploads/2015/10/DSC_9792-scaled.jpg\r\n', 21, 2, 14, NULL),
(26, 'Vixen - Binoculares Foresta 8x42 - Binoculares premium para observación de naturaleza y astronomía básica - Prismas de roof (Schmidt-Pechan) con revestimiento multicapa Dielectric - Lentes BaK-4 de alta transmisión luminosa - Cuerpo ultraligero de magnesio (620g) - Resistente al agua (IPX7) - Ajuste dióptrico y ocular de largo relieve (18mm) - Incluye estuche, correa y tapas protectoras.', 'Vixen Foresta 8x42 - Binoculares compactos de alto rendimiento para birding y cielos estrellados - Incluye estuche, correa y tapas protectoras.', 'Los Vixen Foresta 8x42 son binoculares de 8 aumentos y 42mm de apertura, diseñados para ofrecer imágenes brillantes y nítidas en condiciones de poca luz. \r\n\r\nUsos destacados:\r\nObservación de fauna: Detalle de aves y vida silvestre incluso al amanecer/atardecer.\r\nAstronomía básica: Cúmulos estelares (Pléyades, Hyades), la Luna (cráteres ≥2.5 km) y constelaciones.\r\nSenderismo y viajes: Compactos y ligeros (solo 620g) para llevar a cualquier aventura.', 0, 'https://www.alphacygni.com/22315-large_default/prismatico-vixen-foresta-8x42-cf.jpg\r\nhttps://www.alphacygni.com/22316-large_default/prismatico-vixen-foresta-8x42-cf.jpg\r\nhttps://www.alphacygni.com/22317-large_default/prismatico-vixen-foresta-8x42-cf.jpg', 10, 2, 14, NULL),
(27, 'Oberwerk – Binoculares 8×42 Explore ED – Binoculares Premium para Observación de Aves y Naturaleza – Prismas Roof BaK-4 con Revestimientos Dielectric Multicapa – Lentes de Vidrio ED (Baja Dispersión) – Resistencia al Agua (IPX7) y Niebla Interna – Incluye Estuche Rígido, Correa y Paño de Limpieza.', 'Oberwerk 8×42 Explore ED – Binoculares profesionales para naturaleza y astronomía básica - Ideal para navegación, observación nocturna y safaris.', 'Los Oberwerk 8×42 Explore ED son binoculares de gama alta diseñados para observadores exigentes. Con prismas Roof BaK-4, lentes ED (Extra-low Dispersion) y revestimientos multicapa Dielectric, ofrecen imágenes nítidas, brillantes y con colores realistas en cualquier condición de luz.\r\nAplicaciones destacadas:\r\nObservación de aves: Detalles de plumaje y comportamiento incluso en penumbra.\r\nNaturaleza y vida silvestre: Ideal para safaris, senderismo y fotografía de aproximación.\r\nAstronomía básica: Luna, cúmulos estelares (Pléyades) y constelaciones.\r\nDeportes al aire libre: Eventos deportivos, conciertos y turismo.', 799, 'https://oberwerk.com/wp-content/uploads/2024/07/explore_8x42_standing.webp\r\nhttps://oberwerk.com/wp-content/uploads/2024/07/explore_8x42_eyecup_view-510x203.webp\r\nhttps://oberwerk.com/wp-content/uploads/2024/07/explore_8x42_front.webp', 5, 2, 14, NULL),
(28, 'Explore Scientific - Ocular de ultra gran angular 82° 24mm - Ocular premium tipo Nagler para astronomía - Lentes de precisión con revestimientos Ultra-HD - Campo aparente de 82° - Distancia ocular de 20mm - Compatible con telescopios refractores, Newtonianos y Schmidt-Cassegrain - Ideal para observación de cielo profundo y panorámicas lunares.', 'Explore Scientific 82° 24mm - Ocular de ultra gran angular para astronomía - Ideal para observación de cielo profundo y panorámicas lunares.', 'El ocular Explore Scientific 82° 24mm es un ocular de ultra gran angular diseñado para proporcionar una experiencia de observación inmersiva. Con su campo aparente de 82°, ofrece vistas panorámicas del cielo, ideal para:\r\nAplicaciones destacadas:\r\nCielo profundo: Observación de grandes nebulosas (M42, M8) y galaxias (M31, M33) con un campo de visión amplio.\r\nLuna y planetas: Vistas panorámicas de la Luna y conjunciones planetarias.\r\nComodidad visual: Diseño ergonómico con alivio ocular de 20mm, apto para usuarios con gafas.', 899, 'https://www.explorescientific.com/cdn/shop/products/24_1200x1200.jpg?v=1571439044\r\nhttps://www.explorescientific.com/cdn/shop/products/82D_Family_ef04d4d6-6645-4d04-92e8-c754fc15799f_2000x2000.jpg?v=1571439044\r\n', 10, 3, 14, NULL),
(29, 'Baader Planetarium - Filtro UHC-S (Ultra High Contrast) - Filtro nebular profesional para astronomía - Banda de transmisión ultra-estrecha (24nm) - Mejora el contraste de nebulosas de emisión - Compatible con telescopios y binoculares - Rosca estándar 1.25\" y 2\" - Ideal para observación y astrofotografía de cielo profundo.', 'Baader UHC-S - Filtro nebular de alto contraste para observación y astrofotografía - Ideal para observación y astrofotografía de cielo profundo.', 'El filtro Baader UHC-S es un filtro de banda estrecha (24nm) diseñado para realzar nebulosas de emisión y planetarias, bloqueando la contaminación lumínica y transmitiendo solo las longitudes de onda clave del hidrógeno (H-α y H-β) y oxígeno (OIII).\r\nObjetos mejorados:\r\nNebulosas de emisión: M42 (Orión), M8 (Laguna), M17 (Omega) y la Nebulosa Norteamérica.\r\nNebulosas planetarias: M57 (Anillo), M27 (Dumbbell) y NGC 7293 (Hélice).\r\nAstrofotografía: Incrementa el contraste en cielos con contaminación lumínica moderada.', 299, 'https://m.media-amazon.com/images/I/31M+5oaEcRL._AC_SL1200_.jpg\r\nhttps://m.media-amazon.com/images/I/51pWazePRAL._AC_SX466_.jpg', 5, 3, 14, NULL),
(30, 'iOptron - Montura Ecuatorial CEM26 (Center-Balanced) - Montura para astrofotografía de carga media (11.3kg) - Diseño compacto y portátil - Precisión de seguimiento <0.5\" RMS - Incluye GPS integrado y nivel de burbuja - Compatible con GoTo y seguimiento autoguiado - Conexión WiFi/Bluetooth - Ideal para telescopios refractores y reflectores', 'iOptron CEM26 - Montura ecuatorial premium para astrofotografía - Ideal para telescopios refractores y reflectores.', 'La montura iOptron CEM26 es una solución profesional para astrofotógrafos y observadores avanzados. Con su innovador diseño Center-Balanced (CEM), combina estabilidad y portabilidad, soportando telescopios de hasta 11.3kg para astrofotografía).', 8000, 'https://www.telescopiomania.com/37016-thickbox_default/montura-ioptron-cem26-goto-ipolar-con-tripode-literoc.jpg\r\nhttps://www.telescopiomania.com/37019-thickbox_default/montura-ioptron-cem26-goto-ipolar-con-tripode-literoc.jpg\r\nhttps://www.telescopiomania.com/37017-thickbox_default/montura-ioptron-cem26-goto-ipolar-con-tripode-literoc.jpg', 8, 3, 14, NULL),
(31, 'ZWO - ASI 120MC-S - Cámara astronómica color para planetaria y guiado - Sensor CMOS Sony IMX224 (1/3\") - Resolución 1280x960 - Alta sensibilidad (0.8e⁻ de ruido) - USB 3.0 para transmisión rápida - Incluye software y filtro IR-cut - Ideal para fotografía lunar, planetaria y autoguiado en telescopios.', 'ZWO ASI 120MC-S - Cámara planetaria color de alto rendimiento - Ideal para fotografía lunar, planetaria y autoguiado en telescopios.', 'La ASI 120MC-S de ZWO es una cámara astronómica en color diseñada para capturar imágenes detalladas de planetas, la Luna y servir como cámara de guiado. Con su sensor CMOS Sony IMX224 y tecnología USB 3.0, ofrece:\r\n\r\nAplicaciones Principales:\r\nFotografía planetaria: Alta velocidad de captura (120 FPS) para detalles en Júpiter, Saturno y Marte.\r\nImagen lunar: Resolución de cráteres de ~1 km con telescopios de apertura media.\r\nAutoguiado preciso: Bajo ruido electrónico (0.8e⁻) para seguimiento estable en astrofotografía.', 17800, 'https://m.media-amazon.com/images/I/61nwLsLx86L._AC_SL1000_.jpg\r\nhttps://m.mediaamazon.com/images/I/51zE6IG0GKL._AC_SL1000_.jpg\r\nhttps://m.media-amazon.com/images/I/61hNssAMCkL._AC_SL1000_.jpg', 4, 5, 6, NULL),
(32, 'ZWO - ASI533MM-Pro - Cámara astronómica monocromática de 9MP para astrofotografía - Sensor CMOS Sony IMX533 (back-illuminated) - Resolución 3008x3008 (1:1 cuadrada) - Cero amp-glow y bajo ruido (1.0e⁻) - USB 3.0 de alta velocidad - Enfriamiento activo (ΔT=35°C) - Incluye rueda portafiltros electrónica opcional - Ideal para nebulosas, galaxias y ciencia ciudadana.', 'ZWO ASI533MM-Pro - Cámara monocromática profesional para cielo profundo - Ideal para nebulosas, galaxias y ciencia ciudadana.', 'La ASI533MM-Pro es una cámara astronómica monocromática de alto rendimiento con sensor Sony IMX533 back-illuminated, diseñada para astrofotografía de larga exposición. Su formato cuadrado único y tecnología avanzada la hacen ideal para:\r\n\r\nAplicaciones Premium:\r\nCielo profundo: Captura detallada de nebulosas (M42, NGC7000), galaxias (M31, M101) y nebulosas oscuras.\r\nFotometría científica: Gracias a su linealidad del 99.7% y cero amp-glow.\r\nImagen planetaria en alta resolución: Aprovechando su modo ROI a 120 FPS.', 25621, 'https://m.media-amazon.com/images/I/41Qv+YN-lWL._AC_.jpg\r\nhttps://m.media-amazon.com/images/I/41TAF-JYlTL._AC_.jpg\r\nhttps://m.media-amazon.com/images/I/51+P7RSIKyL._AC_SL1000_.jpg', 10, 5, 6, NULL),
(33, 'Lente Barlow 5X de 1.25 Pulgadas - Lente de Aumento 5X con Revestimiento Multicapa - Rosca T2/M35x1mm - Compatible con Oculares y Cámaras Astronómicas - Construcción en Aluminio de Grado Óptico - Ideal para Fotografía Planetaria y Observación Lunar Profesional.', 'Barlow 5X 1.25\" - Lente de aumento premium para astronomía - Ideal para Fotografía Planetaria y Observación Lunar Profesional.', 'La lente Barlow 5X de 1.25\" es un accesorio óptico diseñado para multiplicar por 5 los aumentos de tus oculares o cámaras astronómicas. \r\nAplicaciones Principales:\r\nFotografía planetaria: Captura detalles finos en Júpiter, Saturno y Marte.\r\nObservación lunar: Aumenta la resolución de cráteres (<1 km con telescopios de 150mm+).\r\nCompatibilidad universal: Funciona con oculares 1.25\" y cámaras (via rosca T2/M35x1mm).', 180, 'https://m.media-amazon.com/images/I/51sv-33NbfL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/51GZX4b6RvL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/617NSeb55JL._AC_SX522_.jpg', 8, 3, 14, NULL),
(34, 'Celestron - Travel Scope 70 DX - Telescopio refractor portátil de 70mm (2.76\") - Óptica de vidrio con revestimientos completos - Ideal para principiantes y viajes - Incluye trípode, mochila y adaptador para smartphones (digiscoping) - Perfecto para observación lunar, planetaria y vida silvestre.', 'Celestron Travel Scope 70 DX - Kit portátil para iniciarse en astronomía - Perfecto para observación lunar, planetaria y vida silvestre.', 'El Travel Scope 70 DX de Celestron es un telescopio refractor compacto y ligero, diseñado para observadores principiantes y viajeros.\r\nObjetos recomendados:\r\nLuna: Cráteres de 5+ km y mares lunares con detalle.\r\nPlanetas: Bandas de Júpiter, anillos de Saturno y fase de Venus.\r\nNaturaleza: Aves, paisajes y vida silvestre (uso diurno).', 9800, 'https://m.media-amazon.com/images/I/61U+hQsbuML._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/615GxSQ6rGL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/61PhMVY3GNL._AC_SX522_.jpg', 25, 1, 1, NULL),
(35, 'Celestron – Adaptador de Fotografía para Smartphone – Kit Universal Digiscoping – Compatible con la Mayoría de Teléfonos iOS y Android – Ajuste Seguro en Oculares de 1.25\" – Ideal para Capturar Fotos y Videos de la Luna, Planetas y Vida Silvestre – Incluye Control Remoto Inalámbrico.', 'Celestron – Adaptador Universal para Smartphone – Kit Universal Digiscoping – Compatible con la Mayoría de Teléfonos iOS y Android - Ideal para Digiscoping con Telescopios', 'El Adaptador de Smartphone Celestron es la herramienta perfecta para convertir tu telescopio en un potente equipo de fotografía astronómica y de naturaleza. Diseñado para ajustarse de manera segura a oculares de 1.25\", permite capturar imágenes y videos de alta calidad de:\r\nAstronomía: Fotografía lunar (cráteres, mares), planetas (Júpiter, Saturno) y objetos brillantes de cielo profundo.\r\nNaturaleza: Digiscoping de aves, vida silvestre y paisajes con telescopios terrestres.\r\nEducación: Comparte imágenes en tiempo real para observaciones grupales o proyectos escolares.', 112, 'https://m.media-amazon.com/images/I/51baIVCMCIS._AC_SL1000_.jpg\nhttps://m.media-amazon.com/images/I/61IMlw98GdS._AC_SX522_.jpg\nhttps://m.media-amazon.com/images/I/61M+Y1MjwTS._AC_SX522_.jpg', 15, 3, 1, NULL),
(36, 'Tasco - Telescopio Astronómico Profesional Luminova Reflector 114/900mm - Montura Ecuatorial con Trípode de Acero - Incluye 2 Oculares (20mm y 4mm) y Barlow 3x - Diseño Dorado - Ideal para Observación Lunar, Planetaria y Cielo Profundo.', 'Tasco Luminova 114/900 - Telescopio reflector para astronomía intermedia - Ideal para Observación Lunar, Planetaria y Cielo Profundo.', 'El Tasco Luminova 114/900 es un telescopio reflector Newtoniano con montura ecuatorial, diseñado para astrónomos principiantes y entusiastas que buscan explorar el cielo con mayor profundidad. \r\nObjetos recomendados:\r\nLuna: Cráteres de 2+ km, mares lunares y cadenas montañosas.\r\nPlanetas: Bandas de Júpiter, anillos de Saturno y fase de Venus.\r\nCielo profundo: Nebulosas brillantes (M42, M57) y galaxias cercanas (M31).', 15300, 'https://m.media-amazon.com/images/I/51IgJRhvZ5L._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/71OaaU123HL._AC_SX522_.jpg\r\n', 32, 1, 14, NULL),
(37, 'Timotech - Binoculares Militares 20x50 HD - Binoculares de Alta Potencia con Prismas BaK-4 y Revestimiento Óptico Completo - Resistente al Agua (IPX5) - Compactos y Ligeros - Incluye Estuche Rígido, Correa y Paño de Limpieza - Ideal para Observación de Aves, Astronomía, Caza y Eventos Deportivos.', 'Timotech 20x50 - Binoculares HD multifuncionales para actividades al aire libre - Ideal para Observación de Aves, Astronomía, Caza y Eventos Deportivos.', 'Los binoculares Timotech 20x50 son una opción versátil y potente para explorar el mundo con claridad. Con 20 aumentos y lentes de 50mm, ofrecen un equilibrio entre potencia y portabilidad, ideales para:\r\nObservación de aves: Detalles de plumaje y comportamiento a larga distancia.\r\nAstronomía básica: Luna (cráteres >3 km), cúmulos estelares (Pléyades) y planetas brillantes (Júpiter, Saturno).\r\nDeportes y eventos: Sigue la acción en estadios o campos abiertos con claridad.\r\nCaza y senderismo: Resistencia y rendimiento en condiciones variables.', 8560, 'https://m.media-amazon.com/images/I/71LoKJn9gAL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/71oqlDoImPL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/71NVzUTa3RL._AC_SL1500_.jpg', 23, 2, 14, NULL),
(38, 'Bluelander - Binoculares Portátiles 8x80 - Prismáticos Profesionales con Visión Nocturna y Resistencia al Agua - Alcance de 2,000 Metros - Prismas BaK-4 y Revestimiento Óptico Completo - Incluye Estuche Rígido, Correa y Paño de Limpieza - Ideales para Camping, Senderismo, Caza y Observación Nocturna.', 'Bluelander 8x80 - Binoculares de Largo Alcance con Visión Nocturna - Ideales para Camping, Senderismo, Caza y Observación Nocturna.', 'Los binoculares Bluelander 8x80 son una herramienta versátil y potente diseñada para actividades al aire libre y observación en condiciones de poca luz. Con 8 aumentos y lentes de 80mm, ofrecen un alcance efectivo de hasta 2,000 metros, ideal para:\r\nObservación Nocturna: Gracias a su gran apertura (80mm) y revestimientos ópticos avanzados.\r\nCaza y Senderismo: Detección de movimiento y seguimiento de fauna silvestre.\r\nCamping y Excursiones: Resistencia al agua y diseño robusto para entornos exigentes.\r\nEventos al Aire Libre: Ideal para conciertos, deportes o avistamiento de paisajes.', 7450, 'https://m.media-amazon.com/images/I/91RaDsPzUnL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/81MgtSC+maL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/51rSRbJO23L._AC_SX522_.jpg', 8, 2, 14, NULL),
(39, 'Tasco - Binoculares Essentials 10x42 - Binoculares de Largo Alcance con Prismas BaK-4 y Revestimiento Óptico Completo - Compactos y Ligeros (650g) - Resistencia Básica al Agua - Incluye Estuche, Correa y Paño de Limpieza - Ideales para Senderismo, Viajes, Avistamiento de Aves y Eventos Deportivos', 'Tasco Essentials 10x42 - Binoculares versátiles para actividades al aire libre - Ideales para Senderismo, Viajes, Avistamiento de Aves y Eventos Deportivos', 'Los binoculares Tasco Essentials 10x42 son una opción equilibrada para quienes buscan calidad óptica y portabilidad. Con 10 aumentos y lentes de 42mm, ofrecen un rendimiento confiable para:\r\nSenderismo y viajes: Tamaño compacto que cabe en cualquier mochila.\r\nAvistamiento de aves: Detección de especies a distancia media.\r\nDeportes al aire libre: Ideal para partidos de fútbol, golf o carreras.\r\nTurismo: Perfectos para miradores y visitas a parques naturales.', 6523, 'https://m.media-amazon.com/images/I/611TDKSFiRL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/51jazjesnvL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/613zy0VE7DL._AC_SX522_.jpg', 12, 2, 14, NULL),
(40, 'Boundless Performance – Arnés Binocular Premium – Sistema de Portabilidad Todo en Uno para Cazadores y Aventureros – Compatible con Binoculares, Telémetros y Accesorios – Correas Ajustables y Funda Protectora – Material Resistente al Agua y Duradero – Ideal para Caza, Senderismo y Tiro Deportivo.', 'Arnés Binocular Boundless Performance – Soporte ergonómico para actividades al aire libre – Ideal para Caza, Senderismo y Tiro Deportivo.', 'El arnés binocular de Boundless Performance es un sistema de transporte diseñado para mantener tus binoculares y accesorios seguros, accesibles y estables durante largas jornadas de caza, senderismo o tiro. Su diseño ergonómico elimina la fatiga en el cuello y mejora la comodidad.\r\n\r\nCaracterísticas destacadas:\r\nPortabilidad inteligente: Distribuye el peso de los binoculares (hasta 2 kg) en hombros y espalda.\r\nCompatibilidad universal: Ajustable para binoculares grandes (10x50, 12x42) y telémetros.\r\nAcceso rápido: Sistema de liberación rápida para usar los prismáticos en segundos.\r\nResistencia: Tejido 600D impermeable y costuras reforzadas para uso rudo.', 700, 'https://m.media-amazon.com/images/I/91bJdYBMRVL._AC_SL1500_.jpg\r\nhttps://m.media-amazon.com/images/I/91RJlLz6NuL._AC_SL1500_.jpg\r\nhttps://m.media-amazon.com/images/I/9154OvxatIL._AC_SL1500_.jpg', 30, 3, 14, NULL),
(41, 'Universo. La Guía Visual Definitiva (Edición 2024) – Enciclopedia Astronómica de Lujo en Pasta Dura – Atlas del Cosmos con Imágenes HD de la NASA y ESA – Datos Actualizados de Galaxias, Planetas y Exploración Espacial – Incluye Mapas Estelares y Diagramas Explicativos – Autor: DK Publishing.', 'Universo: La Guía Visual Definitiva (DK, 2024) – Libro de astronomía para todos los niveles.', 'La edición 2024 de \"Universo. La Guía Visual Definitiva\" de DK es una obra maestra de divulgación astronómica. Con imágenes en ultra alta resolución y contenidos revisados por expertos, ofrece un viaje desde el Sistema Solar hasta los confines del cosmos.\r\n\r\nContenido Destacado:\r\nImágenes exclusivas: Fotografías del James Webb, Hubble y misiones espaciales.\r\nInfografías detalladas: Comparativas de planetas, ciclos estelares y agujeros negros.\r\nNovedades 2024: Últimos descubrimientos en exoplanetas y materia oscura.\r\nHerramientas prácticas: Mapas mensuales del cielo y guía de observación.', 75, 'https://m.media-amazon.com/images/I/81kkrlfcMVL._SL1500_.jpg\r\nhttps://m.media-amazon.com/images/I/41lPJkpx5vL.jpg\r\nhttps://m.media-amazon.com/images/I/61Tn1GK8ssL.jpg\r\n', 10, 4, 14, NULL),
(42, 'Astrofísica para Gente con Prisa (Edición 2023) – Libro de Divulgación Científica por Neil deGrasse Tyson – Explicaciones Sencillas sobre el Big Bang, Agujeros Negros y la Vida en el Cosmos – Formato Pasta Blanda – Ideal para Principiantes en Astronomía – Editorial Paidós.', 'Astrofísica para Gente con Prisa – Neil deGrasse Tyson (Edición 2023).\r\n', 'La edición 2023 de \"Astrofísica para Gente con Prisa\" es la versión actualizada del bestseller de Neil deGrasse Tyson, donde desgloba los grandes misterios del universo en capítulos breves y accesibles. Perfecto para quienes buscan entender conceptos complejos sin tecnicismos.\r\n\r\nTemas clave:\r\nOrigen del universo: Desde el Big Bang hasta la materia oscura.\r\nAgujeros negros y estrellas de neutrones: Cómo funcionan y por qué importan.\r\nVida extraterrestre: La ciencia detrás de la búsqueda de vida en otros planetas.\r\nActualizaciones 2023: Nuevos descubrimientos en exoplanetas y misiones espaciales.', 89, 'https://m.media-amazon.com/images/I/81JgR3nS0oL._SY466_.jpg', 5, 4, 14, NULL),
(43, 'JUOPLD - Telescopio Astronómico Profesional 60/900mm - Telescopio Refractor para Principiantes y Niños - Aumentos Potentes hasta 675x - Incluye Trípode Ajustable, 3 Oculares (20mm, 12.5mm, 4mm) y Barlow 3x - Ideal para Observación Lunar, Planetaria y Terrestre - Portátil y Fácil de Usar.', 'JUOPLD 60/900mm - Telescopio refractor para principiantes - Ideal para Observación Lunar, Planetaria y Terrestre - Portátil y Fácil de Usar.', 'El telescopio JUOPLD 60/900mm es un modelo refractor diseñado para introducir a niños y adultos en la astronomía. Con su apertura de 60mm y distancia focal de 900mm, ofrece imágenes claras de objetos celestes brillantes y observación terrestre.\r\n\r\nAplicaciones principales:\r\nObservación lunar: Cráteres de 3+ km y mares lunares.\r\nPlanetas: Bandas de Júpiter, anillos de Saturno y fase de Venus.\r\nNaturaleza: Aves, paisajes y vida silvestre (uso diurno).', 20000, 'https://m.media-amazon.com/images/I/61CVY61IOOL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/81gusPcCBLL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/71IkYkuFyEL._AC_SX522_.jpg\r\n', 10, 1, 14, NULL),
(44, 'ZWO Seestar S50 - Telescopio Inteligente Todo en Uno con Tecnología Smart - Automatizado con App Integrada - Ideal para Astrofotografía y Observación Lunar/Planetaria - Sensor CMOS Sony IMX462 - WiFi y Bluetooth - Diseño Portátil (2.5kg) - Incluye Batería Recargable - Para Principiantes y Expertos.', 'ZWO Seestar S50 - Telescopio digital inteligente para astrofotografía fácil - Incluye Batería Recargable - Para Principiantes y Expertos.', 'El Seestar S50 de ZWO revoluciona la astrofotografía con un sistema todo en uno automatizado. Combina telescopio, cámara y montura en un dispositivo compacto que se controla desde tu smartphone.\r\nAplicaciones destacadas:\r\nAstrofotografía automática: Captura nebulosas (M42), galaxias (M31) y planetas sin necesidad de configuración compleja.\r\nObservación en tiempo real: Visualiza imágenes directamente en tu móvil/tablet.\r\nModo educativo: Ideal para niños y principiantes con tutoriales integrados.\r\n\r\n', 34560, 'https://m.media-amazon.com/images/I/61HBCbdwwTL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/61X64gyhtDL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/61ArgwHjk5L._AC_SX522_.jpg', 20, 1, 6, NULL),
(45, 'Zopsc Planisferio Star Target, Guía de Mapas Estelares de Astronomía con 100 Cúmulos de Estrellas, Nebulosas y Galaxias, para Observar Constelaciones, Estrellas Brillantes y Objetos', 'Planisferio Star Target Zopsc - Guía práctica para explorar el cielo nocturno.', 'Guía clara de las estrellas: Este mapa estelar proporciona a los entusiastas de la astronomía una guía completa de constelaciones, estrellas brillantes y objetos del espacio profundo. para pulir tus habilidades para observar las estrellas.\r\nObservación versátil: Ya sea que esté usando un telescopio, binoculares o simplemente sus ojos, este mapa estelar es una herramienta valiosa. Mejore sus observaciones astronómicas con facilidad.\r\nUso durante todo el año: Diseñado para el rango de latitud norte de 30 a 50 grados, este mapa estelar se puede utilizar durante todo el año. Disfrute de una observación ininterrumpida de las estrellas independientemente de la fecha del calendario.', 70, 'https://m.media-amazon.com/images/I/71exCCLfTNL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/71jhVR6CpqL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/710HLREAG7L._AC_SX522_.jpg', 8, 4, 14, NULL);
INSERT INTO `producto` (`id_prod`, `nombre_prod`, `nombrecorto_prod`, `descripcion_prod`, `precio`, `url_imagen`, `stock`, `id_departamento`, `id_marca`, `id_oferta`) VALUES
(46, 'David H. Levy\'s Guide to the Stars (Mapa Estelar) - Edición en Inglés - Mapa del Cielo Nocturno para Astrónomos Aficionados - Incluye Constelaciones, Planetas y Objetos de Cielo Profundo - Diseñado por el Descubridor de 22 Cometas - Formato Plegable (22 x 28 cm) - Resistente y Portátil - Publicado el 1 de Diciembre de 2000.', 'David H. Levy\'s Guide to the Stars - Mapa estelar clásico para observación astronómica - Publicado el 1 de Diciembre de 2000.', 'Este mapa estelar plegable, creado por el renombrado astrónomo David H. Levy (descubridor de 22 cometas, incluido el famoso Shoemaker-Levy 9), es una herramienta esencial para identificar constelaciones, planetas y objetos celestes brillantes a simple vista o con binoculares.\r\n\r\nCaracterísticas destacadas:\r\nMapa del cielo completo: Cubre ambas latitudes (norte y sur) con símbolos claros para estrellas hasta magnitud 5.5.\r\nObjetos especiales marcados: 50+ cúmulos, nebulosas y galaxias visibles sin telescopio (ej. M31, M42, M45).\r\nDiseño práctico: Laminado resistente a la humedad y dobleces, ideal para usar al aire libre.\r\nIncluye guía de planetas: Posiciones aproximadas para 2000-2010 (útil como referencia histórica).', 55, 'https://m.media-amazon.com/images/I/A1mjR-1WBML._SY342_.jpg\r\nhttps://m.media-amazon.com/images/I/91kehrTFHaL._SX445_.jpg\r\nhttps://m.media-amazon.com/images/I/91FQZ9sM5xL._SY342_.jpg\r\n', 5, 4, 14, NULL),
(47, 'National Geographic Stargazer\'s Atlas: The Ultimate Guide to the Night Sky (Edición 2022) – Atlas Astronómico de Lujo en Pasta Dura – Mapas Detallados del Cielo Nocturno y Datos Científicos Actualizados – Fotografías HD de Galaxias, Nebulosas y Planetas – Incluye Guía de Observación por Estaciones – Para Astrónomos Aficionados y Expertos.\r\n\r\n', 'Stargazer\'s Atlas de National Geographic – La guía definitiva del cielo nocturno (2022).', 'El Stargazer\'s Atlas de National Geographic es una obra maestra de la cartografía celeste, combinando datos científicos rigurosos con el sello visual característico de NG. Esta edición 2022 incluye:\r\n\r\nContenido destacado:\r\nMapas estelares en 3D: Proyecciones detalladas de ambos hemisferios con 150+ constelaciones y objetos de cielo profundo.\r\nImágenes exclusivas: Fotografías del telescopio James Webb, Hubble y observatorios terrestres.\r\nGuía práctica: Tablas de planetas visibles, eclipses (hasta 2030) y lluvias de meteoros.\r\nEnfoque educativo: Capítulos sobre cosmología, exoplanetas y astrofotografía.\r\n\r\n', 80, 'https://m.media-amazon.com/images/I/81wFWp5ioOL._SY385_.jpg\r\nhttps://m.media-amazon.com/images/I/716pcZIKSdL._SX606_.jpg\r\nhttps://m.media-amazon.com/images/I/71A4PK1qk1L._SX606_.jpg', 5, 4, 14, NULL),
(48, 'Kit de 6 Filtros de Telescopio 1.25\" - Filtros Astronómicos Profesionales para Luna, Planetas y Observación Visual - Incluye Filtros de Colores (Rojo, Azul, Verde, Amarillo, Naranja, Neutro) + Caja de Almacenamiento - Compatible con Oculares de 1.25\" - Ideal para Mejorar el Contraste y Detalle', 'it de 6 Filtros de Telescopio 1.25\" – Para observación lunar y planetaria  - Ideal para Mejorar el Contraste y Detalle.', 'Este kit de 6 filtros de colores de 1.25\" está diseñado para mejorar la observación astronómica, especialmente de la Luna y los planetas. Cada filtro está optimizado para resaltar detalles específicos, reducir el brillo y mejorar el contraste.\r\n\r\nIncluye:\r\n\r\n6 filtros de colores: Rojo (#23A), Verde (#56), Azul (#80A), Amarillo (#12), Naranja (#21) y Neutro (ND25%).\r\n\r\nCaja de almacenamiento: Protectora y organizada.', 250, 'https://m.media-amazon.com/images/I/61AWIXSOCEL._AC_SX679_.jpg\r\nhttps://m.media-amazon.com/images/I/61f6vDXnVNL._AC_SX679_.jpg\r\nhttps://m.media-amazon.com/images/I/71x5CVTfdGL._AC_SX679_.jpg', 12, 3, 14, NULL),
(49, 'Celestron - Telescopio Computerizado NexStar 130SLT - Telescopio Reflector Newtoniano de 130mm (5.1\") - Montura Computerizada Altazimutal - Tecnología SkyAlign para Alineación Rápida - Control Manual Computerizado - Base de Datos de 4,000+ Objetos Celestes - Ideal para Principiantes y Astrónomos Intermedios.', 'Celestron NexStar 130SLT - Telescopio computarizado para exploración astronómica - Ideal para Principiantes y Astrónomos Intermedios. ', 'El NexStar 130SLT de Celestron es un telescopio reflector Newtoniano computerizado que combina un gran poder de captación de luz (130mm de apertura) con la facilidad de uso de una montura automatizada. Perfecto para:\r\n\r\nAplicaciones destacadas:\r\nObservación planetaria: Detalles en Júpiter (bandas atmosféricas), Saturno (anillos) y Marte (casquetes polares).\r\nCielo profundo: Nebulosas brillantes (M42, M57) y galaxias cercanas (M31, M33).\r\nTecnología fácil: Sistema SkyAlign para alineación en 3 minutos sin conocimientos previos.\r\n\r\n', 37680, 'https://m.media-amazon.com/images/I/510IB6E+EqL._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/51gJYTnloKL._AC_.jpg\r\nhttps://m.media-amazon.com/images/I/61xGLlHCeQL._AC_SX522_.jpg\r\n', 15, 1, 1, NULL),
(50, 'Celestron - NexYZ - Adaptador Universal para Smartphone de 3 Ejes - Compatible con la Mayoría de Teléfonos (iPhone, Samsung, Huawei, etc.) - Sistema de Ajuste de 3 Ejes para Alineación Precisa - Compatible con Oculares de Telescopios y Binoculares - Ideal para Astrofotografía Básica, Observación de Aves y Digiscoping.', 'Celestron NexYZ - Adaptador de smartphone de 3 ejes para telescopios y binoculares - Ideal para Astrofotografía Básica, Observación de Aves y Digiscoping.', 'El adaptador Celestron NexYZ es un sistema profesional de acoplamiento para smartphones que permite capturar imágenes y videos a través de telescopios o binoculares. Su innovador diseño de 3 ejes (X, Y, Z) garantiza una alineación perfecta entre la cámara del teléfono y el ocular, eliminando viñeteo y distorsiones.\r\n\r\nAplicaciones principales:\r\nAstrofotografía básica: Fotografía lunar, planetaria y de objetos brillantes de cielo profundo.\r\nObservación de aves y naturaleza: Digiscoping de alta calidad con binoculares.\r\nEducación y ciencia ciudadana: Comparte imágenes en tiempo real con fines educativos.', 250, 'https://m.media-amazon.com/images/I/51PTYDfsmnS._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/61HdZQ2fLaS._AC_SX522_.jpg\r\nhttps://m.media-amazon.com/images/I/61HdZQ2fLaS._AC_SX522_.jpg', 10, 3, 1, NULL);

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

--
-- Volcado de datos para la tabla `reseña`
--

INSERT INTO `reseña` (`id_reseña`, `id_usuario`, `id_prod`, `comentario`, `fec_res`, `punt`) VALUES
(1, 1, 16, 'Muy buena!\r\nEs una guía que me ha ayudado bastante en lo que respecta a la exploración y observación de planetas y estrellas, lo recomiendo mucho, es muy fácil de entender ', '2025-04-16', 5),
(2, 2, 29, 'Excelente filtro.\r\nNo hay mucho que opinar, cumple muy bien con su propósito y es muy bueno en la relación calidad-precio, lo recomiendo.', '2025-04-15', 5),
(3, 3, 12, 'Cumple pero hasta ahí.\r\nLa compré porque necesitaba tener energía de repuesto, la utilice varías veces pero sentí que su capacidad de almacenamiento iba disminuyendo cada vez más, si la vas usar como almacenamiento principal puedes pensártelo dos veces.', '2025-04-14', 3.5),
(4, 2, 49, 'Excelente producto!\r\nNunca había utilizado un telescopio tan completo como este, incluso si eres principiante le vas a entender gracias al manual de usuario tan detallado que tiene, muy buen telescopio  ', '2025-04-16', 5),
(5, 1, 31, 'Me agradó mucho.\r\nUna excelente cámara que me ha ayudado a sacar buenas tomas, me agrada mucho que sea liviana y que tenga una muy buena definición. ', '2025-04-17', 5),
(6, 3, 41, 'Buena guía.\r\nMe ayudó bastante a encontrar planetas del sistema solar y muchas estrellas que no sabía que existían, muy buen producto ', '2025-04-18', 5),
(7, 1, 21, 'Buen Producto\r\nSon algo pesados pero por la calidad de imagen lo vale. He podido ver la luna, un eclipse y hasta nebulosas de forma fácil sin necesidad de un telescopio. Los volvería a comprar sin duda, son muy resistentes y de buena calidad. ', '2025-04-17', 4.5),
(8, 2, 50, 'Buena Calidad.\r\nFácil de usar, centrar la cámara del teléfono en el ocular del telescopio es sencillo con las perillas de ajuste de cada eje. Mantiene la alineación aún después de desmontar el soporte.', '2025-04-12', 5),
(9, 1, 35, 'Bueno pero hasta ahí.\r\nEs un buen soporte para celular. Ayuda mucho para tomar fotografías junto con los binoculares. Aunque le queda algo justo a mi celular con funda. Los materiales son de buena calidad aunque no de la mejor. Tuve problemas para enlazar el disparador.', '2025-04-17', 4),
(10, 3, 19, 'Buen producto.\r\nFunciona genial como intervalómetro y como disparador remoto. Lo único que le hace falta es un botos de encendido/apagado, no me gusta dejarle las pilas puestas ya que si se presiona un botón por error, se prende automáticamente. Pero en general está muy bien.', '2025-04-16', 4.5),
(11, 2, 32, 'Excelente.\r\nCumple con su función, es bastante ligera, por lo que va perfecta con un setup ligero, el guiado es muy preciso incluso en condiciones difíciles (a veces tomó fotografías en la azotea de un edificio que vibra ligeramente con El Paso de camiones, pero el guiado se mantiene dentro de lo aceptable). Excelente para equipo inicial-intermedio.', '2025-04-17', 4.5),
(12, 2, 48, 'Buen producto.\r\nUna opción muy buena y económica.', '2025-04-18', 5),
(13, 1, 11, 'El trípode es de patas de aluminio, el cabezal y montura es de acero bastante robusto. Su ensamblado es fácil y cuenta con una charola para oculares y sus respectivos bastones para el control de movimiento lento.\r\nposee altura ajustable y en general se siente aceptablemente robusto para astronomía visual. ', '2025-04-19', 4.5),
(14, 3, 40, 'Buen producto.\r\nHe hecho de 20 a 30 viajes de caza con ella y se mantiene bien unida. Se adapta bien a mis binoculares y los bolsillos funcionan bien. Ojalá fueran un poco más grandes.', '2025-04-16', 4.5),
(15, 2, 1, 'Excelente!\r\nEl telescopio me encantó, la verdad es que he podido ver pocas cosas con él porque todavía no lo domino, vivo en una zona urbana y no he tenido oportunidad de llevarlo a una zona sin tanta contaminación lumínica. La Luna se ve impresionante, se pueden ver muchos detalles. Aunque es difícil dominar el uso de la montura ecuatorial, vale la pena si eres paciente y sobre todo recomiendo ver algunos videos de YouTube que explican cómo usarlo y qué cosas se pueden ver con este telescopio.', '2025-04-16', 5);

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
  `passw` varchar(250) NOT NULL,
  `direc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `apeP`, `apeM`, `email`, `passw`, `direc`) VALUES
(1, 'Samuel', 'Peréz', 'De Gante', 'samuelpdg2003@gmail.com', 'f37337a99e3cb97ffdda3dd27e25d1ee0bffbf08360a6a52cd55b6fc1486faea', '20 de Noviembre #4, Ciudad de México'),
(2, 'José', 'Rodríguez', 'Ocón', 'jos333-@hotmail.com', '53d71639091d4bb03ec66dbf4623155361185499231cae8c024da864dd9502e0', 'Bosques de África #40, Nezahualcóyotl'),
(3, 'Yasid', 'Conde', 'Sánchez ', 'yasidkonde18@gmail.com', 'ccb64095f0864f6457d87f616c14e120d3e143502c29ace42168d530b03c91df', 'Iztapalapa #18, Ciudad de México');

--
-- Disparadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `Encriptar_passw` BEFORE INSERT ON `usuario` FOR EACH ROW BEGIN
    IF NEW.passw IS NOT NULL AND NEW.passw != '' THEN
        SET NEW.passw = SHA2(CONCAT('salt-secreto-', NEW.passw), 256);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_carritos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_carritos` (
`id_carrito` int(11)
,`id_usuario` int(11)
,`fecha_creacion` datetime
,`total` double
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_carritos`
--
DROP TABLE IF EXISTS `vista_carritos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_carritos`  AS SELECT `c`.`id_carrito` AS `id_carrito`, `c`.`id_usuario` AS `id_usuario`, `c`.`fecha_creacion` AS `fecha_creacion`, sum(`cd`.`cantidad` * `cd`.`precio`) AS `total` FROM (`carrito` `c` join `carrito_detalle` `cd` on(`c`.`id_carrito` = `cd`.`id_carrito`)) GROUP BY `c`.`id_carrito` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id_carrito`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `carrito_detalle`
--
ALTER TABLE `carrito_detalle`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `id_carrito` (`id_carrito`),
  ADD KEY `id_prod` (`id_prod`);

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
  ADD KEY `idx_nombre_producto` (`nombrecorto_prod`(768));

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
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `carrito_detalle`
--
ALTER TABLE `carrito_detalle`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id_prod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `reseña`
--
ALTER TABLE `reseña`
  MODIFY `id_reseña` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `carrito_detalle`
--
ALTER TABLE `carrito_detalle`
  ADD CONSTRAINT `carrito_detalle_ibfk_1` FOREIGN KEY (`id_carrito`) REFERENCES `carrito` (`id_carrito`),
  ADD CONSTRAINT `carrito_detalle_ibfk_2` FOREIGN KEY (`id_prod`) REFERENCES `producto` (`id_prod`);

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

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `eliminar_carritos_pagados` ON SCHEDULE EVERY 1 DAY STARTS '2025-05-01 20:16:37' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  -- Eliminar detalles primero (por integridad referencial)
  DELETE cd FROM carrito_detalle cd
  JOIN carrito c ON cd.id_carrito = c.id_carrito
  WHERE c.estado = 'pagado';

  -- Luego eliminar el carrito
  DELETE FROM carrito
  WHERE estado = 'pagado';
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
