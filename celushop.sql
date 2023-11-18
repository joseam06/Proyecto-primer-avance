-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-11-2023 a las 02:37:54
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `celushop`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarProducto` (IN `id_producto` INT, IN `Nombre` VARCHAR(255), IN `Descripcion` VARCHAR(255), IN `Precio` DECIMAL(10,2), IN `img` VARCHAR(255))   BEGIN
    INSERT INTO Productos(id_producto, Nombre, Descripcion, Precio, img) VALUES (id_producto, Nombre, Descripcion, Precio, img);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarUsuario` (IN `nombre_usuario` VARCHAR(255), IN `Email` VARCHAR(255), IN `Contraseña` VARCHAR(255))   BEGIN
    INSERT INTO Usuarios(nombre_usuario, Email, Contraseña) VALUES (nombre_usuario, Email, Contraseña);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Insertar_orden_compra` (IN `nombre_usuario` VARCHAR(255), IN `id_producto` INT)   BEGIN
    INSERT INTO orden_compra(nombre_usuario, id_producto) VALUES (nombre_usuario, id_producto);
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `TotalOrdenes_compra` () RETURNS INT(11)  BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM orden_compra;
    RETURN total;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `TotalProductos` () RETURNS INT(11)  BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Productos;
    RETURN total;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `TotalUsuarios` () RETURNS INT(11)  BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Usuarios;
    RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(50) NOT NULL,
  `id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `nombre_categoria`, `id_producto`) VALUES
(11, 'Android', 1),
(22, 'Android', 2),
(33, 'Iphone', 3),
(44, 'Android', 4),
(55, 'Android', 5),
(66, 'Android', 6),
(77, 'Android', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_compra`
--

CREATE TABLE `detalles_compra` (
  `id_detallles_compra` int(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_total` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles_compra`
--

INSERT INTO `detalles_compra` (`id_detallles_compra`, `nombre_usuario`, `id_producto`, `cantidad`, `precio_total`) VALUES
(1, 'juanp1', 1, 1, 900000),
(2, 'luisf2', 2, 3, 7800000),
(3, 'josem3', 3, 2, 7000000),
(4, 'miguel4', 4, 1, 1600000),
(5, 'fernando5', 5, 4, 3000000),
(6, 'andres6', 6, 2, 3400000),
(7, 'diomedes', 7, 1, 800000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_compra`
--

CREATE TABLE `orden_compra` (
  `id_orden_compra` int(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `orden_compra`
--

INSERT INTO `orden_compra` (`id_orden_compra`, `nombre_usuario`, `id_producto`) VALUES
(1, 'juanp1', 1),
(2, 'luisf2', 2),
(3, 'josem3', 3),
(4, 'miguel4', 4),
(5, 'fernando5', 5),
(6, 'andres6', 6),
(7, 'diomedes', 7);

--
-- Disparadores `orden_compra`
--
DELIMITER $$
CREATE TRIGGER `Nueva_orden_compra` AFTER INSERT ON `orden_compra` FOR EACH ROW BEGIN
    INSERT INTO LogOrden_compra VALUES (NEW.nombre_usuario, NEW.id_producto, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `precio` int(11) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `img` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `precio`, `descripcion`, `img`) VALUES
(1, 'Xiaomi Redmi 12 Azul', 900000, '8GB RAM, 256GB Almacenamiento', 'https://raw.githubusercontent.com/joseam06/Proyecto-Base-de-datos/44d86709b1362235fdc58f7c5b5be907106dae80/Celular-Xiaomi-Redmi-12-Azul-1.png\r\n'),
(2, 'Samsung Galaxy S20 FE Violeta', 2600000, '8GB RAM, 256GB Almacenamiento', 'https://raw.githubusercontent.com/joseam06/Proyecto-Base-de-datos/44d86709b1362235fdc58f7c5b5be907106dae80/Samsung%20S20%20FE.png\r\n'),
(3, 'iPhone 14 Pro Max Morado', 3500000, '6GB RAM, 256GB Almacenamiento', 'https://raw.githubusercontent.com/joseam06/Proyecto-Base-de-datos/44d86709b1362235fdc58f7c5b5be907106dae80/Iphone%2014%20Pro%20Max%20Morado.png\r\n'),
(4, 'Realme GT Neo 2 Verde', 1600000, '6GB RAM, 128GB Almacenamiento', 'https://raw.githubusercontent.com/joseam06/Proyecto-Base-de-datos/44d86709b1362235fdc58f7c5b5be907106dae80/Realme%20GT%20Neo%202.png\r\n'),
(5, 'Motorola G31 Azul', 750000, '3GB RAM, 128GB Almacenamiento', 'https://raw.githubusercontent.com/joseam06/Proyecto-Base-de-datos/44d86709b1362235fdc58f7c5b5be907106dae80/Motorola%20G31%20Azul.png'),
(6, 'Oppo Reno 7 Azul', 1700000, '8GB RAM, 256GB Almacenamiento', 'https://raw.githubusercontent.com/joseam06/Proyecto-Base-de-datos/44d86709b1362235fdc58f7c5b5be907106dae80/Oppo%20Reno%207%20Azul.png'),
(7, 'Nokia 1100', 800000, '4GB de Ram 128 de Almacenamiento', 'https://nokiaimagen.com');

--
-- Disparadores `productos`
--
DELIMITER $$
CREATE TRIGGER `Nuevo_producto` AFTER INSERT ON `productos` FOR EACH ROW BEGIN
    INSERT INTO LogProductos VALUES (NEW.Nombre, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `nombre_usuario` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`nombre_usuario`, `email`, `contraseña`) VALUES
('andres6', 'andres6@correo.com', 'andres123'),
('diomedes', 'diomedes@correo.com', 'diomedes123'),
('fernando5', 'fernando5@correo.com', 'fernando123'),
('josem3', 'josem3@correo.com', 'jose123'),
('juanp1', 'juanp@correo.com', 'juan123'),
('luisf2', 'luisf2@correo.com', 'luis123'),
('miguel4', 'miguel4@correo.com', 'miguel123');

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `Nuevo_usuario` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
    INSERT INTO LogUsuarios VALUES (NEW.nombre_usuario, NOW());
END
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `detalles_compra`
--
ALTER TABLE `detalles_compra`
  ADD PRIMARY KEY (`id_detallles_compra`),
  ADD KEY `nombre_usuario` (`nombre_usuario`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `orden_compra`
--
ALTER TABLE `orden_compra`
  ADD PRIMARY KEY (`id_orden_compra`),
  ADD KEY `nombre_usuario` (`nombre_usuario`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`nombre_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `detalles_compra`
--
ALTER TABLE `detalles_compra`
  MODIFY `id_detallles_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `orden_compra`
--
ALTER TABLE `orden_compra`
  MODIFY `id_orden_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD CONSTRAINT `categoria_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `detalles_compra`
--
ALTER TABLE `detalles_compra`
  ADD CONSTRAINT `detalles_compra_ibfk_1` FOREIGN KEY (`nombre_usuario`) REFERENCES `usuarios` (`nombre_usuario`),
  ADD CONSTRAINT `detalles_compra_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `orden_compra`
--
ALTER TABLE `orden_compra`
  ADD CONSTRAINT `orden_compra_ibfk_1` FOREIGN KEY (`nombre_usuario`) REFERENCES `usuarios` (`nombre_usuario`),
  ADD CONSTRAINT `orden_compra_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
