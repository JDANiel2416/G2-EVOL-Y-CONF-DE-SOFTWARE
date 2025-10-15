-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 26-06-2025 a las 03:02:16
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
-- Base de datos: `reservas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificaciones`
--

CREATE TABLE `calificaciones` (
  `id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `id_habitacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `calificaciones`
--

INSERT INTO `calificaciones` (`id`, `cantidad`, `comentario`, `fecha`, `id_habitacion`, `id_usuario`) VALUES
(5, 4, 'Bueno', '2024-06-18 01:42:56', 2, 26);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `categoria`, `estado`) VALUES
(1, 'Habitación Simple', 1),
(2, 'Habitación Familiar', 0),
(3, 'Habitación Doble', 1),
(4, 'Habitación Matrimonial', 1),
(5, 'Habitación para los que ven Goku...Good', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `id` int(11) NOT NULL,
  `num_identidad` varchar(50) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(30) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `mensaje` text NOT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `whatsapp` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`id`, `num_identidad`, `nombre`, `telefono`, `direccion`, `correo`, `mensaje`, `facebook`, `twitter`, `instagram`, `whatsapp`) VALUES
(1, '123456789', 'HOTEL LA FE', '51 964 954 496', 'OTUZCO - LA LIBERTAD', 'escobedomichael921@gmail.com', 'Donde cada momento se transforma en una experiencia memorable. Disfruta de nuestra hospitalidad excepcional, comodidades de primer nivel y servicio impecable. ¡Tu escapada perfecta comienza aquí!', 'https://www.facebook.com/HotelLafeotuzco', 'https://twitter.com/?lang=es', 'https://www.instagram.com/alexanderhpg?igsh=aGxmYWt2NzZkMDBq', 'https://wa.me/964954496');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entradas`
--

CREATE TABLE `entradas` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `descripcion` longtext NOT NULL,
  `foto` varchar(100) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `categorias` varchar(255) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitaciones`
--

