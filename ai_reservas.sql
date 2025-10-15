-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 15-10-2025 a las 05:56:52
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
-- Base de datos: `ai_reservas`
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
(1, 5, 'Excelente servicio, el WiFi funcionaba a la perfección y siempre hubo agua caliente. Muy recomendado.', '2025-06-10 17:50:25', 101, 2),
(2, 4, 'La habitación muy limpia y cómoda. La señal del cable podría mejorar, pero en general todo bien.', '2025-06-23 17:50:25', 201, 3),
(3, 5, 'Una vista increíble desde el tercer piso. La cama era muy confortable y el agua caliente no falló. Volvería sin dudarlo.', '2025-05-30 17:50:25', 302, 5),
(4, 3, 'Todo correcto, aunque la habitación era un poco pequeña. El WiFi era estable, lo cual es importante.', '2025-06-30 17:50:25', 305, 6),
(5, 5, 'Perfecto para una escapada en pareja. La atención fue de primera y los servicios de cable y agua caliente impecables.', '2025-02-20 17:50:25', 408, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `Precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `categoria`, `estado`, `Precio`) VALUES
(1, 'Simple', 1, 30.00),
(2, 'Doble', 1, 40.00),
(3, 'Matrimonial', 1, 50.00),
(4, 'Familiar', 0, 65.00),
(5, 'Suite', 0, 100.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datos_usuario`
--

CREATE TABLE `datos_usuario` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `valor` text NOT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `datos_usuario`
--

INSERT INTO `datos_usuario` (`id`, `id_usuario`, `tipo`, `valor`, `fecha`) VALUES
(1, 2, 'DNI', '71558963', '2025-06-30 12:50:25'),
(2, 3, 'Nacionalidad', 'Española', '2025-06-30 12:50:25'),
(3, 5, 'Preferencia Alimenticia', 'Vegetariana', '2025-06-30 12:50:25');

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
(1, 'J-123456789', 'HOSTAL LA FÉ', '+51 964 954 496', 'Calle Tacna 323, Otuzco, La Libertad', 'hlafeotuzco@gmail.com', 'El mejor hospedaje para ti', 'https://www.facebook.com/HotelLafeotuzco/', 'https://twitter.com/?lang=es', 'https://www.instagram.com/alexanderhpg?igsh=aGxmYWt2NzZkMDBq', 'https://wa.me/964954496');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galeria`
--

CREATE TABLE `galeria` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL COMMENT 'Descripción corta para el bot (ej: "Fachada del hotel de noche")',
  `url_imagen` varchar(255) NOT NULL COMMENT 'Ruta a la imagen (ej: "img/galeria/fachada_noche.jpg")',
  `etiquetas` varchar(255) DEFAULT NULL COMMENT 'Palabras clave para búsqueda (ej: "entrada,noche,luces")'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `galeria`
--

INSERT INTO `galeria` (`id`, `titulo`, `url_imagen`, `etiquetas`) VALUES
(1, 'Fachada principal del Hotel de las Alturas', 'assets/img/galeria/fachada.jpg', 'fachada,exterior,entrada,hotel'),
(2, 'Vista del lobby y nuestra área de recepción', 'assets/img/galeria/lobby.jpg', 'lobby,recepcion,interior,espera'),
(3, 'Ejemplo de una de nuestras cómodas Habitaciones Simples', 'assets/img/galeria/habitacion_simple.jpg', 'habitacion,simple,cuarto,dormitorio'),
(4, 'Ejemplo de una espaciosa Habitación Doble', 'assets/img/galeria/habitacion_doble.jpg', 'habitacion,doble,cuarto,dormitorio,dos camas'),
(5, 'Ejemplo de una elegante Habitación Matrimonial', 'assets/img/galeria/habitacion_matrimonial.jpg', 'habitacion,matrimonial,cuarto,dormitorio,cama doble');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitaciones`
--

CREATE TABLE `habitaciones` (
  `id` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `capacidad` int(11) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `video` varchar(255) DEFAULT NULL,
  `descripcion` text NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `habitaciones`
--

INSERT INTO `habitaciones` (`id`, `id_categoria`, `numero`, `capacidad`, `slug`, `foto`, `video`, `descripcion`, `estado`, `fecha_creacion`) VALUES
(101, 1, 101, 1, 'habitacion-101', 'piso1_simple.jpg', NULL, 'Habitación simple en el primer piso.', 1, '2025-06-30 17:50:25'),
(102, 1, 102, 1, 'habitacion-102', 'piso1_simple.jpg', NULL, 'Habitación simple en el primer piso.', 1, '2025-06-30 17:50:25'),
(103, 2, 103, 2, 'habitacion-103', 'piso1_doble.jpg', NULL, 'Habitación doble en el primer piso.', 0, '2025-06-30 17:50:25'),
(104, 2, 104, 2, 'habitacion-104', 'piso1_doble.jpg', NULL, 'Habitación doble en el primer piso.', 1, '2025-06-30 17:50:25'),
(105, 2, 105, 2, 'habitacion-105', 'piso1_doble.jpg', NULL, 'Habitación doble en el primer piso.', 1, '2025-06-30 17:50:25'),
(106, 3, 106, 2, 'habitacion-106', 'piso1_matri.jpg', NULL, 'Habitación matrimonial en el primer piso.', 1, '2025-06-30 17:50:25'),
(107, 3, 107, 2, 'habitacion-107', 'piso1_matri.jpg', NULL, 'Habitación matrimonial en el primer piso.', 1, '2025-06-30 17:50:25'),
(108, 1, 108, 1, 'habitacion-108', 'piso1_simple.jpg', NULL, 'Habitación simple en el primer piso.', 0, '2025-06-30 17:50:25'),
(109, 2, 109, 2, 'habitacion-109', 'piso1_doble.jpg', NULL, 'Habitación doble en el primer piso.', 1, '2025-06-30 17:50:25'),
(110, 3, 110, 2, 'habitacion-110', 'piso1_matri.jpg', NULL, 'Habitación matrimonial en el primer piso.', 1, '2025-06-30 17:50:25'),
(201, 2, 201, 2, 'habitacion-201', 'piso2_doble.jpg', NULL, 'Habitación doble en el segundo piso.', 1, '2025-06-30 17:50:25'),
(202, 2, 202, 2, 'habitacion-202', 'piso2_doble.jpg', NULL, 'Habitación doble en el segundo piso.', 1, '2025-06-30 17:50:25'),
(203, 3, 203, 2, 'habitacion-203', 'piso2_matri.jpg', NULL, 'Habitación matrimonial en el segundo piso.', 1, '2025-06-30 17:50:25'),
(204, 3, 204, 2, 'habitacion-204', 'piso2_matri.jpg', NULL, 'Habitación matrimonial en el segundo piso.', 0, '2025-06-30 17:50:25'),
(205, 1, 205, 1, 'habitacion-205', 'piso2_simple.jpg', NULL, 'Habitación simple en el segundo piso.', 0, '2025-06-30 17:50:25'),
(206, 2, 206, 2, 'habitacion-206', 'piso2_doble.jpg', NULL, 'Habitación doble en el segundo piso.', 1, '2025-06-30 17:50:25'),
(207, 2, 207, 2, 'habitacion-207', 'piso2_doble.jpg', NULL, 'Habitación doble en el segundo piso.', 1, '2025-06-30 17:50:25'),
(208, 3, 208, 2, 'habitacion-208', 'piso2_matri.jpg', NULL, 'Habitación matrimonial en el segundo piso.', 1, '2025-06-30 17:50:25'),
(301, 3, 301, 2, 'habitacion-301', 'piso3_matri.jpg', NULL, 'Habitación matrimonial en el tercer piso.', 1, '2025-06-30 17:50:25'),
(302, 3, 302, 2, 'habitacion-302', 'piso3_matri.jpg', NULL, 'Habitación matrimonial en el tercer piso.', 1, '2025-06-30 17:50:25'),
(303, 2, 303, 2, 'habitacion-303', 'piso3_doble.jpg', NULL, 'Habitación doble en el tercer piso.', 1, '2025-06-30 17:50:25'),
(304, 2, 304, 2, 'habitacion-304', 'piso3_doble.jpg', NULL, 'Habitación doble en el tercer piso.', 1, '2025-06-30 17:50:25'),
(305, 1, 305, 1, 'habitacion-305', 'piso3_simple.jpg', NULL, 'Habitación simple en el tercer piso.', 1, '2025-06-30 17:50:25'),
(306, 3, 306, 2, 'habitacion-306', 'piso3_matri.jpg', NULL, 'Habitación matrimonial en el tercer piso.', 1, '2025-06-30 17:50:25'),
(307, 3, 307, 2, 'habitacion-307', 'piso3_matri.jpg', NULL, 'Habitación matrimonial en el tercer piso.', 1, '2025-06-30 17:50:25'),
(401, 2, 401, 2, 'habitacion-401', 'piso4_doble.jpg', NULL, 'Habitación doble en el cuarto piso.', 1, '2025-06-30 17:50:25'),
(402, 2, 402, 2, 'habitacion-402', 'piso4_doble.jpg', NULL, 'Habitación doble en el cuarto piso.', 1, '2025-06-30 17:50:25'),
(403, 3, 403, 2, 'habitacion-403', 'piso4_matri.jpg', NULL, 'Habitación matrimonial en el cuarto piso.', 0, '2025-06-30 17:50:25'),
(404, 1, 404, 1, 'habitacion-404', 'piso4_simple.jpg', NULL, 'Habitación simple en el cuarto piso.', 1, '2025-06-30 17:50:25'),
(405, 2, 405, 2, 'habitacion-405', 'piso4_doble.jpg', NULL, 'Habitación doble en el cuarto piso.', 1, '2025-06-30 17:50:25'),
(406, 3, 406, 2, 'habitacion-406', 'piso4_matri.jpg', NULL, 'Habitación matrimonial en el cuarto piso.', 0, '2025-06-30 17:50:25'),
(407, 1, 407, 1, 'habitacion-407', 'piso4_simple.jpg', NULL, 'Habitación simple en el cuarto piso.', 0, '2025-06-30 17:50:25'),
(408, 3, 408, 2, 'habitacion-408', 'piso4_matri.jpg', NULL, 'Habitación matrimonial en el cuarto piso.', 1, '2025-06-30 17:50:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_chat`
--

CREATE TABLE `historial_chat` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT 'Se permite NULL para usuarios anónimos',
  `session_id` varchar(50) DEFAULT NULL,
  `mensaje_usuario` text DEFAULT NULL,
  `respuesta_bot` text DEFAULT NULL,
  `visible_al_usuario` tinyint(1) NOT NULL DEFAULT 1,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_chat`
--

INSERT INTO `historial_chat` (`id`, `user_id`, `session_id`, `mensaje_usuario`, `respuesta_bot`, `visible_al_usuario`, `fecha`) VALUES
(75, NULL, NULL, 'quiero iniciar sesión', 'Lo siento, pero no entiendo tu solicitud de \"iniciar sesión\".  El Hostal La Fé no cuenta con un sistema de inicio de sesión para reservas.  Si deseas reservar una habitación, por favor dime qué tipo de habitación necesitas y las fechas de tu estadía.', 1, '2025-06-30 23:12:29'),
(76, NULL, NULL, 'quiero logearme', 'Lo siento, pero no entiendo tu solicitud de \"loguearme\". El Hostal La Fé no cuenta con un sistema de inicio de sesión para reservas. Si deseas reservar una habitación, por favor dime qué tipo de habitación necesitas y las fechas de tu estadía.', 1, '2025-06-30 23:12:37'),
(77, NULL, NULL, 'quiero el login', 'Lo siento, pero no entiendo tu solicitud de \"login\". El Hostal La Fé no cuenta con un sistema de inicio de sesión para reservas. Si deseas reservar una habitación, por favor dime qué tipo de habitación necesitas y las fechas de tu estadía.', 1, '2025-06-30 23:12:44'),
(78, NULL, NULL, 'quiero iniciar sesion', 'Lo siento, pero no entiendo tu solicitud de \"iniciar sesión\". El Hostal La Fé no cuenta con un sistema de inicio de sesión para reservas. Si deseas reservar una habitación, por favor dime qué tipo de habitación necesitas y las fechas de tu estadía.', 1, '2025-06-30 23:28:47'),
(79, NULL, NULL, 'quiero crear una cuenta', 'Lo siento, pero el Hostal La Fé no cuenta con un sistema para crear cuentas de usuario. Si deseas reservar una habitación, por favor dime qué tipo de habitación necesitas y las fechas de tu estadía.', 1, '2025-06-30 23:35:55'),
(97, NULL, NULL, 'hola', 'Hola! Bienvenido al Hostal La Fé, ¿en qué puedo ayudarte?', 1, '2025-07-01 04:29:12'),
(98, NULL, NULL, 'que habitaciones tienes?', 'Hola!  Ofrecemos habitaciones Simples, Dobles y Matrimoniales. ¿Te gustaría saber más sobre alguna en particular?', 1, '2025-07-01 04:31:19'),
(99, NULL, NULL, 'tienes fotos?', '¡Claro que sí! Aquí te muestro una foto de la fachada principal del Hostal La Fé: [IMAGEN:assets/img/galeria/fachada.jpg]', 1, '2025-07-01 04:31:40'),
(100, NULL, NULL, 'y de las habitaciones?', '¡Claro que sí! Tenemos diferentes tipos de habitaciones. Aquí te muestro algunas fotos:\n\n[IMAGEN:assets/img/galeria/habitacion_simple.jpg]  Esta es una de nuestras cómodas habitaciones simples.\n\n[IMAGEN:assets/img/galeria/habitacion_doble.jpg] Aquí tienes un ejemplo de una espaciosa habitación doble.\n\n[IMAGEN:assets/img/galeria/habitacion_matrimonial.jpg] Y por último, una elegante habitación matrimonial.', 1, '2025-07-01 04:31:54'),
(101, NULL, NULL, 'cuales son los precios?', 'Claro que sí, aquí están los precios de nuestras habitaciones:\n\n- Habitación Simple: S/55.00 por noche.\n- Habitación Doble: S/80.00 por noche.\n- Habitación Matrimonial: S/95.00 por noche.', 1, '2025-07-01 04:32:18'),
(102, NULL, NULL, 'para mi y mi amiga que habitacion nos recomendarias?', 'Para ti y tu amiga, les recomendaría una habitación Doble.  Es más espaciosa que una Simple y más económica que una Matrimonial.', 1, '2025-07-01 04:32:39'),
(103, NULL, NULL, 'umm, me gusta, y dime que servicios vienen?', 'Claro que sí! El precio de la habitación incluye alojamiento, WiFi, TV por cable y agua caliente.  Recuerda que no contamos con restaurante, desayuno ni piscina.', 1, '2025-07-01 04:33:17'),
(104, NULL, NULL, 'listo, del 8 al 15 de junio tendras disponible?', '¡Claro que sí! Tenemos disponibilidad del 8 al 15 de junio.  Contamos con varias habitaciones dobles disponibles a S/80.00 por noche.', 1, '2025-07-01 04:33:47'),
(105, NULL, NULL, 'cuanto seria el total?', 'El total sería S/560.00.  Son 7 noches (del 8 al 15 de junio) a S/80.00 por noche.', 1, '2025-07-01 04:34:05'),
(106, NULL, NULL, 'puedes mostrarme de nuevo la foto de la habitacion doble por fa', '¡Claro que sí! Aquí tienes de nuevo la foto de nuestra espaciosa Habitación Doble: [IMAGEN:assets/img/galeria/habitacion_doble.jpg]', 1, '2025-07-01 04:34:47'),
(107, NULL, NULL, 'y si quisiera extender la estadia hasta el 22 de julio disculpa?', 'Lo siento, no puedo procesar esa solicitud de disponibilidad. Necesito la fecha de inicio y la fecha de fin para poder calcular la disponibilidad y el precio.  Por favor, especifica las fechas exactas que te interesan.', 1, '2025-07-01 04:36:29'),
(108, NULL, NULL, '¿qué tipos de habitaciones tienes?', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-01 05:13:54'),
(109, NULL, NULL, 'muéstrame fotos del hotel', 'Claro que sí, con gusto le muestro algunas fotos del Hostal La Fé.  Aquí tiene una foto de nuestra fachada: [IMAGEN:assets/img/galeria/fachada.jpg] , una imagen de nuestro lobby: [IMAGEN:assets/img/galeria/lobby.jpg] y para que vea nuestros tipos de habitaciones, le muestro una habitación simple: [IMAGEN:assets/img/galeria/habitacion_simple.jpg], una doble: [IMAGEN:assets/img/galeria/habitacion_doble.jpg] y una matrimonial: [IMAGEN:assets/img/galeria/habitacion_matrimonial.jpg].  Espero que le gusten.', 1, '2025-07-01 05:14:00'),
(110, NULL, NULL, 'y que tipos de habitaciones tienes?', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-01 05:14:22'),
(111, NULL, NULL, 'una simple del 8 al 13 de julio cuanto sale? esta disponible?', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-01 05:15:16'),
(112, NULL, NULL, 'precios?', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-01 05:16:42'),
(113, NULL, NULL, 'tienes fotos de la habitacion simple?', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-01 05:17:23'),
(114, NULL, NULL, 'muéstrame fotos del hotel', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-01 05:17:31'),
(115, NULL, NULL, 'muéstrame fotos del hotel', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-01 05:17:47'),
(116, NULL, NULL, '¿qué tipos de habitaciones tienes?', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-01 05:18:07'),
(117, NULL, NULL, '¿qué tipos de habitaciones tienes?', 'En Hostal La Fé, contamos con habitaciones Simple, Doble y Matrimonial.', 1, '2025-07-01 05:30:04'),
(118, NULL, NULL, 'precios?', 'En Hostal La Fé, los precios por noche son: Simple: S/55.00, Doble: S/80.00 y Matrimonial: S/95.00.', 1, '2025-07-01 05:31:44'),
(119, NULL, NULL, 'una simple del 8 al 13 de julio cuanto sale? esta disponible?', '¡Hola! Sí, tenemos habitaciones simples disponibles del 8 al 13 de julio. Veo que tenemos varias opciones a S/55.00 por noche. ¿Te gustaría que te ayudara con la reserva de alguna?', 1, '2025-07-01 05:32:04'),
(120, NULL, NULL, 'y cuanto es el total?', 'El precio total por la habitación simple del 8 al 13 de julio sería de S/275.00.', 1, '2025-07-01 05:32:25'),
(121, NULL, NULL, 'me recuerdas el total por fa?', 'El total por la habitación simple del 8 al 13 de julio es de S/275.00.', 1, '2025-07-01 05:34:00'),
(122, NULL, NULL, 'hola, me recuerdas la habitacion y la fecha que te habia pedido por fa?', 'Hola, lamentablemente no tengo acceso a la información de tus solicitudes anteriores. Para ayudarte, por favor, proporcióname el tipo de habitación y las fechas en las que estás interesado.', 1, '2025-07-01 05:37:06'),
(123, NULL, NULL, 'me recuerdas que habitacion y que dias te habia pedido?', 'Hola, lamentablemente no tengo acceso a la información de tus solicitudes anteriores. Para ayudarte, por favor, proporcióname el tipo de habitación y las fechas en las que estás interesado.', 1, '2025-07-01 05:38:14'),
(124, NULL, NULL, 'y cuanto es el total?', 'Hola, lamentablemente no tengo acceso a la información de tus solicitudes anteriores. Para darte el total, por favor, indícame el tipo de habitación y las fechas en las que estás interesado.', 1, '2025-07-01 05:40:03'),
(125, NULL, NULL, 'que habitaciones tienes?', 'En Hostal La Fé, contamos con habitaciones Simple, Doble y Matrimonial.', 1, '2025-07-01 05:44:09'),
(126, 8, NULL, 'y cuales son los precios?', '¡Claro! En Hostal La Fé, tenemos las siguientes categorías y precios base por noche: Simple: S/55.00, Doble: S/80.00, Matrimonial: S/95.00.', 0, '2025-07-01 05:44:32'),
(127, 8, NULL, 'cuanto sale una simple del 3 al 9 de julio? hay disponibilidad?', '¡Hola! Sí, tenemos disponibilidad de habitaciones simples del 3 al 9 de julio. El precio es de S/55.00 por noche. ¡Tenemos varias opciones disponibles!', 0, '2025-07-01 05:45:45'),
(128, 8, NULL, 'y cuanto seria el total?', 'El total sería S/330.00 por las 6 noches en la habitación simple.', 0, '2025-07-01 05:46:09'),
(129, 8, NULL, 'hola', '¡Hola! ¿En qué puedo ayudarte hoy?', 0, '2025-07-01 05:47:04'),
(130, NULL, NULL, 'y en caso de una matrimonial para las mismas fechas?', 'El precio de la habitación matrimonial es de S/95.00 por noche. Del 8 al 13 de julio son 6 noches. Entonces, el total sería S/95.00 * 6 = S/570.00\n\nEl precio total de la habitación matrimonial del 8 al 13 de julio sería de S/570.00.', 1, '2025-07-01 05:48:57'),
(131, NULL, NULL, 'hola', '¡Hola! ¿En qué puedo ayudarte hoy?', 1, '2025-07-01 05:50:51'),
(132, NULL, NULL, 'y tienes habitaciones familiares?', 'Hola, lamentablemente no contamos con habitaciones familiares como tal. Ofrecemos habitaciones simples, dobles y matrimoniales. ¿Te gustaría saber más sobre alguna de ellas?', 1, '2025-07-01 05:51:22'),
(133, NULL, NULL, 'mi esposa y yo queremos estar en otuzco un tiempo, que habitacion me recomiendas?', 'Hola! Para ti y tu esposa, y considerando que planean quedarse un tiempo, les recomendaría una habitación Matrimonial. Es más espaciosa y cómoda para una estadía prolongada. Tenemos habitaciones matrimoniales disponibles desde S/95.00 por noche.', 1, '2025-07-01 05:51:48'),
(134, NULL, NULL, 'tendras disponible del 7 al 13 de julio?', '¡Claro que sí! Tenemos disponibilidad del 7 al 13 de julio. Encontramos habitaciones matrimoniales disponibles a S/95.00 por noche.', 1, '2025-07-01 05:52:15'),
(135, NULL, NULL, 'y cuanto seria el total?', 'El precio total sería de S/570.00 por las 6 noches (S/95.00 por noche x 6 noches).', 1, '2025-07-01 05:52:41'),
(136, NULL, NULL, 'un poco caro jaja', 'Entiendo. Nuestras habitaciones matrimoniales ofrecen una excelente relación calidad-precio, con TV por cable, WiFi y agua caliente incluidos. Sin embargo, si buscas una opción más económica, también tenemos habitaciones dobles disponibles desde S/80.00 por noche.', 1, '2025-07-01 05:52:54'),
(137, NULL, NULL, 'y con la habitacion doble cuanto sale?', '¡Claro! La habitación doble te saldría S/480.00 por las 6 noches (S/80.00 por noche x 6 noches).', 1, '2025-07-01 05:53:16'),
(138, NULL, NULL, 'y tienes alguna foto?', '¡Claro! Aquí tienes una foto de ejemplo de una de nuestras habitaciones dobles: [IMAGEN:assets/img/galeria/habitacion_doble.jpg]', 1, '2025-07-01 05:54:47'),
(139, NULL, NULL, 'quiero logearme', 'Lo siento, no entiendo a qué te refieres con \"logearme\". ¿Quizás querías preguntar algo más sobre nuestras habitaciones o servicios? Estamos aquí para ayudarte con el alojamiento.', 1, '2025-07-01 05:55:15'),
(140, NULL, NULL, 'y cuanto seria el total nuevamente disculpa?', '¡Claro! La habitación doble te saldría S/480.00 por las 6 noches (S/80.00 por noche x 6 noches).', 1, '2025-07-01 05:57:07'),
(141, NULL, NULL, '¿qué tipos de habitaciones tienes?', 'En Hostal La Fé, contamos con habitaciones Simple, Doble y Matrimonial.', 1, '2025-07-01 06:12:15'),
(142, NULL, NULL, 'quiero una doble del 8 al 29 de julio, cuanto es el total? y si hay disponible?', '¡Claro que sí! Tenemos disponibilidad de habitaciones dobles del 8 al 29 de julio. El precio es de S/80.00 por noche. El total por esas fechas sería de S/1680.00.', 1, '2025-07-01 06:13:34'),
(143, NULL, NULL, 'perdon, voy solo, una simple nada más', '¡Claro que sí! Tenemos varias habitaciones simples disponibles para ti. Todas cuestan S/55.00 por noche.', 1, '2025-07-01 06:14:01'),
(144, NULL, NULL, 'y el total?', '¡Por supuesto! El total de la habitación simple del 8 al 29 de julio sería de S/1210.00.', 1, '2025-07-01 06:14:35'),
(145, NULL, NULL, 'y del 9 al 25 de julio cuanto seria?', '¡Claro! Del 9 al 25 de julio serían 16 noches. El total de la habitación simple sería de S/880.00 (S/55.00 por noche x 16 noches).', 1, '2025-07-01 06:26:34'),
(146, NULL, NULL, 'mi esposa me llamó y ella irá conmigo, cuanto seria el precio pero con la habitacion matrimonial?', '¡Entendido! Del 9 al 25 de julio serían 16 noches. El total de la habitación matrimonial sería de S/1520.00 (S/95.00 por noche x 16 noches).', 1, '2025-07-01 06:28:06'),
(172, NULL, NULL, '¿qué tipos de habitaciones tienes?', 'Claro que sí. Ofrecemos habitaciones Simples, Dobles y Matrimoniales.  Cada una con WiFi, TV por cable y agua caliente.', 1, '2025-07-01 15:10:56'),
(173, NULL, NULL, 'y cuales son los precios?', 'Claro que sí. El precio de nuestras habitaciones es el siguiente: Simple S/55.00 por noche, Doble S/80.00 por noche y Matrimonial S/95.00 por noche.', 1, '2025-07-01 15:11:09'),
(174, NULL, NULL, 'quiero una simple del 8 al 15 de julio cuanto sale en total?', 'El precio de una habitación simple es S/55.00 por noche. Del 8 al 15 de julio hay 7 noches.  Por lo tanto, el costo total sería S/55.00 * 7 = S/385.00', 1, '2025-07-01 15:11:25'),
(175, NULL, NULL, 'y sí hay disponibilidad?', '¡Claro que sí! Tenemos disponibilidad.  En este momento tenemos cuatro habitaciones simples disponibles a S/55.00 por noche.', 1, '2025-07-01 15:11:40'),
(176, NULL, NULL, 'puedes darme la dirección y el numero de celular del hotel por favor?', 'Claro que sí.  La dirección del Hostal La Fé es Calle Tacna 323, Otuzco, La Libertad. Nuestro número de teléfono es +51 964 954 496. También puede contactarnos a través de WhatsApp: https://wa.me/964954496 o por correo electrónico a hlafeotuzco@gmail.com', 1, '2025-07-01 15:12:09'),
(177, NULL, NULL, 'alguna foto? de la fachada tal vez?', '¡Claro que sí! Aquí tiene una foto de la fachada de nuestro Hostal: [IMAGEN:assets/img/galeria/fachada.jpg]', 1, '2025-07-01 15:12:35'),
(178, NULL, NULL, 'y de la habitacion que te pedí?', '¡Claro que sí! Aquí tiene una foto de una de nuestras cómodas Habitaciones Simples: [IMAGEN:assets/img/galeria/habitacion_simple.jpg]', 1, '2025-07-01 15:12:53'),
(179, NULL, NULL, 'y si mi esposa me acompaña, que habitación nos recomendarías? para las misma fechas que te indiqué', 'Para usted y su esposa, considerando que viajarán juntos, le recomendaría una habitación Doble. Es más amplia y cómoda que una Simple para dos personas.  También tenemos la opción de una habitación Matrimonial si lo prefieren.', 1, '2025-07-01 15:14:09'),
(180, NULL, NULL, 'y cuanto saldría en total con las dos opciones?', 'El precio de una habitación Doble es S/80.00 por noche. Del 8 al 15 de julio hay 7 noches. Por lo tanto, el costo total de una habitación Doble sería S/80.00 * 7 = S/560.00\n\nEl precio de una habitación Matrimonial es S/95.00 por noche. Del 8 al 15 de julio hay 7 noches. Por lo tanto, el costo total de una habitación Matrimonial sería S/95.00 * 7 = S/665.00', 1, '2025-07-01 15:14:35'),
(181, NULL, NULL, 'listo, creo que me voy por la habitacion matrimonial, si hay habitaciones disponibles?', 'Lo siento, necesito las fechas de su estadía para verificar la disponibilidad de habitaciones matrimoniales. Por favor, indíqueme las fechas de llegada y salida deseadas.', 1, '2025-07-01 15:15:04'),
(182, NULL, NULL, 'las que te di anteriormente', '¡Excelente noticia!  Tenemos disponibilidad para las habitaciones que me consultó anteriormente.  Hay diez habitaciones matrimoniales disponibles a S/95.00 por noche.', 1, '2025-07-01 15:15:19'),
(183, NULL, NULL, 'y para las fechas que te di tambien?', 'Lo siento, necesito las fechas de su estadía para verificar la disponibilidad de habitaciones matrimoniales. Por favor, indíqueme las fechas de llegada y salida deseadas.', 1, '2025-07-01 15:15:39'),
(184, NULL, NULL, 'ya te las di, te las dije hace unos instantes', 'Lo siento, pero necesito las fechas de llegada y salida para poder verificar la disponibilidad de la habitación matrimonial. Por favor, indíqueme nuevamente las fechas.', 1, '2025-07-01 15:16:02'),
(185, NULL, NULL, '¿qué tipos de habitaciones tienes?', 'Claro que sí. Ofrecemos habitaciones Simples, Dobles y Matrimoniales.  Cada una con su propio precio, por supuesto. ¿Te gustaría saber más sobre los precios o alguna en específico?', 1, '2025-07-01 15:36:04'),
(186, NULL, NULL, 'una para mi esposa y yo?', 'Para usted y su esposa, le recomiendo nuestra habitación Doble o Matrimonial. La Doble tiene dos camas individuales, mientras que la Matrimonial cuenta con una cama grande. ¿Le gustaría saber más sobre los precios de cada una?', 1, '2025-07-01 15:36:17'),
(187, NULL, NULL, 'si, y si hay disponibilidad del 8 al 12 de julio', '¡Excelente noticia!  Sí, tenemos disponibilidad del 8 al 12 de julio.  Contamos con doce habitaciones dobles disponibles a S/80.00 por noche.', 1, '2025-07-01 15:36:44'),
(188, NULL, NULL, 'y la matrimonial?', '¡Excelente noticia! Tenemos disponibilidad de habitaciones matrimoniales.  Hay diez habitaciones disponibles a S/95.00 por noche.', 1, '2025-07-01 15:36:59'),
(189, NULL, NULL, 'cuanto seria el total?', 'El precio de una habitación matrimonial es de S/95.00 por noche.  Del 8 al 12 de julio son 5 noches, por lo que el total sería S/475.00 (95 x 5 = 475).', 1, '2025-07-01 15:37:12'),
(190, NULL, NULL, 'cual es la direccion y una foto para ubicarlos mejor', 'Claro que sí. Nuestra dirección es Calle Tacna 323, Otuzco, La Libertad.  Y aquí tiene una foto de nuestra fachada principal para que pueda ubicarnos mejor: [IMAGEN:assets/img/galeria/fachada.jpg]', 1, '2025-07-01 15:38:53'),
(193, NULL, NULL, '¿qué tipos de habitaciones tienes?', 'Claro que sí. Ofrecemos habitaciones Simples, Dobles y Matrimoniales.  ¿Te gustaría saber más sobre alguna en particular?', 1, '2025-07-03 03:59:18'),
(194, NULL, NULL, 'precios?', 'Claro que sí.  El precio de nuestras habitaciones es el siguiente: Simple S/55.00 por noche, Doble S/80.00 por noche y Matrimonial S/95.00 por noche.', 1, '2025-07-03 03:59:26'),
(195, NULL, NULL, 'muéstrame fotos del hotel', 'Claro que sí, con gusto le muestro algunas fotos de nuestro hostal.  Aquí tiene una imagen de la fachada: [IMAGEN:assets/img/galeria/fachada.jpg] , una del lobby: [IMAGEN:assets/img/galeria/lobby.jpg] y ejemplos de nuestras habitaciones:  [IMAGEN:assets/img/galeria/habitacion_simple.jpg] , [IMAGEN:assets/img/galeria/habitacion_doble.jpg] y [IMAGEN:assets/img/galeria/habitacion_matrimonial.jpg].  Espero que le gusten!', 1, '2025-07-03 03:59:49'),
(209, NULL, NULL, '¿qué tipos de habitaciones tienes?', 'Claro que sí. Ofrecemos habitaciones Simples, Dobles y Matrimoniales.  ¿Te gustaría saber más sobre alguna en particular?', 1, '2025-07-04 00:38:30'),
(210, NULL, NULL, 'hola, tienes una habitacion doble disponible para el 29 de julio hasta el 3 de agosto?', '¡Hola!  Sí, tenemos disponibilidad de habitaciones dobles para sus fechas, del 29 de julio al 3 de agosto.  Tenemos actualmente 12 habitaciones dobles disponibles a S/80.00 por noche. ¿Le gustaría reservar alguna?', 1, '2025-07-04 00:41:31'),
(211, NULL, NULL, 'dame una foto de esa habitacion porfa', 'Claro que sí, aquí tiene una foto de una de nuestras cómodas habitaciones dobles: [IMAGEN:assets/img/galeria/habitacion_doble.jpg]', 1, '2025-07-04 00:42:45'),
(212, NULL, NULL, 'hola buenas noches', '¡Hola Michael Cristopher! Buenas noches. ¿En qué puedo ayudarte esta noche?', 1, '2025-07-04 00:48:20'),
(213, NULL, NULL, 'quiero reservar una habitacion desde (fecha: 2025-07-05) hasta (fecha: 2025-07-06), una simple', '¡Hola! Tenemos excelentes noticias, hay disponibilidad para una habitación sencilla del 5 al 6 de julio de 2025.  Tenemos varias opciones, todas a S/55.00 por noche. ¿Le gustaría reservar alguna de ellas?', 1, '2025-07-04 00:49:02'),
(214, NULL, NULL, '¿qué tipos de habitaciones tienes?', '¡Hola Michael Cristopher! Ofrecemos habitaciones Simples, Dobles y Matrimoniales. ¿Te gustaría saber más sobre alguna en particular?', 1, '2025-07-04 00:57:24'),
(215, NULL, NULL, 'hola quiero una habitacion simple de (fecha: 2025-07-05) hasta el 7 de julio por favor, hay disponibilidad?', 'Hola!  ¡Claro que sí! Tenemos disponibilidad para una habitación simple del 5 al 7 de julio.  Tenemos varias habitaciones simples disponibles a S/55.00 por noche. ¿Le gustaría reservar alguna?', 1, '2025-07-04 01:01:28'),
(216, NULL, NULL, 'hola, buenas noches', '¡Hola Michael Cristopher! Buenas noches. ¿En qué puedo ayudarte esta noche?', 1, '2025-07-04 01:10:29'),
(217, NULL, NULL, 'quiero reservar una habitacion de (fecha: 2025-07-04) hasta (fecha: 2025-07-06), una simple, tendrás disponibilidad?', 'Hola Michael Cristopher!  Lo siento, no tengo información sobre la disponibilidad para esas fechas.  Para poder ayudarte necesito que me proporciones más información.', 1, '2025-07-04 01:11:04'),
(218, NULL, NULL, 'de (fecha: 2025-07-04) hasta (fecha: 2025-07-06) una simple', 'Hola Michael Cristopher! Lo siento, no tengo información sobre la disponibilidad para esas fechas. Para poder ayudarte necesito que me proporciones más información.', 1, '2025-07-04 01:11:29'),
(219, NULL, NULL, 'hola', 'El usuario solo dice \"hola\".  No hay indicios de querer reservar, consultar disponibilidad o pedir información específica sobre habitaciones o servicios.  Por lo tanto, no se necesita usar la herramienta `verificar_disponibilidad`.  Se responde con texto plano.\n\nRespuesta:\n\nHola Michael Cristopher! ¿En qué te puedo ayudar esta noche?', 1, '2025-07-04 01:16:04'),
(220, NULL, NULL, 'hola buenas noches', 'El usuario solo dice \"hola buenas noches\".  No hay indicios de querer reservar, consultar disponibilidad o pedir información específica sobre habitaciones o servicios.  Por lo tanto, no se necesita usar la herramienta `verificar_disponibilidad`.  Se responde con texto plano.\n\nRespuesta:\n\nHola Michael Cristopher! Buenas noches. ¿En qué puedo ayudarte esta noche?', 1, '2025-07-04 01:16:57'),
(221, NULL, NULL, 'quiero reservar una habitacion desde (fecha: 2025-07-04) hasta (fecha: 2025-07-07) de la otra semana', '¡Hola!  Tengo buenas noticias, hay disponibilidad para su reserva del 4 al 7 de julio de 2025.  Hemos encontrado varias habitaciones simples disponibles a S/55.00 por noche. ¿Le gustaría proceder con la reserva?', 1, '2025-07-04 01:17:20'),
(222, NULL, NULL, 'y de (fecha: 2025-07-04) hasta el miercoles de la otra semana?', '¡Hola!  Para sus fechas, del 4 de julio de 2025 hasta el miércoles de la semana siguiente, tenemos disponibilidad.  Hemos encontrado cuatro habitaciones simples disponibles a S/55.00 por noche cada una.', 1, '2025-07-04 01:17:53'),
(223, NULL, NULL, 'cuanto seria el precio total?', 'El usuario pregunta por el precio total, pero no especifica la cantidad de habitaciones ni el tipo de habitación.  Como ya se ha establecido una conversación previa sobre una habitación simple del 4 al 7 de julio, asumiré que se refiere a esa reserva.  No es necesario usar `verificar_disponibilidad` porque ya tenemos la información de la disponibilidad y el precio base.  Responderé con texto plano.\n\n\nRespuesta:\n\nHola Michael Cristopher!  Para una habitación simple del 4 al 7 de julio, serían 3 noches a S/55.00 por noche, haciendo un total de S/165.00. ¿Desea proceder con la reserva?', 1, '2025-07-04 01:18:12'),
(224, NULL, NULL, 'no, dije hasta el miercoles no (fecha: 2025-07-07) de la otra semana', 'El usuario aclara que su reserva es hasta el miércoles de la semana siguiente al 4 de julio,  no hasta el 7 de julio. Necesitamos recalcular el precio.  El miércoles de la semana siguiente al 4 de julio es el 9 de julio.  Por lo tanto, la reserva sería del 4 al 9 de julio (5 noches). No es necesario usar la herramienta `verificar_disponibilidad` ya que la información sobre la disponibilidad de habitaciones simples ya se ha establecido.  Responderé con texto plano.\n\n\nRespuesta:\n\n¡Hola Michael Cristopher!  Entiendo.  Para una habitación simple del 4 al 9 de julio (5 noches), el precio total sería S/275.00 (5 noches x S/55.00 por noche). ¿Desea proceder con la reserva?', 1, '2025-07-04 01:18:42'),
(225, NULL, NULL, 'hola buenas noches', 'El usuario solo saluda. No hay indicios de querer reservar, consultar disponibilidad o pedir información específica sobre habitaciones o servicios. Por lo tanto, no se necesita usar la herramienta `verificar_disponibilidad`. Se responde con texto plano.\n\nRespuesta:\n\nHola Michael Cristopher! Buenas noches. ¿En qué puedo ayudarte esta noche?', 1, '2025-07-04 01:26:45'),
(226, NULL, NULL, 'hola, buenas noches', 'Hola Michael Cristopher! Buenas noches. ¿En qué puedo ayudarte esta noche?', 1, '2025-07-04 01:27:35'),
(227, NULL, NULL, 'hola buenas', 'El usuario solo saluda. No hay indicios de querer reservar, consultar disponibilidad o pedir información específica sobre habitaciones o servicios. Por lo tanto, no se necesita usar la herramienta `verificar_disponibilidad`. Se responde con texto plano.\n\nRespuesta:\n\nHola Michael Cristopher! Buenas noches. ¿En qué puedo ayudarte esta noche?', 1, '2025-07-04 01:29:44'),
(228, NULL, NULL, 'hola', 'El usuario solo saluda. No hay indicios de querer reservar, consultar disponibilidad o pedir información específica sobre habitaciones o servicios. Por lo tanto, no se necesita usar la herramienta `verificar_disponibilidad`. Se responde con texto plano.\n\nRespuesta:\n\nHola Michael Cristopher! Buenas noches. ¿En qué puedo ayudarte esta noche?', 1, '2025-07-04 01:31:11'),
(229, NULL, NULL, 'hola', 'Hola Michael Cristopher! ¿En qué te puedo ayudar hoy?', 1, '2025-07-04 01:32:25'),
(230, NULL, NULL, 'quiero reservar de (fecha: 2025-07-03) hasta (fecha: 2025-07-06), una simple, cuanto saldria en total?', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-04 01:34:02'),
(231, NULL, NULL, 'quiero reservar de (fecha: 2025-07-03) hasta (fecha: 2025-07-06), una simple, cuanto saldria en total?', 'Respuesta:\n\nHola Michael Cristopher!  Para una habitación simple del 3 al 6 de julio (4 noches), el precio total sería S/220.00 (4 noches x S/55.00 por noche). ¿Desea proceder con la reserva?', 1, '2025-07-04 01:34:34'),
(232, NULL, NULL, 'y de (fecha: 2025-07-04) hasta (fecha: 2025-07-06)?', 'Respuesta:\n\nHola Michael Cristopher! Para una habitación simple del 4 al 6 de julio (3 noches), el precio total sería S/165.00 (3 noches x S/55.00 por noche). ¿Desea proceder con la reserva?', 1, '2025-07-04 01:38:26'),
(233, NULL, NULL, 'tienes una imagen de esa habitacion?', '¡Claro que sí, Michael Cristopher! Así se ve una de nuestras cómodas Habitaciones Simples: [IMAGEN:assets/img/galeria/habitacion_simple.jpg]', 1, '2025-07-04 01:38:53'),
(234, NULL, NULL, 'y desde el 9 al 20 de julio disculpe?', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-04 01:39:12'),
(235, NULL, NULL, 'y desde el 9 al 20 de julio disculpe?', 'Respuesta:\n\nHola Michael Cristopher!  Para una habitación simple del 9 al 20 de julio (12 noches), el precio total sería S/660.00 (12 noches x S/55.00 por noche).  ¿Te gustaría reservar?', 1, '2025-07-04 01:39:22'),
(236, NULL, NULL, 'disculpa tendras una habitacion desde (fecha: 2025-07-07) de la otra semana hasta (fecha: 2025-07-10)?', 'Hola Michael Cristopher! Para poder darte el precio exacto, necesito saber qué tipo de habitación te gustaría reservar (simple, doble o matrimonial) del 7 al 10 de julio.  Una vez que me digas el tipo de habitación, te puedo dar el precio total.', 1, '2025-07-04 01:41:22'),
(237, NULL, NULL, 'una simple?', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-04 01:41:32'),
(238, NULL, NULL, 'una simple?', 'Respuesta:\n\nHola Michael Cristopher, sí, tenemos habitaciones simples disponibles. Para darte un precio exacto, necesito saber las fechas de tu estadía. Por favor, indica las fechas de llegada y salida deseadas.', 1, '2025-07-04 01:41:45'),
(239, NULL, NULL, 'desde (fecha: 2025-07-07) de la otra semana hasta (fecha: 2025-07-10)?', 'Respuesta:\n\nHola Michael Cristopher, para una habitación simple del 7 al 10 de julio (4 noches), el precio total sería S/220.00 (4 noches x S/55.00 por noche). ¿Deseas reservar?', 1, '2025-07-04 01:42:09'),
(240, NULL, NULL, 'hola buenas noches', 'Hola Michael Cristopher! Buenas noches, ¿en qué te puedo ayudar esta noche?', 1, '2025-07-04 01:45:54'),
(241, NULL, NULL, 'tendrás disponible habitaciones desde (fecha: 2025-07-03) hasta (fecha: 2025-07-10) de la otra semana disculpe?', 'Hola Michael Cristopher! Para poder ayudarte a verificar la disponibilidad, necesito saber qué tipo de habitación te gustaría reservar (simple, doble o matrimonial) del 3 al 10 de julio.  Una vez que me digas el tipo de habitación, podré darte la información de disponibilidad.', 1, '2025-07-04 01:46:25'),
(242, NULL, NULL, 'una simple', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-04 01:46:39'),
(243, NULL, NULL, 'cuanto seria el total?', '{\"error\":\"Problema de conexi\\u00f3n con el asistente.\"}', 1, '2025-07-04 01:46:50'),
(244, NULL, NULL, 'y si escojo una doble cuanto sería?', 'Hola Michael Cristopher! El precio de una habitación doble por 7 noches (del 3 al 10 de julio) sería de S/560.00 (7 noches x S/80.00 por noche).', 1, '2025-07-04 01:47:39'),
(245, NULL, NULL, 'Hola tienes habitaciones simples desde pasado mañana hasta el jueves de la otra semana?', '¡Hola! Sí, tenemos habitaciones simples disponibles desde el 5 de julio de 2025 hasta el 10 de julio de 2025. Contamos con varias opciones a S/55.00 por noche.', 1, '2025-07-04 02:15:38'),
(248, NULL, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-04 02:50:20'),
(249, NULL, NULL, 'Tienes habitacion simple de mañana hasta el miercoles de la otra semana?', '¡Claro que sí! Tenemos habitaciones simples disponibles desde mañana hasta el miércoles de la semana que viene. Hay varias opciones a S/55.00 por noche.', 1, '2025-07-04 02:51:04'),
(250, NULL, NULL, 'Cuanto seria el total?', '¡Hola Michael Cristopher! El precio de una habitación simple por 5 noches (del 4 al 9 de julio) sería de S/275.00 (5 noches x S/55.00 por noche).', 1, '2025-07-04 02:51:19'),
(251, NULL, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-04 03:05:19'),
(252, NULL, NULL, 'Para mi esposa y yo quiero una habitacion simple del 7 al 19 de julio por favor', '¡Claro que sí! Tenemos habitaciones simples disponibles para las fechas que solicitó, del 7 al 19 de julio. Contamos con varias opciones de habitaciones simples a un precio de S/55.00 por noche.', 1, '2025-07-04 03:06:11'),
(253, NULL, NULL, 'Y cuanto seria el total?', '¡Hola Michael Cristopher! El total por una habitación simple del 7 al 19 de julio (12 noches) sería de S/660.00.', 1, '2025-07-04 03:07:35'),
(254, NULL, NULL, 'Hola', '¡Hola! Bienvenido al Hostal La Fé. ¿En qué puedo ayudarte hoy?', 1, '2025-07-04 03:08:16'),
(255, NULL, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-04 03:08:21'),
(256, NULL, NULL, 'Y una habitacion doble para el 8 al 12 de julio cuanto sale?', '¡Hola Michael Cristopher! El precio de una habitación doble del 8 al 12 de julio sería de S/320.00 (4 noches x S/80.00 por noche).', 1, '2025-07-04 03:09:23'),
(257, 8, NULL, 'Quiero crear una cuenta', '', 0, '2025-07-04 03:24:39'),
(258, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-04 03:29:10'),
(259, 8, NULL, 'tienes habitaciones simples del 9 al 12 de julio', '¡Sí, tenemos habitaciones simples disponibles del 9 al 12 de julio! Encontramos varias opciones con un precio de S/55.00 por noche.', 0, '2025-07-04 03:30:10'),
(260, NULL, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-04 03:59:00'),
(261, NULL, NULL, 'Hola', '¡Hola Michael Cristopher! ¿En qué puedo ayudarte hoy?', 1, '2025-07-04 03:59:15'),
(262, NULL, NULL, 'quiero una habitacion para mi y mi prostituta, cual me recomiendas?', 'Hola Michael Cristopher, para dos personas puedo recomendarte una habitación Matrimonial o una Doble. La Matrimonial tiene una cama grande y cómoda, ideal para parejas. La Doble cuenta con dos camas separadas. ¿Cuál prefieres? La Matrimonial cuesta S/95.00 por noche y la Doble S/80.00 por noche.', 1, '2025-07-04 03:59:54'),
(263, NULL, NULL, 'Tienes muebles sexuales?', 'Hola Michael Cristopher, lamentablemente no contamos con ese tipo de mobiliario en nuestras habitaciones. Ofrecemos alojamiento cómodo con servicios básicos como WiFi, TV por cable y agua caliente.', 1, '2025-07-04 04:01:08'),
(264, NULL, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-04 04:03:10'),
(265, NULL, NULL, 'Hola buenas noches', 'Hola Michael Cristopher, ¡buenas noches! ¿En qué puedo ayudarte?', 1, '2025-07-04 04:03:41'),
(266, NULL, NULL, 'Hola', 'Hola Michael Cristopher, ¿en qué puedo ayudarte hoy?', 1, '2025-07-04 04:04:15'),
(267, NULL, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-04 04:11:18'),
(268, NULL, NULL, 'Hola', 'Hola Michael Cristopher, ¡hola! ¿En qué puedo ayudarte hoy?', 1, '2025-07-04 04:11:34'),
(270, NULL, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-04 04:22:11'),
(271, NULL, NULL, 'Hola', 'Hola Michael Cristopher, ¡hola! ¿En qué puedo ayudarte hoy?', 1, '2025-07-04 04:22:31'),
(272, NULL, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-04 04:26:55'),
(273, NULL, NULL, 'Hola', 'Hola Michael Cristopher, ¡hola! ¿En qué puedo ayudarte hoy?', 1, '2025-07-04 04:27:14'),
(274, NULL, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-04 04:33:59'),
(290, NULL, NULL, 'Hola', '¡Hola! ¿En qué puedo ayudarte hoy? Ofrecemos alojamiento cómodo y sencillo en Otuzco. Contamos con habitaciones simples, dobles y matrimoniales. Todas incluyen WiFi, TV por cable y agua caliente.', 1, '2025-07-05 01:32:01'),
(291, NULL, NULL, 'Y en que consiste una simple?', 'Nuestras habitaciones simples son cómodas y acogedoras, ideales para una persona. Cuentan con una cama individual, WiFi, TV por cable y agua caliente. [IMAGEN:assets/img/galeria/habitacion_simple.jpg]', 1, '2025-07-05 01:32:41'),
(292, NULL, NULL, 'Y tienes disponibilidad desde el 10 hasta el 12 de julio para esa habitacion?', 'Sí, tenemos disponibilidad para la Habitación Simple del 10 al 12 de julio. El precio total sería de 110. ¿Le gustaría reservar?', 1, '2025-07-05 01:33:25'),
(293, NULL, NULL, 'Cuanto es el precio por noche?', 'El precio de la habitación Simple es de S/55.00 por noche.', 1, '2025-07-05 01:33:43'),
(294, NULL, NULL, 'Y como reservo?', 'Perfecto, tenemos disponibilidad para la habitación simple por un total de 110. ¿Desea que procedamos con la reserva?', 1, '2025-07-05 01:33:56'),
(295, NULL, NULL, 'Si', '¡Perfecto! Tenemos disponibilidad para la habitación simple del 10 al 12 de julio por un total de 110. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 01:34:05'),
(296, NULL, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 01:34:14'),
(297, NULL, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 01:34:28'),
(298, NULL, NULL, 'Quiero iniciar sesion', '', 1, '2025-07-05 01:34:44'),
(299, NULL, NULL, 'ya inicié sesion', '¡Excelente! Como ya iniciaste sesión, podemos continuar con tu reserva de la habitación simple del 10 al 12 de julio por un total de S/ 110. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 110 ahora</button>', 1, '2025-07-05 01:35:04'),
(300, NULL, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 01:35:12'),
(301, 8, NULL, 'Hola, que tipo de habitaciones tiene?', 'Hola! En Hostal La Fé, contamos con habitaciones Simple, Doble y Matrimonial. Para que te hagas una idea, te puedo mostrar una [IMAGEN:assets/img/galeria/habitacion_simple.jpg] de una habitación simple, una [IMAGEN:assets/img/galeria/habitacion_doble.jpg] de una habitación doble y una [IMAGEN:assets/img/galeria/habitacion_matrimonial.jpg] de una habitación matrimonial.', 0, '2025-07-05 01:36:20'),
(302, 8, NULL, 'Y cuales son los precios?', 'Los precios de nuestras habitaciones son:\n- Simple: S/55.00 por noche.\n- Doble: S/80.00 por noche.\n- Matrimonial: S/95.00 por noche.', 0, '2025-07-05 01:36:36'),
(303, 8, NULL, 'Quiero una doble del 14 al 16 de julio, hay disponibilidad?', 'Sí, tenemos disponibilidad de una habitación doble del 14 al 16 de julio. El precio total sería de 160. ¿Le gustaría reservarla?', 0, '2025-07-05 01:36:57'),
(304, 8, NULL, 'Si por favor', '¡Buenas noticias! La Habitación Doble está disponible. El total sería de S/ 160. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 0, '2025-07-05 01:37:12'),
(305, 8, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 0, '2025-07-05 01:37:21'),
(306, 8, NULL, 'Inicar sesion', '¡Entendido! Te he redirigido a la página de inicio de sesión/registro. Una vez que hayas iniciado sesión, podremos continuar con tu reserva de la habitación doble del 14 al 16 de julio.', 0, '2025-07-05 01:37:27'),
(307, 8, NULL, 'Quiero loguearme', '', 0, '2025-07-05 01:37:39'),
(308, 8, NULL, 'Ya inicie sesion', '¡Hola! Como ya iniciaste sesión, podemos continuar con tu reserva de la Habitación Doble del 14 al 16 de julio. El total sería de S/ 160. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 160 ahora</button>', 0, '2025-07-05 01:43:40'),
(309, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-05 01:43:50'),
(310, NULL, NULL, 'Quiero reservar una habitacion, que tipos o categorias tienes?', '¡Claro! En Hostal La Fé, ofrecemos las siguientes categorías de habitaciones: Simple, Doble y Matrimonial. Para poder ayudarte con la reserva, ¿podrías indicarme qué tipo de habitación te interesa y las fechas de inicio y fin de tu estadía?', 1, '2025-07-05 01:59:19'),
(311, NULL, NULL, 'Para mi y mi esposa, queremos estar desde mañana hasta el martes en Otuzco, cuanto sería?', '¡Claro! Tenemos disponibilidad de una habitación matrimonial en Otuzco desde mañana hasta el martes. El precio total sería de 285. ¿Le gustaría que procedamos con la reserva?', 1, '2025-07-05 01:59:57'),
(312, NULL, NULL, 'Cuanto esta el precio por noche?', 'El precio por noche de la habitación matrimonial sería de S/ 95.00. El total por las 3 noches (desde mañana hasta el martes) es de S/ 285. ¿Le gustaría que procedamos con la reserva? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 02:00:17'),
(313, NULL, NULL, 'Mañana es sabado, hasta el martes son 4 noches no?', 'El precio por noche de la habitación matrimonial es de S/ 95.00. Y sí, tiene razón, de mañana sábado hasta el martes serían 4 noches.', 1, '2025-07-05 02:00:56'),
(314, NULL, NULL, 'Cuanto seria el total entonces?', 'El total de su reserva es de 285. ¿Desea continuar con la reserva?', 1, '2025-07-05 02:01:12'),
(315, NULL, NULL, 'Si por favor', '¡Perfecto! El total sería de S/ 285. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 02:01:21'),
(316, NULL, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 02:01:28'),
(317, NULL, NULL, 'Quiero iniciar sesion', '', 1, '2025-07-05 02:01:34'),
(318, NULL, NULL, 'Ya inicié sesion', 'Hola Michael Cristopher, veo que ya iniciaste sesión. Tenemos disponible una habitación matrimonial por un precio total de 285. ¿Te gustaría reservarla?', 1, '2025-07-05 02:02:01'),
(319, NULL, NULL, 'Si', '¡Hola Michael Cristopher! Tenemos disponible una habitación matrimonial por un precio total de 285. ¿Te gustaría reservarla? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 285 ahora</button>', 1, '2025-07-05 02:02:10'),
(320, NULL, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 02:02:16'),
(321, NULL, NULL, 'Hola', '¡Hola! Bienvenido al Hostal La Fé. ¿En qué puedo ayudarte hoy?', 1, '2025-07-05 14:41:56'),
(324, NULL, NULL, 'Quiero reservar una habitación simple del 9 al 15 de julio porfavor', 'Perfecto, tenemos disponibilidad de una habitación simple del 9 al 15 de julio. El precio total sería de 330. ¿Le gustaría confirmar la reserva?', 1, '2025-07-05 14:42:48'),
(325, NULL, NULL, 'Si por favor', '¡Buenas noticias! La Habitación Simple está disponible. El total sería de S/ 330. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 14:43:05'),
(326, NULL, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 14:43:11'),
(327, NULL, NULL, 'Quiero iniciar sesion', '', 1, '2025-07-05 14:43:24'),
(328, NULL, NULL, 'Quiero iniciar sesion', '', 1, '2025-07-05 14:49:41'),
(329, NULL, NULL, 'Quiero iniciar sesion', '', 1, '2025-07-05 14:49:59'),
(330, NULL, NULL, 'Ya inicié sesión', 'Hola Michael Cristopher, veo que ya iniciaste sesión. Tenemos disponible una habitación simple por un total de 330. ¿Te gustaría reservarla?', 1, '2025-07-05 14:50:24'),
(331, NULL, NULL, 'Si', '¡Hola Michael Cristopher! La Habitación Simple está disponible. El total sería de S/ 330. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 330 ahora</button>', 1, '2025-07-05 14:50:36'),
(332, NULL, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 14:50:47'),
(339, NULL, NULL, 'Quiero reservar una habitacion doble del 9 al 19 de julio, cuanto saldría? Hay disponibilidad?', '¡Claro! Tenemos disponibilidad de una habitación doble del 9 al 19 de julio. El precio total sería de 800. ¿Le gustaría reservarla?', 1, '2025-07-05 15:08:21'),
(340, NULL, NULL, 'Si por favor', '¡Perfecto! La Habitación Doble está disponible. El total sería de S/ 800. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 15:08:41'),
(341, NULL, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 15:08:49'),
(342, NULL, NULL, 'Quiero iniciar session', '¡Entendido! Por favor, procede a iniciar sesión o crear una cuenta para continuar con tu reserva. Hemos guardado los detalles de tu habitación doble del 9 al 19 de julio.', 1, '2025-07-05 15:08:57'),
(343, NULL, NULL, 'Quiero loguearme', '', 1, '2025-07-05 15:09:05'),
(344, NULL, NULL, 'Ya inicié sesion', '¡Excelente! Como ya iniciaste sesión, podemos continuar con tu reserva de la Habitación Doble del 9 al 19 de julio. El total sería de S/ 800. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 800 ahora</button>', 1, '2025-07-05 15:09:24'),
(345, NULL, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 15:09:32'),
(346, NULL, NULL, 'Hola, tendrás habitaciones dobles del 6 al 9 de julio disponibles?', '¡Hola! Sí, tenemos habitaciones dobles disponibles del 6 al 9 de julio. El precio total sería de 240. ¿Le gustaría reservar?', 1, '2025-07-05 15:33:52'),
(347, NULL, NULL, 'Tienes alguna foto?', '¡Claro! Aquí tienes una foto de la fachada principal del hotel: [IMAGEN:assets/img/galeria/fachada.jpg]', 1, '2025-07-05 15:34:06'),
(348, NULL, NULL, 'De la habitacion', '¡Claro! Aquí tienes una foto de una de nuestras habitaciones dobles: [IMAGEN:assets/img/galeria/habitacion_doble.jpg]', 1, '2025-07-05 15:34:15'),
(349, NULL, NULL, 'Listo, entonces si quiero reservar', '¡Buenas noticias! La Habitación Doble está disponible. El total sería de S/ 240. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 15:34:29'),
(350, NULL, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 15:34:35'),
(351, NULL, NULL, 'Quiero loguearme', '', 1, '2025-07-05 15:34:40'),
(352, NULL, NULL, 'Ya inicié sesion', '¡Excelente! Procedemos con el pago de S/ 240. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 240 ahora</button>', 1, '2025-07-05 15:34:56'),
(353, NULL, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 15:35:05'),
(354, NULL, NULL, 'Ya inicié sesion', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 15:40:43'),
(355, NULL, NULL, 'Puedes enviarme nuevamente el clic para volver a pagar, es que me salió error', '¡Claro! Te estoy preparando el formulario de pago seguro. Un momento por favor...', 1, '2025-07-05 15:41:13'),
(356, NULL, NULL, 'Otra vez por favor, cerré la pestaña por accidente', '¡Claro! Aquí tienes el enlace para realizar el pago: <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 240 ahora</button>', 1, '2025-07-05 15:43:05'),
(357, NULL, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 15:43:11'),
(358, NULL, NULL, 'Puedes enviarme nuevamente el clic para volver a pagar, es que me volvió a salió error', '¡Claro! Te estoy preparando el formulario de pago seguro. Un momento por favor...', 1, '2025-07-05 15:46:37'),
(359, NULL, NULL, 'Que habitaciones tienes?', 'En Hostal La Fé, contamos con habitaciones Simple, Doble y Matrimonial. La habitación Simple cuesta S/55.00 por noche, la Doble S/80.00 por noche, y la Matrimonial S/95.00 por noche. ¿Le interesa alguna en particular?', 1, '2025-07-05 15:55:17'),
(360, NULL, NULL, 'Quisiera una simple del 10 al 18 de julio por favor', 'Claro, tenemos una habitación simple disponible del 10 al 18 de julio. El precio total sería de 440. ¿Le gustaría reservarla?', 1, '2025-07-05 15:55:35'),
(361, NULL, NULL, 'Si por favor', 'Por supuesto. He encontrado una habitación individual disponible por un total de 440. ¿Le gustaría reservarla?', 1, '2025-07-05 15:55:51'),
(362, NULL, NULL, 'Si', '¡Perfecto! La habitación simple está disponible del 10 al 18 de julio, con un precio total de S/ 440. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 15:56:04'),
(363, NULL, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 15:56:08'),
(364, NULL, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-05 15:56:17');
INSERT INTO `historial_chat` (`id`, `user_id`, `session_id`, `mensaje_usuario`, `respuesta_bot`, `visible_al_usuario`, `fecha`) VALUES
(365, NULL, NULL, 'Ya inicié sesión', '¡Excelente! La habitación simple está disponible del 10 al 18 de julio, con un precio total de S/ 440. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 440 ahora</button>', 1, '2025-07-05 15:56:39'),
(366, NULL, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 15:56:44'),
(367, NULL, NULL, 'Quiero una doble del 8 al 13 de julio, hay disponibilidad?', '¡Claro que sí! Tenemos disponibilidad de una habitación doble del 8 al 13 de julio. El precio total sería de 400. ¿Le gustaría reservar?', 1, '2025-07-05 15:57:24'),
(368, NULL, NULL, 'Si', '¡Perfecto! La Habitación Doble está disponible del 8 al 13 de julio, el precio total es de S/ 400. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 15:57:34'),
(369, NULL, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 15:57:39'),
(370, NULL, NULL, 'Quiero iniciar sesion', '', 1, '2025-07-05 15:57:47'),
(371, NULL, NULL, 'Ya inicié sesión', '¡Excelente! Ya que iniciaste sesión, podemos proceder con el pago de S/ 400. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 400 ahora</button>', 1, '2025-07-05 15:58:08'),
(372, NULL, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 15:58:14'),
(373, NULL, NULL, 'Puedes enviarme de nuevo a la página, me salió error', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago... <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 400 ahora</button>', 1, '2025-07-05 15:59:33'),
(374, NULL, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 15:59:37'),
(375, NULL, NULL, 'Quiero una habitacion matrimonial del 8 al 10 de julio por favro', '¡Por supuesto! Tenemos una habitación matrimonial disponible del 8 al 10 de julio por un total de 190. ¿Le gustaría reservarla?', 1, '2025-07-05 16:05:16'),
(376, NULL, NULL, 'Si', '¡Buenas noticias! La Habitación Matrimonial está disponible. El total sería de S/ 190. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 16:05:24'),
(377, NULL, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 16:05:30'),
(378, NULL, NULL, 'Quiero loguearme', '', 1, '2025-07-05 16:05:40'),
(379, NULL, NULL, 'Ya inicié sesión', 'Hola Michael, veo que ya has iniciado sesión. Hay una habitación matrimonial disponible por un precio total de 190. ¿Te gustaría reservarla?', 1, '2025-07-05 16:06:06'),
(380, NULL, NULL, 'Si', '¡Hola Michael! La Habitación Matrimonial está disponible. El total sería de S/ 190. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 190 ahora</button>', 1, '2025-07-05 16:06:13'),
(381, NULL, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 16:06:18'),
(382, 12, NULL, 'Quiero registrarme', '', 1, '2025-07-05 16:06:54'),
(383, 12, NULL, 'Quiero reservar una habitacion doble por favor, del 7 al 10 de julio', 'Hola Ana Luisa, tenemos disponibilidad de una habitación doble del 7 al 10 de julio. El precio total sería de 240. ¿Te gustaría reservar esta habitación?', 1, '2025-07-05 16:09:09'),
(384, 12, NULL, 'Sí', '¡Hola Ana Luisa! Perfecto, la Habitación Doble está disponible del 7 al 10 de julio. El total sería de S/ 240. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 240 ahora</button>', 1, '2025-07-05 16:09:19'),
(385, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 16:09:24'),
(386, 12, NULL, 'Puedes enviarme a la pagina de nuevo, ocurrio un error', '¡Entendido! Aquí tienes de nuevo el enlace para el pago: <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 240 ahora</button>', 1, '2025-07-05 16:12:22'),
(387, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 16:12:28'),
(388, NULL, NULL, 'quiero reservar una habitacion del 10 al 12 de julio, una doble por fa', '¡Por supuesto! Tenemos una habitación doble disponible del 10 al 12 de julio por un total de 160. ¿Le gustaría reservarla?', 1, '2025-07-05 16:23:19'),
(389, NULL, NULL, 'Si', '¡Perfecto! La Habitación Doble está disponible del 10 al 12 de julio por un total de S/ 160. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 16:23:28'),
(390, NULL, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 16:23:33'),
(391, NULL, NULL, 'Quiero iniciar sesion', '', 1, '2025-07-05 16:23:42'),
(392, NULL, NULL, 'Ya inicié sesion', 'Hola Michael, veo que ya has iniciado sesión. Tenemos una habitación doble disponible por un precio total de 160. ¿Te gustaría reservarla?', 1, '2025-07-05 16:23:57'),
(393, NULL, NULL, 'Si', '¡Hola Michael! La Habitación Doble está disponible por un precio total de S/ 160. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 160 ahora</button>', 1, '2025-07-05 16:24:06'),
(394, NULL, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 16:24:10'),
(395, 12, NULL, 'Quiero loguearme', '', 1, '2025-07-05 16:24:48'),
(396, 12, NULL, 'QUiero una habitacion simple del 18 al 20 de julio por favor', 'Hola Ana Luisa, tenemos una habitación simple disponible del 18 al 20 de julio por un total de 110. ¿Deseas que la reserve para ti?', 1, '2025-07-05 16:25:18'),
(397, 12, NULL, 'Si', '¡Excelente Ana Luisa! Entonces procedemos con el pago de S/ 110. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 110 ahora</button>', 1, '2025-07-05 16:25:27'),
(398, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 16:25:32'),
(399, 12, NULL, 'Quiero iniciar sesion', '', 1, '2025-07-05 16:31:01'),
(400, 12, NULL, 'Quiero una habitacion doble del 19 al 23 de julio por favor', 'Hola Ana Luisa, tenemos disponibilidad de una habitación doble del 19 al 23 de julio. El precio total sería de 160. ¿Deseas que haga la reserva a tu nombre?', 1, '2025-07-05 16:31:36'),
(401, 12, NULL, 'Si', '¡Perfecto Ana Luisa! Entonces procedemos con el pago de S/ 160. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 160 ahora</button>', 1, '2025-07-05 16:31:43'),
(402, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 16:31:48'),
(403, 12, NULL, 'Puedes enviarme de nuevo al sitio directamente? Me salio error', '¡Perfecto Ana Luisa! Entonces procedemos con el pago de S/ 160. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 160 ahora</button>', 1, '2025-07-05 16:33:20'),
(404, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 16:33:25'),
(405, 12, NULL, 'Quiero reservar una habitación doble del 9 al 11 de julio', 'Claro, tenemos una habitación doble disponible del 9 al 11 de julio. El precio total sería de 80 euros. ¿Le gustaría reservar esta habitación?', 1, '2025-07-05 17:08:38'),
(406, 12, NULL, 'Si', '¡Buenas noticias! La Habitación Doble está disponible del 9 al 11 de julio. El total sería de 80 euros. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 17:08:56'),
(407, 12, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 17:09:04'),
(408, 12, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-05 17:09:10'),
(409, 12, NULL, 'Ya inicié sesión', 'Hola Ana Luisa, bienvenida de nuevo. Veo que ya iniciaste sesión. ¿En qué puedo ayudarte hoy?', 1, '2025-07-05 17:09:47'),
(410, 12, NULL, 'Quiero la reservacion qué hice', '¡Hola Ana Luisa! Confirmamos tu reserva de la Habitación Doble del 9 al 11 de julio por un total de 80 euros. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 80 ahora</button>', 1, '2025-07-05 17:10:29'),
(411, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 17:10:39'),
(412, 12, NULL, 'Quiero reservar una habitación simple del 8 al 13 de julio', 'Claro, tenemos disponibilidad de una habitación simple del 8 al 13 de julio. El precio total sería de 150. ¿Le gustaría que proceda con la reserva?', 1, '2025-07-05 17:13:50'),
(413, 12, NULL, 'Si por favor', '¡Perfecto! La Habitación Simple está disponible del 8 al 13 de julio. El total sería de S/ 150. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 17:14:03'),
(414, 12, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 17:14:08'),
(415, 12, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-05 17:14:19'),
(416, 12, NULL, 'Quiero mi reservación', '¡Perfecto! La Habitación Simple está disponible del 8 al 13 de julio. El total sería de S/ 150. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 150 ahora</button>', 1, '2025-07-05 17:14:51'),
(417, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 17:14:57'),
(418, 12, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-05 17:18:40'),
(419, 12, NULL, 'Puedes darme el enlace de nuevo porfa? Para usar mi otra tarjeta, la anterior fue rechazada', '¡Por supuesto! Aquí tienes el enlace para realizar el pago con tu otra tarjeta: <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 150 ahora</button>', 1, '2025-07-05 17:19:20'),
(420, 12, NULL, '[Internal] initiate-payment', 'Lo siento, ha ocurrido un error al procesar tu solicitud de pago. Por favor, intenta realizar la consulta de reserva de nuevo.', 1, '2025-07-05 17:19:27'),
(421, 12, NULL, 'Quiero reservar la habitacion que te dije anteriormente para las mismas fechas', '¡Hola Ana Luisa! ¡Claro que sí! Veo que quieres reservar la Habitación Simple para las mismas fechas de tu consulta anterior. El precio total sería de 150. ¿Confirmamos la reserva?', 1, '2025-07-05 17:20:02'),
(422, 12, NULL, 'Si', '¡Perfecto Ana Luisa! Entonces procedemos con el pago de S/ 150. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 150 ahora</button>', 1, '2025-07-05 17:20:11'),
(423, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 17:20:16'),
(424, 12, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-05 17:25:13'),
(425, 12, NULL, 'Quiero reservar una habitacion doble del 9 al 10 de julio porfa', '¡Hola, Ana Luisa! Tenemos disponibilidad de una habitación doble del 9 al 10 de julio. El precio total sería de 40. ¿Te gustaría reservarla?', 1, '2025-07-05 17:29:54'),
(426, 12, NULL, 'Si', '¡Perfecto, Ana Luisa! Tenemos disponible una habitación doble por un total de 40. ¿Deseas confirmar la reserva?', 1, '2025-07-05 17:30:05'),
(427, 12, NULL, 'Si porfavor', '¡Excelente Ana Luisa! Entonces procedemos con el pago de S/ 40. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 40 ahora</button>', 1, '2025-07-05 17:30:18'),
(428, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 17:30:24'),
(429, 12, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-05 17:33:17'),
(430, 12, NULL, 'Quiero una matrimonial del 8 al 9 de julio porfa', 'Hola Ana Luisa, ¡perfecto! Tenemos disponible una habitación matrimonial del 8 al 9 de julio por un total de 50. ¿Te gustaría reservarla?', 1, '2025-07-05 17:34:09'),
(431, 12, NULL, 'Si por fa', '¡Excelente Ana Luisa! Entonces procedemos con el pago de S/ 50. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 50 ahora</button>', 1, '2025-07-05 17:34:23'),
(432, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 17:34:28'),
(433, 12, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-05 17:44:33'),
(434, 12, NULL, 'Quiero una habitación simple del 21 al 24 de julio', 'Hola Ana Luisa, tenemos una habitación simple disponible del 21 al 24 de julio. El precio total sería de 90. ¿Te gustaría reservarla?', 1, '2025-07-05 17:45:07'),
(435, 12, NULL, 'Si', '¡Perfecto Ana Luisa! Entonces procedemos con el pago de S/ 90. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 90 ahora</button>', 1, '2025-07-05 17:45:16'),
(436, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 17:45:27'),
(437, 12, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-05 17:50:10'),
(438, 12, NULL, 'Quiero una habitación simple del 9 al 15 de julio', 'Hola Ana Luisa, tenemos una habitación simple disponible del 9 al 15 de julio por un total de 180. ¿Te gustaría reservarla?', 1, '2025-07-05 17:50:42'),
(439, 12, NULL, 'Si', '¡Perfecto Ana Luisa! Entonces procedemos con el pago de S/ 180. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 180 ahora</button>', 1, '2025-07-05 17:50:50'),
(440, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 17:50:57'),
(443, NULL, NULL, 'Quiero una habitación simple del 9 al 16 de jullio', 'Claro, tenemos una habitación simple disponible del 9 al 16 de julio. El precio total sería de 210. ¿Le gustaría reservarla?', 1, '2025-07-05 18:06:20'),
(444, NULL, NULL, 'Si porfa', '¡Buenas noticias! La Habitación Simple está disponible del 9 al 16 de julio. El total sería de S/ 210. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-07-05 18:06:32'),
(446, NULL, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 1, '2025-07-05 18:06:45'),
(453, NULL, NULL, 'quiero iniciar sesion', '', 1, '2025-07-05 18:09:50'),
(469, NULL, NULL, 'Hola, tienes una habitación simple del 8 al 12 de julio?', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 120.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-05 21:42:44'),
(470, NULL, NULL, 'Cual es el precio por noche?', 'El precio de la habitación Simple es de S/30.00 por noche.', 1, '2025-07-05 21:43:03'),
(471, NULL, NULL, 'Tienes alguna foto quizas?', '¡Claro! Aquí tienes una foto de una de nuestras Habitaciones Simples: [IMAGEN:assets/img/galeria/habitacion_simple.jpg]', 1, '2025-07-05 21:43:35'),
(472, NULL, NULL, 'Perfecto, entonces si, quiero la reserva', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 120.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-05 21:43:49'),
(473, NULL, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-05 21:43:59'),
(474, NULL, NULL, 'Ya inicié sesion', '¡Excelente! La Habitación Simple está disponible. El total sería de S/ 120.00. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 120.00 ahora</button>', 1, '2025-07-05 21:44:24'),
(475, NULL, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 21:44:32'),
(476, 12, NULL, 'Hola, buenas tardes, quiero una habitacion doble del 8 al 14 de julio, cuanto saldría? y hay disponibilidad?', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 240.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-05 21:45:37'),
(477, 12, NULL, 'Quiero iniciar sesión', '', 1, '2025-07-05 21:45:45'),
(478, 12, NULL, 'Listo, ya inicié sesion', '¡Perfecto! Ya que iniciaste sesión, la Habitación Doble está disponible por S/ 240. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 240 ahora</button>', 1, '2025-07-05 21:46:14'),
(479, 12, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 1, '2025-07-05 21:46:20'),
(480, 8, NULL, 'Hola quiero una habitación simple del 9 al 15 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 180.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-05 21:55:45'),
(481, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-05 21:55:52'),
(482, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Simple</b> está disponible por <b>S/ 180.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 180.00 ahora</button>', 0, '2025-07-05 21:56:03'),
(483, 8, NULL, 'Hola, tienes habitaciones dobles del 8 al 19 de julio disponibles?', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 440.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-05 22:03:19'),
(484, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-05 22:03:35'),
(485, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Doble</b> está disponible por <b>S/ 440.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 440.00 ahora</button>', 0, '2025-07-05 22:03:47'),
(486, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-05 22:03:51'),
(487, 8, NULL, 'Hola mano, una habitacion simple del 8 al 10 de julio porfa', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 60.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-05 22:23:45'),
(488, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-05 22:23:56'),
(489, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Simple</b> está disponible por <b>S/ 60.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 60.00 ahora</button>', 0, '2025-07-05 22:24:10'),
(490, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-05 22:24:19'),
(491, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-05 22:24:27'),
(492, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-05 22:24:34'),
(494, 8, NULL, 'Quiero una habitacion doble del 8 al 10 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 80.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 00:23:22'),
(495, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 00:24:06'),
(496, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Doble</b> está disponible por <b>S/ 80.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 80.00 ahora</button>', 0, '2025-07-06 00:24:26'),
(497, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 00:24:28'),
(498, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 00:25:47'),
(499, 8, NULL, 'Quiero una habitacion doble desde el 9 al 13 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 160.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 00:31:41'),
(500, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 00:31:48'),
(501, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Doble</b> está disponible por <b>S/ 160.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 160.00 ahora</button>', 0, '2025-07-06 00:32:01'),
(502, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 00:32:21'),
(503, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 00:48:04'),
(504, 8, NULL, 'Quiero una habitacion simple del 7 al 12 de julio', 'Hola René, tenemos una habitación simple disponible del 7 al 12 de julio. El precio total sería de 150. ¿Te gustaría reservarla?', 0, '2025-07-06 00:48:34'),
(505, 8, NULL, 'Si', '¡Perfecto René! La Habitación Simple está disponible. El total sería de S/ 150. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 150 ahora</button>', 0, '2025-07-06 00:48:42'),
(506, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 00:48:48'),
(507, 8, NULL, 'Quiero una habitacion matrimonial del 9 al 13 de julio por favor', '¡Excelente elección! Hemos encontrado una <b>Habitación Matrimonial</b> disponible para ti por <b>S/ 200.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 00:52:29'),
(508, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 00:52:36'),
(509, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Matrimonial</b> está disponible por <b>S/ 200.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 200.00 ahora</button>', 0, '2025-07-06 00:52:48'),
(510, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 00:52:52'),
(511, 8, NULL, 'Quiero una habitacion simple del 9 al 12 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 90.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 01:00:37'),
(512, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 01:00:44'),
(513, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Simple</b> está disponible por <b>S/ 90.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 90.00 ahora</button>', 0, '2025-07-06 01:00:56'),
(514, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 01:00:58'),
(515, 8, NULL, 'Quiero una habitacion doble del 8 al 14 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 240.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 01:07:49'),
(516, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 01:07:56'),
(517, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Doble</b> está disponible por <b>S/ 240.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 240.00 ahora</button>', 0, '2025-07-06 01:08:08'),
(518, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 01:08:10'),
(519, 8, NULL, 'Quiero una habitacion matrimonial del 9 al 12 de julio porfavotr', '¡Excelente elección! Hemos encontrado una <b>Habitación Matrimonial</b> disponible para ti por <b>S/ 150.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 01:10:01'),
(520, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 01:10:05'),
(521, 8, NULL, 'Quiero una habitacion simple del 9 al 12 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 90.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 01:11:38'),
(522, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 01:11:45'),
(523, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Simple</b> está disponible por <b>S/ 90.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 90.00 ahora</button>', 0, '2025-07-06 01:11:59'),
(524, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 01:12:02'),
(526, 8, NULL, 'Quiero una habitacion doble del 12 al 15 de julio por favor', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 120.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 01:13:40'),
(527, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 01:13:47'),
(528, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Doble</b> está disponible por <b>S/ 120.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 120.00 ahora</button>', 0, '2025-07-06 01:13:59'),
(529, 8, NULL, 'Ya hice el pago', '¡Entendido! Estamos verificando tu pago. Te notificaremos en breve cuando se confirme tu reserva.', 0, '2025-07-06 01:14:11'),
(530, 8, NULL, 'Ya inicie sesion', '¡Entendido! Estamos confirmando la recepción de tu pago y finalizando el proceso de reserva. Te notificaremos en breve cuando tu reserva esté completamente confirmada.', 0, '2025-07-06 01:14:22'),
(531, 8, NULL, 'No quiero pagar, me equivoque', '¡Claro! Te estoy preparando el formulario de pago seguro. Un momento por favor...', 0, '2025-07-06 01:14:35'),
(532, 8, NULL, 'Quiero una habitacion doble del 18 al 14 de julio', 'Por favor, verifica las fechas de tu reserva. La fecha de inicio (18 de julio) es posterior a la fecha de fin (14 de julio). ¿Podrías indicarme las fechas correctas para tu habitación doble?', 0, '2025-07-06 01:15:59'),
(533, 8, NULL, 'Ah me equivoque, esta al reves', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 160.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 01:16:18'),
(534, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 01:16:24'),
(535, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Doble</b> está disponible por <b>S/ 160.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 160.00 ahora</button>', 0, '2025-07-06 01:16:37'),
(536, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 01:16:39'),
(537, 8, NULL, 'Quiero una habitacion doble del 7 al 12 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 200.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 01:30:27'),
(538, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 01:30:33'),
(539, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Doble</b> está disponible por <b>S/ 200.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 200.00 ahora</button>', 0, '2025-07-06 01:30:58'),
(540, 8, NULL, 'Ya inicié sesion', '¡Perfecto! Ya que iniciaste sesión, la **Reserva de Habitación Doble** está disponible por **S/ 200.00**. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 200.00 ahora</button>', 0, '2025-07-06 01:31:17'),
(541, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 01:31:36'),
(542, 8, NULL, 'Quiero una habitacion simple del 2 al 16 de agosto, cuanto sale?', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 420.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 01:36:38'),
(543, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 01:36:43'),
(544, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Simple</b> está disponible por <b>S/ 420.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 420.00 ahora</button>', 0, '2025-07-06 01:36:54'),
(545, 8, NULL, 'Ya inicié sesion', '¡Perfecto! Ya que iniciaste sesión, la **Reserva de Habitación Simple** está disponible por **S/ 420.00**. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 420.00 ahora</button>', 0, '2025-07-06 01:37:03'),
(546, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 01:37:08'),
(547, 8, NULL, 'Quiero una habitacion doble del 9 al 12 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 120.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 01:49:49'),
(548, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 01:49:59'),
(549, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Doble</b> está disponible por <b>S/ 120.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 120.00 ahora</button>', 0, '2025-07-06 01:50:12'),
(550, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 01:50:15');
INSERT INTO `historial_chat` (`id`, `user_id`, `session_id`, `mensaje_usuario`, `respuesta_bot`, `visible_al_usuario`, `fecha`) VALUES
(551, 8, NULL, 'Hola quiero una habitacion doble del 12 al 14 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 80.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 02:06:00'),
(552, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 02:06:04'),
(553, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Doble</b> está disponible por <b>S/ 80.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 80.00 ahora</button>', 0, '2025-07-06 02:06:20'),
(554, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 02:06:39'),
(555, 8, NULL, 'Llevame de nuevo a la pagina, la cerre por accidente', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 02:08:08'),
(556, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 02:08:21'),
(557, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 02:10:28'),
(558, 8, NULL, 'Hola, quiero reservar una habitacion simple del 8 al 12 de julio', 'Hola Rene, tenemos disponibilidad de una habitación simple del 8 al 12 de julio por un total de 120. ¿Deseas confirmar la reserva?', 0, '2025-07-06 02:11:28'),
(559, 8, NULL, 'si', '¡Hola Rene! Entendido. Procederemos con el pago de S/ 120. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 120 ahora</button>', 0, '2025-07-06 02:11:43'),
(560, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 02:11:48'),
(561, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Simple</b> está disponible por <b>S/ 120.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 120.00 ahora</button>', 0, '2025-07-06 02:12:43'),
(562, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 02:13:18'),
(563, 8, NULL, 'Quiero una habitacion doble de 11 al 14 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 120.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 02:56:59'),
(564, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 02:57:08'),
(565, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Doble</b> está disponible por <b>S/ 120.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 120.00 ahora</button>', 0, '2025-07-06 02:57:31'),
(566, 8, NULL, 'Quiero una habitacion doble del 8 al 12 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 160.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 03:50:43'),
(567, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 03:50:49'),
(568, 8, NULL, '[Acción automática post-login]', '¡Perfecto! Ya que iniciaste sesión, la <b>Reserva de Habitación Doble</b> está disponible por <b>S/ 160.00</b>. ¿Procedemos con el pago?<br><button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 160.00 ahora</button>', 0, '2025-07-06 03:51:21'),
(569, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 03:51:25'),
(570, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 03:52:40'),
(571, 8, NULL, 'HOLA QUIERO UNA HABITACION SIMPLE DEL 23 AL 27 DE JULIO', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 120.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 04:02:24'),
(572, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 04:02:33'),
(573, 8, NULL, '[Acción automática post-login]', '', 0, '2025-07-06 04:02:52'),
(574, 8, NULL, 'Ya', '<!-- La respuesta final generada por la IA o herramientas -->', 0, '2025-07-06 04:03:35'),
(575, 8, NULL, 'Ya inicie sesion', '<!-- La respuesta final generada por la IA o herramientas -->', 0, '2025-07-06 04:03:58'),
(576, 8, NULL, 'No vep', '<!-- La respuesta final generada por la IA o herramientas -->', 0, '2025-07-06 04:20:11'),
(577, 8, NULL, 'QUe?', '<!-- La respuesta final generada por la IA o herramientas -->', 0, '2025-07-06 04:20:43'),
(578, 8, NULL, 'Cuanto?', '<!-- La respuesta final generada por la IA o herramientas -->', 0, '2025-07-06 04:21:02'),
(579, 8, NULL, '[Acción automática post-login]', '', 0, '2025-07-06 04:39:32'),
(580, 8, NULL, '[Acción automática post-login]', '', 0, '2025-07-06 04:39:37'),
(581, 8, NULL, 'Tienes alguna foto?', '¡Claro! Tenemos varias fotos. ¿Qué le gustaría ver? Por ejemplo, puedo mostrarle la fachada [IMAGEN:assets/img/galeria/fachada.jpg], el lobby [IMAGEN:assets/img/galeria/lobby.jpg], o una habitación simple [IMAGEN:assets/img/galeria/habitacion_simple.jpg], doble [IMAGEN:assets/img/galeria/habitacion_doble.jpg] o matrimonial [IMAGEN:assets/img/galeria/habitacion_matrimonial.jpg].', 0, '2025-07-06 04:39:51'),
(582, 8, NULL, 'Cuanto seria?', 'Para darle un precio necesito saber qué tipo de habitación le interesa y por cuántas noches. ¿Podría indicarme el tipo de habitación y las fechas de su estadía?', 0, '2025-07-06 04:40:04'),
(583, 8, NULL, 'Hola quiero una habitacion simple del 9 al 12 de julio?', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 90.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 04:41:25'),
(584, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 04:41:32'),
(585, 8, NULL, '[Acción automática post-login]', '', 0, '2025-07-06 04:41:57'),
(586, 8, NULL, 'Ya inicie sesion', 'Hola Rene, veo que ya has iniciado sesión. ¡Perfecto! Tenemos una habitación Simple disponible por un precio total de 90. ¿Te gustaría reservarla?', 0, '2025-07-06 04:42:14'),
(587, 8, NULL, 'Si', '¡Excelente, Rene! La Habitación Simple está disponible. El total sería de S/ 90. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 90 ahora</button>', 0, '2025-07-06 04:42:24'),
(588, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 04:42:31'),
(589, 8, NULL, '[Acción automática post-login]', '', 0, '2025-07-06 04:44:06'),
(590, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 04:44:11'),
(591, 8, NULL, '[Acción automática post-login]', '', 0, '2025-07-06 04:44:55'),
(592, 8, NULL, 'Quiero una habitación doble del 9 al 11 de julio porfavor', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 80.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 17:42:37'),
(593, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 17:42:42'),
(594, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Doble</b>. El monto total es de <b>S/ 80.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 80.00 ahora</button></div>', 0, '2025-07-06 17:42:58'),
(595, 8, NULL, 'Quiero una habitacion doble del 9 al 13 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 160.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 17:48:37'),
(596, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 17:48:42'),
(597, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Doble</b>. El monto total es de <b>S/ 160.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 160.00 ahora</button></div>', 0, '2025-07-06 17:48:57'),
(598, 8, NULL, 'Quiero una habitacion simple del 10 al 13 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 90.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 17:51:17'),
(599, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 17:51:21'),
(600, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Simple</b>. El monto total es de <b>S/ 90.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 90.00 ahora</button></div>', 0, '2025-07-06 17:51:38'),
(601, 8, NULL, 'Quiero una habitación simple del 14 al 18 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 120.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 17:55:02'),
(602, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 17:55:06'),
(603, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Simple</b>. El monto total es de <b>S/ 120.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 120.00 ahora</button></div>', 0, '2025-07-06 17:55:17'),
(604, 8, NULL, '[Internal] initiate-payment', 'Lo siento, ha ocurrido un error al procesar tu solicitud de pago. Por favor, intenta realizar la consulta de reserva de nuevo.', 0, '2025-07-06 17:55:18'),
(605, 8, NULL, '[Internal] initiate-payment', 'Lo siento, ha ocurrido un error al procesar tu solicitud de pago. Por favor, intenta realizar la consulta de reserva de nuevo.', 0, '2025-07-06 17:55:30'),
(606, 8, NULL, '[Internal] initiate-payment', 'Lo siento, ha ocurrido un error al procesar tu solicitud de pago. Por favor, intenta realizar la consulta de reserva de nuevo.', 0, '2025-07-06 17:55:36'),
(607, 8, NULL, 'QUiero una habitacion simple del 9 al 12 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 90.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 18:25:01'),
(608, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 18:25:07'),
(609, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Simple</b>. El monto total es de <b>S/ 90.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 90.00 ahora</button></div>', 0, '2025-07-06 18:25:20'),
(610, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 18:25:25'),
(611, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Simple</b>. El monto total es de <b>S/ 90.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 90.00 ahora</button></div>', 0, '2025-07-06 18:26:28'),
(612, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 18:26:29'),
(613, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Simple</b>. El monto total es de <b>S/ 90.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 90.00 ahora</button></div>', 0, '2025-07-06 18:27:06'),
(615, 8, NULL, 'Quiero una matrimonial del 12 al 16 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Matrimonial</b> disponible para ti por <b>S/ 200.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 18:33:00'),
(616, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 18:33:06'),
(617, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Matrimonial</b>. El monto total es de <b>S/ 200.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 200.00 ahora</button></div>', 0, '2025-07-06 18:33:16'),
(618, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 18:33:18'),
(619, 8, NULL, 'Quiero una habitación simple del 12 al 19 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 210.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 18:40:16'),
(620, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 18:42:50'),
(621, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Simple</b>. El monto total es de <b>S/ 210.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 210.00 ahora</button></div>', 0, '2025-07-06 18:43:01'),
(622, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 18:43:02'),
(623, 8, NULL, 'Quiero una habitacion del 9 al 12, matrimonial', 'Hola Rene, tenemos disponibilidad de una habitación matrimonial del 9 al 12. El precio total sería de 150. ¿Te gustaría reservarla?', 0, '2025-07-06 18:44:08'),
(624, 8, NULL, 'Si', '¡Excelente Rene! Procedemos con el pago. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 150 ahora</button>', 0, '2025-07-06 18:44:16'),
(625, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 18:44:21'),
(626, 8, NULL, 'Quiero una habitacion simple del 9 al 19 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 300.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 19:06:03'),
(627, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 19:06:35'),
(628, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Simple</b>. El monto total es de <b>S/ 300.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 300.00 ahora</button></div>', 0, '2025-07-06 19:06:47'),
(629, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 19:06:54'),
(630, 8, NULL, 'Quiero una habitacion del 9 al 15 de julio, simple', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 180.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 19:15:30'),
(631, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 19:15:45'),
(632, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Simple</b>. El monto total es de <b>S/ 180.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 180.00 ahora</button></div>', 0, '2025-07-06 19:15:57'),
(633, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 19:15:58'),
(634, 8, NULL, 'Quiero una habitacion doble del  9 al 19 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 400.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 19:27:28'),
(635, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 19:27:34'),
(636, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Doble</b>. El monto total es de <b>S/ 400.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 400.00 ahora</button></div>', 0, '2025-07-06 19:27:44'),
(637, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 19:27:50'),
(638, 8, NULL, 'Quiero una habitacion simple del 9 al 13 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 120.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 19:38:00'),
(639, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 19:38:05'),
(640, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Simple</b>. El monto total es de <b>S/ 120.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 120.00 ahora</button></div>', 0, '2025-07-06 19:38:20'),
(641, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 19:38:22'),
(642, 8, NULL, 'Quiero una habitacion matrimonial del 9 al 12 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Matrimonial</b> disponible para ti por <b>S/ 150.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 19:46:51'),
(643, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 19:46:55'),
(644, 8, NULL, '', '¡Hola de nuevo, RENE! Hemos recuperado tu selección de la <b>Reserva de Habitación Matrimonial</b>. El monto total es de <b>S/ 150.00</b>.<div class=\\\'mt-2\\\'><button class=\\\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\\\' data-question=\\\'[Internal] initiate-payment\\\'>Pagar S/ 150.00 ahora</button></div>', 0, '2025-07-06 19:47:05'),
(645, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 19:47:06'),
(646, 8, NULL, '', '¡Excelente, RENE! Tu reserva ha sido confirmada con éxito. 🎉<br><br>Hemos enviado un correo electrónico con todos los detalles de tu estancia.<br><br>Muchas gracias por elegir Hostal la Fé. ¡Te esperamos pronto!', 0, '2025-07-06 19:47:47'),
(647, 8, NULL, '', '¡Excelente, RENE! Tu reserva ha sido confirmada con éxito. 🎉<br><br>Hemos enviado un correo electrónico con todos los detalles de tu estancia.<br><br>Muchas gracias por elegir Hostal la Fé. ¡Te esperamos pronto!', 0, '2025-07-06 19:47:48'),
(648, 8, NULL, 'Quiero una habitacion simple del 8 al 10 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 60.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 20:17:39'),
(649, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 20:17:45'),
(650, 8, NULL, 'Quiero una habitacion doble del 12 al 19 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 280.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 20:31:19'),
(651, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 20:31:26'),
(652, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 20:32:05'),
(653, 8, NULL, 'Quiero una habitacion doble del 9 al 14 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 200.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 20:42:18'),
(654, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 20:42:23'),
(655, 8, NULL, '', '¡Bienvenido RENE! Tenemos tu reserva pendiente: <b>Reserva de Habitación Doble</b> por <b>S/ 200.00</b>.', 0, '2025-07-06 20:42:42'),
(656, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 20:42:46'),
(657, 8, NULL, '', '¡Excelente, RENE! Tu reserva ha sido confirmada con éxito. 🎉<br><br>Hemos enviado un correo electrónico con todos los detalles de tu estancia.<br><br>Muchas gracias por elegir Hostal la Fé. ¡Te esperamos pronto!', 0, '2025-07-06 20:43:30'),
(658, 14, NULL, 'Hola quisiera saber que habitaciones tienes?', 'Hola, en Hostal La Fé ofrecemos habitaciones Simple, Doble y Matrimonial. Para verificar la disponibilidad, por favor, indícame qué tipo de habitación te interesa y las fechas de inicio y fin de tu estadía.', 1, '2025-07-06 20:47:13'),
(659, 14, NULL, 'Tienes fotos?', '¡Claro! Aquí tienes algunas fotos de nuestras habitaciones:\n\n[IMAGEN:assets/img/galeria/fachada.jpg]\n[IMAGEN:assets/img/galeria/lobby.jpg]\n[IMAGEN:assets/img/galeria/habitacion_simple.jpg]\n[IMAGEN:assets/img/galeria/habitacion_doble.jpg]\n[IMAGEN:assets/img/galeria/habitacion_matrimonial.jpg]', 1, '2025-07-06 20:47:21'),
(660, 14, NULL, 'De la fachada?', '¡Claro! Aquí tienes una foto de la fachada del Hostal La Fé:\n\n[IMAGEN:assets/img/galeria/fachada.jpg]', 1, '2025-07-06 20:47:37'),
(661, 14, NULL, 'Y cuales son los precios disculpe', 'Los precios de nuestras habitaciones son:\n- Simple: S/30.00 por noche.\n- Doble: S/40.00 por noche.\n- Matrimonial: S/50.00 por noche.', 1, '2025-07-06 20:47:48'),
(662, 14, NULL, 'Genial, quisiera saber si tiene disponible una habitación doble del 9 al 13 de julio por favor', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 160.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-06 20:48:34'),
(663, 14, NULL, 'Quiero crear una cuenta', '', 0, '2025-07-06 20:48:44'),
(664, 14, NULL, '', '¡Bienvenido MICHAEL DEL PIERO! Tenemos tu reserva pendiente: <b>Reserva de Habitación Doble</b> por <b>S/ 160.00</b>.', 1, '2025-07-06 20:49:26'),
(665, 14, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 20:49:31'),
(666, 14, NULL, 'Hola que tipo de habitaciones tiene?', 'Hola! En Hostal La Fé, contamos con habitaciones Simple (S/30.00 por noche), Doble (S/40.00 por noche) y Matrimonial (S/50.00 por noche). Todas nuestras habitaciones incluyen WiFi, TV por cable y agua caliente. ¿En qué tipo de habitación está interesado?', 1, '2025-07-06 20:50:51'),
(667, 14, NULL, 'Hmm, una matrimonial del 10 al 13 de julio?', '¡Excelente elección! Hemos encontrado una <b>Habitación Matrimonial</b> disponible para ti por <b>S/ 150.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-06 20:51:10'),
(668, 14, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 20:51:21'),
(669, 14, NULL, '', '¡Bienvenido MICHAEL DEL PIERO! Tenemos tu reserva pendiente: <b>Reserva de Habitación Matrimonial</b> por <b>S/ 150.00</b>.', 1, '2025-07-06 20:51:53'),
(670, 8, NULL, 'Quisiera saber que habitaciones tienes disponibles', '¿Qué tipo de habitación le interesaría (Simple, Doble o Matrimonial) y para qué fechas (fecha de inicio y fecha de fin)?', 0, '2025-07-06 20:53:08'),
(671, 8, NULL, 'En que conociste cada una y cuanto cuesta?', 'Hola! En Hostal La Fé, contamos con habitaciones cómodas y sencillas para tu estadía en Otuzco. Ofrecemos los siguientes tipos de habitaciones:\n\n*   **Simple:** S/30.00 por noche. [IMAGEN:assets/img/galeria/habitacion_simple.jpg]\n*   **Doble:** S/40.00 por noche. [IMAGEN:assets/img/galeria/habitacion_doble.jpg]\n*   **Matrimonial:** S/50.00 por noche. [IMAGEN:assets/img/galeria/habitacion_matrimonial.jpg]\n\nTodas nuestras habitaciones incluyen WiFi, TV por cable y agua caliente. ¿Te gustaría saber la disponibilidad para alguna fecha en particular?', 0, '2025-07-06 20:53:29'),
(672, 8, NULL, 'Donde están ubicados?', 'Estamos ubicados en Calle Tacna 323, Otuzco, La Libertad.', 0, '2025-07-06 20:53:57'),
(673, 8, NULL, 'Genial, quisiera una doble del 8 al 10 de julio', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 80.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 20:54:16'),
(674, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-06 20:54:21'),
(675, 8, NULL, 'Y mi reserva?', '¡Perfecto! La Habitación Doble está disponible. El total sería de S/ 80. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 0, '2025-07-06 20:55:05'),
(676, 8, NULL, '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 0, '2025-07-06 20:55:11'),
(677, 8, NULL, 'Ya inicié sesion', '¡Hola! Como ya iniciaste sesión, la Habitación Doble está disponible. El total sería de S/ 80. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 80 ahora</button>', 0, '2025-07-06 20:55:22'),
(678, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 20:55:27'),
(679, 8, NULL, '', '¡Excelente, RENE! Tu reserva ha sido confirmada con éxito. 🎉<br><br>Hemos enviado un correo electrónico con todos los detalles de tu estancia.<br><br>Muchas gracias por elegir Hostal la Fé. ¡Te esperamos pronto!', 1, '2025-07-06 20:56:21'),
(680, 15, NULL, 'Que habitaciones tienes', 'En Hostal La Fé, contamos con habitaciones Simple, Doble y Matrimonial. La habitación Simple cuesta S/30.00 por noche, la Doble S/40.00 por noche y la Matrimonial S/50.00 por noche.', 0, '2025-07-06 20:58:25'),
(681, 15, NULL, 'Un simple del 8 al 14 de julio?', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 180.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-06 20:58:38'),
(682, 15, NULL, 'Quiero crear una cuenta', '', 0, '2025-07-06 20:58:52'),
(683, 15, NULL, '', '¡Bienvenido TANIA JOHANA! Tenemos tu reserva pendiente: <b>Reserva de Habitación Simple</b> por <b>S/ 180.00</b>.', 0, '2025-07-06 20:59:29'),
(684, 15, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-06 20:59:32'),
(685, 15, NULL, '', '¡Excelente, TANIA JOHANA! Tu reserva ha sido confirmada con éxito. 🎉<br><br>Hemos enviado un correo electrónico con todos los detalles de tu estancia.<br><br>Muchas gracias por elegir Hostal la Fé. ¡Te esperamos pronto!', 1, '2025-07-06 21:00:19'),
(686, NULL, 'anon_686b65fc3d455', 'Hola, quiero saber qué habitaciones tienes', 'Hola, para poder ayudarte necesito saber qué tipo de habitación te interesa (Simple, Doble o Matrimonial) y las fechas de inicio y fin de tu estadía.', 1, '2025-07-07 06:15:24'),
(687, NULL, 'anon_686b65fc3d455', 'Bueno, antes me gustaria saber el precio de las habitaciones y si tienes fotos de ellos tambien', '¡Hola! Claro que sí.\n\nNuestros precios base son:\n- Habitación Simple: S/30.00 por noche.\n- Habitación Doble: S/40.00 por noche.\n- Habitación Matrimonial: S/50.00 por noche.\n\nAquí tienes algunas fotos de nuestras habitaciones:\n\nHabitación Simple: [IMAGEN:assets/img/galeria/habitacion_simple.jpg]\nHabitación Doble: [IMAGEN:assets/img/galeria/habitacion_doble.jpg]\nHabitación Matrimonial: [IMAGEN:assets/img/galeria/habitacion_matrimonial.jpg]\n\n¿Te gustaría saber algo más?', 1, '2025-07-07 06:18:33'),
(688, NULL, 'anon_686b65fc3d455', 'Genial, quiero reservar una doble desde hoy hasta el martes', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 320.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-07 06:19:07'),
(689, NULL, 'anon_686b65fc3d455', 'Desde cuando hasta cuando seria?', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 40.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-07 06:20:09'),
(690, NULL, 'anon_686b65fc3d455', 'Dime las fechas para las que estas reservando', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 40.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-07 06:20:31'),
(691, NULL, 'anon_686b65fc3d455', 'No, yo quiero saber para que fechas estas dandome esa habitacion', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 40.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-07 06:20:59');
INSERT INTO `historial_chat` (`id`, `user_id`, `session_id`, `mensaje_usuario`, `respuesta_bot`, `visible_al_usuario`, `fecha`) VALUES
(692, NULL, 'anon_686b65fc3d455', 'Si no me dices, me ire de aqui', 'Para poder ayudarte con la reserva, necesito que me confirmes las fechas exactas de inicio y fin, así como el tipo de habitación que deseas.', 1, '2025-07-07 06:21:15'),
(693, NULL, 'anon_686b65fc3d455', 'Una doble, desde hoy hasta el miercoles', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 80.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-07 06:21:36'),
(694, NULL, 'anon_686b65fc3d455', 'Pero, solo para corroborar las fechas puedes decirme para que fechas haces esas reservaciones?', 'La reserva es para una habitación doble desde el 7 de julio de 2025 hasta el 9 de julio de 2025. ¿Es correcto?', 1, '2025-07-07 06:22:26'),
(695, NULL, 'anon_686b6821e4576', 'Hola, quiero saber qué habitaciones tienes.', 'Hola! En Hostal La Fé, contamos con habitaciones Simple, Doble y Matrimonial. Para verificar la disponibilidad, necesito saber qué tipo de habitación le interesa y las fechas de su estadía (fecha de inicio y fecha de fin).', 1, '2025-07-07 06:24:33'),
(696, NULL, 'anon_686b6821e4576', 'Cuales son los precios, y puedes mostrarme fotos de las habitaciones?', '¡Hola! Con gusto te doy información sobre nuestros precios y te muestro fotos de las habitaciones.\n\n- **Simple:** S/30.00 por noche. [IMAGEN:assets/img/galeria/habitacion_simple.jpg]\n- **Doble:** S/40.00 por noche. [IMAGEN:assets/img/galeria/habitacion_doble.jpg]\n- **Matrimonial:** S/50.00 por noche. [IMAGEN:assets/img/galeria/habitacion_matrimonial.jpg]\n\n¿Te interesa verificar la disponibilidad para alguna fecha en especial?', 1, '2025-07-07 06:25:21'),
(697, NULL, 'anon_686b6821e4576', 'Genial, quiero reservar una doble desde hoy hasta el martes', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 40.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-07 06:26:03'),
(698, NULL, 'anon_686b6821e4576', 'Quiero crear una cuenta', '', 0, '2025-07-07 06:26:14'),
(699, NULL, 'anon_686b6821e4576', 'Quiero crear una cuenta', '', 0, '2025-07-07 06:33:26'),
(700, 16, NULL, 'Quiero una habitacion doble desde mañana al jueves', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 80.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-07 06:36:39'),
(701, 16, NULL, 'Quiero crear una cuenta', '', 0, '2025-07-07 06:39:10'),
(702, 16, NULL, '', '¡Bienvenido MICHAEL CRISTOPHER! Tenemos tu reserva pendiente: <b>Reserva de Habitación Doble</b> por <b>S/ 80.00</b>.', 1, '2025-07-07 06:40:44'),
(703, 16, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-07 06:42:02'),
(704, 8, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-07 06:43:46'),
(705, 8, NULL, 'QUiero una habitacion doble desde hoy hasta mañana', 'Hola Rene, tenemos una habitación doble disponible desde hoy hasta mañana por un total de 40. ¿Te gustaría reservarla?', 1, '2025-07-07 06:44:19'),
(706, 8, NULL, 'So', 'Claro Rene, hemos encontrado una habitación doble disponible por 40 dólares. ¿Te gustaría reservarla?', 1, '2025-07-07 06:44:29'),
(707, 8, NULL, 'Si', '¡Perfecto, René! Tenemos una habitación doble disponible por un total de 40 euros. ¿Te gustaría reservarla?', 1, '2025-07-07 06:44:38'),
(708, 8, NULL, 'Si por favot', '¡Perfecto, René! Tenemos una habitación doble disponible por un total de 40 euros. ¿Te gustaría reservarla? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 40 ahora</button>', 1, '2025-07-07 06:44:49'),
(709, 8, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-07 07:02:04'),
(710, NULL, 'anon_686b7288e9aae', 'Cual es la capital de mongolia?', 'Mongolia no es un tema relacionado con el Hostal La Fé. Estoy aquí para ayudarte con información sobre nuestras habitaciones y servicios. ¿Te gustaría saber algo sobre nuestras habitaciones simples, dobles o matrimoniales?', 1, '2025-07-07 07:08:56'),
(711, NULL, 'anon_686b7288e9aae', 'Sabes cómo resolver una ecuación cuadratica? Necesito hacer mi tarea', 'Las ecuaciones cuadráticas no son un tema relacionado con el Hostal La Fé. Estoy aquí para ayudarte con información sobre nuestras habitaciones y servicios. ¿Te gustaría saber algo sobre nuestras habitaciones simples, dobles o matrimoniales?', 1, '2025-07-07 07:09:41'),
(712, 17, NULL, 'Hola', '¡Hola! Bienvenido al Hostal La Fé. ¿En qué puedo ayudarte hoy?', 0, '2025-07-08 23:07:39'),
(713, 17, NULL, 'Que tipo de habitaciones tienen', 'En Hostal La Fé, contamos con habitaciones Simple, Doble y Matrimonial. Cada una está equipada con WiFi, TV por cable y agua caliente. ¿Te gustaría saber algo más?', 0, '2025-07-08 23:08:33'),
(714, 17, NULL, 'Que precios tienen?', 'En Hostal La Fé, contamos con los siguientes precios por noche:\n\n*   **Simple:** S/30.00\n*   **Doble:** S/40.00\n*   **Matrimonial:** S/50.00', 0, '2025-07-08 23:09:00'),
(715, 17, NULL, 'Tienes habitaciones simples desde mañana hasta el sabado?', '¡Excelente elección! Hemos encontrado una <b>Habitación Simple</b> disponible para ti por <b>S/ 90.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 0, '2025-07-08 23:10:05'),
(716, 17, NULL, 'Quiero crear una cuenta', '', 0, '2025-07-08 23:10:41'),
(717, 17, NULL, '', '¡Bienvenido ISAI ALEXANDER! Tenemos tu reserva pendiente: <b>Reserva de Habitación Simple</b> por <b>S/ 90.00</b>.', 0, '2025-07-08 23:12:03'),
(718, 17, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-08 23:12:13'),
(719, 17, NULL, 'Quiero iniciar sesión', '', 0, '2025-07-08 23:12:36'),
(720, 17, NULL, 'Quiero continuar con la reservacion anterior', '¡Hola ISAI ALEXANDER! La Habitación Simple está disponible. El total sería de S/ 90. ¿Procedemos con el pago? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 90 ahora</button>', 0, '2025-07-08 23:13:06'),
(721, 17, NULL, '[Internal] initiate-payment', 'Lo siento, ha ocurrido un error al procesar tu solicitud de pago. Por favor, intenta realizar la consulta de reserva de nuevo.', 0, '2025-07-08 23:13:14'),
(722, 17, NULL, 'quiero una habitacion doble de mañana hasta el domingo', 'Hola Isai Alexander, tenemos disponibilidad para una habitación doble desde mañana hasta el domingo por un total de 160. ¿Deseas que la reserve a tu nombre?', 0, '2025-07-08 23:13:34'),
(723, 17, NULL, 'Si', '¡Perfecto Isai Alexander! Entonces procedemos a reservar la habitación doble a tu nombre desde mañana hasta el domingo por S/ 160. <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] initiate-payment\'>Pagar S/ 160 ahora</button>', 0, '2025-07-08 23:13:42'),
(724, 17, NULL, '[Internal] initiate-payment', '¡Perfecto! Preparando tu pago seguro. En un momento aparecerá la ventana de pago...', 0, '2025-07-08 23:13:47'),
(725, 17, NULL, '', '¡Excelente, ISAI ALEXANDER! Tu reserva ha sido confirmada con éxito. 🎉<br><br>Hemos enviado un correo electrónico con todos los detalles de tu estancia.<br><br>Muchas gracias por elegir Hostal la Fé. ¡Te esperamos pronto!', 1, '2025-07-08 23:15:00'),
(726, 18, NULL, 'Hola', '¡Hola! Bienvenido al Hostal La Fé. ¿En qué puedo ayudarte hoy?', 1, '2025-07-28 06:49:57'),
(727, NULL, 'anon_68871e463a894', 'Hola', '¡Hola! ¿En qué puedo ayudarte hoy? Ofrecemos alojamiento cómodo y sencillo en Otuzco. Contamos con habitaciones simples, dobles y matrimoniales, con WiFi, TV por cable y agua caliente.', 1, '2025-07-28 06:52:54'),
(728, NULL, 'anon_68871e463a894', 'Quiero una habitación matrimonial', '¿Para cuándo le gustaría reservar la habitación matrimonial y por cuántas noches?', 1, '2025-07-28 06:53:11'),
(729, NULL, 'anon_68871e463a894', 'Mañana', '¿Cuántas noches se quedaría en la habitación matrimonial a partir del 29 de julio?', 1, '2025-07-28 06:53:18'),
(730, NULL, 'anon_68871e463a894', '1', '¡Excelente elección! Hemos encontrado una <b>Habitación Matrimonial</b> disponible para ti por <b>S/ 50.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-28 06:53:24'),
(731, 18, NULL, 'Que tipo de habitaciones tienes?', 'En el Hostal La Fé, contamos con habitaciones Simple (S/30.00 por noche), Doble (S/40.00 por noche) y Matrimonial (S/50.00 por noche). ¿Te interesa alguna en particular?', 1, '2025-07-28 06:58:34'),
(732, 18, NULL, 'Tienes imágenes de esas?', '¡Claro! Aquí tienes algunas imágenes de nuestras habitaciones:\n\nHabitación Simple: [IMAGEN:assets/img/galeria/habitacion_simple.jpg]\nHabitación Doble: [IMAGEN:assets/img/galeria/habitacion_doble.jpg]\nHabitación Matrimonial: [IMAGEN:assets/img/galeria/habitacion_matrimonial.jpg]', 1, '2025-07-28 06:58:44'),
(733, 18, NULL, 'Tienes disponible una doble del 8 al 12 de agosto?', '¡Excelente elección! Hemos encontrado una <b>Habitación Doble</b> disponible para ti por <b>S/ 160.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-07-28 07:00:40'),
(734, 18, NULL, 'Quiero crear una cuenta', '', 0, '2025-07-28 07:00:49'),
(735, 18, NULL, '', '¡Bienvenido GERARDO ALONSO! Tenemos tu reserva pendiente: <b>Reserva de Habitación Doble</b> por <b>S/ 160.00</b>.', 1, '2025-07-28 07:01:58'),
(736, NULL, 'anon_68c84cceb6220', 'Hola', '¡Hola! Bienvenido al Hostal La Fé. ¿En qué puedo ayudarte hoy?', 1, '2025-09-15 17:28:46'),
(737, NULL, 'anon_68c84cceb6220', 'Tiene habitaciones para mi y mi esposa del 20 al 24 de setiembre?', '¡Excelente elección! Hemos encontrado una <b>Habitación Matrimonial</b> disponible para ti por <b>S/ 200.00</b>.<br><br>Para poder asegurar tu reserva, por favor, elige una opción:<div class=\'flex flex-wrap gap-2 mt-3\'><button class=\'quick-question bg-blue-100 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 px-3 py-2 rounded-full text-sm hover:bg-blue-200 dark:hover:bg-blue-900/30 transition-colors\' data-question=\'Quiero iniciar sesión\'><i class=\'fas fa-sign-in-alt mr-1\'></i> Iniciar Sesión</button><button class=\'quick-question bg-green-100 dark:bg-green-900/20 text-green-700 dark:text-green-300 px-3 py-2 rounded-full text-sm hover:bg-green-200 dark:hover:bg-green-900/30 transition-colors\' data-question=\'Quiero crear una cuenta\'><i class=\'fas fa-user-plus mr-1\'></i> Registrarme</button></div>', 1, '2025-09-15 17:29:14'),
(738, NULL, 'anon_68c84cceb6220', 'Claro, antes quisiera saber que servicios incluye y si tiene alguna imagen de la habitación', 'Nuestras habitaciones incluyen WiFi, TV por cable y agua caliente. No ofrecemos restaurante, desayuno, piscina ni ningún otro servicio. Aquí tienes una imagen de ejemplo de una habitación matrimonial: [IMAGEN:assets/img/galeria/habitacion_matrimonial.jpg]', 1, '2025-09-15 17:29:55'),
(739, NULL, 'anon_68c84cceb6220', 'Listo, perfecto, entonces como pago?', '¡Buenas noticias! La Habitación Matrimonial está disponible. El total sería de S/ 200. ¿Desea continuar? <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-09-15 17:30:17'),
(740, NULL, 'anon_68c84cceb6220', '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 0, '2025-09-15 17:30:48'),
(741, NULL, 'anon_68c84cceb6220', 'Y como inicio sesión?', 'Para iniciar sesión, puedes hacer clic en el botón \"Iniciar Sesión\" que te mostré anteriormente. Si no lo ves, puedo volver a mostrarte las opciones:\n\n¡Excelente elección! Hemos encontrado una Habitación Matrimonial disponible para ti por S/ 200.00.\n\nPara poder asegurar tu reserva, por favor, elige una opción: <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-09-15 17:32:40'),
(742, NULL, 'anon_68c84cceb6220', '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 0, '2025-09-15 17:32:48'),
(743, NULL, 'anon_68c84cceb6220', 'Pero como creo una cuenta?', '¡Entiendo! Para crear una cuenta, puedes hacer clic en el botón \"Crear Cuenta\" que te mostré anteriormente. Si no lo ves, puedo volver a mostrarte las opciones:\n\n¡Excelente elección! Hemos encontrado una Habitación Matrimonial disponible para ti por S/ 200.00.\n\nPara poder asegurar tu reserva, por favor, elige una opción: <button class=\'quick-question bg-primary-500 hover:bg-primary-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors mt-3\' data-question=\'[Internal] request-login\'>Asegurar Habitación y Pagar</button>', 1, '2025-09-15 17:33:01'),
(744, NULL, 'anon_68c84cceb6220', '[Internal] request-login', '¡Genial! Para poder asociar esta reserva a tu nombre, por favor, **inicia sesión o crea una cuenta**. No te preocupes, hemos guardado los detalles de tu elección para cuando termines.', 0, '2025-09-15 17:33:07'),
(745, NULL, 'anon_68c84cceb6220', 'Quiero crear una cuenta', '', 0, '2025-09-15 17:33:15'),
(746, NULL, 'anon_68ca18865e1ea', 'Hola', '¡Hola! ¿En qué puedo ayudarte hoy? ¿Buscas información sobre nuestras habitaciones o deseas reservar?', 1, '2025-09-17 02:10:14'),
(747, NULL, 'anon_68ca18865e1ea', 'Tienes habitaciones simples?', '¡Hola! Sí, tenemos habitaciones simples disponibles. Para verificar la disponibilidad, ¿podrías indicarme las fechas de inicio y fin de tu estadía?', 1, '2025-09-17 02:10:24'),
(748, NULL, 'anon_68ca18865e1ea', 'Tienes alguna foto?', '¡Claro! Aquí tienes una foto de la fachada principal del hostal: [IMAGEN:assets/img/galeria/fachada.jpg]', 1, '2025-09-17 02:10:33'),
(749, NULL, 'anon_68ca18865e1ea', 'De la habitacion simple?', '¡Por supuesto! Aquí tienes una foto de una de nuestras Habitaciones Simples: [IMAGEN:assets/img/galeria/habitacion_simple.jpg]', 1, '2025-09-17 02:10:42'),
(750, NULL, NULL, 'hola', 'Hola, bienvenido al Hostal La Fé. ¿En qué puedo ayudarte hoy?', 1, '2025-10-07 21:46:07'),
(751, NULL, NULL, 'que habitaciones tienes?', 'En el Hostal La Fé contamos con habitaciones Simple, Doble y Matrimonial. ¿Te interesa saber los precios de alguna en particular?', 1, '2025-10-07 21:46:17'),
(752, NULL, NULL, 'si, precios de la simple', 'El precio de la habitación Simple es de S/30.00 por noche. ¿Te puedo ayudar con algo más?', 1, '2025-10-07 21:46:28'),
(753, NULL, NULL, 'tienes la direccion del hostal?', 'La dirección del Hostal La Fé es Calle Tacna 323, Otuzco, La Libertad. ¿Hay algo más en lo que pueda ayudarte?', 1, '2025-10-07 21:46:44'),
(754, NULL, NULL, 'alguna foto para referencias?', 'No he entendido tu consulta. ¿Puedo ayudarte con información sobre nuestras habitaciones o reservas?', 1, '2025-10-07 21:46:56'),
(755, NULL, NULL, 'puedes proporcionarme una foto del hotel o sus habitaciones?', 'No he entendido tu consulta. ¿Puedo ayudarte con información sobre nuestras habitaciones o reservas?', 1, '2025-10-07 21:47:12'),
(756, NULL, NULL, '¿cómo puedo contactar al hotel?', 'Puedes contactarnos a través de los siguientes medios: Teléfono: +51 964 954 496, Correo: hlafeotuzco@gmail.com, o WhatsApp: https://wa.me/964954496. ¿En qué más puedo ayudarte?', 1, '2025-10-07 21:47:18'),
(757, NULL, NULL, '¿qué calificaciones tiene el hotel?', 'Tenemos varias opiniones de clientes: \"Todo correcto, aunque la habitación era un poco pequeña. El WiFi era estable, lo cual es importante.\", \"La habitación muy limpia y cómoda. La señal del cable podría mejorar, pero en general todo bien.\", y \"Excelente servicio, el WiFi funcionaba a la perfección y siempre hubo agua caliente. Muy recomendado.\" ¿Te gustaría saber algo más específico sobre las opiniones?', 1, '2025-10-07 21:47:24'),
(758, NULL, NULL, '¿qué tipos de habitaciones tienes?', 'Tenemos habitaciones Simple, Doble y Matrimonial. ¿Te gustaría saber los precios de cada una?', 1, '2025-10-07 21:47:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `id_pago_externo` varchar(255) DEFAULT NULL,
  `preferencia_pago_id` varchar(255) DEFAULT NULL,
  `cod_reserva` varchar(50) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `fecha_salida` date NOT NULL,
  `fecha_reserva` datetime NOT NULL DEFAULT current_timestamp(),
  `descripcion` text DEFAULT NULL,
  `estado` varchar(50) NOT NULL DEFAULT 'Pendiente de Pago',
  `metodo` varchar(50) NOT NULL,
  `id_habitacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `monto`, `id_pago_externo`, `preferencia_pago_id`, `cod_reserva`, `fecha_ingreso`, `fecha_salida`, `fecha_reserva`, `descripcion`, `estado`, `metodo`, `id_habitacion`, `id_usuario`) VALUES
(1, 640.00, 'MP-112233', NULL, 'Rsv-A1B2', '2024-07-10', '2024-07-18', '2025-06-30 12:50:25', 'Reserva cliente Juan', '1', 'Mercado Pago', 103, 2),
(2, 440.00, 'EFC-445566', NULL, 'Rsv-C3D4', '2024-07-18', '2024-07-26', '2025-06-30 12:50:25', 'Reserva en efectivo', '1', 'Efectivo', 108, 3),
(3, 855.00, 'MP-778899', NULL, 'Rsv-E5F6', '2024-07-20', '2024-07-29', '2025-06-30 12:50:25', 'Estancia larga', '1', 'Mercado Pago', 204, 5),
(4, 330.00, 'EFC-101112', NULL, 'Rsv-G7H8', '2024-07-22', '2024-07-28', '2025-06-30 12:50:25', NULL, '1', 'Efectivo', 205, 6),
(5, 760.00, 'MP-131415', NULL, 'Rsv-I9J0', '2024-07-12', '2024-07-20', '2025-06-30 12:50:25', 'Reserva para aniversario', '1', 'Mercado Pago', 403, 2),
(6, 950.00, 'EFC-161718', NULL, 'Rsv-K1L2', '2024-07-25', '2024-08-04', '2025-06-30 12:50:25', 'Vacaciones familiares', '1', 'Efectivo', 406, 3),
(7, 275.00, 'MP-192021', NULL, 'Rsv-M3N4', '2024-07-11', '2024-07-16', '2025-06-30 12:50:25', 'Viaje de negocios', '1', 'Mercado Pago', 407, 5),
(17, 240.00, NULL, '1656118711-07af8d3a-8dfa-47ff-8f77-141b9b2113d5', '', '2025-07-07', '2025-07-10', '2025-07-05 11:09:24', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 12),
(18, 240.00, NULL, '1656118711-5e13d490-b96e-4cb2-b2aa-5486b6381e7e', '', '2025-07-07', '2025-07-10', '2025-07-05 11:12:28', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 12),
(20, 110.00, NULL, '1656118711-7d6424bf-26fd-421e-9558-f64c8b52db77', '', '2025-07-18', '2025-07-20', '2025-07-05 11:25:33', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 12),
(21, 160.00, NULL, '1656118711-b0ba6b49-3f87-4c9c-b04b-43d80f43db23', '', '2025-07-19', '2025-07-23', '2025-07-05 11:31:48', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 12),
(22, 160.00, NULL, '1656118711-085be734-a456-43f5-bf87-ac7bbc7a02de', '', '2025-07-19', '2025-07-23', '2025-07-05 11:33:25', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 12),
(23, 80.00, NULL, '1656118711-5f83024e-6242-425a-89f0-d6770f8847f7', '', '2025-07-09', '2025-07-11', '2025-07-05 12:10:39', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 12),
(24, 150.00, NULL, '1656118711-d80f8171-d319-4467-b4b3-9e35041ea2af', '', '2025-07-08', '2025-07-13', '2025-07-05 12:14:57', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 12),
(25, 150.00, NULL, '1656118711-62cba07c-00ac-4ebf-862f-db6c436e4dea', '', '2025-07-08', '2025-07-13', '2025-07-05 12:20:16', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 12),
(26, 40.00, NULL, '1656118711-bc3e82f2-c235-4101-8656-d210c2b96cbc', '', '2025-07-09', '2025-07-10', '2025-07-05 12:30:24', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 12),
(27, 50.00, NULL, '1656118711-31aa3637-fad2-4d8b-9708-55860312af05', '', '2025-07-08', '2025-07-09', '2025-07-05 12:34:28', NULL, 'Pendiente de Pago', 'Mercado Pago', 106, 12),
(28, 90.00, NULL, '1656118711-5f5eeab3-1351-4b06-8874-03e74e04e633', '', '2025-07-21', '2025-07-24', '2025-07-05 12:45:28', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 12),
(29, 180.00, NULL, '1656118711-e6581c52-9ca8-40fd-a891-5817703b0c2e', '', '2025-07-09', '2025-07-15', '2025-07-05 12:50:57', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 12),
(32, 240.00, NULL, '1656118711-9052c628-f3bd-4cc2-b127-2f3b602733b6', '', '2025-07-08', '2025-07-14', '2025-07-05 16:46:20', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 12),
(33, 440.00, NULL, '1656118711-9db7b109-62ff-4e4f-b872-9f1e6a56d459', '', '2025-07-08', '2025-07-19', '2025-07-05 17:03:51', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(34, 60.00, NULL, NULL, '', '2025-07-08', '2025-07-10', '2025-07-05 17:24:19', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(35, 60.00, NULL, NULL, '', '2025-07-08', '2025-07-10', '2025-07-05 17:24:27', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(36, 60.00, NULL, NULL, '', '2025-07-08', '2025-07-10', '2025-07-05 17:24:34', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(37, 80.00, NULL, '1656118711-897bd42b-d883-46d3-8c59-e8067668daca', '', '2025-07-08', '2025-07-10', '2025-07-05 19:24:28', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(38, 160.00, NULL, '1656118711-262e3997-5765-4546-8784-4812a02e2f87', '', '2025-07-09', '2025-07-13', '2025-07-05 19:32:21', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(39, 150.00, NULL, '1656118711-4db573e6-211b-4961-828c-b53d4af7059c', '', '2025-07-07', '2025-07-12', '2025-07-05 19:48:48', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(40, 200.00, NULL, '1656118711-2596b902-edf7-4b0e-ba3f-af05e77232c0', '', '2025-07-09', '2025-07-13', '2025-07-05 19:52:52', NULL, 'Pendiente de Pago', 'Mercado Pago', 106, 8),
(41, 90.00, NULL, '1656118711-48697262-af13-4221-a77c-02d1878d4197', '', '2025-07-09', '2025-07-12', '2025-07-05 20:00:59', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(42, 240.00, NULL, '1656118711-21e57850-4d2b-4a43-b408-8883254f1c96', '', '2025-07-08', '2025-07-14', '2025-07-05 20:08:10', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(43, 90.00, NULL, '1656118711-5cd94140-b22a-4656-8288-802c8f106fdd', '', '2025-07-09', '2025-07-12', '2025-07-05 20:12:02', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(44, 120.00, NULL, '1656118711-9e8f4d65-8517-4d1b-a3a1-5ab21a4db5de', '', '2025-07-12', '2025-07-15', '2025-07-05 20:14:35', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(45, 160.00, NULL, '1656118711-159fecc9-8a4d-4e57-afca-2076e1855b59', '', '2025-07-14', '2025-07-18', '2025-07-05 20:16:39', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(46, 200.00, NULL, '1656118711-b79e306d-c664-46b3-afdd-413b9b0bac2b', '', '2025-07-07', '2025-07-12', '2025-07-05 20:31:36', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(47, 420.00, NULL, '1656118711-7a5fb477-9ad5-46a4-a233-32721914fea4', '', '2025-08-02', '2025-08-16', '2025-07-05 20:37:08', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(48, 120.00, NULL, '1656118711-d00a0c8c-5308-4acf-80fe-2a84aa2cfead', '', '2025-07-09', '2025-07-12', '2025-07-05 20:50:16', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(49, 80.00, NULL, '1656118711-c6138ff9-62f6-4321-85cf-34348c41b3f7', '', '2025-07-12', '2025-07-14', '2025-07-05 21:06:39', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(50, 80.00, NULL, '1656118711-122e07ca-22d2-4234-81cc-422613a53818', '', '2025-07-12', '2025-07-14', '2025-07-05 21:08:21', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(51, 120.00, NULL, '1656118711-512d5cb5-2f10-4a8e-9c55-731ec9c82c06', '', '2025-07-08', '2025-07-12', '2025-07-05 21:11:48', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(52, 120.00, NULL, '1656118711-4a63d813-a175-42d5-bfdb-2ed065c88fad', '', '2025-07-08', '2025-07-12', '2025-07-05 21:13:18', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(53, 160.00, NULL, '1656118711-36ae2535-a3ee-45db-8f2d-daf284a9a734', '', '2025-07-08', '2025-07-12', '2025-07-05 22:51:25', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(54, 160.00, NULL, '1656118711-94108252-fb97-4af5-a9e2-df294eb66bc5', '', '2025-07-08', '2025-07-12', '2025-07-05 22:52:41', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(55, 90.00, NULL, '1656118711-7bdb4607-fa66-421f-b5bd-177a9431a296', '', '2025-07-09', '2025-07-12', '2025-07-05 23:42:32', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(56, 90.00, NULL, '1656118711-8bbfbd7c-3107-4c84-bdb8-b860059ce57c', '', '2025-07-09', '2025-07-12', '2025-07-05 23:44:11', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(57, 90.00, NULL, '1656118711-8e17762e-9eec-4402-9d4d-2d76c6741576', '', '2025-07-09', '2025-07-12', '2025-07-06 13:25:26', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(58, 90.00, NULL, '1656118711-a456d8c0-771a-4cd1-a0d7-b48fa2ff3a3f', '', '2025-07-09', '2025-07-12', '2025-07-06 13:26:29', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(59, 200.00, NULL, '1656118711-662c0491-3169-4c01-a9a7-23d669a2d3d5', '', '2025-07-12', '2025-07-16', '2025-07-06 13:33:18', NULL, 'Pendiente de Pago', 'Mercado Pago', 106, 8),
(60, 210.00, NULL, '1656118711-108268bb-bec5-47f3-9bcb-35fb2a6ef8d5', '', '2025-07-12', '2025-07-19', '2025-07-06 13:43:03', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(61, 150.00, NULL, '1656118711-d3e1a65c-3a5f-4df0-afed-8bc1bfa8f659', '', '2025-07-09', '2025-07-12', '2025-07-06 13:44:21', NULL, 'Pendiente de Pago', 'Mercado Pago', 106, 8),
(62, 300.00, NULL, '1656118711-acd5d268-1737-49a1-a92e-b08f675f9df0', '', '2025-07-09', '2025-07-19', '2025-07-06 14:06:54', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(63, 180.00, NULL, '1656118711-207d785a-26fe-458a-bec1-cb8230f1f04a', '', '2025-07-09', '2025-07-15', '2025-07-06 14:15:58', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(64, 400.00, NULL, '1656118711-883dd3da-6089-479b-9423-96a4713ddf7e', '', '2025-07-09', '2025-07-19', '2025-07-06 14:27:50', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(65, 120.00, NULL, '1656118711-8ae56332-2f6a-44c6-ae79-a2305742e816', '', '2025-07-09', '2025-07-13', '2025-07-06 14:38:22', NULL, 'Pendiente de Pago', 'Mercado Pago', 101, 8),
(66, 150.00, '1338744045', '1656118711-ecc81183-61d2-4aa1-b54c-9c08ff1023ee', '', '2025-07-09', '2025-07-12', '2025-07-06 14:47:07', NULL, 'Confirmada', 'Mercado Pago', 106, 8),
(67, 200.00, '1338744363', '1656118711-aff34a07-e0d5-4ba7-a6e1-3d9cffea308a', '', '2025-07-09', '2025-07-14', '2025-07-06 15:42:46', NULL, 'Confirmada', 'Mercado Pago', 104, 8),
(68, 160.00, NULL, '1656118711-1c012340-1c68-4783-82f1-98745ee4fe5a', '', '2025-07-09', '2025-07-13', '2025-07-06 15:49:31', NULL, 'Pendiente de Pago', 'Mercado Pago', 105, 14),
(69, 80.00, '1338744443', '1656118711-1575d54b-9203-4195-9013-18148327c231', '', '2025-07-08', '2025-07-10', '2025-07-06 15:55:27', NULL, 'Confirmada', 'Mercado Pago', 105, 8),
(70, 180.00, '1323977180', '1656118711-fac9164d-b9fd-4325-87ed-6048e49b4d23', '', '2025-07-08', '2025-07-14', '2025-07-06 15:59:32', NULL, 'Confirmada', 'Mercado Pago', 101, 15),
(71, 80.00, NULL, '1656118711-39427203-e817-41ae-977a-15942863261a', '', '2025-07-08', '2025-07-10', '2025-07-07 01:42:02', NULL, 'Pendiente de Pago', 'Mercado Pago', 109, 16),
(72, 40.00, NULL, '1656118711-a6903fdd-bf89-4e3c-85f1-10a7fee460d1', '', '2025-07-07', '2025-07-08', '2025-07-07 02:02:05', NULL, 'Pendiente de Pago', 'Mercado Pago', 104, 8),
(73, 90.00, NULL, '1656118711-13c73b66-250d-46b1-99ba-6b001b2e808d', '', '2025-07-09', '2025-07-12', '2025-07-08 18:12:13', NULL, 'Pendiente de Pago', 'Mercado Pago', 102, 17),
(74, 160.00, '1338884243', '1656118711-c3e5b651-4def-4962-b4e4-110374db5a09', '', '2025-07-09', '2025-07-13', '2025-07-08 18:13:47', NULL, 'Confirmada', 'Mercado Pago', 109, 17);

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
(1, 'Bienvenido a Hotel de las Alturas', 'Su descanso por encima de las nubes', 'https://hotelalturas.com/habitaciones', 'slider01.jpg', 1),
(2, 'Confort y Tranquilidad Garantizada', 'Nuestras habitaciones están equipadas para su máximo confort', 'https://hotelalturas.com/servicios', 'slider02.jpg', 1),
(3, 'Reserve su Estancia Hoy', 'Aproveche nuestras tarifas especiales de temporada', 'https://hotelalturas.com/reservas', 'slider03.jpg', 1);

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
(1, NULL, 'admin001', 'Admin', 'Hotel', 'admin', 'admin@hotelalturas.com', '999888777', NULL, 'clave_segura_admin', 0, 1, NULL, 1, '2025-06-30 17:50:25', NULL, 1, NULL),
(2, '12345678A', '71558963', 'Juan', 'Pérez', 'juanp', 'juan.perez@email.com', '611223344', NULL, 'clave_juan', 0, 2, NULL, 1, '2025-06-30 17:50:25', NULL, 1, NULL),
(3, '87654321B', '45896325', 'María', 'García', 'mariag', 'maria.garcia@email.com', '622334455', NULL, 'clave_maria', 0, 2, NULL, 1, '2025-06-30 17:50:25', NULL, 1, NULL),
(4, '45678912C', '89632541', 'Carlos', 'Rodríguez', 'carlosr', 'carlos.r@email.com', '633445566', NULL, 'clave_carlos', 0, 2, NULL, 0, '2025-06-30 17:50:25', NULL, 1, NULL),
(5, '98765432D', '75321456', 'Ana', 'Martínez', 'anam', 'ana.martinez@email.com', '644556677', NULL, 'clave_ana', 0, 2, NULL, 1, '2025-06-30 17:50:25', NULL, 1, NULL),
(6, '15975324E', '95135746', 'Luis', 'Hernández', 'luish', 'luis.h@email.com', '655667788', NULL, 'clave_luis', 0, 2, NULL, 1, '2025-06-30 17:50:25', NULL, 1, NULL),
(8, NULL, '72643176', 'RENE', 'LLANQUI CALVO', 'Rene23', 'rene34r@gmail.com', NULL, NULL, '$2y$10$eqzzH0trpSh015W0QCc6mOz.Qrje1x.c0ruvB..glo6PcZ0ST6aEi', 0, 2, NULL, 1, '2025-07-01 03:19:01', NULL, 1, NULL),
(12, NULL, '72643156', 'ANA LUISA', 'RUIZ MIÑANO', 'mike21', 'mike21@gmail.com', NULL, NULL, '$2y$10$TzVqYZtM.u.rnSRJBMSxW.jOM26lBP8Nx32GLlhC1C3hef655SNyu', 0, 2, NULL, 1, '2025-07-05 16:08:40', NULL, 1, NULL),
(14, NULL, '72643188', 'MICHAEL DEL PIERO', 'ZAVALETA ESQUIVEL', 'mcris21', 'escobedomichael921@gmail.com', NULL, NULL, '$2y$10$u9IyuaZp2JE9eOCh6EUhhuC5585yt36fO5BHmLxdoKpZHMNLSl0g.', 0, 2, NULL, 1, '2025-07-06 20:49:23', NULL, 1, NULL),
(15, NULL, '72543177', 'TANIA JOHANA', 'MARTINEZ IPANAQUE', 'mcris2108', 'michaelcris2108@gmail.com', NULL, NULL, '$2y$10$mR5s2vvuqgxhWAMi6VawBObhJz4V8eaD0whNlS5aXThV5iEEpVpDm', 0, 2, NULL, 1, '2025-07-06 20:59:26', NULL, 1, NULL),
(16, NULL, '72643177', 'MICHAEL CRISTOPHER', 'ESCOBEDO AGUSTIN', 'cris21', 'michaelcristopher21@gmail.com', NULL, NULL, '$2y$10$8c8.zDC8oFtIf13M8D3clO1zyErAVAAMFrignsNE0Xp4rBlPUvbNq', 0, 2, NULL, 1, '2025-07-07 06:40:42', NULL, 1, NULL),
(17, NULL, '74154012', 'ISAI ALEXANDER', 'GARCIA SANCHEZ', 'alex', 'alex@gmail.com', NULL, NULL, '$2y$10$eOCZkdxo9fdVl8oP3k6xHO7XrXVZ.4/L8629LDviNo/5iwoIylAzC', 0, 2, NULL, 1, '2025-07-08 23:12:00', NULL, 1, NULL),
(18, NULL, '72749161', 'GERARDO ALONSO', 'UNTIVEROS SALCEDO', 'Gerardo21', 'gerar21@gmail.com', NULL, NULL, '$2y$10$8GvrDo4KXTiHN2mc4s8PZeKG.eRlYwUDQ8udMY4U61zb0QeXKiWl6', 0, 2, NULL, 1, '2025-07-28 07:01:54', NULL, 1, NULL);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_datos_usuario_usuario` (`id_usuario`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `galeria`
--
ALTER TABLE `galeria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_habitacion_categoria` (`id_categoria`);

--
-- Indices de la tabla `historial_chat`
--
ALTER TABLE `historial_chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_historial_usuario` (`user_id`),
  ADD KEY `idx_session_id` (`session_id`);

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo_unico` (`correo`),
  ADD UNIQUE KEY `usuario_unico` (`usuario`);

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
-- AUTO_INCREMENT de la tabla `datos_usuario`
--
ALTER TABLE `datos_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `galeria`
--
ALTER TABLE `galeria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=409;

--
-- AUTO_INCREMENT de la tabla `historial_chat`
--
ALTER TABLE `historial_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=759;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de la tabla `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD CONSTRAINT `calificaciones_fk_habitacion` FOREIGN KEY (`id_habitacion`) REFERENCES `habitaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `calificaciones_fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `datos_usuario`
--
ALTER TABLE `datos_usuario`
  ADD CONSTRAINT `datos_usuario_fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  ADD CONSTRAINT `fk_habitacion_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `historial_chat`
--
ALTER TABLE `historial_chat`
  ADD CONSTRAINT `historial_chat_fk_usuario` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_fk_habitacion` FOREIGN KEY (`id_habitacion`) REFERENCES `habitaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservas_fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
