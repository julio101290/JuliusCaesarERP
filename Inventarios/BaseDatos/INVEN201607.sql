-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 27-07-2016 a las 06:36:34
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `INVEN`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `PAC_ActualizaInventarioMaestro` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_Factura` VARCHAR(15), IN `PAR_FECHA` VARCHAR(15), IN `PAR_idBodega` BIGINT, IN `PAR_idCliente` BIGINT, IN `PAR_idFolio` BIGINT, IN `PAR_idTipoFlujo` BIGINT, IN `PAR_Observacion` VARCHAR(500))  NO SQL
UPDATE MovimientoInventario
SET
Fecha=PAR_FECHA
,idCliente=PAR_idCliente
,Observacion=PAR_Observacion
,Factura=PAR_Factura
WHERE 	EntradaSalida=PAR_EntradaSalida
	and idBodega=PAR_idBodega
    and idTipoFlujo=PAR_idTipoFlujo
    AND idFolio=PAR_idFolio$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_LeerMovimientoInventario` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_idBodega` BIGINT, IN `PAR_idTipoFlujo` BIGINT, IN `PAR_idFolio` BIGINT)  NO SQL
SELECT
	Factura
    ,Fecha
    ,idCliente
    ,Observacion
    ,'SI' as EXISTE
FROM MovimientoInventario

WHERE 	EntradaSalida=PAR_EntradaSalida
	and idBodega=PAR_idBodega
    and idTipoFlujo=PAR_idTipoFlujo
    AND idFolio=PAR_idFolio$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_UltimoFolioInventario` (IN `parTipoMovimiento` VARCHAR(15), IN `parIdFlujo` BIGINT, IN `parIdBodega` BIGINT)  NO SQL
SELECT IFNULL(max(idFolio),0)+1 as siguiente
FROM MovimientoInventario
where EntradaSalida=parTipoMovimiento
	and idTipoFlujo=parIdFlujo
    and idBodega=parIdBodega$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_EliminamovimientoInventario` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_idBodega` BIGINT, IN `PAR_idTipoFlujo` BIGINT, IN `PAR_idFolio` BIGINT)  NO SQL
DELETE
FROM MovimientoInventario

WHERE 	EntradaSalida=PAR_EntradaSalida
	and idBodega=PAR_idBodega
    and idTipoFlujo=PAR_idTipoFlujo
    AND idFolio=PAR_idFolio$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_INSERTAMOVIMIENTOINVENTARIO` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_Factura` VARCHAR(15), IN `PAR_FECHA` VARCHAR(20), IN `PAR_idBodega` BIGINT, IN `PAR_idCliente` BIGINT, IN `PAR_idFolio` BIGINT, IN `PAR_idTipoFlujo` BIGINT, IN `PAR_Observacion` VARCHAR(500))  NO SQL
INSERT INTO MovimientoInventario 
(
	EntradaSalida
    ,Factura
    ,Fecha
    ,idBodega
    ,idCliente
    ,idFolio
    ,idTipoFlujo
    ,Observacion

)
VALUES
(PAR_EntradaSalida
,PAR_Factura
,PAR_FECHA
,PAR_idBodega
,PAR_idCliente
,PAR_idFolio
,PAR_idTipoFlujo
,PAR_Observacion
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_InsertaMovimientoInventarioProducto` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_idFolio` BIGINT(15), IN `PAR_idTipoFlujo` BIGINT(15), IN `PAR_idBodega` BIGINT, IN `PAR_IdArticulo` BIGINT, IN `PAR_DescripcionArticulo` VARCHAR(500), IN `PAR_Precio` DECIMAL(18,2), IN `PAR_Cantidad` DECIMAL(24,4), IN `PAR_ImporteTotal` DECIMAL(18,2))  NO SQL
INSERT INTO inventarioProductos
(
    Cantidad
    ,Descripcion
    ,EntradaSalida
    ,idBodega
    ,idFolio
    ,idTipoFlujo
    ,Precio
    ,Producto
    ,importeTotal
    )
    VALUES
    (
    PAR_Cantidad
    ,PAR_DescripcionArticulo    
    ,PAR_EntradaSalida
    ,PAR_idBodega 
    ,PAR_idFolio  
    ,PAR_idTipoFlujo
    ,PAR_Precio  
    ,PAR_IdArticulo  
    ,PAR_ImporteTotal    
    )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_RegistraInventario` (IN `parEntradaSalida` VARCHAR(15), IN `parIdTipoFlujo` BIGINT, IN `parIdBodega` BIGINT, IN `parFolio` BIGINT, IN `parFecha` DATE, IN `parIdCliente` INT, IN `parFactura` INT, IN `parObservaciones` VARCHAR(255))  NO SQL
insert into MovimientoInventario
	(
     EntradaSalida
     ,idTipoFlujo
     ,idBodega
     ,idFolio   
     ,Fecha
     ,idCliente
     ,Factura
     ,Observacion   
    )
Values(
    parEntradaSalida
	,parIdTipoFlujo
    ,parIdBodega
    ,parFolio
    ,parFecha
    ,parIdCliente
    ,parFactura
    ,parObservaciones
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizaArticulo` (IN `parIdArticulo` MEDIUMINT, IN `pardescripcion` VARCHAR(800), IN `parTipo` VARCHAR(100), IN `parIEPS` DECIMAL(18,2), IN `parIVA` DECIMAL(18,2), IN `parPrecioCosto` DECIMAL(18,2), IN `parPrecioVenta` DECIMAL(18,2))  NO SQL
UPDATE Articulos SET
	Descripcion=pardescripcion
    ,Tipo=parTipo
    ,IEPS=parIEPS
    ,IVA=parIVA
    ,PrecioCosto=parPrecioCosto
    ,PrecioVenta=parPrecioVenta
    WHERE
    idArticulo=parIdArticulo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizaBodega` (IN `parIdBodega` BIGINT, IN `parDescripcion` VARCHAR(800))  NO SQL
update Bodegas

set Descripcion=parDescripcion

where idBodega=parIdBodega$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizaCliente` (IN `Cliente` BIGINT, IN `Nombres` VARCHAR(200), IN `Apellidos` VARCHAR(200), IN `Ciudad` VARCHAR(200), IN `Telefono` VARCHAR(200), IN `RFC` VARCHAR(200), IN `FechaNacimiento` DATE, IN `Estado` VARCHAR(200), IN `Municipio` VARCHAR(200), IN `CodigoPostal` VARCHAR(200), IN `LugarNacimiento` VARCHAR(1000), IN `Direccion` VARCHAR(1000))  MODIFIES SQL DATA
UPDATE `Clientes` SET 
`Nombres`=Nombres
,`Apellidos`=Apellidos
,`Direccion`=Direccion
,`Ciudad`=Ciudad
,`Telefono`=Telefono
,`RFC`=RFC
,`FechaNacimiento`=FechaNacimiento
,`Estado`=Estado
,`Municipio`=Municipio
,`CodigoPostal`=CodigoPostal
,`LugarNacimiento`=LugarNacimiento

