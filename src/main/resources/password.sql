-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 23-08-2014 a las 11:18:07
-- Versión del servidor: 5.5.38-0ubuntu0.14.04.1
-- Versión de PHP: 5.5.9-1ubuntu4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `baloncesto`
--
CREATE DATABASE IF NOT EXISTS `proyectoJSP` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `proyectoJSP`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password`
--
CREATE TABLE IF NOT EXISTS `password` (
                                       `user` varchar(40) COLLATE utf8_spanish2_ci NOT NULL,
                                       `pass` varchar(200) COLLATE utf8_spanish2_ci NOT NULL,
                                       PRIMARY KEY (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `socio`
--
INSERT INTO `password` (`user`, `pass`) VALUES
                                    ('admin', '123456'),
                                    ('tux', 'linux'),
                                    ('usuario', 'usuario'),
                                    ('root', 'toor'),
                                    ('usuario2', '123');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;