CREATE TABLE `habitaciones` (
  `id` int(11) NOT NULL,
  `estilo` varchar(200) NOT NULL,
  `numero` int(11) NOT NULL,
  `capacidad` int(11) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `video` varchar(255) DEFAULT NULL,
  `descripcion` text NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `habitaciones`
--

INSERT INTO `habitaciones` (`id`, `estilo`, `numero`, `capacidad`, `slug`, `foto`, `video`, `descripcion`, `precio`, `estado`, `fecha`) VALUES
(1, 'Habitación simple', 10, 1, 'habitacion-simple', '1.jpg', NULL, '<p>Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.</p>', 10.00, 1, '2024-10-08 18:44:19'),
(2, 'Habitación Doble', 150, 2, 'habitacion-doble', '2.jpg', NULL, '<p>Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.</p>', 50.00, 1, '2024-06-06 06:36:57'),
(3, 'Habitación matrimonial', 50, 2, 'habitacion-matrimonial', '20240617212441.jpg', NULL, '<p>Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.</p>', 40.00, 1, '2024-06-17 21:24:41'),
(4, 'Suite Romántica', 150, 3, 'suite-romantica', '4.jpg', NULL, 'Una escapada íntima y lujosa diseñada para parejas que buscan reavivar la chispa del romance en un entorno elegante y privado.', 50.00, 0, '2024-06-06 06:35:28'),
(5, 'Habitación con Vistas al Mar', 50, 6, 'habitacion-vistas-mar', '5.jpg', NULL, 'Disfruta de impresionantes vistas al océano desde esta habitación, donde la brisa marina y el sonido de las olas crean un ambiente de tranquilidad y serenidad.', 100.00, 0, '2024-06-06 06:35:34'),
(6, 'Suite Deluxe', 150, 3, 'suite-deluxe', '6.jpg', NULL, 'Sumérgete en el lujo y la elegancia de esta suite excepcionalmente espaciosa, donde cada detalle está cuidadosamente diseñado para brindarte una experiencia inolvidable.', 50.00, 0, '2024-06-06 06:35:40'),
(7, 'Habitación Zen Garden', 50, 6, 'habitacion-zen-garden', '7.jpg', NULL, 'Encuentra paz y armonía en esta habitación inspirada en un jardín zen, donde la serenidad del entorno te invita a relajarte y renovar tus sentidos.', 100.00, 0, '2024-06-06 06:35:46'),
(8, 'Suite Presidencial', 150, 3, 'suite-presidencial', '8.jpg', NULL, 'Experimenta el máximo nivel de lujo y privacidad en esta suite exclusiva, diseñada para satisfacer incluso los gustos más exigentes de nuestros huéspedes VIP.', 50.00, 0, '2024-06-06 06:35:50'),
(9, 'Habitación Loft Urbano', 50, 6, 'habitacion-loft-urbano', '9.jpg', NULL, ' Disfruta de un estilo moderno y sofisticado en este loft urbano, donde el diseño vanguardista se combina con comodidades de primera clase para una estancia inigualable.', 100.00, 0, '2024-06-06 06:35:54'),
(10, 'Suite Skyline', 50, 6, 'suite-skyline', '10.jpg', NULL, 'Contempla las impresionantes vistas de la ciudad desde esta suite de altura, donde la elegancia se combina con panorámicas inigualables para una experiencia verdaderamente espectacular.', 100.00, 0, '2024-06-06 06:35:57'),
(11, 'habitacion eliminar', 30, 20, 'habitacion-eliminar', '20240319155234.jpg', NULL, '<p>esta se eliminara</p>', 40.00, 0, '2024-03-19 14:52:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `num_transaccion` varchar(50) NOT NULL,
  `cod_reserva` varchar(50) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `fecha_salida` date NOT NULL,
  `fecha_reserva` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `descripcion` text DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `metodo` varchar(50) NOT NULL,
  `id_habitacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `monto`, `num_transaccion`, `cod_reserva`, `fecha_ingreso`, `fecha_salida`, `fecha_reserva`, `descripcion`, `estado`, `metodo`, `id_habitacion`, `id_usuario`) VALUES
(25, 150.00, '1318632992', '6673a95eb4828', '2024-06-30', '2024-07-03', '2024-06-19 00:00:00', '', 1, 'Mercado Pago', 2, 28),
(30, 1.80, '81493586627', '6682b8c433f84', '2024-07-02', '2024-07-03', '2024-07-01 00:00:00', '', 1, 'Mercado Pago', 1, 21),
(32, 10.00, '73U429223R316303X', '6742543c14780', '2024-11-23', '2024-11-24', '2024-11-23 00:00:00', '', 1, 'Paypal', 1, 41),
(33, 100.00, '58X26500XA5834154', '6743e685b8f2e', '2024-11-27', '2024-11-29', '2024-11-25 00:00:00', '', 1, 'Paypal', 2, 41),
(34, 50.00, '5FM68997XV651572V', '6743e7530ce90', '2024-11-25', '2024-11-26', '2024-11-25 00:00:00', '', 1, 'Paypal', 2, 41),
(35, 80.00, '9TE006085D707491J', '6743e7a2b0848', '2024-11-25', '2024-11-27', '2024-11-25 00:00:00', '', 1, 'Paypal', 3, 41),
(36, 50.00, '7W912121TK1526642', '6743e87244c1f', '2024-11-30', '2024-12-01', '2024-11-25 04:01:06', '', 1, 'Paypal', 2, 41),
(37, 120.00, '3CG631049M866032S', '6743e9a12d4a6', '2024-11-29', '2024-12-02', '2024-11-25 04:06:09', '', 1, 'Paypal', 3, 41),
(38, 20.00, '41019520G1894292X', '6743ea307d5fc', '2024-11-25', '2024-11-27', '2024-11-25 04:08:32', '', 1, 'Paypal', 1, 41),
(39, 10.00, '0SD15729VA890370F', '676965594e9e9', '2024-12-22', '2024-12-23', '2024-12-23 08:27:53', '', 1, 'Paypal', 1, 41),
(40, 10.00, '85M53432PH993314N', '67f5b9fe495ea', '2025-04-08', '2025-04-09', '2025-04-08 20:06:22', '', 1, 'Paypal', 1, 41);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sliders`
--

CREATE TABLE `sliders` (
  `id` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `subtitulo` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `identidad` varchar(100) DEFAULT NULL,
  `dni` varchar(20) DEFAULT NULL,
  `nombre` varchar(150) NOT NULL,
  `apellido` varchar(150) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `clave` varchar(150) NOT NULL,
  `verify` int(11) NOT NULL DEFAULT 0,
  `rol` int(11) NOT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `token` varchar(255) DEFAULT NULL,
  `token_estado` tinyint(1) DEFAULT 1,
  `token_expiracion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_habitacion` (`id_habitacion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `entradas`
--
ALTER TABLE `entradas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_habitacion` (`id_habitacion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `entradas`
--
ALTER TABLE `entradas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`id_habitacion`) REFERENCES `habitaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `entradas`
--
ALTER TABLE `entradas`
  ADD CONSTRAINT `entradas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_habitacion`) REFERENCES `habitaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