WHERE idCliente=Cliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizaEstado` (IN `parEstado` BIGINT(20), IN `parPais` BIGINT(20), IN `parDescripcion` VARCHAR(800))  NO SQL
UPDATE `Estados` SET `Descripcion`=parDescripcion WHERE idPais=parPais and idEstado=parEstado$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizaPais` (IN `ParIdPais` BIGINT, `parDescripcion` VARCHAR(200))  BEGIN

	UPDATE Paises set Descripcion=parDescripcion
	where idPais=ParIdPais;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizarGrupo` (IN `parIDGrupo` BIGINT, IN `parDescripcion` VARCHAR(200), IN `parAccesoConfiguracion` BOOLEAN, IN `parAccesoGrupos` BOOLEAN, IN `parAccesoUsuarios` BOOLEAN, IN `parAccesoClientes` BOOLEAN, IN `parAccesoArticulos` BOOLEAN, IN `parAccesoInventario` BOOLEAN)  NO SQL
update GruposUsuarios 

set Descripcion=parDescripcion
	,accesoConfiguracion=parAccesoConfiguracion
    ,accesoGrupos=parAccesoGrupos
    ,accesoUsuarios=parAccesoUsuarios
    ,accesoClientes=parAccesoClientes
    ,accesoArticulos=parAccesoArticulos
    ,accesoInventario=parAccesoInventario

where idGrupoUsuario=parIDGrupo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizarUsuario` (IN `parUsuario` VARCHAR(100), IN `parContra` VARCHAR(200), IN `parGrupo` MEDIUMINT, IN `parNombre` CHAR(200))  NO SQL
update Usuarios set 
Usuario=parUsuario
,Contra=parContra
,Grupo=parGrupo
,Nombre=parNombre
where Usuario=parUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizaTipoFlujo` (IN `parIdTipoFlujo` BIGINT, IN `parDescripcion` VARCHAR(200), IN `parEntradaSalida` VARCHAR(200))  NO SQL
UPDATE TiposFlujos
set Descripcion=parDescripcion
	,EntradaSalida=parEntradaSalida
    WHERE
    idTipoFlujo=parIdTipoFlujo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_CuantosClientes` (IN `Busqueda` VARCHAR(200))  READS SQL DATA
    DETERMINISTIC
BEGIN

