-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-09-2026 a las 01:22:15
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
-- Base de datos: `ciencia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `avances_robotica`
--

CREATE TABLE `avances_robotica` (
  `id` int(11) NOT NULL,
  `proyecto_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `titulo` varchar(160) NOT NULL,
  `descripcion` text NOT NULL,
  `fecha_avance` date NOT NULL,
  `estado` enum('pendiente','visible','oculto') NOT NULL DEFAULT 'pendiente',
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `avances_robotica_imagenes`
--

CREATE TABLE `avances_robotica_imagenes` (
  `id` int(11) NOT NULL,
  `avance_id` int(11) NOT NULL,
  `archivo` varchar(255) NOT NULL,
  `orden` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificaciones`
--

CREATE TABLE `calificaciones` (
  `id` int(11) NOT NULL,
  `experimento_id` int(11) NOT NULL,
  `profesor_id` int(11) NOT NULL,
  `estudiante_id` int(11) NOT NULL,
  `nota` decimal(3,2) NOT NULL CHECK (`nota` between 1 and 5),
  `comentario` text NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `experimento_id` int(11) DEFAULT NULL,
  `avance_robotica_id` int(11) DEFAULT NULL,
  `comentario` text NOT NULL,
  `estado` enum('visible','pendiente','oculto') NOT NULL DEFAULT 'visible',
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id`, `usuario_id`, `experimento_id`, `avance_robotica_id`, `comentario`, `estado`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, 13, 6, NULL, 'MUY BUENO', 'visible', '2026-09-10 15:37:09', '2026-09-10 15:37:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion`
--

CREATE TABLE `configuracion` (
  `clave` varchar(60) NOT NULL,
  `valor` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracion`
--

INSERT INTO `configuracion` (`clave`, `valor`) VALUES
('mensaje_comunidad', 'Un espacio donde estudiantes y profesores convierten ideas en proyectos que inspiran.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datos_cientificos`
--

CREATE TABLE `datos_cientificos` (
  `id` int(11) NOT NULL,
  `titulo` varchar(160) NOT NULL,
  `descripcion` text NOT NULL,
  `categoria` varchar(80) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `creado_por` int(11) DEFAULT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `datos_cientificos`
--

INSERT INTO `datos_cientificos` (`id`, `titulo`, `descripcion`, `categoria`, `imagen`, `activo`, `creado_por`, `fecha_creacion`) VALUES
(1, 'Animales que sobrevivieron al espacio', 'En 2007, algunos tardígrados deshidratados sobrevivieron a la exposición al vacío del espacio. Al volver a la Tierra y recibir agua, recuperaron su actividad. Estos animales miden alrededor de un milímetro.', 'Biología', NULL, 1, NULL, '2026-09-07 13:46:46'),
(2, 'Venus cumple años antes de terminar un giro', 'Venus tarda unos 243 días terrestres en girar sobre sí mismo, pero solo 225 en dar una vuelta al Sol. ¡Completa un año antes que una rotación!', 'Astronomía', NULL, 1, NULL, '2026-09-07 13:46:46'),
(3, 'Una montaña en un terrón de azúcar', 'La materia de una estrella de neutrones es tan densa que un volumen del tamaño de un terrón de azúcar tendría una masa de alrededor de mil millones de toneladas: comparable a una montaña.', 'Astronomía', NULL, 1, NULL, '2026-09-07 13:46:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experimentos`
--

CREATE TABLE `experimentos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `titulo` varchar(160) NOT NULL,
  `categoria` varchar(80) DEFAULT NULL,
  `descripcion` text NOT NULL,
  `archivo` varchar(255) DEFAULT NULL,
  `estado` enum('borrador','pendiente','aprobado','rechazado','cambios_solicitados','oculto') NOT NULL DEFAULT 'pendiente',
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `destacado` tinyint(1) NOT NULL DEFAULT 0,
  `moderado_por` int(11) DEFAULT NULL,
  `fecha_moderacion` datetime DEFAULT NULL,
  `observacion_moderacion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `experimentos`
--

INSERT INTO `experimentos` (`id`, `usuario_id`, `titulo`, `categoria`, `descripcion`, `archivo`, `estado`, `fecha_creacion`, `fecha_actualizacion`, `destacado`, `moderado_por`, `fecha_moderacion`, `observacion_moderacion`) VALUES
(4, 6, 'AROMATIZANTE NATURAL', 'AMBIENTAL', 'HUELE NATURAL Y MUY RICO', 'exp_6a73cdbd0ece32.27074287.jpg', 'aprobado', '2026-08-05 18:56:20', '2026-09-07 13:46:45', 0, NULL, NULL, NULL),
(5, 8, 'caramelos gengi', 'salud', 'caramelos par la tos', 'exp_6a74ebfa02d308.40946771.jpg', 'aprobado', '2026-08-06 15:18:02', '2026-09-07 13:46:45', 0, NULL, NULL, NULL),
(6, 9, 'jabonBon', 'Aseo', 'jabones Caseros', 'exp_6a74f851154501.24434748.jpg', 'aprobado', '2026-08-06 16:10:41', '2026-09-07 13:46:45', 0, NULL, NULL, NULL),
(7, 13, 'esto', 'Astronomía', '...', NULL, 'aprobado', '2026-09-10 14:42:12', '2026-09-10 14:45:46', 0, 12, '2026-09-10 14:45:46', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experimento_imagenes`
--

CREATE TABLE `experimento_imagenes` (
  `id` int(11) NOT NULL,
  `experimento_id` int(11) NOT NULL,
  `archivo` varchar(255) NOT NULL,
  `orden` int(11) NOT NULL DEFAULT 0,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `experimento_imagenes`
--

INSERT INTO `experimento_imagenes` (`id`, `experimento_id`, `archivo`, `orden`, `fecha_creacion`) VALUES
(1, 4, 'exp_6a73cdbd0ece32.27074287.jpg', 0, '2026-09-07 13:46:45'),
(2, 5, 'exp_6a74ebfa02d308.40946771.jpg', 0, '2026-09-07 13:46:45'),
(3, 6, 'exp_6a74f851154501.24434748.jpg', 0, '2026-09-07 13:46:45'),
(4, 7, 'experimentos/8a37ec98cfe6587809b9525e0f5c275569057e19.webp', 1, '2026-09-10 14:42:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `usuario_id` int(11) NOT NULL,
  `experimento_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_admin`
--

CREATE TABLE `historial_admin` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `accion` varchar(120) NOT NULL,
  `usuario_afectado_id` int(11) DEFAULT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `ip` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_admin`
--

INSERT INTO `historial_admin` (`id`, `admin_id`, `accion`, `usuario_afectado_id`, `fecha`, `ip`) VALUES
(1, 2, 'Edito usuario', 7, '2026-08-06 13:56:02', '::1'),
(2, 2, 'Edito usuario', 8, '2026-08-06 15:23:48', '::1'),
(3, 7, 'Creo usuario', 9, '2026-08-06 15:26:30', '::1'),
(4, 12, 'Promoción inicial por CLI', 12, '2026-09-09 17:04:07', '127.0.0.1'),
(5, 12, 'Cuenta: administrador / activo', 11, '2026-09-10 13:24:27', '::1'),
(6, 12, 'Proyecto #7: aprobado', 13, '2026-09-10 14:45:46', '::1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_experimentos`
--

CREATE TABLE `historial_experimentos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `experimento_id` int(11) DEFAULT NULL,
  `experimento_referencia_id` int(11) DEFAULT NULL,
  `accion` varchar(120) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `ip` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_experimentos`
--

INSERT INTO `historial_experimentos` (`id`, `usuario_id`, `experimento_id`, `experimento_referencia_id`, `accion`, `fecha`, `ip`) VALUES
(1, 1, NULL, NULL, 'Creacion de experimento', '2026-08-02 20:12:49', '127.0.0.1'),
(2, 1, NULL, NULL, 'Eliminacion de experimento', '2026-08-02 20:13:04', '127.0.0.1'),
(5, 2, NULL, 1, 'Eliminacion de experimento', '2026-08-02 20:21:00', '::1'),
(6, 6, 4, 4, 'Creacion de experimento', '2026-08-05 18:56:20', '::1'),
(7, 6, 4, 4, 'Edicion de experimento', '2026-08-05 18:56:45', '::1'),
(8, 8, 5, 5, 'Creacion de experimento', '2026-08-06 15:18:02', '::1'),
(9, 9, 6, 6, 'Creacion de experimento', '2026-08-06 16:10:41', '::1'),
(10, 13, 7, 7, 'Proyecto guardado: pendiente', '2026-09-10 14:42:12', '::1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_usuarios`
--

CREATE TABLE `historial_usuarios` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `accion` varchar(120) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `ip` varchar(45) NOT NULL,
  `navegador` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_usuarios`
--

INSERT INTO `historial_usuarios` (`id`, `usuario_id`, `accion`, `fecha`, `ip`, `navegador`) VALUES
(1, 2, 'Registro', '2026-08-02 19:42:13', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(2, 2, 'Inicio de sesion', '2026-08-02 19:42:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(3, 2, 'Cierre de sesion', '2026-08-02 19:49:08', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(4, 2, 'Inicio de sesion', '2026-08-02 19:49:20', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(5, 1, 'Inicio de sesion', '2026-08-02 19:58:08', '::1', 'Mozilla/5.0 (Windows NT; Windows NT 10.0; es-CO) WindowsPowerShell/5.1.26100.8875'),
(6, 2, 'Creo experimento', '2026-08-02 19:59:10', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(7, 2, 'Cierre de sesion', '2026-08-02 19:59:24', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(8, 5, 'Registro', '2026-08-02 19:59:48', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(9, 5, 'Inicio de sesion', '2026-08-02 19:59:58', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(10, 1, 'Creo experimento', '2026-08-02 20:12:49', '127.0.0.1', 'Desconocido'),
(11, 1, 'Elimino experimento', '2026-08-02 20:13:04', '127.0.0.1', 'Desconocido'),
(12, 1, 'Creo experimento', '2026-08-02 20:13:50', '127.0.0.1', 'Desconocido'),
(13, 1, 'Elimino experimento', '2026-08-02 20:14:04', '127.0.0.1', 'Desconocido'),
(14, 5, 'Cierre de sesion', '2026-08-02 20:20:07', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(15, 2, 'Inicio de sesion', '2026-08-02 20:20:37', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(16, 2, 'Elimino experimento', '2026-08-02 20:21:00', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36'),
(17, 6, 'Registro', '2026-08-05 18:49:14', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(18, 6, 'Inicio de sesion', '2026-08-05 18:49:25', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(19, 6, 'Creo experimento', '2026-08-05 18:56:20', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(20, 6, 'Edito experimento', '2026-08-05 18:56:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(21, 2, 'Inicio de sesion', '2026-08-06 13:29:30', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(22, 2, 'Cierre de sesion', '2026-08-06 13:31:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(23, 7, 'Registro', '2026-08-06 13:32:59', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(24, 7, 'Inicio de sesion', '2026-08-06 13:33:09', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(25, 7, 'Inicio de sesion', '2026-08-06 13:44:49', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(26, 7, 'Cierre de sesion', '2026-08-06 13:54:54', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(27, 7, 'Inicio de sesion', '2026-08-06 13:55:06', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(28, 7, 'Cierre de sesion', '2026-08-06 13:55:17', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(29, 2, 'Inicio de sesion', '2026-08-06 13:55:32', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(30, 2, 'Cierre de sesion', '2026-08-06 15:13:44', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(31, 8, 'Registro', '2026-08-06 15:15:28', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(32, 8, 'Inicio de sesion', '2026-08-06 15:15:46', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(33, 8, 'Creo experimento', '2026-08-06 15:18:02', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(34, 8, 'Edicion de perfil', '2026-08-06 15:19:39', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(35, 8, 'Cambio de contrasena', '2026-08-06 15:20:29', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(36, 8, 'Cierre de sesion', '2026-08-06 15:20:36', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(37, 8, 'Inicio de sesion', '2026-08-06 15:20:53', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(38, 8, 'Cierre de sesion', '2026-08-06 15:22:39', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(39, 2, 'Inicio de sesion', '2026-08-06 15:23:00', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(40, 2, 'Cierre de sesion', '2026-08-06 15:23:51', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(41, 7, 'Inicio de sesion', '2026-08-06 15:24:40', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(42, 7, 'Cierre de sesion', '2026-08-06 15:26:51', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(43, 9, 'Inicio de sesion', '2026-08-06 15:27:07', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(44, 9, 'Creo experimento', '2026-08-06 16:10:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(45, 10, 'Registro', '2026-08-11 14:37:21', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(46, 10, 'Inicio de sesion', '2026-08-11 14:38:25', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36'),
(47, 11, 'Registro', '2026-09-08 13:33:41', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(48, 11, 'Inicio de sesion', '2026-09-08 13:33:54', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(49, 11, 'Cierre de sesion', '2026-09-08 13:58:19', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(50, 11, 'Inicio de sesion', '2026-09-09 16:40:20', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(51, 11, 'Cierre de sesion', '2026-09-09 16:49:03', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(52, 11, 'Inicio de sesion', '2026-09-09 16:51:55', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(53, 11, 'Cierre de sesion', '2026-09-09 16:57:38', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(54, 12, 'Registro', '2026-09-09 17:03:22', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(55, 12, 'Inicio de sesion', '2026-09-09 17:05:22', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(56, 12, 'Cierre de sesion', '2026-09-10 14:24:26', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(57, 13, 'Registro', '2026-09-10 14:39:38', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(58, 13, 'Inicio de sesion', '2026-09-10 14:41:01', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(59, 13, 'Cierre de sesion', '2026-09-10 14:43:08', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(60, 11, 'Inicio de sesion', '2026-09-10 14:43:25', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(61, 11, 'Cierre de sesion', '2026-09-10 14:44:55', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(62, 12, 'Inicio de sesion', '2026-09-10 14:45:24', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(63, 12, 'Cierre de sesion', '2026-09-10 14:46:51', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(64, 13, 'Inicio de sesion', '2026-09-10 14:47:14', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(65, 13, 'Cierre de sesion', '2026-09-10 16:18:45', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36'),
(66, 14, 'Registro', '2026-09-17 13:32:20', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36'),
(67, 14, 'Inicio de sesion', '2026-09-17 13:32:30', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36'),
(68, 14, 'Cierre de sesion', '2026-09-17 15:41:36', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36'),
(69, 12, 'Inicio de sesion', '2026-09-17 15:43:52', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36'),
(70, 12, 'Cierre de sesion', '2026-09-17 15:47:34', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `intentos_login`
--

CREATE TABLE `intentos_login` (
  `clave` char(64) NOT NULL,
  `intentos` int(11) NOT NULL DEFAULT 0,
  `desde` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `miembros_robotica`
--

CREATE TABLE `miembros_robotica` (
  `proyecto_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moderaciones`
--

CREATE TABLE `moderaciones` (
  `id` int(11) NOT NULL,
  `experimento_id` int(11) NOT NULL,
  `administrador_id` int(11) NOT NULL,
  `accion` varchar(30) NOT NULL,
  `observacion` text NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `moderaciones`
--

INSERT INTO `moderaciones` (`id`, `experimento_id`, `administrador_id`, `accion`, `observacion`, `fecha`) VALUES
(1, 7, 12, 'aprobado', '', '2026-09-10 14:45:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `tipo` varchar(40) NOT NULL,
  `titulo` varchar(160) NOT NULL,
  `mensaje` text NOT NULL,
  `url` varchar(255) NOT NULL,
  `leida` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificaciones`
--

INSERT INTO `notificaciones` (`id`, `usuario_id`, `tipo`, `titulo`, `mensaje`, `url`, `leida`, `fecha_creacion`) VALUES
(1, 13, 'moderacion', 'Tu proyecto: aprobado', 'esto', 'experimento.php?id=7', 0, '2026-09-10 14:45:46'),
(2, 9, 'comentario', 'Nuevo comentario', 'ester comentó tu publicación.', 'experimento.php?id=6', 0, '2026-09-10 15:37:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos_robotica`
--

CREATE TABLE `proyectos_robotica` (
  `id` int(11) NOT NULL,
  `titulo` varchar(160) NOT NULL,
  `descripcion` text NOT NULL,
  `creador_id` int(11) NOT NULL,
  `estado` enum('idea','prototipo','programacion','pruebas','terminado') NOT NULL DEFAULT 'idea',
  `moderacion` enum('pendiente','aprobado','rechazado','oculto') NOT NULL DEFAULT 'pendiente',
  `portada` varchar(255) DEFAULT NULL,
  `equipo` varchar(120) NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reconocimientos`
--

CREATE TABLE `reconocimientos` (
  `id` int(11) NOT NULL,
  `experimento_id` int(11) NOT NULL,
  `titulo` varchar(120) NOT NULL,
  `descripcion` text NOT NULL,
  `icono` varchar(20) NOT NULL DEFAULT '★',
  `fecha` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `usuario` varchar(60) NOT NULL,
  `correo` varchar(120) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` enum('estudiante','profesor','administrador','super_administrador') NOT NULL DEFAULT 'estudiante',
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo',
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp(),
  `ultimo_acceso` datetime DEFAULT NULL,
  `actualizado_en` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `avatar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `usuario`, `correo`, `contrasena`, `rol`, `estado`, `fecha_registro`, `ultimo_acceso`, `actualizado_en`, `avatar`) VALUES
(1, 'Administrador Mundo Ciencia', 'admin', 'admin@mundociencia.local', '$2y$10$ds/xlbSRgJsqQjZYyG8MJO8L.DxhEwVHV1yOSV2kdDwM6dj2ldl0O', 'administrador', 'activo', '2026-08-02 19:36:27', '2026-08-03 02:58:08', '2026-09-07 13:46:44', NULL),
(2, 'sara', 'sara1', 'riosmunoz@gmail.com', '$2y$10$m0iM30BHCO3kJ6yK7iE5fOWxKUNWKSk/LOwsl8XV5eKpXoMBZTx2i', 'administrador', 'activo', '2026-08-02 19:42:13', '2026-08-06 22:23:00', '2026-09-07 13:46:44', NULL),
(5, 'Matias', 'mati123', 'pinedamatias717@gmail.com', '$2y$10$tSCNnMkH5PKFMZJSHe6DfO2AsN3wxXvP1FWJR0M0LrEbVOejnKlz.', 'estudiante', 'activo', '2026-08-02 19:59:48', '2026-08-03 02:59:58', '2026-09-07 13:46:44', NULL),
(6, 'JUAN JOSE YARCE', 'YARCE_01', 'joseyarce4525@gmail.com', '$2y$10$XGLgjNaF/ilnVJFZv6op.uOPIh4RnCx4XZ9LFiuSSTSbGPuPHv.Ay', 'estudiante', 'activo', '2026-08-05 18:49:14', '2026-08-06 01:49:25', '2026-09-07 13:46:44', NULL),
(7, 'isabella muñoz', 'isa_01', 'munozisabella523@gmail.com', '$2y$10$McN.iKzNzGqLfaxJB8vSDuXXb5Wa2235ZgtORC/P/AyB1/K1onIPC', 'administrador', 'activo', '2026-08-06 13:32:59', '2026-08-06 22:24:40', '2026-09-07 13:46:44', NULL),
(8, 'mariana', 'mar_1', 'marianal@gmail.com', '$2y$10$UN29rAcQOMstbVAig1k3F..WIba/13l1V7KzozIT93WM26/0XaSHO', 'estudiante', 'inactivo', '2026-08-06 15:15:28', '2026-08-06 22:20:53', '2026-09-07 13:46:44', NULL),
(9, 'andres', 'nava_', 'andrenav1@gmail.com', '$2y$10$uy7QPC1sSUK438YsoM6HvuWxiCYjvz5lIEJBgdwMWTJf4qcKpbmdS', 'administrador', 'activo', '2026-08-06 15:26:30', '2026-08-06 22:27:07', '2026-09-07 13:46:44', NULL),
(10, 'mariana', 'mariana1', 'loaizamariana333@gmail.com', '$2y$10$3VSywoZNQnBlfgFptSs5geKgb02uR/gmalt8iYWA02luZ2BLvCM3u', 'estudiante', 'activo', '2026-08-11 14:37:21', '2026-08-11 21:38:25', '2026-09-07 13:46:44', NULL),
(11, 'simba', 'mar_emoto', 'sofiagiraldorestrepo993@gmail.com', '$2y$10$gsZWJmhpCiQ7J3T0xnVkl.ZI3B/zYvSfRmL1yxkwM4AO8IttOJmlq', 'administrador', 'activo', '2026-09-08 13:33:41', '2026-09-10 21:43:25', '2026-09-10 14:43:25', NULL),
(12, 'Andres Navarro', 'ONYX', 'mundociencia6@gmail.com', '$2y$10$nN5sKUX6/vdv9nYDbHGKHOu/njK7oHwrjD2U8QwZeuiCfXCkZh4Ay', 'super_administrador', 'activo', '2026-09-09 17:03:22', '2026-09-17 22:43:52', '2026-09-17 15:43:52', NULL),
(13, 'ester', 'Es4', 'hola@gmail.com', '$2y$10$R7ZRi9lHk0tHFO4V4z0cLO4mHiucdE.q1X7he6lAYWM3OjQuEzy4S', 'estudiante', 'activo', '2026-09-10 14:39:38', '2026-09-10 21:47:14', '2026-09-10 14:47:14', NULL),
(14, 'sal', 's111', 'sal@gmail.com', '$2y$10$iHruoZOa1GsfMlgbe8.QPOjc4166gb1WRJZY3d4bEWTlKVhzAzXSG', 'estudiante', 'activo', '2026-09-17 13:32:20', '2026-09-17 20:32:30', '2026-09-17 13:32:30', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `versiones_esquema`
--

CREATE TABLE `versiones_esquema` (
  `version` varchar(60) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `versiones_esquema`
--

INSERT INTO `versiones_esquema` (`version`, `fecha`) VALUES
('mundo_ciencia_v2', '2026-09-07 13:46:46');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `avances_robotica`
--
ALTER TABLE `avances_robotica`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proyecto_id` (`proyecto_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `avances_robotica_imagenes`
--
ALTER TABLE `avances_robotica_imagenes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `avance_id` (`avance_id`);

--
-- Indices de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_calificacion` (`experimento_id`,`profesor_id`),
  ADD KEY `profesor_id` (`profesor_id`),
  ADD KEY `estudiante_id` (`estudiante_id`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `experimento_id` (`experimento_id`),
  ADD KEY `avance_robotica_id` (`avance_robotica_id`),
  ADD KEY `estado` (`estado`,`fecha_creacion`);

--
-- Indices de la tabla `configuracion`
--
ALTER TABLE `configuracion`
  ADD PRIMARY KEY (`clave`);

--
-- Indices de la tabla `datos_cientificos`
--
ALTER TABLE `datos_cientificos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `titulo` (`titulo`),
  ADD KEY `creado_por` (`creado_por`);

--
-- Indices de la tabla `experimentos`
--
ALTER TABLE `experimentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_experimentos_usuario` (`usuario_id`),
  ADD KEY `fk_experimentos_moderador` (`moderado_por`),
  ADD KEY `idx_experimentos_publicos` (`estado`,`destacado`,`fecha_creacion`);

--
-- Indices de la tabla `experimento_imagenes`
--
ALTER TABLE `experimento_imagenes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_exp_archivo` (`experimento_id`,`archivo`);

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`usuario_id`,`experimento_id`),
  ADD KEY `experimento_id` (`experimento_id`);

--
-- Indices de la tabla `historial_admin`
--
ALTER TABLE `historial_admin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_historial_admin_admin` (`admin_id`),
  ADD KEY `fk_historial_admin_afectado` (`usuario_afectado_id`);

--
-- Indices de la tabla `historial_experimentos`
--
ALTER TABLE `historial_experimentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_historial_experimentos_usuario` (`usuario_id`),
  ADD KEY `fk_historial_experimentos_experimento` (`experimento_id`);

--
-- Indices de la tabla `historial_usuarios`
--
ALTER TABLE `historial_usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_historial_usuarios_usuario` (`usuario_id`);

--
-- Indices de la tabla `intentos_login`
--
ALTER TABLE `intentos_login`
  ADD PRIMARY KEY (`clave`);

--
-- Indices de la tabla `miembros_robotica`
--
ALTER TABLE `miembros_robotica`
  ADD PRIMARY KEY (`proyecto_id`,`usuario_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `moderaciones`
--
ALTER TABLE `moderaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `experimento_id` (`experimento_id`),
  ADD KEY `administrador_id` (`administrador_id`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`,`leida`,`fecha_creacion`);

--
-- Indices de la tabla `proyectos_robotica`
--
ALTER TABLE `proyectos_robotica`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creador_id` (`creador_id`),
  ADD KEY `moderacion` (`moderacion`,`fecha_creacion`);

--
-- Indices de la tabla `reconocimientos`
--
ALTER TABLE `reconocimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `experimento_id` (`experimento_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `versiones_esquema`
--
ALTER TABLE `versiones_esquema`
  ADD PRIMARY KEY (`version`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `avances_robotica`
--
ALTER TABLE `avances_robotica`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `avances_robotica_imagenes`
--
ALTER TABLE `avances_robotica_imagenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `datos_cientificos`
--
ALTER TABLE `datos_cientificos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `experimentos`
--
ALTER TABLE `experimentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `experimento_imagenes`
--
ALTER TABLE `experimento_imagenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `historial_admin`
--
ALTER TABLE `historial_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `historial_experimentos`
--
ALTER TABLE `historial_experimentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `historial_usuarios`
--
ALTER TABLE `historial_usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `moderaciones`
--
ALTER TABLE `moderaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `proyectos_robotica`
--
ALTER TABLE `proyectos_robotica`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reconocimientos`
--
ALTER TABLE `reconocimientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `avances_robotica`
--
ALTER TABLE `avances_robotica`
  ADD CONSTRAINT `avances_robotica_ibfk_1` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos_robotica` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `avances_robotica_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `avances_robotica_imagenes`
--
ALTER TABLE `avances_robotica_imagenes`
  ADD CONSTRAINT `avances_robotica_imagenes_ibfk_1` FOREIGN KEY (`avance_id`) REFERENCES `avances_robotica` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`experimento_id`) REFERENCES `experimentos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`profesor_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `calificaciones_ibfk_3` FOREIGN KEY (`estudiante_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`experimento_id`) REFERENCES `experimentos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comentarios_ibfk_3` FOREIGN KEY (`avance_robotica_id`) REFERENCES `avances_robotica` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `datos_cientificos`
--
ALTER TABLE `datos_cientificos`
  ADD CONSTRAINT `datos_cientificos_ibfk_1` FOREIGN KEY (`creado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `experimentos`
--
ALTER TABLE `experimentos`
  ADD CONSTRAINT `fk_experimentos_moderador` FOREIGN KEY (`moderado_por`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_experimentos_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `experimento_imagenes`
--
ALTER TABLE `experimento_imagenes`
  ADD CONSTRAINT `experimento_imagenes_ibfk_1` FOREIGN KEY (`experimento_id`) REFERENCES `experimentos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`experimento_id`) REFERENCES `experimentos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `historial_admin`
--
ALTER TABLE `historial_admin`
  ADD CONSTRAINT `fk_historial_admin_admin` FOREIGN KEY (`admin_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_historial_admin_afectado` FOREIGN KEY (`usuario_afectado_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `historial_experimentos`
--
ALTER TABLE `historial_experimentos`
  ADD CONSTRAINT `fk_historial_experimentos_experimento` FOREIGN KEY (`experimento_id`) REFERENCES `experimentos` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_historial_experimentos_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `historial_usuarios`
--
ALTER TABLE `historial_usuarios`
  ADD CONSTRAINT `fk_historial_usuarios_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `miembros_robotica`
--
ALTER TABLE `miembros_robotica`
  ADD CONSTRAINT `miembros_robotica_ibfk_1` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos_robotica` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `miembros_robotica_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `moderaciones`
--
ALTER TABLE `moderaciones`
  ADD CONSTRAINT `moderaciones_ibfk_1` FOREIGN KEY (`experimento_id`) REFERENCES `experimentos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `moderaciones_ibfk_2` FOREIGN KEY (`administrador_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `proyectos_robotica`
--
ALTER TABLE `proyectos_robotica`
  ADD CONSTRAINT `proyectos_robotica_ibfk_1` FOREIGN KEY (`creador_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `reconocimientos`
--
ALTER TABLE `reconocimientos`
  ADD CONSTRAINT `reconocimientos_ibfk_1` FOREIGN KEY (`experimento_id`) REFERENCES `experimentos` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
