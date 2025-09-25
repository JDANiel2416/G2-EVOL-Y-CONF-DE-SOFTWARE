-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 25-09-2025 a las 01:15:18
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
(5, 4, 'Bueno y bacan', '2025-06-26 03:07:12', 2, 26),
(6, 5, 'Excelente atención y limpieza.', '2025-06-26 02:35:43', 1, 1),
(7, 4, 'Muy buena ubicación y desayuno variado.', '2025-06-26 02:35:43', 2, 1),
(8, 5, 'El personal fue muy amable durante mi estancia.', '2025-06-26 02:35:43', 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `precio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datos_usuario`
--

CREATE TABLE `datos_usuario` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `valor` text NOT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `datos_usuario`
--

INSERT INTO `datos_usuario` (`id`, `user_id`, `tipo`, `valor`, `fecha`) VALUES
(1, 0, 'interes_habitacion', 'simple', '2025-06-28 19:33:30'),
(2, 0, 'interes_habitacion', 'doble', '2025-06-28 19:36:21'),
(3, 0, 'interes_habitacion', 'doble', '2025-06-28 19:36:30'),
(4, 0, 'interes_habitacion', 'doble', '2025-06-28 19:36:36'),
(5, 0, 'interes_habitacion', 'simple', '2025-06-28 19:48:20'),
(6, 0, 'fecha_mencionada', '2025-07-01', '2025-06-28 19:49:13'),
(7, 0, 'interes_habitacion', 'simple', '2025-06-28 20:06:45'),
(8, 0, 'interes_habitacion', 'simple', '2025-06-28 20:08:30'),
(9, 0, 'interes_habitacion', 'simple', '2025-06-28 20:30:12'),
(10, 0, 'interes_habitacion', 'doble', '2025-06-28 20:30:44'),
(11, 0, 'interes_habitacion', 'simple', '2025-06-28 20:38:34'),
(12, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 20:38:36'),
(13, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 20:38:36'),
(14, 0, 'interes_habitacion', 'doble', '2025-06-28 20:38:49'),
(15, 0, 'interes_habitacion', 'simple', '2025-06-28 20:46:37'),
(16, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 20:46:41'),
(17, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 20:46:41'),
(18, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 20:47:02'),
(19, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 20:47:02'),
(20, 0, 'interes_habitacion', 'simple', '2025-06-28 20:47:31'),
(21, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 20:47:36'),
(22, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 20:47:36'),
(23, 0, 'interes_habitacion', 'matrimonial', '2025-06-28 20:49:26'),
(24, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 20:49:31'),
(25, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 20:49:31'),
(26, 0, 'interes_habitacion', 'simple', '2025-06-28 20:50:41'),
(27, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 20:50:45'),
(28, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 20:50:45'),
(29, 0, 'interes_habitacion', 'simple', '2025-06-28 20:55:52'),
(30, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 20:55:54'),
(31, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 20:55:54'),
(32, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 20:56:08'),
(33, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 20:56:08'),
(34, 0, 'interes_habitacion', 'simple', '2025-06-28 20:57:48'),
(35, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 20:57:51'),
(36, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 20:57:51'),
(37, 0, 'interes_habitacion', 'simple', '2025-06-28 21:03:14'),
(38, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 21:03:18'),
(39, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 21:03:18'),
(40, 0, 'interes_habitacion', 'simple', '2025-06-28 21:08:00'),
(41, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 21:08:02'),
(42, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 21:08:02'),
(43, 0, 'interes_habitacion', 'simple', '2025-06-28 21:10:39'),
(44, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 21:10:41'),
(45, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 21:10:41'),
(46, 0, 'interes_habitacion', 'simple', '2025-06-28 21:11:32'),
(47, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 21:11:34'),
(48, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 21:11:34'),
(49, 0, 'interes_habitacion', 'simple', '2025-06-28 21:11:52'),
(50, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 21:11:55'),
(51, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 21:11:55'),
(52, 0, 'interes_habitacion', 'simple', '2025-06-28 21:28:28'),
(53, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 21:28:33'),
(54, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 21:28:33'),
(55, 0, 'interes_habitacion', 'simple', '2025-06-28 21:29:27'),
(56, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 21:29:29'),
(57, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 21:29:29'),
(58, 0, 'interes_habitacion', 'simple', '2025-06-28 21:29:51'),
(59, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 21:29:55'),
(60, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 21:29:55'),
(61, 0, 'interes_habitacion', 'simple', '2025-06-28 21:32:51'),
(62, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 21:32:53'),
(63, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 21:32:53'),
(64, 0, 'interes_habitacion', 'simple', '2025-06-28 21:38:49'),
(65, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 21:38:51'),
(66, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 21:38:51'),
(67, 0, 'interes_habitacion', 'simple', '2025-06-28 21:39:20'),
(68, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 21:39:23'),
(69, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 21:39:23'),
(70, 0, 'interes_habitacion', 'simple', '2025-06-28 21:39:49'),
(71, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 21:39:52'),
(72, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 21:39:52'),
(73, 0, 'interes_habitacion', 'simple', '2025-06-28 21:40:33'),
(74, 0, 'ultima_busqueda_entrada', '2024-07-05', '2025-06-28 21:40:35'),
(75, 0, 'ultima_busqueda_salida', '2024-07-08', '2025-06-28 21:40:35'),
(76, 0, 'interes_habitacion', 'simple', '2025-06-28 21:57:53'),
(77, 0, 'ultima_busqueda_entrada', '2024-07-05', '2025-06-28 21:57:55'),
(78, 0, 'ultima_busqueda_salida', '2024-07-08', '2025-06-28 21:57:55'),
(79, 0, 'ultima_busqueda_entrada', '2024-07-05', '2025-06-28 21:58:24'),
(80, 0, 'ultima_busqueda_salida', '2024-07-08', '2025-06-28 21:58:24'),
(81, 0, 'interes_habitacion', 'simple', '2025-06-28 22:00:45'),
(82, 0, 'ultima_busqueda_entrada', '2024-07-05', '2025-06-28 22:00:47'),
(83, 0, 'ultima_busqueda_salida', '2024-07-08', '2025-06-28 22:00:47'),
(84, 0, 'ultima_busqueda_entrada', '2024-07-05', '2025-06-28 22:01:13'),
(85, 0, 'ultima_busqueda_salida', '2024-07-15', '2025-06-28 22:01:13'),
(86, 0, 'interes_habitacion', 'simple', '2025-06-28 22:11:00'),
(87, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-28 22:11:02'),
(88, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-28 22:11:02'),
(89, 0, 'interes_habitacion', 'simple', '2025-06-28 22:11:32'),
(90, 0, 'ultima_busqueda_entrada', '2024-07-05', '2025-06-28 22:11:34'),
(91, 0, 'ultima_busqueda_salida', '2024-07-08', '2025-06-28 22:11:34'),
(92, 0, 'ultima_busqueda_entrada', '2024-07-01', '2025-06-29 19:33:12'),
(93, 0, 'ultima_busqueda_salida', '2024-07-04', '2025-06-29 19:33:12');

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
(1, '10848384', 'HOSTAL LA FE', '51 964 954 496', 'OTUZCO - LA LIBERTAD', 'consultas@lafehostal.com', 'Donde cada momento se transforma en una experiencia memorable. Disfruta de nuestra hospitalidad excepcional, comodidades de primer nivel y servicio impecable. ¡Tu escapada perfecta comienza aquí!', 'https://www.facebook.com/HotelLafeotuzco', 'https://twitter.com/?lang=es', 'https://www.instagram.com/alexanderhpg?igsh=aGxmYWt2NzZkMDBq', 'https://wa.me/964954496');

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
  `categoría` varchar(200) NOT NULL,
  `numero` int(11) NOT NULL,
  `capacidad` int(11) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `video` varchar(255) DEFAULT NULL,
  `descripcion` text NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `habitaciones`
--

INSERT INTO `habitaciones` (`id`, `categoría`, `numero`, `capacidad`, `slug`, `foto`, `video`, `descripcion`, `precio`, `estado`, `fecha_creacion`) VALUES
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
-- Estructura de tabla para la tabla `historial_chat`
--

CREATE TABLE `historial_chat` (
  `id` int(11) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `mensaje_usuario` text DEFAULT NULL,
  `respuesta_bot` text DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_chat`
--

INSERT INTO `historial_chat` (`id`, `user_id`, `mensaje_usuario`, `respuesta_bot`, `fecha`) VALUES
(1, 'user_68607086e0096', 'hola, cual es el numero del hotel?', 'Teléfono: 51 964 954 496\nCorreo: escobedomichael921@gmail.com\nDirección: OTUZCO - LA LIBERTAD\nWhatsApp: https://wa.me/964954496\nFacebook: https://www.facebook.com/HotelLafeotuzco\nInstagram: https://www.instagram.com/alexanderhpg?igsh=aGxmYWt2NzZkMDBq', '2025-06-28 22:45:26'),
(2, 'user_68607086e0096', 'solo el numero', '51 964 954 496', '2025-06-28 22:45:41'),
(3, 'user_68607086e0096', 'una pregunta, que tipo de habitaciones tienes?', 'Tenemos los siguientes tipos de habitaciones:\n- Habitación Doble: Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.\n- Habitación Matrimonial: Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.\n- Habitación Simple: Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.', '2025-06-28 22:45:58'),
(4, 'user_68607086e0096', 'y cuales son los precios?', 'Los precios por noche son:\n- Habitación Doble: S/50.00\n- Habitación Matrimonial: S/40.00\n- Habitación Simple: S/10.00', '2025-06-28 22:46:12'),
(5, 'user_68607086e0096', 'que opiniones tienen las personas que se hospedaron en este hotel?', 'Aquí tienes algunos comentarios de nuestros huéspedes:\n- \"Bueno y bacan\"\n- \"Excelente atención y limpieza.\"\n- \"Muy buena ubicación y desayuno variado.\"', '2025-06-28 22:49:49'),
(6, 'user_6860880d65e92', 'hola, quien es el dueño del hotel y cual es su numero y correo?', 'Teléfono: 51 964 954 496\nCorreo: escobedomichael921@gmail.com\nWhatsApp: https://wa.me/964954496\nFacebook: https://www.facebook.com/HotelLafeotuzco\nInstagram: https://www.instagram.com/alexanderhpg?igsh=aGxmYWt2NzZkMDBq\n\nNo dispongo de información sobre el dueño del hotel en este momento.', '2025-06-29 00:25:49'),
(7, 'user_6860880d65e92', 'ola tienz el nhumero del horl?', '¿Necesita el número de teléfono del hotel? Puedo ayudarle con información general sobre el hotel si lo desea.', '2025-06-29 00:26:40'),
(8, 'user_6860880d65e92', 'zhy', '¿Necesita el número de teléfono del hotel? Puedo ayudarle con información general sobre el hotel si lo desea.', '2025-06-29 00:26:50'),
(9, 'user_6860880d65e92', 'si', '¿Necesita el número de teléfono del hotel? Puedo ayudarle con información general sobre el hotel si lo desea.', '2025-06-29 00:27:05'),
(10, 'user_6860880d65e92', 'sí, quiero el número', '¿Necesita el número de teléfono del hotel? Puedo ayudarle con información general sobre el hotel si lo desea.', '2025-06-29 00:27:17'),
(11, 'user_6860880d65e92', 'el numero del hotel por favor, solo numero', '51 964 954 496\nCorreo: escobedomichael921@gmail.com\nDirección: OTUZCO - LA LIBERTAD\nWhatsApp: https://wa.me/964954496\nFacebook: https://www.facebook.com/HotelLafeotuzco\nInstagram: https://www.instagram.com/alexanderhpg?igsh=aGxmYWt2NzZkMDBq', '2025-06-29 00:27:44'),
(12, 'user_6860880d65e92', 'hola', '¿Necesita información general sobre el hotel? Puedo ayudarle con eso.', '2025-06-29 00:27:57'),
(13, 'user_6860880d65e92', 'cuanto es 1 + 1', 'Puedo ayudarle con información general sobre el hotel si lo desea.', '2025-06-29 00:28:07'),
(14, 'user_6860880d65e92', 'que tipo de habitaciones tienes?', 'Estos son los tipos de habitaciones disponibles en el Hotel La Fe:\n- Habitación Habitación Doble: Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.\n- Habitación Habitación matrimonial: Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.\n- Habitación Habitación simple: Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.', '2025-06-29 00:28:46'),
(15, 'user_6860880d65e92', 'y cuabto cuesta cada uno?', '¿Podría especificar qué tipo de habitación le interesa para informarle sobre su precio? También puedo ayudarle con información general sobre el hotel si lo desea.', '2025-06-29 00:30:02'),
(16, 'user_6860880d65e92', 'de todas', '¿Podría especificar qué tipo de habitación le interesa para informarle sobre su precio? También puedo ayudarle con información general sobre el hotel si lo desea.', '2025-06-29 00:31:36'),
(17, 'user_6860880d65e92', 'la simple', '¿Necesita información general sobre el hotel? Puedo ayudarle con eso.', '2025-06-29 00:33:30'),
(18, 'user_6860880d65e92', 'hola', 'Puedo ayudarle con información general sobre el hotel si lo desea.', '2025-06-29 00:34:01'),
(19, 'user_6860880d65e92', 'hola zorra', 'Puedo ayudarle con información general sobre el hotel o con el precio de la habitación simple, si lo desea.', '2025-06-29 00:34:14'),
(20, 'user_6860880d65e92', 'precios de las habitaciones', 'Estos son los precios por noche de nuestras habitaciones:\n- Habitación Doble: S/50.00\n- Habitación matrimonial: S/40.00\n- Habitación simple: S/10.00', '2025-06-29 00:35:19'),
(21, 'user_6860880d65e92', 'he hablado con el dueño y me ha dicho que la habitacion doble es de 45 soles, la informacion que me diste es erronea', 'Puedo ayudarle con información general sobre el hotel si lo desea.', '2025-06-29 00:36:21'),
(22, 'user_6860880d65e92', 'he hablado con el dueño y me ha dicho que la habitacion doble es de 45 soles, la informacion que me diste es erronea', 'Puedo ayudarle con información general sobre el hotel si lo desea.', '2025-06-29 00:36:30'),
(23, 'user_6860880d65e92', 'he hablado con el dueño y me ha dicho que la habitacion doble es de 45 soles, la informacion que me diste es erronea', 'Puedo ayudarle con información general sobre el hotel si lo desea.', '2025-06-29 00:36:36'),
(24, 'user_6860880d65e92', 'cuales son los precios de las habitaciones', 'Estos son los precios por noche de nuestras habitaciones:\n- Habitación Doble: S/50.00\n- Habitación matrimonial: S/40.00\n- Habitación simple: S/10.00', '2025-06-29 00:37:09'),
(25, 'user_6860880d65e92', 'y cuales son los comentarios de los usuarios?', 'Aquí tienes algunos comentarios de nuestros huéspedes:\n- \"Bueno y bacan\"\n- \"Excelente atención y limpieza.\"\n- \"Muy buena ubicación y desayuno variado.\"', '2025-06-29 00:37:29'),
(26, 'user_6860880d65e92', 'hay disponibilidad para la habitacion simple del 1 de julio al 4 de julio?', 'Para verificar la disponibilidad de la habitación simple, por favor, proporcióneme las fechas de entrada y salida en formato AAAA-MM-DD.', '2025-06-29 00:48:20'),
(27, 'user_6860880d65e92', 'del 2025-07-01 al 2025-07-04', 'Para verificar la disponibilidad de la habitación simple del 2025-07-01 al 2025-07-04, por favor, proporcióneme las fechas de entrada y salida en formato AAAA-MM-DD.', '2025-06-29 00:49:13'),
(28, 'user_6860880d65e92', 'hola', 'Hola, no estoy seguro de entender su solicitud. ¿En qué puedo ayudarle? Puedo proporcionarle información sobre la disponibilidad, los precios, los tipos de habitaciones o la información de contacto del hotel.', '2025-06-29 00:53:17'),
(29, 'user_6860880d65e92', 'cual es el numero del hotel y su correo?', 'Teléfono: 51 964 954 496\nCorreo: escobedomichael921@gmail.com', '2025-06-29 00:53:42'),
(30, 'user_6860880d65e92', 'que tipos de habitaciones tienes disponible?', 'Para verificar la disponibilidad, por favor, proporcióneme las fechas de entrada y salida en formato AAAA-MM-DD.', '2025-06-29 00:54:13'),
(31, 'user_6860880d65e92', 'pero quiero saber que categorias o tipos de habitaciones tienes disponibles?', 'Disponemos de habitación doble, habitación matrimonial y habitación simple. Para verificar la disponibilidad, por favor, proporcióneme las fechas de entrada y salida en formato AAAA-MM-DD.', '2025-06-29 00:54:51'),
(32, 'user_6860880d65e92', 'hola', 'Lo siento, nuestro asistente virtual no pudo procesar tu solicitud (API Error 400). Mensaje: API key not valid. Please pass a valid API key.', '2025-06-29 00:58:05'),
(33, 'user_6860880d65e92', 'hola', 'Hola, no estoy seguro de entender su solicitud. ¿En qué puedo ayudarle? Puedo proporcionarle información sobre la disponibilidad, los precios, los tipos de habitaciones o la información de contacto del hotel.', '2025-06-29 01:00:19'),
(34, 'user_6860880d65e92', 'hola', 'Hola, no estoy seguro de entender su solicitud. ¿En qué puedo ayudarle? Puedo proporcionarle información sobre la disponibilidad, los precios, los tipos de habitaciones o la información de contacto del hotel.', '2025-06-29 01:05:25'),
(35, 'user_6860880d65e92', 'hay disponibilidad para el 1 de julio al 4 de julio', 'Para las fechas del 2024-07-01 al 2024-07-04, tenemos disponible la habitación Habitación matrimonial (capacidad: 2 personas, precio por noche: S/40.00).', '2025-06-29 01:06:26'),
(36, 'user_6860880d65e92', 'la simple?', 'Hola, no estoy seguro de entender su solicitud. ¿En qué puedo ayudarle? Puedo proporcionarle información sobre la disponibilidad, los precios, los tipos de habitaciones o la información de contacto del hotel.', '2025-06-29 01:06:45'),
(37, 'user_6860880d65e92', 'me refiero a si hay disponible la habitacion simple del 1 de julio al 4 de julio', 'No tenemos disponibilidad de habitación simple del 1 de julio al 4 de julio. Para esas fechas, tenemos disponible la habitación Habitación matrimonial (capacidad: 2 personas, precio por noche: S/40.00).', '2025-06-29 01:08:30'),
(38, 'user_6860880d65e92', 'hola', 'Hola, no estoy seguro de entender su solicitud. ¿En qué puedo ayudarle? Puedo proporcionarle información sobre la disponibilidad, los precios, los tipos de habitaciones o la información de contacto del hotel.', '2025-06-29 01:16:25'),
(39, 'user_6860880d65e92', 'hola, que tipo de habitaciones tienes?', 'Hola, no estoy seguro de entender su solicitud. ¿En qué puedo ayudarle? Puedo proporcionarle información sobre la disponibilidad, los precios, los tipos de habitaciones o la información de contacto del hotel.', '2025-06-29 01:16:45'),
(40, 'user_6860880d65e92', 'qué tipo de habitaciones tienes?', 'Estos son los tipos de habitaciones disponibles en el Hotel La Fe:\n- Habitación Habitación Doble: Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.\n- Habitación Habitación matrimonial: Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.\n- Habitación Habitación simple: Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.', '2025-06-29 01:17:06'),
(41, 'user_6860943631973', 'hola', 'Hola, bienvenido al Hotel La Fe. ¿En qué puedo ayudarle hoy? Por ejemplo, puedo darle información sobre disponibilidad, precios, tipos de habitaciones o información de contacto.', '2025-06-29 01:17:42'),
(42, 'user_6860943631973', 'puedes darme el correo por favor?', 'Correo: escobedomichael921@gmail.com', '2025-06-29 01:18:06'),
(43, 'user_6860943631973', 'y cual es el numero?', '51 964 954 496', '2025-06-29 01:18:20'),
(44, 'user_6860943631973', 'tiene redes sociales?', 'No estoy seguro de entender completamente tu pregunta. ¿Te refieres a si el Hotel La Fe tiene perfiles en redes sociales?\n\nPuedo ayudarte con información sobre disponibilidad, precios, tipos de habitaciones o información de contacto si lo deseas.', '2025-06-29 01:18:33'),
(45, 'user_6860943631973', 'si, el hotel tiene instagram, facebook o whatsapp?', 'Teléfono: 51 964 954 496\nCorreo: escobedomichael921@gmail.com\nWhatsApp: https://wa.me/964954496\nFacebook: https://www.facebook.com/HotelLafeotuzco\nInstagram: https://www.instagram.com/alexanderhpg?igsh=aGxmYWt2NzZkMDBq', '2025-06-29 01:18:56'),
(46, 'user_6860943631973', 'que habitaciones hay disponibles?', 'El usuario pregunta por disponibilidad, pero no he podido identificar un rango de fechas claro en tu mensaje. Por favor, ¿podrías indicarme las fechas de entrada y salida? Por ejemplo: \'Quiero del 1 al 5 de julio\' o \'Del 2025-07-01 al 2025-07-04\'.', '2025-06-29 01:20:18'),
(47, 'user_6860943631973', 'que tipo de habitaciones tienes disponibles?', 'El usuario pregunta por disponibilidad, pero no he podido identificar un rango de fechas claro en tu mensaje. Por favor, ¿podrías indicarme las fechas de entrada y salida? Por ejemplo: \'Quiero del 1 al 5 de julio\' o \'Del 2025-07-01 al 2025-07-04\'.', '2025-06-29 01:20:59'),
(48, 'user_686096c957587', 'hola', 'Hola, bienvenido al Hotel La Fe. ¿En qué puedo ayudarle hoy? Por ejemplo, puedo darle información sobre disponibilidad, precios, tipos de habitaciones o información de contacto.', '2025-06-29 01:28:41'),
(49, 'user_686096c957587', 'cuales son las habitaciones dispones?', 'Disculpa, no he comprendido completamente tu pregunta. ¿Podrías ser más específico? Puedo ayudarte con información sobre disponibilidad, precios, tipos de habitaciones o información de contacto del hotel.', '2025-06-29 01:28:54'),
(50, 'user_686096c957587', 'que tipo de habitaciones tienes disponibles?', 'Estos son los tipos de habitaciones disponibles en el Hotel La Fe:\n- Habitación Habitación Doble: Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.\n- Habitación Habitación matrimonial: Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.\n- Habitación Habitación simple: Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.', '2025-06-29 01:29:13'),
(51, 'user_686096c957587', 'y cuales son los precios de cada una?', 'Estos son los precios por noche de cada tipo de habitación:\n- Habitación Doble: S/50.00\n- Habitación matrimonial: S/40.00\n- Habitación simple: S/10.00', '2025-06-29 01:29:29'),
(52, 'user_686096c957587', 'quiero reservar una habitacion simple del 1 al 4 de julio', 'No tenemos habitaciones simples disponibles del 1 al 4 de julio. Sin embargo, tenemos disponible una Habitación matrimonial (capacidad: 2 personas, precio por noche: S/40.00) para esas fechas.', '2025-06-29 01:30:12'),
(53, 'user_686096c957587', 'y habitaciones dobles hay disponibles para esas fechas?', 'El usuario pregunta por disponibilidad, pero no he podido identificar un rango de fechas claro en tu mensaje. Por favor, ¿podrías indicarme las fechas de entrada y salida? Por ejemplo: \'Quiero del 1 al 5 de julio\' o \'Del 2025-07-01 al 2025-07-04\'.', '2025-06-29 01:30:44'),
(54, 'user_686096c957587', 'oe ctmr', 'Disculpa, no he comprendido completamente tu pregunta. ¿Podrías ser más específico? Puedo ayudarte con información sobre disponibilidad, precios, tipos de habitaciones o información de contacto del hotel.', '2025-06-29 01:34:18'),
(55, 'user_686098bef2e15', 'hola', 'Hola, bienvenido al Asistente Virtual del Hotel La Fe. ¿En qué puedo ayudarle hoy? Por ejemplo, puedo darle información sobre disponibilidad, precios, tipos de habitaciones o información de contacto.', '2025-06-29 01:37:02'),
(56, 'user_686098bef2e15', 'quiero saber que tipos de habitaciones tienes actualmente?', 'Estos son los tipos de habitaciones disponibles en el Hotel La Fe:\n- Habitación Habitación Doble: Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.\n- Habitación Habitación matrimonial: Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.\n- Habitación Habitación simple: Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.', '2025-06-29 01:37:26'),
(57, 'user_686098bef2e15', 'hay disponible habitacion simple del 1 al 4 de julio?', 'No hay habitaciones simples disponibles del 1 al 4 de julio. Le sugiero probar con otras fechas o consultar por otro tipo de habitación.', '2025-06-29 01:38:34'),
(58, 'user_686098bef2e15', 'habitacion doble?', 'No estoy seguro de entender completamente su pregunta. ¿Le gustaría consultar la disponibilidad de una habitación doble entre ciertas fechas? O tal vez le interese conocer los precios o las características de este tipo de habitación. También puedo proporcionarle información de contacto del hotel si lo desea.', '2025-06-29 01:38:49'),
(59, 'user_68609a8f684ad', 'hola', 'Hola, soy el Asistente Virtual del Hotel La Fe. ¿En qué puedo ayudarle hoy? Puedo informarle sobre disponibilidad, precios, tipos de habitaciones o información de contacto.', '2025-06-29 01:44:47'),
(60, 'user_68609a8f684ad', 'que habitaciones tienes?', 'Para poder ayudarte mejor, ¿podrías especificar qué tipo de información necesitas sobre las habitaciones? Por ejemplo, puedo darte detalles sobre los tipos de habitaciones disponibles, su equipamiento, o verificar la disponibilidad y precios para fechas específicas.', '2025-06-29 01:45:02'),
(61, 'user_68609a8f684ad', 'que tipo de habitaciones tienes?', 'En el Hotel La Fe, disponemos de los siguientes tipos de habitaciones:\n\nHabitación Doble: Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.\nHabitación matrimonial: Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.\nHabitación simple: Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.', '2025-06-29 01:45:21'),
(62, 'user_68609a8f684ad', 'y cuales son los precios?', 'Los precios por noche son los siguientes:\nHabitación Doble: S/50.00\nHabitación matrimonial: S/40.00\nHabitación simple: S/10.00', '2025-06-29 01:45:52'),
(63, 'user_68609a8f684ad', 'tienes disponible la simple del 1 al 4 de julio?', 'Lamentablemente, no tenemos disponibilidad para la Habitación simple del 1 al 4 de julio. Le sugiero probar con otras fechas o tipos de habitación.', '2025-06-29 01:46:37'),
(64, 'user_68609a8f684ad', 'y del 5 al 10 de julio?', 'No dispongo de información sobre la disponibilidad de habitaciones para las fechas del 5 al 10 de julio en este momento.', '2025-06-29 01:46:59'),
(65, 'user_68609a8f684ad', 'no está disponible la habitacion simple del 5 al 10 de julio?', 'No dispongo de información sobre la disponibilidad de la Habitación simple para las fechas del 5 al 10 de julio en este momento.', '2025-06-29 01:47:31'),
(66, 'user_68609a8f684ad', 'y la habitacion matrimonial?', 'Lo siento, recibí una respuesta inesperada de nuestro asistente virtual (Respuesta Gemini).', '2025-06-29 01:49:26'),
(67, 'user_68609a8f684ad', 'perdon?', 'Disculpe, no he comprendido su última pregunta. ¿Podría ser más específico, por favor? Puedo ayudarle con información sobre la disponibilidad de habitaciones, precios, tipos de habitaciones o datos de contacto del hotel.', '2025-06-29 01:50:08'),
(68, 'user_68609a8f684ad', 'hay disponibilidad de la habitacion simple del 5 al 10 de julio?', 'No dispongo de información sobre la disponibilidad de la Habitación simple para las fechas del 5 al 10 de julio en este momento.', '2025-06-29 01:50:41'),
(69, 'user_68609ce217386', 'hola', 'Hola, bienvenido al Hotel La Fe. Soy su Asistente Virtual. ¿En qué puedo ayudarle hoy? Puedo informarle sobre disponibilidad, precios, tipos de habitaciones o datos de contacto.', '2025-06-29 01:54:42'),
(70, 'user_68609ce217386', 'que habitaciones tienes?', 'En el Hotel La Fe, disponemos de las siguientes habitaciones:\n\nHabitación Doble: Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.\nHabitación matrimonial: Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.\nHabitación simple: Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.', '2025-06-29 01:55:02'),
(71, 'user_68609ce217386', 'cuales son los precios?', 'Los precios por noche son los siguientes:\n\nHabitación Doble: S/50.00 por noche\nHabitación matrimonial: S/40.00 por noche\nHabitación simple: S/10.00 por noche', '2025-06-29 01:55:16'),
(72, 'user_68609ce217386', 'hay disponibilidad para la habitacion simple del 1 al 4 de julio?', 'Lamentablemente, no tenemos disponibilidad para la habitación simple del 1 al 4 de julio. Le sugerimos probar con otras fechas o explorar otros tipos de habitación.', '2025-06-29 01:55:52'),
(73, 'user_68609ce217386', 'y del 5 al 10 de julio?', 'No dispongo de información sobre la disponibilidad para las fechas del 5 al 10 de julio en este momento.', '2025-06-29 01:56:06'),
(74, 'user_68609ce217386', 'hola, que habitaciones tienes?', 'En', '2025-06-29 01:56:43'),
(75, 'user_68609ce217386', 'disculpa?', 'Disculpe, no he comprendido su pregunta. ¿En qué puedo ayudarle? Puedo informarle sobre la disponibilidad, los precios, los tipos de habitaciones o la información de contacto del hotel.', '2025-06-29 01:57:05'),
(76, 'user_68609ce217386', 'que tipo de habitaciones tienes?', 'En el Hotel La Fe, disponemos de las siguientes habitaciones:\n\nHabitación Doble: Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.\nHabitación matrimonial: Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.\nHabitación simple: Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.', '2025-06-29 01:57:24'),
(77, 'user_68609ce217386', 'y hay disponible la simple del 5 al 10 de julio?', 'No dispongo de información sobre la disponibilidad para la habitación simple del 5 al 10 de julio en este momento.', '2025-06-29 01:57:48'),
(78, 'user_68609ce217386', 'hay disponible la habitacion simple del 5 al 10 de julio?', 'No dispongo de información sobre la disponibilidad para la habitación simple del 5 al 10 de julio en este momento.', '2025-06-29 02:03:14'),
(79, 'user_68609fb53c190', 'hola, que habitaciones tienes?', 'Hola. Soy el Asistente Virtual del Hotel La Fe. Puedo ayudarte con información sobre disponibilidad, precios, tipos de habitaciones o datos de contacto.', '2025-06-29 02:06:45'),
(80, 'user_68609fb53c190', 'que habitaciones tienes?', 'En el Hotel La Fe, disponemos de los siguientes tipos de habitaciones:\nHabitación Doble: Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.\nHabitación matrimonial: Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.\nHabitación simple: Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.', '2025-06-29 02:07:15'),
(81, 'user_68609fb53c190', 'está disponible la habitacion simple del 5 al 10 de julio?', 'No dispongo de información sobre la disponibilidad de la habitación simple para las fechas del 5 al 10 de julio en este momento. Le sugiero probar con otras fechas o tipos de habitación.', '2025-06-29 02:08:00'),
(82, 'user_68609fb53c190', 'que habitaciones tienes?', 'En el Hotel La Fe, disponemos de los siguientes tipos de habitaciones:\nHabitación Doble: Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.\nHabitación matrimonial: Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.\nHabitación simple: Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.', '2025-06-29 02:09:59'),
(83, 'user_68609fb53c190', 'la habitacion simple esta disponible del 2 al 3 de julio?', 'La habitación simple no está disponible para las fechas del 2 al 3 de julio. Le sugiero probar con otras fechas o tipos de habitación.', '2025-06-29 02:10:39'),
(84, 'user_68609fb53c190', 'la habitacion simple esta disponible del 5 al 8 de julio?', 'Lo siento, recibí una respuesta inesperada de nuestro asistente virtual (Respuesta Gemini).', '2025-06-29 02:11:32'),
(85, 'user_68609fb53c190', 'la habitacion simple esta disponible del 5 al 8 de julio?', 'No dispongo de información sobre la disponibilidad de la habitación simple para las fechas del 5 al 8 de julio en este momento. Le sugiero probar con otras fechas o tipos de habitación.', '2025-06-29 02:11:52'),
(86, 'user_6860a49475fee', 'hola que habitaciones tienes disponibles?', 'Hola. Soy el Asistente Virtual', '2025-06-29 02:27:32'),
(87, 'user_6860a49475fee', 'que habitaciones tienes?', 'En el Hotel La Fe, tenemos los siguientes tipos de habitaciones:\n\nHabitación Doble: Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.\nHabitación matrimonial: Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.\nHabitación simple: Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.', '2025-06-29 02:28:00'),
(88, 'user_6860a49475fee', 'hay disponible la habitacion simple del 1 al 4 de julio?', 'Lamentablemente, la habitación simple no está disponible del 1 al 4 de julio, ya que se encuentra ocupada para esas fechas. Le sugiero probar con otras fechas cercanas o considerar otro tipo de habitación.', '2025-06-29 02:28:28'),
(89, 'user_6860a49475fee', 'hay disponible la habitacion simple del 5 al 8 de julio?', 'Lo siento, recibí una respuesta inesperada de nuestro asistente virtual (Respuesta Gemini).', '2025-06-29 02:29:27'),
(90, 'user_6860a49475fee', 'hay disponible la habitacion simple del 5 al 8 de julio?', 'Lo siento, recibí una respuesta inesperada de nuestro asistente virtual (Respuesta Gemini).', '2025-06-29 02:29:51'),
(91, 'user_6860a49475fee', 'hay disponible la habitacion simple del 5 al 8 de julio?', 'Lo siento, recibí una respuesta inesperada de nuestro asistente virtual (Respuesta Gemini).', '2025-06-29 02:32:51'),
(92, 'user_6860a49475fee', 'que habitaciones tienes?', 'En el Hotel La Fe, tenemos los siguientes tipos de habitaciones:\n\nHabitación Doble: Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.\nHabitación matrimonial: Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.\nHabitación simple: Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.', '2025-06-29 02:38:15'),
(93, 'user_6860a49475fee', 'hay disponible la habitacion simple del 5 al 8 de julio?', 'Lamentablemente, la habitación simple no está disponible del 5 al 8 de julio, ya que se encuentra ocupada para esas fechas. Le sugiero probar con otras fechas cercanas o considerar otro tipo de habitación.', '2025-06-29 02:38:49'),
(94, 'user_6860a49475fee', 'hay disponible la habitacion simple del 8 al 10 de julio?', 'Lo siento, recibí una respuesta inesperada de nuestro asistente virtual (Respuesta Gemini).', '2025-06-29 02:39:20'),
(95, 'user_6860a49475fee', 'hay disponible la habitacion simple del 8 al 12 de julio?', 'Lo siento, recibí una respuesta inesperada de nuestro asistente virtual (Respuesta Gemini).', '2025-06-29 02:39:49'),
(96, 'user_6860a49475fee', 'hay disponible la habitacion simple del 5 al 8 de julio?', 'Sí, la habitación simple está disponible del 5 al 8 de julio. Tiene capacidad para 1 persona y el precio por noche es de S/10.00.', '2025-06-29 02:40:33'),
(97, 'user_6860a49475fee', 'listo, entonces cuanto seria el total a pagar?', 'No estoy seguro de entender completamente su pregunta. ¿Podría proporcionar más detalles? Puedo ayudarle con información sobre disponibilidad, precios, tipos de habitaciones o información de contacto del hotel.', '2025-06-29 02:41:13'),
(98, 'user_6860abb17d3eb', 'hay disponible la habitacion simple del 5 al 8 de julio?', 'Sí, hay habitaciones simples disponibles del 5 al 8 de julio. La habitación simple tiene capacidad para 1 persona y el precio por noche es de S/10.00.', '2025-06-29 02:57:53'),
(99, 'user_6860abb17d3eb', 'listo, entonces cuanto seria el total a pagar?', 'Para poder calcular el total, por favor, indíqueme las fechas de su estancia y el tipo de habitación que desea reservar.', '2025-06-29 02:58:09'),
(100, 'user_6860abb17d3eb', 'del 5 al 8 de julio', 'Habitaciones disponibles del 5 al 8 de julio:\nHabitación Doble (capacidad: 2 personas, precio por noche: S/50.00)\nHabitación matrimonial (capacidad: 2 personas, precio por noche: S/40.00)\nHabitación simple (capacidad: 1 personas, precio por noche: S/10.00)', '2025-06-29 02:58:22'),
(101, 'user_6860abb17d3eb', 'hay disponible la habitacion simple del 5 al 8 de julio?', 'Sí, la habitación simple está disponible del 5 al 8 de julio.\n\nHabitación simple (capacidad: 1 persona, precio por noche: S/10.00)', '2025-06-29 03:00:45'),
(102, 'user_6860abb17d3eb', 'listo, entonces cuanto seria el total a pagar?', 'El total a pagar por la habitación simple del 5 al 8 de julio es S/30.00.', '2025-06-29 03:00:54'),
(103, 'user_6860abb17d3eb', 'y si quiero del 5 al 15 de julio?', 'Habitaciones disponibles del 5 al 15 de julio:\nHabitación Doble (capacidad: 2 personas, precio por noche: S/50.00)\nHabitación matrimonial (capacidad: 2 personas, precio por noche: S/40.00)\nHabitación simple (capacidad: 1 persona, precio por noche: S/10.00)', '2025-06-29 03:01:11'),
(104, 'user_6860abb17d3eb', 'cuanto sería el total?', 'El total a pagar por la habitación simple del 5 al 15 de julio es S/100.00.', '2025-06-29 03:01:33'),
(105, 'user_6860abb17d3eb', 'hola', 'Hola, ¿en qué puedo ayudarle hoy? Puedo asistirle con información sobre disponibilidad, precios, tipos de habitaciones o información de contacto.', '2025-06-29 03:09:59'),
(106, 'user_6860abb17d3eb', 'que precios tiene', 'Los precios por noche son: Habitación Doble S/50.00, Habitación matrimonial S/40.00 y Habitación simple S/10.00.', '2025-06-29 03:10:11'),
(107, 'user_6860abb17d3eb', 'quiero saber si esta disponible la habitacion simple del 1 al 4 de julio', 'La habitación simple no está disponible del 1 al 4 de julio. Está ocupada para esas fechas. Podría probar con otras fechas cercanas o consultar por otro tipo de habitación.', '2025-06-29 03:11:00'),
(108, 'user_6860abb17d3eb', 'y estará disponible la habitacion simple del 5 al 8 de julio?', 'Sí, la habitación simple está disponible del 5 al 8 de julio.\n\nHabitación simple (capacidad: 1 persona, precio por noche: S/10.00)', '2025-06-29 03:11:32'),
(109, 'user_6860abb17d3eb', 'y cual sería el total a pagar?', 'El total a pagar por la habitación simple del 5 al 8 de julio es S/30.00.', '2025-06-29 03:11:52'),
(110, 'user_6860abb17d3eb', 'que opiniones hay del hotel?', 'Aquí tienes algunos comentarios de nuestros huéspedes: \"Bueno y bacan\", \"Excelente atención y limpieza.\" y \"Muy buena ubicación y desayuno variado.\"', '2025-06-29 03:16:35'),
(111, 'user_6860abb17d3eb', 'tienes el correo para comunicarme?', 'El correo es escobedomichael921@gmail.com.', '2025-06-29 03:16:48'),
(112, 'user_6860abb17d3eb', 'puedes darme le whatsapp del hotel?', 'WhatsApp: https://wa.me/964954496', '2025-06-29 03:17:06'),
(113, 'user_6861db2edc75f', '¿cuáles son los horarios del hotel?', 'No estoy seguro de entender completamente tu pregunta sobre los horarios del hotel. ¿Podrías ser más específico? Puedo ayudarte con información sobre disponibilidad, precios, tipos de habitaciones o información de contacto si lo deseas.', '2025-06-30 00:32:46'),
(114, 'user_6861db2edc75f', '¿qué servicios ofrece el hotel?', 'No estoy seguro de entender completamente tu pregunta. ¿Podrías ser más específico? Puedo ayudarte con información sobre disponibilidad, precios, tipos de habitaciones o información de contacto del hotel.', '2025-06-30 00:32:57'),
(115, 'user_6861db2edc75f', '¿cómo puedo hacer una reserva?', 'No estoy seguro de entender completamente tu pregunta. ¿Podrías ser más específico? Puedo ayudarte con información sobre disponibilidad, precios, tipos de habitaciones o información de contacto del hotel.', '2025-06-30 00:33:03'),
(116, 'user_6861db2edc75f', '¿qué actividades hay cerca del hotel?', 'No dispongo de información sobre actividades cerca del hotel en este momento.', '2025-06-30 00:33:09'),
(117, 'user_6861db2edc75f', '¿cuál es la política de cancelación?', 'No estoy seguro de entender completamente tu pregunta. ¿Podrías ser más específico? Puedo ayudarte con información sobre disponibilidad, precios, tipos de habitaciones o información de contacto del hotel.', '2025-06-30 00:33:19'),
(118, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', 'Estos son los tipos de habitaciones disponibles en el Hotel La Fe:\n- Habitación Doble: <p>Un espacio elegante y funcional diseñado para viajeros de negocios que valoran la comodidad y la eficiencia durante su estancia.</p>\n- Habitación matrimonial: <p>Amplia y acogedora, esta habitación es ideal para familias que desean compartir momentos especiales juntos mientras disfrutan de todas las comodidades del hogar.</p>\n- Habitación simple: <p>Un refugio tranquilo y relajante, perfecto para aquellos que buscan escapar del ajetreo y el bullicio de la vida cotidiana.</p>', '2025-06-30 00:38:06'),
(119, 'user_6861db2edc75f', '¿cómo puedo contactar al hotel?', 'No estoy seguro de entender completamente tu pregunta. ¿Podrías ser más específico? Puedo ayudarte con información sobre disponibilidad, precios, tipos de habitaciones o información de contacto del hotel.', '2025-06-30 00:38:52'),
(120, 'user_6861db2edc75f', '¿cómo puedo contactar al hotel?', 'No estoy seguro de entender completamente tu pregunta. ¿Podrías ser más específico? Puedo ayudarte con información sobre disponibilidad, precios, tipos de habitaciones o información de contacto del hotel.', '2025-06-30 00:39:03'),
(121, 'user_6861db2edc75f', 'cómo me pongo en contacto con el hotel?', 'Información de contacto del Hotel La Fe:\nTeléfono: 51 964 954 496\nCorreo: escobedomichael921@gmail.com\nDirección: OTUZCO - LA LIBERTAD\nWhatsApp: https://wa.me/964954496\nFacebook: https://www.facebook.com/HotelLafeotuzco\nInstagram: https://www.instagram.com/alexanderhpg?igsh=aGxmYWt2NzZkMDBq', '2025-06-30 00:39:17'),
(122, 'user_6861db2edc75f', '¿qué calificaciones tiene el hotel?', 'Aquí tienes algunos comentarios de nuestros huéspedes: \"Bueno y bacan\", \"Excelente atención y limpieza.\", \"Muy buena ubicación y desayuno variado.\"', '2025-06-30 00:39:25'),
(123, 'user_6861db2edc75f', 'hola', 'Lo siento, el asistente virtual no pudo procesar tu solicitud. (HTTP 400)', '2025-06-30 01:10:52'),
(124, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', 'Lo siento, el asistente virtual no pudo procesar tu solicitud. (HTTP 400)', '2025-06-30 01:10:59'),
(125, 'user_6861db2edc75f', '¿cómo puedo contactar al hotel?', 'Lo siento, el asistente virtual no pudo procesar tu solicitud. (HTTP 400)', '2025-06-30 01:11:18'),
(126, 'user_6861db2edc75f', 'hola', '¡Hola! Bienvenido/a. ¿En qué puedo ayudarte hoy?  Puedo ayudarte con información sobre disponibilidad, precios, tipos de habitación o reservas.  Veo que has estado buscando habitaciones simples para el 1 de julio al 4 de julio y del 5 de julio al 15 de julio. ¿Te gustaría que revisemos la disponibilidad para esas fechas?\n', '2025-06-30 01:13:36'),
(127, 'user_6861db2edc75f', 'si, por favor', 'Entendido. ¿Te refieres a la disponibilidad de habitaciones simples para las fechas que mencionaste anteriormente: del 1 de julio al 4 de julio y del 5 de julio al 15 de julio?\n', '2025-06-30 01:13:56'),
(128, 'user_6861db2edc75f', 'solo del 5 al 15 de julio por favor', 'Perfecto. Entiendo que quieres saber la disponibilidad de habitaciones simples del 5 al 15 de julio. Estoy revisando la disponibilidad para esas fechas. Por favor, espera un momento.\n', '2025-06-30 01:14:25'),
(129, 'user_6861db2edc75f', 'listo', 'Entendido. ¿Listo para qué? ¿Quieres que te confirme la disponibilidad de habitaciones simples del 5 al 15 de julio?\n', '2025-06-30 01:14:36'),
(130, 'user_6861db2edc75f', 'sí por favor', 'Perfecto. Entiendo que quieres que te confirme la disponibilidad de habitaciones simples del 5 al 15 de julio. Estoy revisando la disponibilidad para esas fechas. Por favor, espera un momento.\n', '2025-06-30 01:14:50'),
(131, 'user_6861db2edc75f', 'si hay disponibilidad?', 'Estoy revisando la disponibilidad de habitaciones simples del 5 al 15 de julio. Por favor, espera un momento.\n', '2025-06-30 01:15:06'),
(132, 'user_6861db2edc75f', 'ya revisaste?', '¿Te refieres a si ya terminé de revisar la disponibilidad de habitaciones simples del 5 al 15 de julio?\n', '2025-06-30 01:15:21'),
(133, 'user_6861db2edc75f', 'si', 'Entendido. Para confirmar, ¿quieres saber si ya terminé de revisar la disponibilidad de habitaciones simples del 5 al 15 de julio?\n', '2025-06-30 01:15:27'),
(134, 'user_6861db2edc75f', 'síii', 'Entendido. ¿Quieres saber si ya terminé de revisar la disponibilidad de habitaciones simples del 5 al 15 de julio?\n', '2025-06-30 01:15:36'),
(135, 'user_6861db2edc75f', 'xd', 'Entiendo. No estoy seguro de qué necesitas ahora. ¿Podrías indicarme si deseas saber sobre precios, disponibilidad, tipos de habitaciones, reservas o algo más? Estoy aquí para ayudarte.\n', '2025-06-30 01:15:44'),
(136, 'user_6861db2edc75f', 'hay disponibilidad para reservar la habitacion simple del 5 al 15 de julio?', 'Estoy revisando la disponibilidad de habitaciones simples del 5 al 15 de julio. Por favor, espera un momento.\n', '2025-06-30 01:16:09'),
(137, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', 'Actualmente ofrecemos los siguientes tipos de habitación:\n\n*   **Habitación Simple**\n*   **Habitación Doble**\n*   **Suite Presidencial:** La opción más lujosa, con amplias estancias y vistas panorámicas.\n', '2025-06-30 02:07:40'),
(138, 'user_6861db2edc75f', '¿qué precios tienen las habitaciones?', 'Para darte los precios, necesito saber qué tipo de habitación te interesa y para qué fechas (entrada y salida). ¿Me puedes dar esa información?\n', '2025-06-30 02:07:51'),
(139, 'user_6861db2edc75f', '¿cómo puedo contactar al hotel?', 'Puedes contactar al hotel de las siguientes maneras:\n\n*   **Teléfono:** [Número de teléfono del hotel]\n*   **Correo electrónico:** [Dirección de correo electrónico del hotel]\n*   **Formulario de contacto:** [Enlace al formulario de contacto en la página web del hotel]\n*   **Dirección:** [Dirección física del hotel]\n\n¿Te gustaría que te proporcione alguno de estos datos en particular?\n', '2025-06-30 02:08:01'),
(140, 'user_6861db2edc75f', '¿qué calificaciones tiene el hotel?', 'No tengo acceso a las calificaciones del hotel. ¿Te gustaría que te ayude con otra cosa, como precios, disponibilidad, tipos de habitaciones, reservas o información de contacto?\n', '2025-06-30 02:08:10'),
(141, 'user_6861db2edc75f', '¿cuáles son los horarios del hotel?', 'No tengo esa información sobre los horarios del hotel. ¿Te gustaría que te ayude con otra cosa, como precios, disponibilidad, tipos de habitaciones, reservas o información de contacto?\n', '2025-06-30 02:08:28'),
(142, 'user_6861db2edc75f', 'hola', '¡Hola! Bienvenido al Hotel La Fe. Es un placer saludarte. ¿En qué puedo ayudarte hoy? Puedo brindarte información sobre precios, disponibilidad, tipos de habitación o ayudarte con tu reserva. ¡Estoy a tu disposición!\n', '2025-06-30 02:23:34'),
(143, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', 'Ya te he proporcionado la lista de tipos de habitaciones que tenemos. ¿Te gustaría saber algo más sobre ellas, como la disponibilidad, los precios o las características de cada una?\n', '2025-06-30 02:23:46'),
(144, 'user_6861db2edc75f', '¿qué precios tienen las habitaciones?', 'La habitación individual cuesta S/40 por noche, la habitación doble S/50 por noche y la suite familiar S/80 por noche.\n', '2025-06-30 02:24:03'),
(145, 'user_6861db2edc75f', 'que precios tienen?', 'La habitación individual cuesta S/40 por noche, la habitación doble S/50 por noche y la suite familiar S/80 por noche.\n', '2025-06-30 02:28:31'),
(146, 'user_6861db2edc75f', 'hay habitacion simple?', '¿Te refieres a si tenemos disponibilidad de habitaciones individuales o si quieres saber algo más sobre ellas, como el precio o las características?\n', '2025-06-30 02:28:48'),
(147, 'user_6861db2edc75f', 'la habitacion simple', 'Entiendo. Para ayudarte mejor con la habitación simple, ¿te gustaría saber si tenemos disponibilidad, cuál es el precio o alguna otra característica específica?\n', '2025-06-30 02:29:05'),
(148, 'user_6861db2edc75f', 'el precio', 'La habitación individual cuesta S/40 por noche.\n', '2025-06-30 02:29:15'),
(149, 'user_6861db2edc75f', '¿qué precios tienen las habitaciones?', 'La habitación individual cuesta S/40 por noche, la habitación doble S/50 por noche y la suite familiar S/80 por noche.\n', '2025-06-30 02:32:16'),
(150, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', 'Ofrecemos habitaciones individuales, dobles y suites familiares. ¿Te gustaría saber más sobre alguna de ellas en particular, como sus características o precios?\n', '2025-06-30 02:32:21'),
(151, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', 'Ofrecemos habitaciones individuales, dobles y suites familiares. ¿Te gustaría saber algo más sobre alguna de ellas, como la disponibilidad o los precios?\n', '2025-06-30 02:34:06'),
(152, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', '```json\n{\"tool_name\": \"obtener_tipos_habitacion\"}\n```\n', '2025-06-30 02:39:14'),
(153, 'user_6861db2edc75f', '¿qué precios tienen las habitaciones?', '```json\n{\"tool_name\": \"obtener_tipos_habitacion\"}\n```\n', '2025-06-30 02:39:21'),
(154, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', '```json\n{\"tool_name\": \"obtener_tipos_habitacion\"}\n```\n', '2025-06-30 02:42:04'),
(155, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', 'Ofrecemos habitación simple, habitación matrimonial y habitación doble. ¿Te gustaría saber algo más sobre alguna de ellas, como la disponibilidad o los precios?\n', '2025-06-30 02:46:51'),
(156, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', 'Ofrecemos habitación simple, habitación doble, habitación familiar y habitación matrimonial. ¿Te gustaría saber algo más sobre alguna de ellas, como la disponibilidad o los precios?\n', '2025-06-30 02:49:26'),
(157, 'user_6861db2edc75f', 'los precios?', 'Ofrecemos:\n\n*   Habitación Simple: S/10 por noche\n*   Habitación Doble: S/20 por noche\n*   Habitación Familiar: S/25 por noche\n*   Habitación Matrimonial: S/50 por noche\n', '2025-06-30 02:49:38'),
(158, 'user_6861db2edc75f', 'hay disponible la simple del 1 al 4 de julio?', '¡Hola! Sí, tenemos disponibilidad de habitación simple del 1 al 4 de julio, a S/10.00 por noche. También tenemos disponibilidad de habitación matrimonial (S/40.00 por noche) y habitación doble (S/50.00 por noche) para esas fechas. ¿Te gustaría reservar alguna de estas opciones?\n', '2025-06-30 02:50:00'),
(159, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', 'Ofrecemos habitación simple, habitación doble, habitación familiar y habitación matrimonial. ¿Te gustaría saber algo más sobre alguna de ellas, como la disponibilidad o los precios?\n', '2025-06-30 02:52:41'),
(160, 'user_6861db2edc75f', 'sí, los precios', 'Los precios de nuestras habitaciones son los siguientes:\n\n* Habitación Simple: S/10 por noche\n* Habitación Doble: S/20 por noche\n* Habitación Familiar: S/25 por noche\n* Habitación Matrimonial: S/50 por noche\n\n¿Te gustaría saber algo más, como la disponibilidad para ciertas fechas o alguna otra característica de las habitaciones?\n', '2025-06-30 02:52:53'),
(161, 'user_6861db2edc75f', 'esta disponible la simple del 1 al 4 de julio?', 'No dispongo de esa información en este momento, pero puedo ayudarte con los precios, tipos de habitación o disponibilidad si me indicas las fechas.\n', '2025-06-30 02:53:11'),
(162, 'user_6861db2edc75f', 'esta disponible la habitacion simple del 1 al 4 de julio?', 'Lo siento, pero no hay disponibilidad de habitaciones simples del 1 al 4 de julio.  Te sugiero que intentes consultar la disponibilidad para otras fechas o consideres alguno de nuestros otros tipos de habitaciones: dobles, familiares o matrimoniales.  ¿Te gustaría que te ayude a buscar disponibilidad en otras fechas?\n', '2025-06-30 02:53:39'),
(163, 'user_6861db2edc75f', 'y para el 5 al 9 de julio?', '¿Qué tipo de habitación te interesa para esas fechas?\n', '2025-06-30 02:54:00'),
(164, 'user_6861db2edc75f', 'simple', '¿Para qué fechas te interesa la habitación simple?\n', '2025-06-30 02:54:05'),
(165, 'user_6861db2edc75f', 'del 5 al 9 de julio', '¿Qué tipo de habitación te interesa del 5 al 9 de julio?\n', '2025-06-30 02:54:16'),
(166, 'user_6861db2edc75f', 'la habitacion simple', '¿Para qué fechas te interesa la habitación simple?\n', '2025-06-30 02:54:27'),
(167, 'user_6861db2edc75f', 'ya te lo dije', 'No he entendido tu consulta. ¿Puedo ayudarte con información sobre nuestras habitaciones o reservas?\n', '2025-06-30 02:54:35'),
(168, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', 'Los tipos de habitaciones que tenemos son: Simple, Doble, Familiar y Matrimonial.\n', '2025-06-30 02:59:30'),
(169, 'user_6861db2edc75f', '¿qué precios tienen las habitaciones?', 'Los precios de nuestras habitaciones son los siguientes:\n\n- Habitación Simple: S/10\n- Habitación Doble: S/20\n- Habitación Familiar: S/25\n- Habitación Matrimonial: S/50\n', '2025-06-30 02:59:35'),
(170, 'user_6861db2edc75f', 'está disponible la habitacion simple del 1 al 4 de julio?', 'Lo siento, pero ya te indiqué que no hay disponibilidad de habitaciones simples del 1 al 4 de julio.  ¿Te gustaría consultar la disponibilidad para otras fechas o un tipo de habitación diferente?\n', '2025-06-30 03:00:21'),
(171, 'user_6861db2edc75f', 'y del 5 al 9 de julio?', '¿Qué tipo de habitación te interesa del 5 al 9 de julio?\n', '2025-06-30 03:00:40'),
(172, 'user_6861db2edc75f', 'habitacion simple', '¿Para qué fechas te gustaría la habitación simple?\n', '2025-06-30 03:00:51'),
(173, 'user_6861db2edc75f', 'del 5 al 9 de julio', '¿Para qué fechas te gustaría la habitación simple?\n', '2025-06-30 03:01:04'),
(174, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', '<pensamiento>\n1. **SÍNTESIS:** El usuario pregunta por los tipos de habitaciones disponibles en el hotel.  No hay una solicitud de disponibilidad con fechas específicas.\n\n2. **INTENCIÓN:** La solicitud es sobre `tipos_habitacion`.\n\n3. **DATOS PARA DISPONIBILIDAD:** No aplica, ya que la intención no es verificar disponibilidad.\n</pensamiento>\n\n**ACCIÓN A:**\n\nLos tipos de habitaciones que tenemos son: Simple, Doble, Familiar y Matrimonial.\n', '2025-06-30 03:04:26'),
(175, 'user_6861db2edc75f', 'está disponible la habitacion simple del 1 al 4 de julio?', '<pensamiento>\n1. **SÍNTESIS:** El usuario pregunta si hay disponibilidad de una habitación simple del 1 al 4 de julio.\n\n2. **INTENCIÓN:** La solicitud es sobre `disponibilidad`.\n\n3. **DATOS PARA DISPONIBILIDAD:**\n    - tipo_habitacion: Sí (simple)\n    - fecha_inicio: Sí (1 de julio)\n    - fecha_fin: Sí (4 de julio)\n</pensamiento>\n\nLo siento, pero ya te indiqué que no hay disponibilidad de habitaciones simples del 1 al 4 de julio.  ¿Te gustaría consultar la disponibilidad para otras fechas o un tipo de habitación diferente?\n', '2025-06-30 03:06:28'),
(176, 'user_6861db2edc75f', 'y del 5 al 9 de julio?', '<pensamiento>\n1. **SÍNTESIS:** El usuario pregunta por la disponibilidad de una habitación simple del 5 al 9 de julio.\n\n2. **INTENCIÓN:** La solicitud es sobre `disponibilidad`.\n\n3. **DATOS PARA DISPONIBILIDAD:**\n    - tipo_habitacion: Sí (simple)\n    - fecha_inicio: Sí (5 de julio)\n    - fecha_fin: Sí (9 de julio)\n</pensamiento>\n\n```json\n{\"tool_name\": \"verificar_disponibilidad\", \"parameters\": {\"tipo_habitacion\": \"simple\", \"fecha_inicio\": \"2024-07-05\", \"fecha_fin\": \"2024-07-09\"}}\n```\n', '2025-06-30 03:08:58'),
(177, 'user_6861db2edc75f', '¿qué tipos de habitaciones tienes?', '**ACCIÓN A:**\n\nTenemos cuatro tipos de habitaciones: Simple, Doble, Familiar y Matrimonial.  ¿Te gustaría saber más sobre alguna en particular?', '2025-06-30 03:23:12'),
(178, 'user_6861db2edc75f', 'hay disponibilidad del 5 al 9 de julio la habitacion simple?', '¡Buenos días!  He revisado la disponibilidad para una habitación simple del 5 al 9 de julio y ¡tenemos buenas noticias!  Sí, hay disponibilidad.  Tenemos habitaciones simples a S/10.00 por noche. ¿Le gustaría que le reserve una?\n', '2025-06-30 03:23:43'),
(179, 'user_6861db2edc75f', 'y del 1 al 4 de julio?', 'Buenos días/tardes.  He revisado la disponibilidad para una habitación sencilla del 1 al 4 de julio.  Lamentablemente, no tenemos ninguna habitación de ese tipo disponible en esas fechas.  ¿Le gustaría que revisáramos otras opciones, como una habitación doble, o quizás otras fechas?  También puedo buscar disponibilidad en hoteles cercanos si le interesa.\n', '2025-06-30 03:24:08'),
(180, 'user_6861db2edc75f', 'y para el 10 de julio hasta el 25 de julio?', '**ACCIÓN C:**\n\nEntendido. ¿Qué tipo de habitación te interesa para esas fechas?', '2025-06-30 03:24:39');
INSERT INTO `historial_chat` (`id`, `user_id`, `mensaje_usuario`, `respuesta_bot`, `fecha`) VALUES
(181, 'user_6861db2edc75f', 'la habitacion simple', '**ACCIÓN C:**\n\nPara poder ayudarte, necesito saber las fechas en las que necesitas la habitación simple. ¿Para qué fechas te gustaría reservar?', '2025-06-30 03:24:50'),
(182, 'user_6861db2edc75f', 'del 10 al 25 de julio', '¡Hola!  He revisado la disponibilidad para usted del 10 al 25 de julio y ¡tenemos buenas noticias!  Sí hay habitaciones disponibles.  En este momento, tenemos habitaciones simples a S/10.00 por noche. ¿Le gustaría que le diera más detalles o procedamos con la reserva?\n', '2025-06-30 03:25:03'),
(183, 'user_6861db2edc75f', 'mi esposa tambien irá, asi que quisiera saber si en lugar de la habitacion simple, se use la matrimonial', '¡Claro que sí!  He revisado la disponibilidad y tenemos habitaciones matrimoniales disponibles para usted y su esposa.  El precio por noche es de S/40.00. ¿Le gustaría reservar una?\n', '2025-06-30 03:26:16'),
(184, 'user_6861db2edc75f', 'si, del 5 al 9 de julio por favor', '¡Hola!  He revisado la disponibilidad para usted del 5 al 9 de julio y ¡tenemos buenas noticias!  Sí hay habitaciones disponibles.  Encontré una habitación matrimonial a S/40.00 por noche. ¿Le gustaría reservar esta habitación o desea ver otras opciones?\n', '2025-06-30 03:26:39'),
(185, 'user_6861db2edc75f', 'y cuanto estaria costando?', '## PASO 1: PENSAMIENTO INTERNO\n\n1. **SÍNTESIS:** El usuario pregunta el costo total de una habitación matrimonial del 5 al 9 de julio,  siendo que ya se confirmó la disponibilidad.\n\n2. **INTENCIÓN:** La solicitud se centra en el `precios`.\n\n3. **DATOS PARA DISPONIBILIDAD:** No aplica, la intención no es `disponibilidad`.\n\n\n## PASO 2: ACCIÓN Y RESPUESTA FINAL\n\nEl costo de una habitación matrimonial es de S/50 por noche.  Del 5 al 9 de julio son 5 noches, por lo tanto, el costo total sería S/250.', '2025-06-30 03:27:03'),
(186, 'user_6862047651a89', '¿qué tipos de habitaciones tienes?', '## PASO 1: PENSAMIENTO INTERNO\n\n1. **SÍNTESIS:** El usuario pregunta sobre los tipos de habitaciones disponibles en el Hotel La Fe.\n\n2. **INTENCIÓN:** La solicitud es sobre `tipos_habitacion`.\n\n3. **DATOS PARA DISPONIBILIDAD:** No aplica, ya que la intención no es sobre disponibilidad.\n\n\n## PASO 2: ACCIÓN Y RESPUESTA FINAL\n\nEn el Hotel La Fe, ofrecemos los siguientes tipos de habitaciones: Habitación Simple, Habitación Doble, Habitación Familiar y Habitación Matrimonial.  ¿Te gustaría saber más sobre alguna en particular?', '2025-06-30 03:28:54'),
(187, 'user_686204a371085', 'que habitaciones tienes y cual es el costo de cada uno', '## PASO 1: PENSAMIENTO INTERNO\n\n1. **SÍNTESIS:** El usuario solicita información sobre los tipos de habitaciones disponibles en el Hotel La Fe y el costo de cada una.\n\n2. **INTENCIÓN:** La solicitud es sobre `tipos_habitacion` y `precios`.\n\n3. **DATOS PARA DISPONIBILIDAD:** No aplica, ya que la intención no es sobre disponibilidad.\n</pensamiento>\n\n## PASO 2: ACCIÓN Y RESPUESTA FINAL\n\nEn el Hotel La Fe, contamos con los siguientes tipos de habitaciones y sus precios base por noche:\n\n- Habitación Simple: S/10\n- Habitación Doble: S/20\n- Habitación Familiar: S/25\n- Habitación Matrimonial: S/50\n\n¿Te gustaría saber algo más?', '2025-06-30 03:29:39'),
(188, 'user_686204a371085', 'quiero una habitacion matrimonial para el 30 de junio hasta el 2 de julio', '¡Hola!  He revisado la disponibilidad para una habitación matrimonial del 30 de junio al 2 de julio y ¡tenemos buenas noticias!  Tenemos habitaciones matrimoniales disponibles a S/40.00 por noche. ¿Le gustaría que le reserve una?\n', '2025-06-30 03:30:31'),
(189, 'user_686204a371085', 'cual seria el costo total?', '## PASO 1: PENSAMIENTO INTERNO\n\n1. **SÍNTESIS:** El usuario pregunta por el costo total de una habitación matrimonial del 30 de junio al 2 de julio,  siendo que ya se le ha informado que hay disponibilidad a S/40.00 por noche.\n\n2. **INTENCIÓN:** La solicitud es sobre `precios`.\n\n3. **DATOS PARA DISPONIBILIDAD:** No aplica.\n\n\n## PASO 2: ACCIÓN Y RESPUESTA FINAL\n\nEl costo por noche de una habitación matrimonial es de S/40.00.  Como su reserva es del 30 de junio al 2 de julio (3 noches), el costo total sería S/120.00 (3 noches x S/40.00/noche).', '2025-06-30 03:32:05'),
(190, 'user_686204a371085', 'hola, como tu te llamas?', '## PASO 2: ACCIÓN Y RESPUESTA FINAL\n\nSoy un asistente virtual del HOTEL LA FE. Estoy aquí para ayudarte con tu reserva.', '2025-06-30 03:36:14'),
(191, 'user_686204a371085', 'donde está ubicado el hotel?', '## PASO 2: ACCIÓN Y RESPUESTA FINAL\n\nEl Hotel La Fe está ubicado en OTUZCO - LA LIBERTAD.', '2025-06-30 03:36:36'),
(192, 'user_686204a371085', 'dame el whatsapp del hotel', '```tool_code\n## PASO 1: PENSAMIENTO INTERNO\n1. **SÍNTESIS:** El usuario solicita el número de WhatsApp del hotel.\n2. **INTENCIÓN:** La solicitud es sobre `otra_cosa` (información de contacto).\n3. **DATOS PARA DISPONIBILIDAD:** No aplica.\n</pensamiento>\n\n## PASO 2: ACCIÓN Y RESPUESTA FINAL\nEl número de WhatsApp del Hotel La Fe es: https://wa.me/964954496\n```', '2025-06-30 03:37:02'),
(193, 'user_686204a371085', 'cuantas habitaciones tienes por piso?', '```tool_code\n## PASO 1: PENSAMIENTO INTERNO\n1. **SÍNTESIS:** El usuario pregunta cuántas habitaciones hay por piso en el hotel.\n2. **INTENCIÓN:** La solicitud es sobre `otra_cosa` (información general del hotel que no tengo).\n3. **DATOS PARA DISPONIBILIDAD:** No aplica.\n</pensamiento>\n\n## PASO 2: ACCIÓN Y RESPUESTA FINAL\nNo he entendido tu consulta. ¿Puedo ayudarte con información sobre nuestras habitaciones o reservas?\n```', '2025-06-30 03:38:02'),
(194, 'user_686204a371085', 'sabes cuanto es 1+1?', '```tool_code\n## PASO 1: PENSAMIENTO INTERNO\n1. **SÍNTESIS:** El usuario pregunta cuánto es 1+1. Esta pregunta no está relacionada con el hotel.\n2. **INTENCIÓN:** La solicitud es sobre `otra_cosa` (una pregunta matemática).\n3. **DATOS PARA DISPONIBILIDAD:** No aplica.\n</pensamiento>\n\n## PASO 2: ACCIÓN Y RESPUESTA FINAL\nNo he entendido tu consulta. ¿Puedo ayudarte con información sobre nuestras habitaciones o reservas?\n```', '2025-06-30 03:38:21'),
(195, 'user_686204a371085', '¿qué tipos de habitaciones tienes?', '```tool_code\n## PASO 1: PENSAMIENTO INTERNO\n1. **SÍNTESIS:** El usuario pregunta qué tipos de habitaciones están disponibles en el hotel.\n2. **INTENCIÓN:** La solicitud es sobre `tipos_habitacion`.\n3. **DATOS PARA DISPONIBILIDAD:** No aplica.\n</pensamiento>\n\n## PASO 2: ACCIÓN Y RESPUESTA FINAL\nEn el Hotel La Fe, contamos con los siguientes tipos de habitaciones: Habitación Simple, Habitación Doble, Habitación Familiar y Habitación Matrimonial.\n```', '2025-06-30 03:42:08'),
(196, 'user_686204a371085', '¿qué precios tienen las habitaciones?', '```tool_code\n## PASO 1: PENSAMIENTO INTERNO\n1. **SÍNTESIS:** El usuario pregunta por los precios de las habitaciones disponibles en el hotel.\n2. **INTENCIÓN:** La solicitud es sobre `precios`.\n3. **DATOS PARA DISPONIBILIDAD:** No aplica.\n</pensamiento>\n\n## PASO 2: ACCIÓN Y RESPUESTA FINAL\nLos precios base de nuestras habitaciones son: Habitación Simple: S/10 por noche, Habitación Doble: S/20 por noche, Habitación Familiar: S/25 por noche, y Habitación Matrimonial: S/50 por noche.\n```', '2025-06-30 03:42:15'),
(197, 'user_686204a371085', '¿cómo puedo contactar al hotel?', '```tool_code\n## PASO 1: PENSAMIENTO INTERNO\n1. **SÍNTESIS:** El usuario pregunta cómo puede contactar al hotel.\n2. **INTENCIÓN:** La solicitud es sobre `otra_cosa` (información de contacto).\n3. **DATOS PARA DISPONIBILIDAD:** No aplica.\n</pensamiento>\n\n## PASO 2: ACCIÓN Y RESPUESTA FINAL\nPuedes contactarnos a través de los siguientes medios: Teléfono: 51 964 954 496, Correo: escobedomichael921@gmail.com, o vía WhatsApp: https://wa.me/964954496.\n```', '2025-06-30 03:42:21'),
(198, 'user_686204a371085', '¿qué calificaciones tiene el hotel?', '```tool_code\n## PASO 1: PENSAMIENTO INTERNO\n1. **SÍNTESIS:** El usuario pregunta por las calificaciones del hotel. Esto se refiere a las opiniones de los clientes.\n2. **INTENCIÓN:** La solicitud es sobre `otra_cosa` (opiniones de clientes).\n3. **DATOS PARA DISPONIBILIDAD:** No aplica.\n</pensamiento>\n\n## PASO 2: ACCIÓN Y RESPUESTA FINAL\nAlgunas opiniones de nuestros clientes son: \"Bueno y bacan\", \"Excelente atención y limpieza.\", \"Muy buena ubicación y desayuno variado.\"\n```', '2025-06-30 03:42:32'),
(199, 'user_686208ac9e6bb', 'hola', '**ACCIÓN A:**\nHola! En qué puedo ayudarte hoy? Puedo darte información sobre nuestras habitaciones, precios o ayudarte con una reserva.', '2025-06-30 03:46:52'),
(200, 'user_686208ac9e6bb', '¿qué tipos de habitaciones tienes?', '**ACCIÓN A:**\nContamos con habitación Simple (S/10 por noche), Doble (S/20 por noche), Familiar (S/25 por noche) y Matrimonial (S/50 por noche).', '2025-06-30 03:46:58'),
(201, 'user_686208ac9e6bb', '¿qué precios tienen las habitaciones?', '**ACCIÓN A:**\nHabitación Simple: S/10 por noche, Habitación Doble: S/20 por noche, Habitación Familiar: S/25 por noche, Habitación Matrimonial: S/50 por noche.', '2025-06-30 03:47:04'),
(202, 'user_686208ac9e6bb', 'del 5 al 10 de julio, habitacion simple, hay disponibilidad? cuanto seria el total?', '¡Hola! ¡Buenas noticias! Sí tenemos disponibilidad de habitación simple del 5 al 10 de julio. El precio por noche es de S/10.00.  Así que el total por las 5 noches sería de S/50.00. ¿Te gustaría que la reserve para ti?\n', '2025-06-30 03:47:39'),
(203, 'user_68620a319f03c', '¿qué tipos de habitaciones tienes?', 'En el HOTEL LA FE, contamos con Habitación Simple (S/10 por noche), Habitación Doble (S/20 por noche), Habitación Familiar (S/25 por noche) y Habitación Matrimonial (S/50 por noche). ¿En cuál está interesado?', '2025-06-30 03:53:21'),
(204, 'user_68620a319f03c', 'tienes disponible la habitacion simple del 1 al 4 de julio?', '¡Hola! Gracias por tu consulta.\n\nLamentablemente, no tenemos disponibilidad para la habitación simple que solicitaste del 1 al 4 de julio. Lo siento mucho.\n\n¿Te gustaría que revisara otras fechas o tal vez otro tipo de habitación? Podríamos ver si hay algo más que se ajuste a tus necesidades.\n', '2025-06-30 03:53:51'),
(205, 'user_68620a319f03c', 'y para el 5 al 10 de julio?', '¡Claro! Para las fechas del 5 al 10 de julio, sí tenemos disponibilidad. Encontramos habitaciones simples disponibles a S/10.00 por noche. ¿Le gustaría que le reserve una?\n', '2025-06-30 03:54:10'),
(206, 'user_68620a319f03c', 'sí, por favor, cuanto sería el costo total?', '¡Claro! El costo total de la habitación simple del 5 al 10 de julio sería de S/60.00 (S/10 por noche x 6 noches).', '2025-06-30 03:54:37'),
(207, 'user_68620a319f03c', 'listo, ese me gusta', '¡Perfecto! Me alegra que le guste. Le confirmo que sí tenemos disponibilidad. Encontramos una habitación simple disponible para usted, con un precio de S/10.00 por noche. ¿Le gustaría que procedamos con la reserva?\n', '2025-06-30 03:54:50'),
(208, 'user_68620a319f03c', 'si', '¡Perfecto! ¡Tenemos disponibilidad! Encontramos una habitación simple disponible para ti a un precio de S/10.00 por noche. ¿Te gustaría que te la reserve?\n', '2025-06-30 03:55:03'),
(209, 'user_68620a319f03c', '¿qué calificaciones tiene el hotel?', '¡Claro! Algunos de nuestros clientes han comentado: \"Bueno y bacan\", \"Excelente atención y limpieza\" y \"Muy buena ubicación y desayuno variado\". ¿Te gustaría reservar la habitación simple?', '2025-06-30 03:55:14'),
(210, 'user_6862b2b312772', '¿qué tipos de habitaciones tienes?', '¡Claro! En el HOTEL LA FE, contamos con las siguientes opciones de habitaciones: Simple, Doble, Familiar y Matrimonial. ¿Te gustaría saber los precios de alguna en particular?', '2025-06-30 15:52:19'),
(211, 'user_6862b2b312772', 'hola', '¡Hola! ¿En qué puedo ayudarte hoy? ¿Te gustaría saber los precios de alguna habitación en particular o tienes alguna otra consulta?', '2025-06-30 15:53:13'),
(212, 'user_6862b2b312772', 'qué habitaciones tienes?', '¡Claro! En el HOTEL LA FE, contamos con las siguientes opciones de habitaciones: Simple, Doble, Familiar y Matrimonial. ¿Te gustaría saber los precios de alguna en particular?', '2025-06-30 15:53:28'),
(213, 'user_6862b2b312772', 'cuanto está la familiar?', '¡La habitación Familiar tiene un precio base de S/25 por noche! ¿Te gustaría saber algo más?', '2025-06-30 15:53:43'),
(214, 'user_6862b2b312772', 'estára disponible para del 8 al 15 de julio?', '¡Hola! Gracias por preguntar sobre la disponibilidad.\n\nRevisé las fechas del 8 al 15 de julio para la habitación Familiar, y lamentablemente no tenemos disponibilidad para esas fechas. \n\n¿Le gustaría que revisara otras fechas o quizás otro tipo de habitación? ¡Estoy aquí para ayudarle a encontrar la opción perfecta!\n', '2025-06-30 15:54:04'),
(215, 'user_6862b2b312772', 'no hay disponible la habitacion familiar del 8 al 15 de julio?', '¡Hola! Gracias por tu consulta.\n\nHe revisado la disponibilidad de la habitación familiar del 8 al 15 de julio y, lamentablemente, no tenemos disponibilidad para esas fechas. \n\n¿Te interesaría que revisara otras fechas cercanas o quizás otro tipo de habitación? ¡Estoy aquí para ayudarte a encontrar la mejor opción para tu familia!\n', '2025-06-30 15:56:04'),
(216, 'user_6862b2b312772', 'hola, la habitacion familiar esta disponible del 7 al 9 de julio?', '¡Hola! Gracias por tu consulta.\n\nHe revisado la disponibilidad de la habitación familiar del 7 al 9 de julio. Lamentablemente, no tenemos disponibilidad para esas fechas.\n\n¿Te gustaría que revisara otras fechas o tal vez otro tipo de habitación? ¡Estoy aquí para ayudarte a encontrar la mejor opción para tu familia!\n', '2025-06-30 15:57:05'),
(217, 'user_68c84b776c77c', 'hola', '```text\n\n```\nHola! ¿En qué puedo ayudarte hoy? ¿Te interesa información sobre nuestras habitaciones o reservas?', '2025-09-15 17:23:03'),
(218, 'user_68c84b9da0eff', 'hola, buenos días', '```text\n\n```\nBuenos días. ¿En qué puedo ayudarte hoy?', '2025-09-15 17:23:41'),
(219, 'user_68c84b9da0eff', 'que habitaciones tienes disponibles?', 'Buenos días. Para verificar la disponibilidad, necesito saber qué tipo de habitación te interesa y para qué fechas.', '2025-09-15 17:23:55'),
(220, 'user_68c84b9da0eff', 'del 18 al 21 de setiembre?', '```text\n\nPerfecto. ¿Qué tipo de habitación te interesa para esas fechas?\n```', '2025-09-15 17:24:17'),
(221, 'user_68c84b9da0eff', 'que habitaciones tienes?', '```text\n\nPerfecto. ¿Qué tipo de habitación te interesa para esas fechas?\n```', '2025-09-15 17:24:28'),
(222, 'user_68c84b9da0eff', 'pero no sé que tipo de habitaciones tienes', 'Buenos días. En Hostal La Fe, ofrecemos habitaciones individuales, dobles y familiares. Cada una está diseñada para brindarte comodidad y una excelente estadía. ¿Cuál de estas opciones se adapta mejor a tus necesidades para las fechas del 18 al 21 de setiembre?', '2025-09-15 17:24:44'),
(223, 'user_68c84b9da0eff', 'y cuanto está una habitación individual?', '```text\n\n```\nEn Hostal La Fe, el precio base de una habitación individual es de [PRECIO]. Sin embargo, este precio puede variar. Para darte un precio exacto, ¿podrías indicarme las fechas en las que estarías interesado?', '2025-09-15 17:25:16'),
(224, 'user_68c84b9da0eff', '18 al 21 de setiembre', '', '2025-09-15 17:25:29'),
(225, 'user_68ca1842813c2', 'hola', 'Hola, bienvenido al Hostal La Fe. ¿En qué puedo ayudarte hoy?', '2025-09-17 02:09:06'),
(226, 'user_68ca1842813c2', 'que habitaciones tienen?', 'Hola! En Hostal La Fe, ofrecemos habitaciones individuales, dobles y familiares. Cada una está diseñada para brindarte comodidad y una excelente estadía. ¿Te gustaría saber algo más sobre alguna en particular?', '2025-09-17 02:09:27'),
(227, 'user_68ca1842813c2', 'tienes imagenes?', '```text\n\nHola! Actualmente no cuento con imágenes de las habitaciones, pero puedo darte detalles sobre cada una. Ofrecemos habitaciones individuales, dobles y familiares. ¿Te gustaría saber algo más sobre alguna en particular?\n```', '2025-09-17 02:09:46'),
(228, 'user_68ca1842813c2', 'cuales son los precios?', '```text\n\n```\nHola! Actualmente no cuento con los precios de las habitaciones. Te recomiendo contactarnos a través de los siguientes medios para obtener información más precisa: Teléfono: 51 964 954 496, Correo: consultas@lafehostal.com, WhatsApp: https://wa.me/964954496', '2025-09-17 02:14:22'),
(229, 'user_68ca1842813c2', 'donde queda el hotel?', '```text\n\n```\nNuestro hotel se encuentra en OTUZCO - LA LIBERTAD.', '2025-09-17 02:14:36'),
(230, 'user_68ca1842813c2', 'la direccion exacta', '```json\n\n```\nNuestro hotel se encuentra en OTUZCO - LA LIBERTAD.', '2025-09-17 02:14:46'),
(231, 'user_68ca1842813c2', 'de pasado mañana hasta el domingo?', 'PASO 1: PENSAMIENTO INTERNO\n1.  **SÍNTESIS:** El usuario pregunta por la disponibilidad de una habitación desde pasado mañana hasta el domingo. Necesito saber el tipo de habitación para verificar la disponibilidad.\n2.  **INTENCIÓN:** La intención es `disponibilidad`, pero faltan datos.\n3.  **DATOS PARA DISPONIBILIDAD:** Falta el tipo de habitación. Las fechas se pueden calcular a partir de la fecha actual (2025-09-17). Pasado mañana sería 2025-09-19 y el domingo sería 2025-09-21.\n\nPASO 2: RESPUESTA FINAL\nEntendido. ¿Qué tipo de habitación te interesa para esas fechas?', '2025-09-17 02:16:08'),
(232, 'user_68ca1842813c2', 'que me recomiendas para mi y mi esposa?', 'PASO 1: PENSAMIENTO INTERNO\n1.  **SÍNTESIS:** El usuario pregunta qué tipo de habitación se recomienda para una pareja (él y su esposa).\n2.  **INTENCIÓN:** La intención es `tipos_habitacion`.\n3.  **DATOS PARA DISPONIBILIDAD:** No se requiere verificar disponibilidad.\n\nPASO 2: RESPUESTA FINAL\nPara ti y tu esposa, te recomendaría una habitación doble. Es perfecta para parejas y ofrece comodidad y privacidad durante su estadía.', '2025-09-17 02:16:48'),
(233, 'user_68ca1842813c2', '¿qué tipos de habitaciones tienes?', 'PASO 1: PENSAMIENTO INTERNO\n1.  **SÍNTESIS:** El usuario pregunta qué tipos de habitaciones están disponibles en el hostal.\n2.  **INTENCIÓN:** La intención es `tipos_habitacion`.\n3.  **DATOS PARA DISPONIBILIDAD:** No se requiere verificar disponibilidad.\n\nPASO 2: RESPUESTA FINAL\nOfrecemos habitaciones individuales, dobles y familiares. Cada una está diseñada para brindarte comodidad y una excelente estadía. ¿Te gustaría saber algo más sobre alguna en particular?', '2025-09-17 02:54:18'),
(234, 'user_68ca1842813c2', '¿qué precios tienen las habitaciones?', 'PASO 1: PENSAMIENTO INTERNO\n1.  **SÍNTESIS:** El usuario pregunta por los precios de las habitaciones.\n2.  **INTENCIÓN:** La intención es `precios`.\n3.  **DATOS PARA DISPONIBILIDAD:** No se requiere verificar disponibilidad.\n\nPASO 2: RESPUESTA FINAL\nHola! Actualmente no cuento con los precios de las habitaciones. Te recomiendo contactarnos a través de los siguientes medios para obtener información más precisa: Teléfono: 51 964 954 496, Correo: consultas@lafehostal.com, WhatsApp: https://wa.me/964954496', '2025-09-17 02:54:25'),
(235, 'user_68ca1842813c2', '¿cómo puedo contactar al hotel?', 'PASO 1: PENSAMIENTO INTERNO\n1.  **SÍNTESIS:** El usuario pregunta cómo puede contactar al hotel.\n2.  **INTENCIÓN:** La intención es `contacto`.\n3.  **DATOS PARA DISPONIBILIDAD:** No se requiere verificar disponibilidad.\n\nPASO 2: RESPUESTA FINAL\nPuedes contactarnos a través de los siguientes medios: Teléfono: 51 964 954 496, Correo: consultas@lafehostal.com, WhatsApp: https://wa.me/964954496', '2025-09-17 02:54:33'),
(236, 'user_68ca1842813c2', '¿qué calificaciones tiene el hotel?', 'PASO 1: PENSAMIENTO INTERNO\n1.  **SÍNTESIS:** El usuario pregunta por las calificaciones del hotel. Esto se refiere a las opiniones de los clientes.\n2.  **INTENCIÓN:** La intención es `opiniones`.\n3.  **DATOS PARA DISPONIBILIDAD:** No se requiere verificar disponibilidad.\n\nPASO 2: RESPUESTA FINAL\nAlgunas opiniones de nuestros clientes son: \"Bueno y bacan\", \"Excelente atención y limpieza.\" y \"Muy buena ubicación y desayuno variado.\"', '2025-09-17 02:54:39');

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
(40, 10.00, '85M53432PH993314N', '67f5b9fe495ea', '2025-04-08', '2025-04-09', '2025-04-08 20:06:22', '', 1, 'Paypal', 1, 41),
(41, 30.00, '8BV2232608950183W', '68608ca31d3b4', '2025-07-01', '2025-07-04', '2025-06-29 02:45:23', '', 1, 'Paypal', 1, 41);

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

--
-- Volcado de datos para la tabla `sliders`
--

INSERT INTO `sliders` (`id`, `titulo`, `subtitulo`, `url`, `foto`, `estado`) VALUES
(1, 'Reserva Hoy', 'Vive Experiencias Inolvidables', 'http://localhost/reservas/', '20240617213440.jpg', 1),
(2, 'Planifica Ahora', 'Comienza la Magia', 'http://localhost/reservas/', '20240617213540.jpg', 1),
(3, 'Tu Hogar te Espera', 'Calidez y Comodidad', 'http://localhost/reservas/', '20241018215748.jpg', 1),
(6, 'Catedral de otuzco', 'Disfruta tu estadía en esta hermosa ciudad', NULL, '20240618021016.jpg', 1);

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
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `identidad`, `dni`, `nombre`, `apellido`, `usuario`, `correo`, `telefono`, `direccion`, `clave`, `verify`, `rol`, `foto`, `estado`, `fecha`, `token`, `token_estado`, `token_expiracion`) VALUES
(1, NULL, NULL, 'HUGO', 'PERALTA', 'USUARIO', 'hotelafe2024@admin.com', NULL, '', '$2y$10$tlr673uHS3cIkQIPH2N3T.pd4UAveHGLBtpjwRGSZor0H2Li6ZEoO', 0, 1, NULL, 1, '2024-06-13 08:07:43', NULL, 1, NULL),
(2, NULL, NULL, 'NOMBRE', 'APELLIDO', 'USUARIO1', 'RECEPCIONISTA@GMAIL.COM', NULL, '', '$2y$10$ks2E5DumEWR2A54Jz.2/y.BvmDAqMa9IRRAeH0961hyS4wAIpch..', 1, 2, NULL, 1, '2024-06-23 18:49:15', NULL, 1, NULL),
(4, NULL, NULL, 'hola', 'hola edit', 'hola', 'hola@gmail.com', NULL, 'hola', '$2y$10$0pTbMKFLXKUDjUJL7X4DROrjfNo63gV8M1Ldalo3P4G9Z86pE0Pom', 0, 1, NULL, 0, '2024-03-18 16:17:10', NULL, 1, NULL),
(19, NULL, '71541275', 'WALTER JEAN PIERE', 'BARDALES GUANILO', 'jampi08', 'jampi0801@gmail.com', NULL, NULL, '$2y$10$GFzu5pdZFvElGxeuL2kQAePbCK.aLU0Q1Vk9tKEZAnEpzLCKqj6qW', 0, 3, NULL, 1, '2024-06-15 14:26:33', NULL, 1, NULL),
(20, NULL, '75949761', 'ELIZABETH BEATRIZ', 'SAAVEDRA CHACON', 'Elizabeth', 'beatriz.elizacu98@gmail.com', NULL, NULL, '$2y$10$JViv6EiqXp9GIuQn6nmCTuvoQ3hq0tXqBvSQR70EfSp1TtRNCP5bG', 0, 3, NULL, 1, '2024-06-16 03:58:01', NULL, 1, NULL),
(21, NULL, '73759270', 'HUGO ALEXANDER', 'PERALTA GARCIA', 'Hugo', 'alexanderhpg@gmail.com', NULL, NULL, '$2y$10$hFuMn.wUzdMaVxwC52AFuOwumhPRhHliy2AehvIszubzWxjo8qdy.', 0, 3, NULL, 1, '2024-11-25 06:22:15', '919856', 1, '2024-11-25 07:27:15'),
(22, NULL, '72145417', 'ALEJANDRO RAFAEL', 'LUNA PERALTA', 'Arlp96', 'arlp.flz64@gmail.com', NULL, NULL, '$2y$10$37Ew4Sqp0nCXaeIhg7HA0OAeFapOQxu/evJdgUJAQi/WDt/IZSqoC', 0, 3, NULL, 1, '2024-06-16 23:14:43', NULL, 1, NULL),
(23, NULL, '72537577', 'JERSON LUISIN BILLY JERALD', 'PERALTA DOMINGUEZ', 'Jperalta', 'jerson.l123@gmail.com', NULL, NULL, '$2y$10$7xDXobzoywJmo8suTKH7EeJ7ELOkIYgdCgyymand8jPjkpc8dfu32', 0, 3, NULL, 1, '2024-06-17 02:58:00', NULL, 1, NULL),
(25, NULL, '47119924', 'AMPARO EDITH', 'PERALTA DOMINGUEZ', 'Amparito', 'aperaltad@hotmail.com', NULL, NULL, '$2y$10$jiBJYe8QAl1S9K1VWbyA3uPG0s9OCfmZ6Y9CoiAJfhY5w171oFVW6', 0, 3, NULL, 1, '2024-06-17 05:30:32', NULL, 1, NULL),
(26, NULL, '18214307', 'HENRY PAÚL', 'BERMEJO TERRONES', 'Henry18', 'henry.bermejo@upn.pe', NULL, NULL, '$2y$10$U6m8hrtJU5fVakyUh5KQwO0ndBLI21MWSxN71yzOaqyPwUD1FvTWK', 0, 3, NULL, 1, '2024-06-18 01:39:18', NULL, 1, NULL),
(27, NULL, '71291839', 'ANTHONY WILFREDO', 'GUILLEN MATENCIO', 'Thony Montana', 'anthoni16m@gmail.con', NULL, NULL, '$2y$10$8cg9VdJw.Ts5baav8sa/D.udaZVLJZE9b9YWJuIFmJqnVbAFiPM6S', 0, 3, NULL, 1, '2024-06-19 14:03:48', NULL, 1, NULL),
(28, NULL, '18179541', 'WILLIAM ABAT', 'ESCOBEDO NORIEGA', 'Wileco1219', 'wileco1219@hotmail.com', NULL, NULL, '$2y$10$eDGPhnMhZm8P.EXkRMZP/Oks345SxFhXkkrc0DW6e01ukuMCwF1tK', 0, 3, NULL, 1, '2024-06-20 03:56:11', NULL, 1, NULL),
(29, NULL, '73520328', 'RENZO SAIR', 'VASQUEZ ULLOA', 'Renzo Ulloa', 'renzosair05@gmail.com', NULL, NULL, '$2y$10$gacHrDRFOoSHR3od4m1eeuK0F0dJ0YnUc78aX8Qeo/M2GSg7MNwHG', 0, 3, NULL, 1, '2024-06-20 14:18:03', NULL, 1, NULL),
(30, NULL, '75171432', 'WHINEY FABIOLA', 'GONZALES SOTO', 'whineygonzales', 'whineygonzaless@gmail.com', NULL, NULL, '$2y$10$mlUyrEQzWbfQui8ynE.bvOdRcfHuWt62CJ0l6T0am3O6pnQgpm86C', 0, 3, NULL, 1, '2024-06-21 03:20:49', NULL, 1, NULL),
(31, NULL, '75933128', 'FRANCIS JUNIOR', 'HERRERA SIFUENTES', 'Franksito69', 'francis30_06@hotmail.com', NULL, NULL, '$2y$10$.EtI1DtQTx36/pqt.qFTuujUxCHrvN8qYvyO0FjOF4UE06597z/z2', 0, 3, NULL, 1, '2024-06-21 23:20:08', NULL, 1, NULL),
(32, NULL, '73759285', 'MARTHA IRIS', 'PERALTA GARCIA', 'IrisPG', 'iris8502@gmail.com', NULL, NULL, '$2y$10$R/.tQldAJVYzrypXwl8ffOosfBI1cw4WdiumICLNaBSSXKrkzF4A2', 0, 3, NULL, 1, '2024-06-30 04:06:59', NULL, 1, NULL),
(33, NULL, '76445423', 'CRISTIAN GERARDO', 'ROJAS MENDIETA', 'cristianrm2002', 'obligatoryfolksong@gmail.com', NULL, NULL, '$2y$10$vvoj1zjiLlRBkzD/C.0fK.Ip6T09aldd85aCNhAFkEQKhvGkUbIB2', 0, 3, NULL, 1, '2024-07-02 01:19:22', NULL, 1, NULL),
(40, NULL, '72643171', 'KEVEENS JOEL', 'LAZARO RUBIO', '123', '123@gmail.com', NULL, NULL, '$2y$10$n5ZUnZVjb2vvl0aQhZYmrej9Jb4p9GggBi./KftQNGJTAwR9zrEzq', 0, 3, NULL, 1, '2024-11-22 04:51:58', NULL, 1, NULL),
(41, NULL, '72643177', 'MICHAEL CRISTOPHER', 'ESCOBEDO AGUSTIN', 'Mike21', 'michaelcristopher21@gmail.com', NULL, NULL, '$2y$10$LOzOuWDt2hu.Y9oRw7hGguqoDCvCPOsc53aqEuhI4jAAl2a2nX8M6', 0, 3, NULL, 1, '2025-05-28 18:16:17', '6008a813d331aeb8e53e8c9a5bfb5a3f2bdf1fb07652585a86143555ad574b63', 1, '2025-05-28 14:21:17'),
(42, NULL, '76762642', 'JOSUE DANIEL', 'VILLENA SANCHEZ', 'jdaniel', 'josuedanielvillena@gmail.com', NULL, NULL, '$2y$10$91Fv95uJYK0Q6B6.pWR6c.7V9g6ViY8R/VoyLp1FDDyN99TyOo49a', 0, 3, NULL, 1, '2024-11-25 06:20:21', '510869', 1, '2024-11-25 07:25:21'),
(43, NULL, '73625234', 'FIORELLA YESENIA', 'DE LA CRUZ RODRIGUEZ', 'Fiorella_123', 'meylixuwuescobedomontez@gmail.com', NULL, NULL, '$2y$10$8MiXRRGLpZYiNjjFJOMrL.hxBrWbG1A3ZoF95wic0x4ZZlmZPZfNm', 0, 3, NULL, 1, '2024-12-23 18:50:53', 'bf6c144f1b33df6e6393899178700df5b14a14ba7db8f722ef37ad071ad7c029', 1, '2024-12-23 13:55:53');

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
-- Indices de la tabla `datos_usuario`
--
ALTER TABLE `datos_usuario`
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
-- Indices de la tabla `historial_chat`
--
ALTER TABLE `historial_chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id_fecha` (`user_id`(191),`fecha`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `datos_usuario`
--
ALTER TABLE `datos_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

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
-- AUTO_INCREMENT de la tabla `historial_chat`
--
ALTER TABLE `historial_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=237;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

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