SELECT COUNT(*) as cuantos
FROM `INVEN`.`Clientes`
where Nombres LIKE CONCAT('%',Busqueda,'%')
	  or	Nombres LIKE CONCAT('%',Busqueda,'%')
      or	Apellidos LIKE CONCAT('%',Busqueda,'%')
      or	Direccion LIKE CONCAT('%',Busqueda,'%')
      or	Ciudad LIKE CONCAT('%',Busqueda,'%')
      or	Telefono LIKE CONCAT('%',Busqueda,'%')
      or	RFC LIKE CONCAT('%',Busqueda,'%')
      or	Estado LIKE CONCAT('%',Busqueda,'%');

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_CuantosGrupos` (IN `parBusqueda` VARCHAR(200))  NO SQL
SELECT COUNT(*) as cuantos
FROM `INVEN`.`GruposUsuarios`
where Descripcion LIKE CONCAT('%',parBusqueda,'%')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_CuantosUsuarios` (IN `parBusqueda` VARCHAR(200))  NO SQL
SELECT COUNT(*) as cuantos
FROM Usuarios
where Nombre LIKE CONCAT('%',parBusqueda,'%')
or Usuario LIKE CONCAT('%',parBusqueda,'%')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_DATOSEMPRESA` (IN `parDireccion` VARCHAR(1000), IN `parEstado` VARCHAR(1000), IN `parNombre` VARCHAR(1000), IN `parPais` VARCHAR(1000), IN `parRazonSocial` VARCHAR(1000), IN `parRFC` VARCHAR(1000), IN `parTelefono` VARCHAR(1000), IN `parCiudad` VARCHAR(1000))  MODIFIES SQL DATA
INSERT INTO DatosEmpresa (
                         Direccion
                         ,Estado
                         ,Nombre
                         ,Pais
                         ,RazonSocial
                         ,RFC
                         ,Telefono
                         ,Ciudad
                         )
                         
                         values(
                         parDireccion
                         ,parEstado
                         ,parNombre
                         ,parPais
                         ,parRazonSocial
                         ,parRFC
                         ,parTelefono
                         ,parCiudad
                         
                         )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ELIMINADATOSEMPRESA` ()  NO SQL
