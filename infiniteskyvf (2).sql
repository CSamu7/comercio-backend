-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-04-2025 a las 04:02:17
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
  `nombrecorto_prod` text NOT NULL,
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
(1, 'Celestron - Telescopio NexStar 8SE - Telescopio computarizado para principiantes y usuarios avanzados - Montura Goto totalmente automatizada - Tecnología SkyAlign - Más de 40,000 objetos celestes - Espejo primario de 8 pulgadas.', 'Celestron - Telescopio NexStar 8SE - Más de 40,000 objetos celestes - Espejo primario de 8 pulgadas.\r\n', 'El NexStar 8SE es un telescopio computarizado de alto rendimiento que combina tecnología avanzada con facilidad de uso. Su espejo primario de 8 pulgadas (203mm) ofrece imágenes brillantes y detalladas de planetas, nebulosas y galaxias. La montura motorizada Goto permite localizar automáticamente más de 40,000 objetos celestes con solo presionar un botón, gracias a su sistema SkyAlign para alineamiento rápido. Incluye ocular de 25mm, controlador manual y software educativo. Ideal para observadores intermedios y avanzados que buscan precisión y portabilidad.', 1599, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrJciTD-GllUePcKGhSV33KV99L2beBy2smg&s', 8, 1, 1, NULL),
(2, 'Sky-Watcher - Telescopio Refractor 120mm EQ3 - Telescopio refractor para principiantes y aficionados - Montura ecuatorial para seguimiento preciso - Lente de alta calidad de 120mm - Ideal para observación lunar y planetaria.', 'SkyWatcher - Telescopio Refractor 120mm EQ3- Ideal para observación lunar y planetaria.', 'Este telescopio refractor profesional destaca por su lente acromática de 120mm, que reduce aberraciones cromáticas para imágenes nítidas. La montura ecuatorial EQ3 ofrece seguimiento preciso de planetas, la Luna y estrellas dobles. Perfecto para aficionados que desean adentrarse en la astronomía óptica, con capacidad limitada para astrofotografía básica.', 899, 'https://m.media-amazon.com/images/I/711XoZ4AvOL.jpg', 5, 1, 5, NULL),
(3, 'Orion - Telescopio Dobsoniano SkyQuest XT10 Clásico - Telescopio reflector para astrónomos principiantes y avanzados - Diseño dobsoniano de fácil manejo - Gran apertura de 254mm (10\") para imágenes brillantes - Base altazimutal suave y estable - Ideal para observación de espacio profundo', 'Orion XT10 -  Telescopio Dobsoniano SkyQuest XT10 Clásico - Ideal para observación de espacio profundo.\r\n\r\n', 'El Telescopio Dobsoniano SkyQuest XT10 Clásico de Orion es un instrumento de gran apertura diseñado para revelar el universo con claridad excepcional. Su espejo parabólico de 10 pulgadas (254mm) recoge hasta un 77% más de luz que un telescopio de 8\", permitiendo observar galaxias, nebulosas y cúmulos estelares con ricos detalles', 699, 'https://www.sbkmexico.com/catalogo/images/OR08947.jpg', 6, 1, 2, NULL),
(4, 'Meade - Telescopio LX200 12\" - Telescopio avanzado Schmidt-Cassegrain para astrónomos expertos - Montura computerizada altazimutal/ecuatorial - Apertura ultra-grande de 304mm (12\") ', 'Meade - Telescopio LX200 12\" - Telescopio avanzado Schmidt-Cassegrain - Ideal para la observación de objetos celestes con detalles.', 'El Telescopio LX200 12\" ACF de Meade representa la cúspide de la tecnología astronómica amateur, combinando un sistema óptico Advanced Coma-Free (ACF) de 12\" (304mm) con una montura computerizada de alta precisión. Este instrumento está diseñado para astrofotografía de largo alcance y observación de objetos celestes con detalles sin precedentes.', 3499, 'https://www.meade.com.mx/wp-content/uploads/2016/06/lx200_12in_leftside_1210-60-03-671x1030.jpg', 3, 1, 7, NULL),
(5, 'Celestron - Telescopio Portátil Travel Scope \"80mm - Telescopio refractor ultraportátil para viajes y observación casual - Apertura de 70mm -  Montura altazimutal ligera de mesa.', 'Celestron - Telescopio Portátil Travel Scope \"80mm - para viajes y observación casual - Ideal para observación lunar.', 'Telescopio refractor ultraportátil (70mm u 80mm) diseñado para excursionistas y viajeros. Viene con mochila resistente, trípode de mesa y adaptador para smartphone para fotografía básica. Los oculares de 20mm y 10mm permiten aumentos versátiles, mientras que su lente multicapa mejora el contraste. Ideal para observación lunar, aves o paisajes, con un peso mínimo (1.5 kg el modelo 70mm).', 99, 'https://www.celestronmexico.com/wp-content/uploads/2020/02/22035_Travel_Scope_70_DX_v1.jpg', 15, 1, 1, NULL),
(6, 'Orion - Binoculares Astronómicos 20x80 - Binoculares profesionales para observación astronómica y terrestre - Aumentos 20x con lentes de 80mm de apertura - Prismas BaK-4 para imágenes brillantes y de alto contraste.', 'Orion - Binoculares Astronómicos 20x80 - Aumentos 20x con lentes de 80mm de apertura - ideal para escanear la Vía Láctea.  ', 'Binoculares de alta gama con aumento 20x y lentes de 80mm, equipados con prismas BaK-4 y revestimiento Fully Multi-Coated para máxima claridad. Su campo de visión de 3.2° es ideal para escanear la Vía Láctea, cúmulos como las Pléyades o la Luna. Incluyen adaptador para trípode (necesario por su peso de 1.8 kg) y estuche rígido. Recomendados para astrónomos que buscan una alternativa a telescopios.', 199, 'https://m.media-amazon.com/images/I/71-qQZQB0PL._AC_UF894,1000_QL80_.jpg', 12, 2, 2, NULL),
(7, 'Celestron - Binoculares SkyMaster 15x70 - Binoculares astronómicos profesionales de alto rendimiento - 15x aumentos - Lentes de 70mm - Prismas BaK-4 - Revestimiento multicapa - Incluye adaptador para trípode - Ideal para astronomía y observación terrestre.', 'Celestron - Binoculares SkyMaster 15x70 - 15x aumentos - Lentes de 70mm - Ideal para astronomía y observación terrestre.', 'Los Binoculares Celestron SkyMaster 15x70 son instrumentos ópticos profesionales diseñados para observación astronómica y terrestre. Con 15x aumentos y lentes de 70mm, ofrecen imágenes brillantes y detalladas gracias a sus prismas BaK-4 y revestimiento multicapa que maximizan la transmisión de luz. Su amplio campo de visión de 4.4° permite explorar cúmulos estelares, la Luna y objetos de espacio profundo, mientras que su diseño sellado al nitrógeno los hace resistentes a la humedad. ', 129, 'https://vyorsa.com.mx/media/catalog/product/cache/5c9671fc3539eb4576835b6f9295a2cf/1/4/1461167325_283197.jpg', 10, 2, 1, NULL),
(8, 'Nikon - Binoculares Aculon A211 10x50 - Binoculares versátiles para observación terrestre y astronomía básica - 10x aumentos - Lentes de 50mm - Prismas BaK-4 - Revestimiento multicapa - Campo de visión de 6.5° - Diseño ergonómico y ligero.', 'Nikon - Binoculares Aculon A211 10x50 - 10x aumentos - Lentes de 50mm - Ideal para naturaleza y astronomía básica.', 'Los Binoculares Nikon Aculon A211 10x50 son un instrumento óptico versátil y accesible, perfecto para observación terrestre y astronomía básica. Con 10x aumentos y lentes de 50mm, ofrecen un equilibrio perfecto entre potencia y luminosidad. Sus prismas BaK-4 y revestimiento multicapa garantizan imágenes nítidas y brillantes, incluso en condiciones de poca luz.', 89, 'https://m.media-amazon.com/images/I/416F-nh3u2L.jpg', 18, 2, 8, NULL),
(9, 'Tele Vue - Ocular Nagler 13mm Tipo 6 - Ocular ultra gran angular de 82° para astronomía profesional - Diseño de 7 elementos con lentes de alta transmisión - Distancia de eye relief de 12mm - Compatible con telescopios de 1.25\" y 2\" - Ideal para observación de cielo profundo y planetaria.', 'Tele Vue - Ocular Nagler 13mm - Ultra gran angular 82° - Para observación profesional - Ideal para observación de cielo profundo y planetaria.', 'El Ocular Tele Vue Nagler 13mm Tipo 6 es un ocular premium diseñado para astrónomos exigentes. Con su campo aparente ultra amplio de 82°, ofrece una experiencia de observación inmersiva, perfecta para explorar cúmulos estelares, nebulosas y planetas con gran detalle.', 599, 'https://m.media-amazon.com/images/I/61IpSjmyRyL.jpg', 5, 3, 3, NULL),
(10, 'Celestron - Filtro Lunar 1.25\" - Filtro óptico premium para observación lunar - Reduce el brillo y mejora el contraste - Densidad neutra (ND-96) - Elimina el deslumbramiento - Compatible con todos los oculares 1.25\" - Ideal para telescopios y binoculares astronómicos.\r\n\r\n', 'Celestron - Filtro Lunar 1.25\" - Reduce brillo y mejora detalles lunares - Ideal para telescopios y binoculares astronómicos.', 'El Filtro Lunar Celestron 1.25\" es un accesorio esencial para observadores lunares, diseñado para reducir la intensidad de la luz y revelar detalles superficiales con claridad. Tecnología ND-96 (0.9 densidad neutra) filtra un 82% de la luz, eliminando el deslumbramiento durante las fases de Luna llena.', 29, 'https://www.celestronmexico.com/wp-content/uploads/2021/11/94105_Filtro-lunar-neutral.jpg', 20, 3, 1, NULL),
(11, 'Orion - Montura Ecuatorial Atlas Pro AZ/EQ-G - Montura computerizada profesional para astrofotografía - Capacidad de carga 45 kg - Modos ecuatorial/altazimutal - Compatible con WiFi/PC.', 'Orion - Montura Atlas Pro AZ/EQ-G - Doble modo ecuatorial/altazimutal - 45kg capacidad - Incluye controlador Atlas Pro y trípode de acero.', 'La montura Orion Atlas Pro AZ/EQ-G es una solución profesional para observación y astrofotografía avanzada. Con su diseño híbrido, funciona en modo ecuatorial (para astrofotografía de larga exposición) y altazimutal (para observación visual rápida).', 1999, 'https://www.astroshop.es/Produktbilder/zoom/46557_1/Orion-Montura-Atlas-Pro-AZ-EQ-G-SynScan-GoTo.jpg', 4, 3, 2, NULL),
(12, 'Celestron - Batería PowerTank 12V 7Ah - Fuente de alimentación portátil para telescopios - Batería recargable de ciclo profundo - Salidas 12V DC (5A) y USB (2.1A) - Incluye cables para monturas Celestron/Meade - Luz LED integrada -', 'Celestron - PowerTank 12V - Alimentación portátil para telescopios - 7Ah de capacidad.', 'La Batería PowerTank 12V de Celestron es una solución de energía portátil diseñada específicamente para telescopios computerizados y accesorios astronómicos. Con su batería de plomo-ácido sellada de 7Ah, proporciona hasta 20 horas de uso continuo con monturas como la NexStar SE o CG-4.', 89, 'https://m.media-amazon.com/images/I/61+xg8Vl-tL._AC_UF894,1000_QL80_.jpg', 12, 3, 1, NULL),
(13, 'Celestron - Reductor de Focal f/6.3 para telescopios Schmidt-Cassegrain - Aumenta campo de visión y reduce tiempo de exposición - Compatible con modelos C5/C6/C8/C9.25/C11 - Conexión estándar 1.25\" y 2\" - Ideal para astrofotografía y observación de cielo profundo.', 'Celestron - Reductor Focal f/6.3 - Para telescopios SCT - Mejora campo visual y luminosidad.', 'El Reductor Focal f/6.3 de Celestron es un accesorio óptico diseñado para telescopios Schmidt-Cassegrain, que reduce la relación focal de f/10 a f/6.3. Aumenta el campo de visión un 37% (ideal para objetos extensos como la Nebulosa de Orión), reduce el tiempo de exposición en astrofotografía (4x más rápido que en f/10) y mejora la luminosidad para observación visual de nebulosas y galaxias.', 149, 'https://m.media-amazon.com/images/I/71BalOnEL5L.jpg', 7, 3, 1, NULL),
(14, 'Libro Cosmos de Carl Sagan - Obra maestra de divulgación científica - Edición actualizada con prólogo de Neil deGrasse Tyson - Incluye ilustraciones a todo color y nuevos hallazgos astronómicos - 384 páginas - Editorial Planeta - ISBN 978-8408198901.', 'Libro Cosmos - Carl Sagan - Clásico de astronomía y ciencia - Editorial Planeta - ISBN 978-8408198901.', '\"Cosmos\", la obra icónica de Carl Sagan, es un viaje literario a través del universo que combina astronomía, filosofía e historia de la ciencia. Esta edición especial incluye:\r\n13 capítulos que exploran desde el Big Bang hasta el origen de la vida, actualizaciones científicas basadas en descubrimientos recientes e ilustraciones a color de nebulosas, planetas y telescopios espaciales', 25, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXPUYXaACfje7xd7GdhjkB6wndbhM8gWAgAA&s', 30, 4, 14, NULL),
(15, 'Mapa Espacial del Universo Observable - Poster Astronómico Educativo - Incluye 500+ objetos celestes (galaxias, nebulosas, cúmulos) - Proyección 3D de la Vía Láctea - Escala de distancias en años luz - Datos técnicos de planetas y estrellas - Tamaño 90x60 cm - Material laminado resistente.', 'Mapa del Universo Observable - Poster educativo con 500+ objetos celestes - Tamaño 90x60 cm - Material laminado resistente.', 'Este mapa espacial es una herramienta visual única que combina arte y ciencia, mostrando el universo conocido en cuatro niveles de escala:\r\nCapas principales:\r\nSistema Solar: Órbitas planetarias a escala  lunas destacadas\r\nVecindario estelar: 100 estrellas dentro de 50 años luz (Próxima Centauri, Sirio)\r\nVía Láctea: Estructura espiral con posición del Sol y nebulosas clave (Orión, Águila)', 12, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTOya7rn4rZSsACaQQymyiC8XyjBoABRg9KYQgCRYEWT9ilkpppTgfNm4PlJgicxQ3o3M9o71e1KiyxfNSq7rJrPhaAWM_xP2dZ2xsIa7q041dlD_dKNt-w', 25, 4, 14, NULL),
(16, '\"Guía Astronómica 2024 (Edición Española)\" - Anuario completo para observación del cielo - Efemérides mensuales y mapas estelares - Posiciones planetarias y eventos celestes - Incluye lluvias de meteoros, eclipses y conjunciones - Datos ISS y satélites visibles - 196 páginas - Editorial AstroPrint - ISBN 978-84-123456-7-8', 'Guía Astronómica 2024 - Anuario con efemérides y mapas celestes  - 196 páginas - Editorial AstroPrint - ISBN 978-84-123456-7-8.', 'La Guía Astronómica 2024 es la herramienta esencial para planificar tus observaciones a lo largo del año. Esta edición en español ofrece:\r\nContenido organizado por meses:\r\nEfemérides diarias: Salida/puesta de Sol/Luna, fases lunares\r\nPlanetas visibles: Mejores horas de observación (Júpiter, Saturno, etc.)\r\nEventos destacados:', 18, 'https://m.media-amazon.com/images/I/61zJzP8RRoL._SY466_.jpg', 25, 4, 14, NULL),
(17, 'ZWO - Cámara Astronómica ASI 294MC Pro - Cámara CMOS color para astrofotografía - Sensor Sony IMX294 de 11.7MP (4/3\") - Resolución 4144x2822 - Tamaño de píxel 4.63µm - Modos de alta sensibilidad (Ganancia 0-450) - Ventana Peltier y diseño refrigerado - Incluye software ASICap y drivers - Compatible con telescopios y lentes.', 'ZWO ASI 294MC Pro - Cámara CMOS color para astrofotografía profunda - Incluye software ASICap y drivers - Compatible con telescopios y lentes.', 'La ASI 294MC Pro de ZWO es una cámara astronómica profesional que combina alta sensibilidad y resolución ideal para capturar:\r\nNebulosas de emisión (M42, M8) con su amplio FOV.\r\nGalaxias brillantes (M31, M81) gracias a su baja relación de lectura.\r\nPlanetas (Júpiter, Saturno) en modo ROI de alta velocidad.', 1099, 'https://m.media-amazon.com/images/I/81TlJG3W4jL._AC_UF894,1000_QL80_.jpg', 6, 5, 6, NULL),
(18, 'Canon - Cámara EOS Ra (Edición Astrofotografía) - Cuerpo full-frame modificado para espectro H-alfa - Sensor CMOS de 30.3MP - Doble Pixel RAW 4K - Modo Astro (amplificación ISO 400-3200) - Compatible con lentes EF/EF-S - Pantalla articulada táctil - WiFi/GPS integrado - Incluye software DPP4.', 'Canon EOS Ra - Cámara full-frame modificada para astrofotografía - Pantalla articulada táctil - WiFi/GPS integrado - Incluye software DPP4.', 'La Canon EOS Ra es una versión especializada de la EOS R, optimizada para capturar nebulosas de emisión gracias a su:\r\nModificaciones clave:\r\nFiltro IR ampliado: Transmite 4x más H-alfa (656nm) que modelos estándar.\r\nModo Astro: Reducción de ruido en largas exposiciones (hasta 30min).\r\nLiveView mejorado: Visualización en tiempo real con amplificación de señal.', 2499, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRr5ILew35gyvj1ermvdHbneuJexj0RLoTNg&s', 3, 5, 14, NULL),
(19, 'Intervalómetro Profesional para DSLR/Mirrorless - Disparador remoto con temporizador programable - Pantalla LCD retroiluminada - Funciones: Time-Lapse, Bulb, Exposiciones prolongadas - Compatible con Canon/Nikon/Sony/Fuji - Incluye cable de 1.5m y soporte de montaje - Rango: 1seg a 99h59m59s - Alimentación por batería CR2032.', 'Intervalómetro para DSLR - Disparador programable para time-lapse y larga exposición - Alimentación por batería CR2032.', 'Este intervalómetro universal es un accesorio esencial para astrofotografía y fotografía creativa, que permite:\r\nFunciones clave:\r\nModo Bulb: Control preciso de exposiciones >30seg (ideal para trazas estelares) Time-Lapse.Programación de:\r\nIntervalos (1seg a 24h).\r\nNúmero de disparos (1-399).\r\nRetardo inicial (0-99h).\r\nExposición múltiple: Hasta 9 disparos consecutivos.', 39, 'https://m.media-amazon.com/images/I/61-6qMT8DAL.jpg', 15, 5, 14, NULL),
(20, 'Celestron - Telescopio AstroMaster 130EQ - Telescopio reflector Newtoniano para principiantes - Montura ecuatorial manual - Apertura de 130mm (5.1\") - Distancia focal 650mm (f/5) - Incluye 2 oculares (20mm y 10mm) - Trípode de acero ajustable - Buscador StarPointer - Ideal para observación lunar y planetaria.', 'Celestron AstroMaster 130EQ - Telescopio reflector 130mm con montura ecuatorial -  Ideal para observación lunar y planetaria.', 'El AstroMaster 130EQ es un telescopio reflector de entrada a intermedio que ofrece un equilibrio perfecto entre potencia y facilidad de uso. Su diseño Newtoniano proporciona imágenes brillantes de:\r\nLuna: Cráteres de hasta 3 km de diámetro.\r\nPlanetas: Bandas de Júpiter, anillos de Saturno.\r\nObjetos brillantes de espacio profundo: Nebulosa de Orión (M42), Cúmulo de Hércules (M13).', 299, 'https://www.celestronmexico.com/wp-content/uploads/2018/10/CPC_1100_GPS_11075-XLT.jpg', 8, 1, 1, NULL),
(21, 'Celestron - Binoculares SkyMaster 25x100 Pro - Binoculares astronómicos profesionales de alta potencia - 25x aumentos - Objetivos de 100mm de apertura - Prismas BaK-4 con revestimiento multicapa - Estructura sellada al nitrógeno - Trípode adaptable - Incluye estuche rígido y tapas protectoras - Ideal para observación de cielo profundo.', 'Celestron SkyMaster 25x100 - Binoculares gigantes para astronomía profesional - Objetivos de 100mm de apertura - Prismas BaK-4 con revestimiento multicapa - Ideal para observación de cielo profundo', 'Los SkyMaster 25x100 son binoculares de gama alta diseñados para observación astronómica seria. Con sus lentes de 100mm, capturan un 150% más de luz que modelos de 70mm, revelando:\r\nCúmulos globulares: Resolución de estrellas individuales en M13.\r\nNebulosas brillantes: Estructura completa de la Nebulosa de Orión.\r\nGalaxias cercanas: Brazos espirales de M31 (Andrómeda).\r\nDetalles lunares: Cráteres de <2km con buena estabilidad.', 399, 'https://m.media-amazon.com/images/I/61jT-esP7PL._AC_UF894,1000_QL80_.jpg', 4, 2, 1, NULL);

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