DELETE FROM DatosEmpresa$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EliminaEstado` (IN `parIdEstado` BIGINT, IN `parIdPais` BIGINT)  NO SQL
delete from Estados where idEstado = parIdEstado
and idPais=parIdPais$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EliminarArticulo` (IN `parIdArticulo` BIGINT)  NO SQL
DELETE from Articulos 
WHERE idArticulo=parIdArticulo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EliminarBodega` (IN `parBodega` BIGINT)  NO SQL
delete from Bodegas where idBodega=parBodega$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EliminarCliente` (IN `idCliente1` BIGINT)  NO SQL
delete 
FROM Clientes 
WHERE idCliente=idCliente1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EliminarGrupo` (IN `parIDGrupo` INT)  NO SQL
delete from GruposUsuarios where idGrupoUsuario = parIDGrupo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EliminarTipoFlujo` (IN `ParIdTipoFlujo` BIGINT)  NO SQL
delete from TiposFlujos where idTipoFlujo=ParIdTipoFlujo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EliminarUsuario` (IN `parUsuario` VARCHAR(200))  NO SQL
delete from Usuarios where usuario=parUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaArticulo` (IN `parDescripcion` VARCHAR(1000), IN `parTipo` VARCHAR(100), IN `ParIEPS` DECIMAL(18,2), IN `parIVA` DECIMAL(18,2), IN `parPrecioCosto` DECIMAL(18,2), IN `parPrecioVenta` DECIMAL(18,2))  NO SQL
INSERT INTO Articulos		
						(
                        Descripcion
                        ,Tipo
                        ,IEPS
                        ,IVA
                        ,PrecioCosto
                        ,PrecioVenta
                        )
                        VALUES
                        (
                            parDescripcion
                            ,parTipo
                            ,ParIEPS
                            ,parIVA
                            ,parPrecioCosto
                            ,parPrecioVenta
                            
                        )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaBodega` (IN `parBodega` VARCHAR(800))  NO SQL
insert into Bodegas(Descripcion)
values(parBodega)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaEmpresa` (IN `ParCiudad` VARCHAR(1000), IN `ParDireccion` VARCHAR(1000), IN `ParEstado` VARCHAR(1000), IN `ParLogo` BLOB, IN `ParNombre` VARCHAR(1000), IN `ParPais` VARCHAR(1000), IN `parRazonSocial` VARCHAR(1000), IN `parRFC` VARCHAR(1000), IN `parTelefono` VARCHAR(1000))  NO SQL
INSERT INTO DatosEmpresa
(
    Ciudad
    ,Direccion
    ,Estado
    ,Logo
    ,Nombre
    ,Pais
    ,RazonSocial
    ,RFC
    ,Telefono
)
VALUES
(
       ParCiudad
    ,ParDireccion
    ,ParEstado
    ,ParLogo
    ,ParNombre
    ,ParPais
    ,parRazonSocial
    ,parRFC
    ,parTelefono
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaEstado` (IN `parDescripcion` VARCHAR(800), IN `parPais` INT)  NO SQL
insert into Estados (Descripcion,idPais)
values (parDescripcion,parPais)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaGrupoUsuario` (IN `ParDescripcion` VARCHAR(200), IN `parAccesoConfiguracion` BOOLEAN, IN `parAccesoGrupos` BOOLEAN, IN `parAccesoUsuarios` BOOLEAN, IN `parAccesoClientes` BOOLEAN, IN `parAccesoArticulos` BOOLEAN, IN `parAccesoInventario` BOOLEAN)  NO SQL
insert into GruposUsuarios (Descripcion
                            ,accesoConfiguracion
                           	,accesoGrupos
                            ,accesoUsuarios
                            ,accesoClientes
                            ,accesoArticulos
                            ,accesoInventario
                           )
values(ParDescripcion
      ,parAccesoConfiguracion
      ,parAccesoGrupos
      ,parAccesoUsuarios 
      ,parAccesoClientes
      ,parAccesoArticulos
      ,parAccesoInventario 
      )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaPais` (IN `parDescripcion` VARCHAR(200))  NO SQL
insert into Paises (Descripcion)
values (parDescripcion)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaTipoFlujo` (IN `parDescripcion` VARCHAR(200), IN `ParEntradaSalida` VARCHAR(20))  NO SQL
insert into TiposFlujos(Descripcion,EntradaSalida) VALUES(
parDescripcion
,ParEntradaSalida

)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaUsuario` (IN `parUsuario` VARCHAR(100), IN `parContra` VARCHAR(200), IN `parGrupo` MEDIUMINT, IN `parNombre` VARCHAR(200))  NO SQL
insert into Usuarios (Usuario,Contra,Grupo,Nombre)
values(parUsuario,parContra,parGrupo,ParNombre)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeArticulo` (IN `parArticlulo` BIGINT)  NO SQL
SELECT 
	idArticulo
    ,Descripcion
    ,Tipo
    ,IVA
    ,IEPS
    ,PrecioCosto
    ,PrecioVenta
    FROM
    Articulos
    WHERE
    idArticulo=parArticlulo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeArticulos` (IN `parDesde` BIGINT, IN `parCuantos` BIGINT, IN `parBusqueda` VARCHAR(500))  READS SQL DATA
SELECT 
		idArticulo
        ,Descripcion
		,Tipo
        ,IEPS
        ,IVA
        ,PrecioCosto
        ,PrecioVenta
        FROM
        Articulos
        
        where Descripcion LIKE CONCAT('%',parBusqueda,'%')
	  	or	Tipo LIKE CONCAT('%',parBusqueda,'%')
 
limit parDesde,parCuantos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_Leebodega` (IN `parBodega` BIGINT)  NO SQL
SELECT idBodega
		,Descripcion
FROM	
	Bodegas
    WHERE
    idBodega =parBodega$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeBodegas` (IN `parDesde` INT, IN `parCuantos` INT, IN `parBusqueda` VARCHAR(800))  NO SQL
SELECT 
		idBodega
        ,Descripcion

        FROM
        Bodegas
        
        where Descripcion LIKE CONCAT('%',parBusqueda,'%')

 
limit parDesde,parCuantos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeCliente` (IN `cliente` BIGINT)  SELECT right(`Clientes`.`idCliente`,5) as idCliente,
    `Clientes`.`Nombres`,
    `Clientes`.`Apellidos`,
    `Clientes`.`Direccion`,
    `Clientes`.`Ciudad`,
    `Clientes`.`Telefono`,
    `Clientes`.`RFC`,
    `Clientes`.`FechaNacimiento`,
    `Clientes`.`Estado`,
    `Clientes`.`Municipio`,
    `Clientes`.`CodigoPostal`,
    `Clientes`.`LugarNacimiento`
FROM `INVEN`.`Clientes`
WHERE idCliente=cliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeClientes` (IN `desde` BIGINT, IN `cuantos` BIGINT, IN `Busqueda` VARCHAR(200))  READS SQL DATA
BEGIN

SELECT right(`Clientes`.`idCliente`,5) as idCliente,
    `Clientes`.`Nombres`,
    `Clientes`.`Apellidos`,
    `Clientes`.`Direccion`,
    `Clientes`.`Ciudad`,
    `Clientes`.`Telefono`,
    `Clientes`.`RFC`,
    `Clientes`.`FechaNacimiento`,
    `Clientes`.`Estado`,
    `Clientes`.`Municipio`,
    `Clientes`.`CodigoPostal`
FROM `INVEN`.`Clientes`
where Nombres LIKE CONCAT('%',Busqueda,'%')
	  or	Nombres LIKE CONCAT('%',Busqueda,'%')
      or	Apellidos LIKE CONCAT('%',Busqueda,'%')
      or	Direccion LIKE CONCAT('%',Busqueda,'%')
      or	Ciudad LIKE CONCAT('%',Busqueda,'%')
      or	Telefono LIKE CONCAT('%',Busqueda,'%')
      or	RFC LIKE CONCAT('%',Busqueda,'%')
      or	Estado LIKE CONCAT('%',Busqueda,'%')
limit desde,cuantos;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeCuantosArticulos` (IN `parBusqueda` VARCHAR(1000))  NO SQL
SELECT COUNT(*) as cuantos
FROM Articulos
where Descripcion LIKE CONCAT('%',parBusqueda,'%')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeCuantosBodegas` (IN `parBusqueda` INT)  NO SQL
SELECT COUNT(*) as cuantos
FROM Bodegas
where Descripcion LIKE CONCAT('%',parBusqueda,'%')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeCuantosEstados` (IN `parBusqueda` VARCHAR(800), IN `parIdPais` BIGINT)  NO SQL
SELECT COUNT(*) as cuantos
FROM Estados
where Descripcion LIKE CONCAT('%',parBusqueda,'%')
and idPais = parIdPais$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeCuantosPaises` (IN `parBusqueda` VARCHAR(200))  NO SQL
SELECT COUNT(*) as cuantos
FROM Usuarios
where Nombre LIKE CONCAT('%',parBusqueda,'%')
or Usuario LIKE CONCAT('%',parBusqueda,'%')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeCuantosTiposFlujos` (IN `parBusqueda` VARCHAR(200))  NO SQL
SELECT COUNT(TiposFlujos.idTipoFlujo) AS CUANTOS
	from TiposFlujos t
    
    	where TiposFlujos.Descripcion LIKE CONCAT('%',parBusqueda,'%')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LEEDATOSEMPRESA` ()  NO SQL
SELECT 
	Ciudad
    ,Direccion
    ,Estado
    ,Nombre
    ,Pais
    ,RazonSocial
    ,RFC
    ,Telefono
    FROM
    DatosEmpresa$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeEstado` (IN `parPais` BIGINT, IN `parEstado` BIGINT)  READS SQL DATA
SELECT right(a.idEstado,5) as idEstado
		,a.Descripcion
        ,(SELECT b.Descripcion from Paises  b where
          b.idPais=a.idPais) as NombrePais 
        ,right(a.idPais,4) as idPais
    
FROM Estados a
where a.idPais =parPais
and  a.idEstado =parEstado$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeEstados` (IN `parDesde` BIGINT, IN `parCuantos` BIGINT, IN `parBusqueda` VARCHAR(800), IN `parPais` BIGINT)  READS SQL DATA
SELECT idPais
		,a.idEstado
		,a.Descripcion
from Estados a
where a.Descripcion LIKE CONCAT('%',parBusqueda,'%')
		and idPais=parPais

limit parDesde,parCuantos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeGruposUsuarios` (IN `parDesde` BIGINT, IN `parCuantos` BIGINT, IN `parBusqueda` VARCHAR(200))  NO SQL
SELECT right(`GruposUsuarios`.`idGrupoUsuario`,5) as idGrupoUsuario,
    `GruposUsuarios`.`Descripcion`
   
FROM `INVEN`.`GruposUsuarios`
where Descripcion LIKE CONCAT('%',parBusqueda,'%')

limit parDesde,parCuantos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeePaises` (IN `parDesde` BIGINT, IN `parCuantos` BIGINT, IN `parBusqueda` VARCHAR(200))  NO SQL
SELECT idPais
		,a.Descripcion
from Paises a
where a.Descripcion LIKE CONCAT('%',parBusqueda,'%')


limit parDesde,parCuantos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeerArticulos` (IN `parDesde` BIGINT, IN `parCuantos` BIGINT, IN `parBusqueda` VARCHAR(800))  NO SQL
SELECT 	idArticulo
		,Descripcion
        ,Tipo
        ,IEPS
        ,IVA
        ,PrecioCosto
        ,PrecioVenta
FROM	
		Articulos
WHERE
		 Descripcion LIKE CONCAT('%',parBusqueda,'%')
	  	or	Tipo LIKE CONCAT('%',parBusqueda,'%')

limit parDesde,parCuantos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeerGrupoUsuario` (IN `parIDGrupoUsuario` BIGINT)  NO SQL
SELECT idGrupoUsuario
,Descripcion 
,accesoConfiguracion
,accesoGrupos
,accesoUsuarios
,accesoClientes
,accesoArticulos
,accesoInventario
from GruposUsuarios where idGrupoUsuario=parIDGrupoUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeerPais` (IN `parIdPais` BIGINT)  NO SQL
SELECT right(`Paises`.`idPais`,5) as idPais,
    `Paises`.`Descripcion`

FROM Paises
WHERE idPais=parIdPais$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeTipoFlujo` (IN `parTipoFlujo` BIGINT)  NO SQL
SELECT 	idTipoFlujo
		,Descripcion
		,EntradaSalida
        FROM
        TiposFlujos
        WHERE
        idTipoFlujo=parTipoFlujo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeTiposFlujos` (IN `parDesde` BIGINT, IN `parCuantos` BIGINT, IN `parBusqueda` VARCHAR(400))  NO SQL
SELECT
		idTipoFlujo
        ,Descripcion
        ,EntradaSalida
        FROM
        TiposFlujos
        WHERE
        
        Descripcion LIKE CONCAT('%',parBusqueda,'%')

 
limit parDesde,parCuantos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeUsuario` (IN `parUsuario` VARCHAR(200))  NO SQL
SELECT right(a.idUsuario,5) as idUsuario
		,a.Usuario
        ,a.Contra
        ,(SELECT b.Descripcion from GruposUsuarios b where b.IdGrupoUsuario=a.Grupo) as grupo 
        ,a.Nombre
        ,right(a.Grupo,4) as idGrupo
    
FROM Usuarios a
where a.Usuario =parUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeUsuarios` (IN `parDesde` BIGINT, IN `parCuantos` BIGINT, IN `parBusqueda` VARCHAR(200))  NO SQL
SELECT idUsuario,USUARIO,CONTRA ,(SELECT b.Descripcion from GruposUsuarios b where b.IdGrupoUsuario=a.Grupo) as grupo 
,a.Nombre
,a.idUsuario
,a.Grupo as idGrupo
from Usuarios a
where a.Usuario LIKE CONCAT('%',parBusqueda,'%')


limit parDesde,parCuantos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaCliente` (IN `Nombres` VARCHAR(200), IN `Apellidos` VARCHAR(200), IN `Direccion` VARCHAR(200), IN `Ciudad` VARCHAR(200), IN `Telefono` VARCHAR(200), IN `RFC` VARCHAR(10), IN `FechaNacimiento` VARCHAR(200), IN `Estado` VARCHAR(200), IN `Municipio` VARCHAR(200), IN `CodigoPostal` VARCHAR(200), IN `LugarNacimiento` VARCHAR(1000))  BEGIN
 
    INSERT INTO `Clientes`
    (
    `Nombres`,
    `Apellidos`,
    `Direccion`,
    `Ciudad`,
    `Telefono`,
    `RFC`,
    `FechaNacimiento`,
    `Estado`,
    `Municipio`,
    `CodigoPostal`,
    `LugarNacimiento`
        )
    VALUES
    (
    Nombres,
    Apellidos,
    Direccion,
    ciudad,
    Telefono,
    RFC,
    FechaNacimiento,
    Estado,
    Municipio,
    CodigoPostal,
    LugarNacimiento
    );
 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Articulos`
--

CREATE TABLE `Articulos` (
  `idArticulo` bigint(20) NOT NULL,
  `Descripcion` varchar(1000) NOT NULL,
  `Tipo` varchar(100) NOT NULL,
  `PrecioCosto` decimal(18,2) NOT NULL,
  `PrecioVenta` decimal(18,2) NOT NULL,
  `IVA` double NOT NULL,
  `IEPS` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Articulos`
--

INSERT INTO `Articulos` (`idArticulo`, `Descripcion`, `Tipo`, `PrecioCosto`, `PrecioVenta`, `IVA`, `IEPS`) VALUES
(1, 'Prueba1', 'Producto', '5.00', '10.00', 6, 16),
(2, 'Manzanas', 'Producto', '10.00', '20.00', 12, 12),
(3, 'peras', 'Producto', '1.00', '2.00', 2, 1),
(4, 'Platanos', 'Producto', '3.00', '4.00', 2, 3),
(5, 'Guayabas', 'Producto', '1.00', '2.00', 3, 4),
(6, 'Jicama', 'Producto', '2.00', '3.00', 43, 32);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Bodegas`
--

CREATE TABLE `Bodegas` (
  `idBodega` bigint(20) UNSIGNED NOT NULL,
  `Descripcion` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Bodegas`
--

INSERT INTO `Bodegas` (`idBodega`, `Descripcion`) VALUES
(2, 'Guasave'),
(3, 'Mochis');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Clientes`
--

CREATE TABLE `Clientes` (
  `idCliente` bigint(20) UNSIGNED ZEROFILL NOT NULL,
  `Nombres` varchar(100) DEFAULT NULL,
  `Apellidos` varchar(45) DEFAULT NULL,
  `Direccion` varchar(45) DEFAULT NULL,
  `Ciudad` varchar(45) DEFAULT NULL,
  `Telefono` varchar(45) DEFAULT NULL,
  `RFC` varchar(45) DEFAULT NULL,
  `FechaNacimiento` date DEFAULT NULL,
  `Estado` varchar(45) DEFAULT NULL,
  `Municipio` varchar(45) DEFAULT NULL,
  `CodigoPostal` varchar(45) DEFAULT NULL,
  `LugarNacimiento` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Clientes`
--

INSERT INTO `Clientes` (`idCliente`, `Nombres`, `Apellidos`, `Direccion`, `Ciudad`, `Telefono`, `RFC`, `FechaNacimiento`, `Estado`, `Municipio`, `CodigoPostal`, `LugarNacimiento`) VALUES
(00000000000000000008, 'cesar', 'julio', 'as', 's', 's', 'asd', '2015-01-01', 's', 's', 's', '0'),
(00000000000000000017, 'cesar', 'julio', 'as', 's', 's', 'asd', '2015-01-01', '', '', '', ''),
(00000000000000000020, 'cesar', 'julio', 'as', 's', 's', 'asd', '2015-01-01', 's', 's', 's', '0'),
(00000000000000000022, 'cesar', 'julio', 'as', 's', 's', 'asd', '2015-01-01', 's', 's', 's', '0'),
(00000000000000000023, 'cesar', 'julio', 'as', 's', 's', 'asd', '2015-01-01', 's', 's', 's', '0'),
(00000000000000000024, 'cesar', 'julio', 'as', 's', 's', 'asd', '2015-01-01', 's', 's', 's', '0'),
(00000000000000000025, 'cesar', 'julio', 'as', 's', 's', 'asd', '2015-01-01', 's', 's', 's', '0'),
(00000000000000000026, 'cesar', 'julio', 'as', 's', 's', 'asd', '2015-01-01', 's', 's', 's', '0'),
(00000000000000000027, 'cesar', 'julio', 'as', 's', 's', 'asd', '2015-01-01', 's', 's', 's', '0'),
(00000000000000000028, 'cesar', 'julio', 'as', 's', 's', 'asd', '2015-01-01', 's', 's', 's', '0'),
(00000000000000000029, 'cesar', 'julio', 'as', 's', 's', 'asd', '2015-01-01', 's', 's', 's', '0'),
(00000000000000000030, 'cesar', 'julio', 'as', 's', 's', 'asd', '2015-01-01', 's', 's', '0', 'Los Mochis'),
(00000000000000000034, 'Mariela', 'Salomon', 'Domicilio', 'jjr', '0000000', 'RFC', '1990-07-27', '', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DatosEmpresa`
--

CREATE TABLE `DatosEmpresa` (
  `Nombre` varchar(800) NOT NULL,
  `RazonSocial` varchar(800) NOT NULL,
  `RFC` varchar(15) NOT NULL,
  `Telefono` varchar(100) NOT NULL,
  `Direccion` varchar(1000) NOT NULL,
  `Ciudad` varchar(800) NOT NULL,
  `Pais` varchar(800) NOT NULL,
  `Estado` varchar(800) NOT NULL,
  `Logo` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `DatosEmpresa`
--

INSERT INTO `DatosEmpresa` (`Nombre`, `RazonSocial`, `RFC`, `Telefono`, `Direccion`, `Ciudad`, `Pais`, `Estado`, `Logo`) VALUES
('NOMBRE', 'RAZON SOCIAL', 'RFC', 'TELEFONO', 'DIRECCION', 'CIUDAD', '0001 MEXICO', '0001 CHIHUAHUA', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Estados`
--

CREATE TABLE `Estados` (
  `idPais` bigint(20) UNSIGNED NOT NULL,
  `idEstado` bigint(20) NOT NULL,
  `Descripcion` varchar(800) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Estados`
--

INSERT INTO `Estados` (`idPais`, `idEstado`, `Descripcion`) VALUES
(1, 1, 'CHIHUAHUA'),
(2, 3, 'NUEVO MEXICO'),
(2, 4, 'TEXAS'),
(1, 6, 'SINALOA'),
(1, 7, 'NAYARIT'),
(1, 8, 'SONORA'),
(1, 9, 'DURANGO'),
(2, 13, 'FLORIDA'),
(1, 14, 'BAJA CALIFORNIA SUR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `GruposUsuarios`
--

CREATE TABLE `GruposUsuarios` (
  `IdGrupoUsuario` bigint(20) UNSIGNED NOT NULL,
  `Descripcion` varchar(200) NOT NULL,
  `accesoUsuarios` tinyint(1) DEFAULT '0',
  `accesoGrupos` tinyint(1) DEFAULT '0',
  `accesoClientes` tinyint(1) DEFAULT '0',
  `accesoArticulos` tinyint(1) DEFAULT '0',
  `accesoConfiguracion` tinyint(1) DEFAULT '0',
  `accesoInventario` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `GruposUsuarios`
--

INSERT INTO `GruposUsuarios` (`IdGrupoUsuario`, `Descripcion`, `accesoUsuarios`, `accesoGrupos`, `accesoClientes`, `accesoArticulos`, `accesoConfiguracion`, `accesoInventario`) VALUES
(2, 'PRUEBAS', 1, 1, 1, 1, 1, 1),
(9, 'Administrador', 0, 0, 0, 0, 0, 0),
(10, 'Supervisor', 1, 1, 1, 1, 1, 1),
(11, 'Desarrollador', 1, 0, 0, 0, 0, 1),
(12, 'Inventario', 1, 0, 0, 0, 0, 1),
(21, 's', 1, 1, 1, 1, 1, 1),
(22, '1', 0, 0, 0, 0, 1, 0),
(23, '2', 0, 1, 0, 0, 0, 0),
(24, '3', 1, 0, 0, 0, 0, 0),
(25, '4', 0, 0, 1, 0, 0, 0),
(26, '5', 0, 0, 0, 1, 0, 0),
(27, '6', 0, 0, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventarioProductos`
--

CREATE TABLE `inventarioProductos` (
  `EntradaSalida` varchar(15) NOT NULL,
  `idTipoFlujo` bigint(20) NOT NULL,
  `idBodega` bigint(20) NOT NULL,
  `idFolio` bigint(20) NOT NULL,
  `Producto` bigint(20) NOT NULL,
  `Descripcion` varchar(500) NOT NULL,
  `Cantidad` decimal(24,4) NOT NULL,
  `Precio` decimal(18,2) NOT NULL,
  `ImporteTotal` decimal(18,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `inventarioProductos`
--

INSERT INTO `inventarioProductos` (`EntradaSalida`, `idTipoFlujo`, `idBodega`, `idFolio`, `Producto`, `Descripcion`, `Cantidad`, `Precio`, `ImporteTotal`) VALUES
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, 'descripcion', '1.0000', '2.00', '2.00'),
('Entrada', 4, 2, 1, 1, '2', '3.0000', '4.00', '5.00'),
('Entrada', 4, 2, 1, 1, '2', '3.0000', '4.00', '5.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `MovimientoInventario`
--

CREATE TABLE `MovimientoInventario` (
  `EntradaSalida` varchar(15) NOT NULL,
  `idTipoFlujo` bigint(20) NOT NULL,
  `idBodega` bigint(20) NOT NULL,
  `idFolio` bigint(20) UNSIGNED NOT NULL,
  `Fecha` date NOT NULL,
  `idCliente` bigint(20) NOT NULL,
  `Factura` varchar(20) NOT NULL,
  `Observacion` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `MovimientoInventario`
--

INSERT INTO `MovimientoInventario` (`EntradaSalida`, `idTipoFlujo`, `idBodega`, `idFolio`, `Fecha`, `idCliente`, `Factura`, `Observacion`) VALUES
('Entrada', 4, 2, 1, '2016-07-01', 20, 'factura', 'Observacion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Paises`
--

CREATE TABLE `Paises` (
  `idPais` bigint(20) UNSIGNED NOT NULL,
  `Descripcion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Paises`
--

INSERT INTO `Paises` (`idPais`, `Descripcion`) VALUES
(1, 'MEXICO'),
(2, 'Estados Unidos Americanos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `TiposFlujos`
--

CREATE TABLE `TiposFlujos` (
  `idTipoFlujo` bigint(20) NOT NULL,
  `Descripcion` varchar(200) NOT NULL,
  `EntradaSalida` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `TiposFlujos`
--

INSERT INTO `TiposFlujos` (`idTipoFlujo`, `Descripcion`, `EntradaSalida`) VALUES
(3, 'SALIDA POR VENTA', 'Salida'),
(4, 'ENTRADA POR COMPRA', 'Entrada'),
(5, 'Entrada por devolucion', 'Entrada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Usuarios`
--

CREATE TABLE `Usuarios` (
  `idUsuario` bigint(20) UNSIGNED NOT NULL,
  `Usuario` varchar(300) NOT NULL,
  `Contra` varchar(300) NOT NULL,
  `Grupo` mediumint(9) NOT NULL,
  `Nombre` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Usuarios`
--

INSERT INTO `Usuarios` (`idUsuario`, `Usuario`, `Contra`, `Grupo`, `Nombre`) VALUES
(1, 'Julio', 'Cesar', 2, 'adas'),
(3, 'asad', '123', 10, 'asad'),
(4, '123', '123', 13, '123'),
(5, '1231', '123', 2, '1231'),
(9, '123123', '12312', 12, '123123'),
(10, '12312', '123', 12, '12312'),
(11, 'asd', 'asd', 12, 'asd'),
(12, '', '', 2, '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Articulos`
--
ALTER TABLE `Articulos`
  ADD PRIMARY KEY (`idArticulo`);

--
-- Indices de la tabla `Bodegas`
--
ALTER TABLE `Bodegas`
  ADD PRIMARY KEY (`idBodega`);

--
-- Indices de la tabla `Clientes`
--
ALTER TABLE `Clientes`
  ADD UNIQUE KEY `idCliente` (`idCliente`);

--
-- Indices de la tabla `Estados`
--
ALTER TABLE `Estados`
  ADD UNIQUE KEY `Estado` (`idEstado`);

--
-- Indices de la tabla `GruposUsuarios`
--
ALTER TABLE `GruposUsuarios`
  ADD PRIMARY KEY (`IdGrupoUsuario`);

--
-- Indices de la tabla `MovimientoInventario`
--
ALTER TABLE `MovimientoInventario`
  ADD PRIMARY KEY (`EntradaSalida`,`idTipoFlujo`,`idBodega`),
  ADD KEY `EntradaSalida` (`EntradaSalida`,`idTipoFlujo`,`idBodega`);

--
-- Indices de la tabla `Paises`
--
ALTER TABLE `Paises`
  ADD PRIMARY KEY (`idPais`);

--
-- Indices de la tabla `TiposFlujos`
--
ALTER TABLE `TiposFlujos`
  ADD PRIMARY KEY (`idTipoFlujo`);

--
-- Indices de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `Usuario` (`Usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Articulos`
--
ALTER TABLE `Articulos`
  MODIFY `idArticulo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `Bodegas`
--
ALTER TABLE `Bodegas`
  MODIFY `idBodega` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `Clientes`
--
ALTER TABLE `Clientes`
  MODIFY `idCliente` bigint(20) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT de la tabla `Estados`
--
ALTER TABLE `Estados`
  MODIFY `idEstado` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT de la tabla `GruposUsuarios`
--
ALTER TABLE `GruposUsuarios`
  MODIFY `IdGrupoUsuario` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT de la tabla `Paises`
--
ALTER TABLE `Paises`
  MODIFY `idPais` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `TiposFlujos`
--
ALTER TABLE `TiposFlujos`
  MODIFY `idTipoFlujo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  MODIFY `idUsuario` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
