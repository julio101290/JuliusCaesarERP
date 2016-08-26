-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-08-2016 a las 12:05:37
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tienda`
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_InformeExistencias` ()  NO SQL
select
    ifnull((select sum(x.Cantidad)
        from inventarios x
        where x.EntradaSalida='Entrada' 
        	                                                      and x.Producto=a.Producto
             group by x.Producto
            
           ),0) -
            
          ifnull( (select sum(x.Cantidad)
        from inventarios x
        where x.EntradaSalida='Salida' 
        	                                                          and x.Producto=a.Producto
             group by x.Producto 
                   
                  ),0)
             as EXISTENCIA
        ,a.Producto
        ,(select x.Descripcion from articulos x where x.idArticulo=a.Producto)as Descripcion
        ,(SELECT Logo FROM datosempresa) as logo
        FROM
        inventarios a
group by a.Producto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_LeeInventariosProductos` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_idBodega` BIGINT, IN `PAR_idTipoFlujo` BIGINT, IN `PAR_idFolio` BIGINT)  NO SQL
Select Registro
		,Producto
		,Descripcion
        ,Precio
        ,Cantidad
        ,importeTotal
FROM inventarioProductos

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_UltimoRegistroInventariosProductos` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_idBodega` BIGINT, IN `PAR_idTipoFlujo` BIGINT, IN `PAR_idFolio` BIGINT)  NO SQL
SELECT IFNULL(max(Registro),0)+1 as siguiente
FROM inventarioProductos
WHERE 	EntradaSalida=PAR_EntradaSalida
	and idBodega=PAR_idBodega
    and idTipoFlujo=PAR_idTipoFlujo
    AND idFolio=PAR_idFolio$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_EliminamovimientoInventario` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_idBodega` BIGINT, IN `PAR_idTipoFlujo` BIGINT, IN `PAR_idFolio` BIGINT)  NO SQL
DELETE
FROM MovimientoInventario

WHERE 	EntradaSalida=PAR_EntradaSalida
	and idBodega=PAR_idBodega
    and idTipoFlujo=PAR_idTipoFlujo
    AND idFolio=PAR_idFolio$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_EliminamovimientoInventarioProducto` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_idBodega` BIGINT, IN `PAR_idTipoFlujo` BIGINT, IN `PAR_idFolio` BIGINT, IN `PAR_registro` BIGINT)  NO SQL
DELETE
FROM inventarioProductos

WHERE 	EntradaSalida=PAR_EntradaSalida
	and idBodega=PAR_idBodega
    and idTipoFlujo=PAR_idTipoFlujo
    AND idFolio=PAR_idFolio
    and Registro=PAR_registro$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_EliminarInventarioProducto` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_idBodega` BIGINT, IN `PAR_idTipoFlujo` BIGINT, IN `PAR_idFolio` BIGINT, IN `PAR_registro` BIGINT)  NO SQL
delete
FROM inventarioProductos

WHERE 	EntradaSalida=PAR_EntradaSalida
	and idBodega=PAR_idBodega
    and idTipoFlujo=PAR_idTipoFlujo
    AND idFolio=PAR_idFolio
    and Registro=PAR_registro$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_EliminarTodoInventarioProducto` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_idBodega` BIGINT, IN `PAR_idTipoFlujo` BIGINT, IN `PAR_idFolio` BIGINT)  NO SQL
delete
FROM inventarioProductos

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_InsertaMovimientoInventarioProducto` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_idFolio` BIGINT(15), IN `PAR_idTipoFlujo` BIGINT(15), IN `PAR_idBodega` BIGINT, IN `PAR_IdArticulo` BIGINT, IN `PAR_DescripcionArticulo` VARCHAR(500), IN `PAR_Precio` DECIMAL(18,2), IN `PAR_Cantidad` DECIMAL(24,4), IN `PAR_ImporteTotal` DECIMAL(18,2), IN `PAR_Registro` BIGINT)  NO SQL
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
    ,Registro
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
    ,PAR_Registro    
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizarGrupo` (IN `parIDGrupo` BIGINT, IN `parDescripcion` VARCHAR(200), IN `parAccesoConfiguracion` BOOLEAN, IN `parAccesoGrupos` BOOLEAN, IN `parAccesoUsuarios` BOOLEAN, IN `parAccesoClientes` BOOLEAN, IN `parAccesoArticulos` BOOLEAN, IN `parAccesoInventario` BOOLEAN, IN `parABCBodegas` BOOLEAN, IN `parABCTiposFlujo` BOOLEAN, IN `parReportesInventarios` BOOLEAN, IN `parPuntosVenta` BOOLEAN, IN `parVentas` BOOLEAN, IN `parReportesVentas` BOOLEAN, IN `parCartera` BOOLEAN, IN `parReportesCartera` BOOLEAN)  NO SQL
update GruposUsuarios 

set Descripcion=parDescripcion
	,accesoConfiguracion=parAccesoConfiguracion
    ,accesoGrupos=parAccesoGrupos
    ,accesoUsuarios=parAccesoUsuarios
    ,accesoClientes=parAccesoClientes
    ,accesoArticulos=parAccesoArticulos
    ,accesoInventario=parAccesoInventario
    
    ,abcBodegas=parABCBodegas
    ,abcTipoFlujo=parABCTiposFlujo
    ,ReportesInventarios=parReportesInventarios
    
    ,Puntos_venta=parPuntosVenta
    ,Venta=parVentas
    
    ,ReportesVenta=parReportesVentas
    ,Cartera=parCartera
    ,ReportesCartera=parReportesCartera

where idGrupoUsuario=parIDGrupo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizarUsuario` (IN `parUsuario` VARCHAR(100), IN `parContra` VARCHAR(200), IN `parGrupo` MEDIUMINT, IN `parNombre` CHAR(200), IN `parIdUsuario` BIGINT)  NO SQL
update Usuarios set 
Usuario=parUsuario
,Contra=parContra
,Grupo=parGrupo
,Nombre=parNombre
where idUsuario=parIdUsuario$$

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
FROM `Clientes`
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaGrupoUsuario` (IN `ParDescripcion` VARCHAR(200), IN `parAccesoConfiguracion` BOOLEAN, IN `parAccesoGrupos` BOOLEAN, IN `parAccesoUsuarios` BOOLEAN, IN `parAccesoClientes` BOOLEAN, IN `parAccesoArticulos` BOOLEAN, IN `parAccesoInventario` BOOLEAN, IN `parABCBodegas` BOOLEAN, IN `parABCTiposFlujo` BOOLEAN, IN `parReportesInventario` BOOLEAN, IN `parPuntosVentas` BOOLEAN, IN `parVentas` BOOLEAN, IN `parReportesVentas` BOOLEAN, IN `parCartera` BOOLEAN, IN `parReportesCartera` BOOLEAN)  NO SQL
insert into GruposUsuarios (Descripcion
                            ,accesoConfiguracion
                           	,accesoGrupos
                            ,accesoUsuarios
                            ,accesoClientes
                            ,accesoArticulos
                            ,accesoInventario
                            
                            ,abcBodegas
                            ,abcTipoFlujo
                            ,ReportesInventarios
                            
                            ,Puntos_venta
                            ,Venta
                            ,ReportesVenta
                            ,Cartera
                            ,ReportesCartera
                           )
values(ParDescripcion
      ,parAccesoConfiguracion
      ,parAccesoGrupos
      ,parAccesoUsuarios 
      ,parAccesoClientes
      ,parAccesoArticulos
      ,parAccesoInventario 
       
      ,parABCBodegas
      ,parABCTiposFlujo
      ,parReportesInventario
       
      ,parPuntosVentas
      ,parVentas 
      ,parReportesVentas
      ,parCartera
      ,parReportesCartera
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
        ,(SELECT Logo FROM datosempresa) as logo
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
FROM `Clientes`
WHERE idCliente=cliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeClientes` (IN `desde` BIGINT, IN `cuantos` BIGINT, IN `Busqueda` VARCHAR(200))  READS SQL DATA
BEGIN

SELECT right(`idCliente`,5) as idCliente,
    `Nombres`,
    `Apellidos`,
    `Direccion`,
    `Ciudad`,
    `Telefono`,
    `RFC`,
    `FechaNacimiento`,
    `Estado`,
    `Municipio`,
    `CodigoPostal`
    , (SELECT Logo FROM datosempresa) as logo
FROM `Clientes`
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
FROM Paises
where Descripcion LIKE CONCAT('%',parBusqueda,'%')
or idPais LIKE CONCAT('%',parBusqueda,'%')$$

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
     ,(SELECT Logo FROM datosempresa) as logo
   
FROM `GruposUsuarios`
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

,abcBodegas
,abcTipoFlujo
,ReportesInventarios

,Puntos_venta
,Venta
,ReportesVenta
,Cartera
,ReportesCartera

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
, (SELECT Logo FROM datosempresa) as logo
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
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `idArticulo` bigint(20) NOT NULL,
  `Descripcion` varchar(1000) NOT NULL,
  `Tipo` varchar(100) NOT NULL,
  `PrecioCosto` decimal(18,2) NOT NULL,
  `PrecioVenta` decimal(18,2) NOT NULL,
  `IVA` double NOT NULL,
  `IEPS` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`idArticulo`, `Descripcion`, `Tipo`, `PrecioCosto`, `PrecioVenta`, `IVA`, `IEPS`) VALUES
(1, 'Limones', 'Producto', '5.00', '10.00', 6, 16),
(2, 'Manzanas', 'Producto', '10.00', '20.00', 12, 12),
(3, 'peras', 'Producto', '1.00', '2.00', 2, 1),
(4, 'Platanos', 'Producto', '3.00', '4.00', 2, 3),
(5, 'Guayabas', 'Producto', '1.00', '2.00', 3, 4),
(6, 'Jicama', 'Producto', '2.00', '3.00', 43, 32),
(7, 'Limones', 'Producto', '10.00', '100.00', 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bodegas`
--

CREATE TABLE `bodegas` (
  `idBodega` bigint(20) UNSIGNED NOT NULL,
  `Descripcion` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `bodegas`
--

INSERT INTO `bodegas` (`idBodega`, `Descripcion`) VALUES
(2, 'Guasave'),
(3, 'Mochis'),
(4, 'Juan Jose Rios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
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
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idCliente`, `Nombres`, `Apellidos`, `Direccion`, `Ciudad`, `Telefono`, `RFC`, `FechaNacimiento`, `Estado`, `Municipio`, `CodigoPostal`, `LugarNacimiento`) VALUES
(00000000000000000017, 'Julio', 'Leyva', 'as', 's', 's', 'XXX000X', '2015-01-01', '', '', '81110', 'Los Mochis'),
(00000000000000000034, 'Mariela', 'Salomon', 'Domicilio', 'jjr', '0000000', 'RFC', '1990-07-27', '', '', '', ''),
(00000000000000000035, 'Kakaroto', 'Goku', 'Domicilio', 'Ciudad', '12365332423', 'XXX000', '2016-08-16', 'Estado', 'Conocido', '81110', 'Chuna');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datosempresa`
--

CREATE TABLE `datosempresa` (
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
-- Volcado de datos para la tabla `datosempresa`
--

INSERT INTO `datosempresa` (`Nombre`, `RazonSocial`, `RFC`, `Telefono`, `Direccion`, `Ciudad`, `Pais`, `Estado`, `Logo`) VALUES
('Julio y Asociados', 'JULIO Y ASOCIADOS SA DE CV', 'XXX00XX0000X0', '6688612348', 'CALLE 10 AVENIDA JAPARAQUI', 'JUAN JOSE RIOS', '0001 MEXICO', '0006 SINALOA', 0xffd8ffe000104a46494600010001006000600000fffe001f4c45414420546563686e6f6c6f6769657320496e632e2056312e303100ffdb00840008050607060508070607090808090c140d0c0b0b0c1811120e141d191e1e1c191c1b20242e2720222b221b1c2836282b2f313334331f26383c38323c2e323331010809090c0a0c170d0d1731211c213131313131313131313131313131313131313131313131313131313131313131313131313131313131313131313131313131ffc401a20000010501010101010100000000000000000102030405060708090a0b0100030101010101010101010000000000000102030405060708090a0b100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9fa1100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffc00011080121013c03011100021101031101ffda000c03010002110311003f00f7fa002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a002800a004660bd78a008fed11838dd400e12a1e8c2801db97d45001903b8a004dea3b8a00699a31d585002ac887ee9a007d001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001401ccfc42d724d03c37797f0a8692241b01e9b890a33f89ad29439e6a24b76573e7d3e3af13fda8dc0d62e03939c71b7fef9c63f4af53d853b5ac61cf2366c7e2c7892d80137d96e47abc654ff00e3a40fd2b37848741fb466ac5f19f525ff0059a5c2c3fd994aff004350f06bb95ed7c89dbe35dc6d38d1403db375ff00d852fa9ff783daf914a7f8c9ac367c9b0b54ff007999bfc2a960e3dc5ed7c8c8bdf8a1e28b92765d436c0f68a21c7fdf59ad16169a17b466b782fe2aea5657a906bf2fdaad5db066da03c7efc751faff002aceae155af01c6a773ddb4fbc8eee0496270c8e032b29c820f7af39ab1b96e900500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001401c97c4db0fb7f84f52840e4c0cca3dd7e61fa8ad694b96699325a1f32e2bda390314006da003140062800c50018a00f65f81fe2732dbbe8b752664b71ba0c9ea9dc7e07f43ed5e6e2a9d9f323a29caeac7b0a3654115c46a2d00140050014005001400500140050014005001400500140050014005001d2802196e5231c91401977fe26d36c491757b6f011ff3d2555fe754a327b215d2306e7e27786e062ada9a1c7f7119c7e80d6ab0f51f425ce2ba9465f8b7e1e4cecb899f07f86161fcc0aafab54ec2f6911f17c59f0eb300d77227b985f8fc851f56a9d83da44d1b4f88fe1db860abaac0a4ff00cf4253ff0042c543a151742b9e3dcddb2d7acaf1775b5cc332fac6e187e95938b5b945f8ee637e8c290128607a1a005a002800a00a5ab4225b575600820822803e53d52c9b4fd4eeacdc60c12b47f91c57bb17cd14ce26acec56db5420db4006da0036d001b6800db401a1e1cd4e4d135bb5d422cfee1c1603f897a30fcb359d4873c5c4a8be5773ea4d1eed2eace396260c8ea1948ee0d78ad5b43b0bd4802800a002800a002800a002800a002800a002800a002800a002800a00ced73508f4dd3e7ba98958e18da4623d00c9a715776427a1f3f78a7c79ac6b933ac73bd9da13f2c5136091fed3753fcabd5a7878437d59cd2a8dec72a412492724f735d06626da041b6800db4006da00744d242e1e2768dc746538228693dc69d8e834af1bf88b4c2045a8c9320fe09ff783f33cfeb584b0f4e5d0b55248ee740f8bc9b963d62d1a1f59613b97f23c8fd6b9a7846be166aaaaea7a3e89e24d3f57804b63751cc9df6b723ea3a8fc6b8e50707668d534f63651d58641a918ea008ee1774445007ce7f1574efb178c6e182e12e55651f960fea0d7ad8695e9fa1cb555a4725b6ba0c836e2800db4006da0036d001b6800db401ef3f0675637be198a091b325a3184f3d872bfa103f0af2b130e59fa9d74dde27a25731a050014005001400500140050014005001400500140050014005001401c4fc59bafb3f84aff000705d4463df7301fd6b7a0af51113768b3e7edb5ec58e20db48036d030db458036d1600db4ec20db48036fb53b0c36d0227b1bbb9d3ee16e2ca7920957a321c1a994549598d49ad8f4cf097c5364296daf26dec2e231c7fc097b7d47e55c3530b6d607446af467ab69da9417b024b04a92238cab29c822b85ab686e5d382b480f1ff008e5a67eeecafd57fd5b9898fb1191fc8fe75dd84959b898565a5cf29db5e858e70db458036d02b86da76186da401b68b006da047a1fc13be36fad5d5993859a31201eea71fc9bf4ae2c5c744cde8bdd1ee519ca035e71d23a800a002800a002800a002800a002800a002800a002800a0028003c0a00f2af8db7a174db6b407e69a6dc7e8a3fc48aecc247de6cc2b3b46c791ecaf4ce50d94006ca0036d001b2800d94006ca00365001b2800d94006ca00dff0009f8aaff00c37703c8632da9397818f1f51e86b0ab46351799a42a389ee3e16f13596bb64b3da4b9ecc878643e8457973a72a6ecceb8c9495d143e25e98352f0c5e46a32ca9e62fd579fe98fc6aa8cb96698a6af168f9fb67b57b27086ca00365001b2800d94006ca0036500743f0f27fb278bec1ba076287f107fae2b9f10af4d9a527691f45da9cc22bc83b496800a002800a002800a002800a002800a002800a002800a00280239db6464d007847c54bffb77894c2a7296a817fe04793fd3f2af530b1b42fdce3acfdeb1c86caeb310d94006ca00365001b2800d94006cc5001b2800d94006ca00365001b28034740d5aef42bf4bbb27208e1d09f95c7a1acea53551599519383ba3dc344d6ed7c41a32cf09c8618643d54f706bc89c1d39599dd19292ba3c2f5cd3ff00b3b58bbb4c6045290bfeef6fd315ebd39734133866b964d14b6568486ca00365001b314006ca00365005ff000fb791aee9f274db71193f4dc2b3a8af06541da48fa4b4f39817e95e21e8166800a002800a002800a002800a002800a002800a002800a00280323c4ba8c7a769b3dc4a70b12163ef5518b934909bb2b9f3cddcb25ddd4b7131cc92b976fa939af72315156479cddddc8b653106ca00367b5001b2800d94006ca00367b5001b2800d94006ca00365001b2800d9401b9e0ed724d0b530c58fd966c2cabedd9bea3fc6b0af4bda47ccd29cf919a1f12ad146ad0dec58d9731f247723ffac45658497bae3d8baeacd3393d95d8601b2800d94006ca00365001b28027d3971a85b11ff3d57f98a99fc2ca8fc48fa434cff8f75fa57847a25ba002800a002800a002800a002800a002800a002800a002801b236c527a5007947c56d73ce9134b85b8043cd8fd07f5fcabd0c253fb6ce5af3b7ba8f3dd95e81cb70d9405c365020d94006ca0770d9405c365020d94006ca0770d9405c3650170d9405c3650170d940836500740663a9784cc4e73369ee08f52878ff3f4ae4b7b3ad7e8ce8bf3d3f439fd95d66170d9405c365020d9ed4006ca0036503b96b4787ccd5acd00fbd3a0ff00c785454d20ca87c48fa1f4e18b71f4af08f48b54005001400500140050014005001400500140050014005004376098481401e0fe2cb5b883c417bf6a560cf2b3293dd49e31f857b541a74d58f3aaa6a6ee64ecad8c8365001b2800d94006ca003650170d94006ca00365001b2800d94006ca02e1b280b86ca02e1b280b9a5e1e216ffc87ff0057728d137e22b0c42f739974d4d693f7addccf96168a468d86190907eb5b27757466f4761bb298ae1b280b86ca02e1b280b86ca02e6b7846d8cfe24b1403a49bbf204ff4ac710ed4d9ad2579a3de2d176c2a2bc53d126a002800a002800a002800a002800a002800a002800a00280108c8c500675fe8f6b7abb6e208e51e8ea0ff003aa5271d989a4f73226f03e91275b1887fba36ff002ad157a8ba90e943b14a5f879a4b7dd85d3e9237f5356b15517527d843b155fe1be9e7eebdc2fd1c7f8552c5d427eaf0217f86b6bfc173703ea54ff4aafae4fb217d5a3dc84fc358c7fcbdcbff007c8a7f5c97617d5a3dc864f87691f5be61ff00001fe34feb8fb07d597733ef7c216b68332ea6b18ff6d40feb551c549ed125d08add9933e9ba64590354dc7fd9889fe55b2a955fd8fc4cdc29afb457fb1d867fe3fdbfefc1ff001abe7a9fcbf893cb0fe6fc0962d32ce5c6cd4e253feda15fe749d59ade0354e0f6917a2f085ccebbadeeade407a1c9fe80d67f5b8add32feaefa3125f066af18ca451c9fee3ff8e2a962a992f0f3466dd68da859e4dc59cc80753b723f31c56d1ab096cccdd39477452d95a101b28025b53e4dcc520e36386fc8d4c95e2d0e2ecd32ff00896d3ecfab4bc6048038fc7afeb9ac70d2e6a6bc8d6b2e59997b2ba0c4365001b2800d94006ca00eb3e1a5979bad49391c4298fc49ff00006b8b192b4523a70cbde6cf5f886d402bcb3b8750021207b5004325d471f5228008ae524fba45004f40050014005001400500140050014005001400500140050014011cb2ac63268039af1078b2cf4c050bef97b469c9ff00eb56f4a84ea6c653ab186e707ab78b753be62237fb347e89d7f3ff000c57a14f0b086fa9c73c449eda18321791cbc8ccec7a963926ba924b4460ddf71bb28106ca0036501725b59e7b490496d2bc4c3ba9c54ca1192b491519b8eccec7c3de34d8561d5547a095471f88ae0ab84b6b03ae9e216d23b9b692cefa10f19565619041c835c0d35a33ad3bec61f88bc1b677b1b490a0866ea1d0633f51deb7a5889d3f4329d28ccf33beb196c6e9edee176ba1c7d7debd784d4e3cc8f3a517076640139c015449d4f8e6c8a25a5c63d50ff31fd6bcfc1cb5713b712b44ce5b657a07106ca00365001b280b86ca02e7a67c34d3becfa679ecb869db77e1d07f9f7af27153e6a96ec7a3878da173b9e95c87411cb2ac6324e280399f10f8b6d34d05377993768d3afe3e95bd2a12a9b6c653ab186e79d6b3e20d435590f992b451768e3240fc7d6bd3a787853f538675a53347c05aa5c5b6b096ad2b186607e52720103391f95658aa6b93996e8d30f37cdca7adc2dba306bca3bc7d0014005001400500140050014005001400500140050056bbbb8ede32ccc140e73458363cefc4de3092766b7d35b0bd0cbfe1fe35e8d1c27da9fdc7155c47481c736598b312589c924f26bd14ada1c571365020d9405c3650170d9400e8a1795d63890bb370154649a4da8abb1a4dbb236adbc23aace81bcb48f3d9dbfc335cb2c5d34742c34d8db9f09eab6ea4f90b201fdc6ff1a71c5537e40f0f3443a7dfea5a14ff002092319e6290100d5ce9d3ac888ce7499e93e17d723d6ad0b282ae9c3a1ec6bcaab45d27667a14ea2a8ae8e5fe24d82a3c374ab839d8defdc7f5fcebab052d5c4c3151d148e5748b5375a9db4207de9067e8393fa57755972c1b3929ae69a4773e39b4ce825b1cc6cac3f3c7f5af2f0aed551df885fbb679decaf60f32e1b68b05c3650170d9405c9ec2cdaf2f22b78c7cd2301f41dcd44e4a117265c23cd2513da348b64b4b48d1405545000f6af05bbbb9eba560d475382ca16925915157a9271428b6ec81b4b5679ef887c633dd96874f2638fa190f53f4f4af4a8e112d6670d4c4f481c9b6598b312589c924f26bbd2b688e4b89b2811774493ecdabdac9d009003f43c7f5acab46f4da35a52b4d1ed560fba05fa57847ac58a002800a002800a002800a002800a002800a0028029ea1791dac2ceec155464927a534afa213763cc7c4de21975495a1858a5b03f8bfd7dabd6c3e1953f7a5b9e6d6afcda4763036d761cc1b6800db4006da0036d002a44cee11172cc7000ee686ecaec16aec8f49f08f86e3b180492a869dbef363a7b0af16bd6751f91eb52a4a9af33a7db142bc802b98d84510cbc00280219f4b8261878d581ec4534dad8561f65a74164316f124609c908a053726f70492d8e53e2401fd9ebff5d07f5aeac1ff0010e7c4ff000cc3f00d979daa3ce47112e07d4fff00aaba71b2b4544c30b1d5b3aef19c63fb0ee01ed19ae0a1fc48fa9d757e06795edaf74f2036d001b6800db401d9780f490a4dfce319e23cfa7735e6632addf223d0c353b2e666eebfe26b7d32331a1df2e38453cfe3e95cd4a84aabd3636a95634d6bb9e7baaea777a9cdbee5fe507e541f756bd7a5463496879b52aca6f5296dad4cc36d001b6800008208e08e680bd8f61f0cdd8bad3e1901fbe80d7cfce3c9271ec7b50973453362a0a0a002800a002800a002800a002800a0028020ba99618c9271401e67e2dd71f50b86b781b1021e48fe33fe15eb6170fc8b9e5b9e6e22b5df2c7639edb5dc718628186da0418a00314006da00e8fc0fa5fdaaf8dcc8bf245c2ffbdfe7f9d70632a72c541753b70b4eef999e8b24d1da43c90302bca3d1384f12f8aa495da0d39f68e8d28fe9fe35e961f09f6a7f71c35b136f7606ff0081ad67834c06e198bcac643b8e48cfff00aab9b1328caa7bbb237a117186a7515cc6e1401c6fc44859b4dde07092027f97f5aecc1bb5439b14bf763fc05a79b6d396475dad29dff876fd2a7153e6a8edd07878f2c1799278eee963d2e540797c281f5a5868f35543af2e5a6cf36db5ed9e48628106da00bda469ff006b9f327cb0272edd3f0ae7af5952565b9d146973bbbd8d9d4fc47e4c5f65d330a00dbe60e83e95cb4708dfbd50e8ab8951f760732e59dcbbb166272493926bd14925647036dbbb1314c41b6800c50018a0036d00771f0f6ff113dab1e633951ec7ff00af5e4e369f2cb9bb9e9e16778f2f63bb539008ae13ac5a002800a002800a002800a002800a004760ab93401c478df5a31a7d9206c3c83e623f856bbb09479e5ccf6472626af22e55bb386c57ae79618a6018a00314006290062980bb6901e8ba047168fa3a194842177393ebdebc1ab2756a368f6a9c55382472de21f10cda93b4501296ff00916ffeb57a387c2aa7ef4b7382b621cfdd8ec33c2ba41d46f83b8cc311c9f73e94f155bd9c7956ec30d4b9df33d91e9d6ca96e817a578c7a8580411c5002d0056ba8a0954aca1594f50c320d34dad82dd0a379a85b69f0166754503d714e31727644b6a2aecf3bf116aedaadd6572214fba0f7f7af670d43d92bbdcf2ebd6f68ecb632715d6730629012c508237c876463bf73f4aca752cf963abfeb7368434e69688927ba678c4310f2e11fc23bfd6a69d1517cd2d58e759b5cb1d115b15b9806298062800c50018a003140062802f6897a74fd462981c2e76b7d0d615e9fb48346d46a7b39a67ace9f389a1520e78af0363d92d5001400500140050014005001400500666b97c96569248e701466aa1172928a2652515767945e5cc9777324f29f99ce7e9ed5f434e0a9c5451e2ce6e72726455640500140050014005005cd1a0171a8c4a7eea9dcdf415cf899f2536cde8439aa2347c4daa34f27d9226c451fdec773e9f8573e0e872ae77b9b62aaddf2230abd0388f49f05d9ac1a5c471f332ee3f53cd781889f3546cf66847969a467f8cf51bdd3eeada5b690a202432f6278ebfad6f85a70a8a5196e65889ca9d9c4d9f0e6b31ea36aae0e1ba32e7a1ae6ab49d2972b37a751548dd0be21d721d2625329259f211547269d2a32aaed1154ab1a4aece2efbc597d7048842c2bdbb9af4618282f89dce1962e4fe156316e6ea7b97dd712bc87dcf4aeb8538c348ab1cd29ca7f1322ad082786cee26ff571363fbc4605653ad0a7bb358529cb642c91c56c70c44b20ec3ee8ff001ac94a7576d17e25b8c296fabfc081dd9ce58e6b78c1415918ca4e4eec4ab242800a004a005a003f4a002800a002803bbf01ea66680db4872f0e00f75ed5e362e9724f996ccf570d539e367d0ed074ae23a82800a002800a002800a002801ae76a93401e7de3dd48b4a966878fbcff00d2bd2c153d5cd9c38b9d9282392cd7a679c19a6019a00334803340066800cd006a694ff64b2b8bbfe2fb89f5ff0038ae1c42f695234ceda1fbb84a66596249249c9e49aee5a6871bd433408f4cf065dacda5c183caaed3f51c57815e3c951a3daa32e6826278cf4ffb569b26d19651b97ea29e1ea7b3a898ab439e0d1c1e87aa3e9778b22e4c678751e9eb5ebd7a2aac6dd4f368d5f672f23d0e2365acdb233ac7321e46e008af17dfa6edb33d5b466bba117c33a70e96d07fdf22abdb54fe662f650fe5435fc3fa620e6da0ff00be052f6d53f99fde1eca1fca8ccd45b47d297263855bb2aa0c9ab82ab55d9364c9d3a4b5d0e5753d6a5bb62b08f262f41d4fd6bd1a3858d3d65ab386ae2653d23a233735d8720669806690099a602e6900669806690099a005cd300cd200cd00769f0fac5c2c974c08121c2fd057958da97928ae87a584872c5cbb9dd8e00af3ced16800a002800a002800a002802aea3288a0624e302803c7b54bc379a84d39390cc76fd3b57bf461ece0a278d565cf36cadbab533b06ea003750160dd4006ea02c1ba8106ea02c69ea59b6d3ed2dfa1237b0f7ff0024d71d0f7eaca7f23aeb2e4a718199babb0e50dd4058dbf0a6b5fd9977b256c4121e4ff74fad71e2a87b45cd1dd1d587abc8f95ec7a43489796b9520e4578e7a67956b96a6c7549e1c61436e5fa1af7a854e7a699e3d68724da19a76ab75a73e6da5da3ba9e41a2a51854f890a9d5953d8dc8fc6d74a986b7527d43e3fa5723c0ae923a562df628df78a751ba0555c42bfec75fceb686129c77d4ce5899bdb431de56918b3b1663d493935d4924ac8e66dbd589ba9858375020dd40c3750160cd020dd4006ea061ba8106ea00375001ba819ade1dd1a5d56e46415810fccdebec2b9b115d52565b9d1468f3bbbd8f52d3acd2d6054450aaa3000ed5e2b777767a895b445ca430a002800a002800a002800a00e67c737bf65d2272a70586d1f8f15be1e3cd51232ad2e5836795eeaf70f22c1ba800dd4006ea00375001ba800dd401674c84dd5fc3001f79867e9d4fe959d59f241b34a71e69a45df143635429d02201fd7fad618356a66b89f8cc9dd5d67306ea003750163a2f0cf89df4e65b7ba62d6fd037529ff00d6ae2c46194fde86e75d1afcbeecb6353c5b691ea76697d6643ba0cfcbcee5ae6c354f652e591bd7a7cf1e689c4eeaf58f34375001ba800dd4006ea00375001ba800dd4006ea00375001ba800dd4006ea00375006df873c3f3ead2877063b60796eedec3fc6b96be2553d16e7451a0e7abd8f4fd2b4d86ca048e1408aa3000af2252727767a6928ab2342a4614005001400500140050014001e9401e79f13ae76c30420e37c85bf21ffd7aeec12f79b39314fdd48e0b7d7a870584df400bba800dd405837d001ba80b06fa00e9bc0369f68d4259c8e224c0fa9ffeb0fd6b87193b4544ebc2c756ca3e30f935fb85f65fe42b5c2ff0919e23e331f7d749806fa0037d0160df4058d0d235a9f4d7c292f093f3464f1f51e95856a11aabccda95574fd09b51b786ed5af34de54f3245dd4fae2b3a55254df254f932ea53535cf03277d759cd60df40584df40585df40584df40585df405837d001ba80b06ea00375001be80b0fb78e5b89445046d23b745519349c9455d8d45b76476be1bf053332cfa98cf7110e83ebeb5e756c5b7a40eda7864b591dfda59c76f18545000e0002bcf3b0b340050014005001400500140050014008ff0074d00794fc4f9bfe2656c9d9518fe647f857a5825a36716277471dbebbce4b06fa02c1be80b06fa02c1be80b06fa02c1be80b1ea3f0eac3c9d116565c34e4c9f876fd05791899f3547e47a3423cb0392f8851983c405b1812460ff0031fd2bb308ff0077639b10bdf39bdf5d673d837d0160df405837d0160df4058920b9920903c2e5187715328a92b31c5b8bba2f2b5b6a270c56d6e8f7fe073fd0d61efd1db55f8a36f76a7932a5ddadc59bedb888a7a1ec7e86b68548cd7bacce54dc37441beac8b06fa0037d0160df405837d0160df405837d01626b5b7b8bb93cbb585e56f445ce2a6538c3765460e5b23a9d1bc0b797255efdfc84fee2f2df9f41fad71d4c625a411d10c33fb477ba2f872cf4c8c2dbc2a87bb773f535c13a929bbc99d718461a246d246a830a3159963a800a002800a002800a002800a002800a0047fba6803c93e2a46d1ea96d29185642a3ea0fff005ebd2c1bd1a38f12b54717bebbce40df4006fa0037d001be800df40135944d77770dbc7f7a57083f13532972c5b2a31bb48f79d1ad56dac6389061514281ec05782ddddcf512b68703f15ecca0b6bb51c2b1463f5e47f235dd83959b89cd888e899e7dbebd138837d300df4006fa0037d001e65001be901b1a3f8864b3021bb41736a782adc951ed9fe55cd570ea5ac7466f0aae3a3d8e9e0f0fe87af41e7e9f21849ebe59c60fa153d2b97db55a4ed237f654e6ae8ab73f0f2f50ff00a35dc6e3b6f52bfcb35aac62ea887867d19424f03eb48701216ff75cff00515a2c5d323eaf31bff084eb7ff3ca21ff0003a3eb74c3eaf3268bc05ac39f99add07fbc4ff4a4f190e898d61e4695a7c389d883737981e889fd49fe9593c67645ac37766fe9fe00d32020c9134c47791b3fa74ac2589a92eb6355420ba1d2d9e936d6a8122892351d02a802b9db6f735492d8ba91aa0f946290c7d00140050014005001400500140050014005001400500731e33f0da6bb62620de5c887746f8ce0ff00856d46aba52b99d4829ab1e4facf86755d20b19edcc912ff00cb58be65fc7b8fc6bd3a75e13d99c72a52898dbeb7320df4006fa0037d001be803aaf86961f6dd7fcf23296cbbbfe04781fd6b93173e585bb9d1423ef5cf6b817646074af28ed39df1ce99fda3a2dcc2ab972bb93fde1c8ad694f92699138f345a3c3376383c57b679a1be800df4006fa0037d001be800df4006fa00b3a7ea373a75c09ece6689c7a743ec477a89c23356922a32717747a6f847c776fa814b6bedb05cf4193f2bfd0ff4af32b61e54f55aa3b69d552d1ee7750b432a8200ae53625f293fba280144683a28a0050a0741400b40050014005001400500140050014005001400500140050014005002103bd004135a4728c151401c6f89bc0163a80696dd7ecb3f5df18e0fd477ae9a7889c34dd194e94647976bda0ea1a14db2f623e59385957956fc7b1f6af469d58d4d8e49d37032b7e2b5330df4006fa00f61f851a5fd9b445b875c3dcb799f8741fa73f8d795899f34edd8eea31e589df8e062b94d886ee2124441a00f05f1e696da478826555c43707cd8fd39ea3f3fe95ebe1e7cf0f4386ac796473fbeba0c437d001be800df4006fa0037d001be800df4006ff4a06765e12f1f5ce96c96fa9169edba07eae9fe23f5ae3ab8652d61a337a759ad247ade91ac5b6a36c935b4ab246e32194d79d28b8bb33ad34f634811daa462d001400500140050014005001400500140050014005001400500140050014005002100f5a00a1aa6956f7d6ef0cf12c91b8c15619069a6e2ee84d1e3be38f034fa317bcd355a5b31cb27568bfc457a54710a5eecb7396a52b6b1389df5d873d8b9a359bea7aa5b59479ccce1491d8773f966a272e48b654637763e8dd1ed52d2d238a350aa8a1540ec05788ddcf44bf48008e31401c47c4bf0e9d5b486681337307cf163bfaafe23f5c56f42a7b396bb19d487323c38b10707822bd8386c1be8106fa0037d001be800df40c37d001be800df40837d03357c3de23bed06e44b67266327e7898fcadfe07deb2a94a3516a5c26e1b1ed1e10f17d96bd6c0c2fb2551f3c4c7e65ff0011ef5e554a52a6eccec8cd49687528c186456458ea002800a002800a002800a002800a002800a002800a002800a002800a002800a002802bdd5b24d195600e6803c9bc67f0d6e0dd35d680a987397b7276807d54f4fc2bbe8e26cad339e74afaa347e1bf816e749ba6d4355082e0aed8e3539d83b927d6a3115d4d72c762a9d3e5d59e9d1aec500715c66c3a800a008ae221246411401e1ff14bc2eda55fb6a7691ffa2cedfbd007fab73dfe87f9d7a586ab75c8ce5ab0b7bc8e137d769806fa0037d001be800df4006fa0037d001be800df4006fa009ec6fee34fba4b9b399a19a339565a994549598d3717747b87c37f17ff00c24366e93288eeadf02551d0e7a11f91af26bd2f64f4d8eca73e647723a56068140050014005001400500140050014005001400500140050014005001400500140050035914f514002a2af418a007500140050014019dace9906a3672dbdc46b2472295653dc534dc5dd058f9ebc6de18b9f0cea263219ed2424c32ffeca7dc57af46aaa8bcce39c3959cf6ead8cec1ba98ec1ba90ac1ba98ec1ba80b06ea42b06ea63b06ea041ba90589acedae2f67582ce192795ba246b9349c9455d8d26f63da3e14f842ef428a6bbd430b717000f2c1cec51ea7d79af33115554765b23aa9c3956a7a40e05729a8b4005001400500140050014005001400500140050014005001400500140050014005001400500140050014005000476a00c6f11e8369acd84b6b77109239073ea0fa8f435519383ba1349ab1f3e78cfc277be17bd2b22b4b66e7f75381c1f63e87f9d7ad46b2a8bcce59c1c4e7b756c661ba9806ea430dd4c41ba9006ea061bb1408ec3c17e01d43c42c971701ad2c4f3bc8f9a41fec8f4f7fe75cd57111a7a2d59ac69b7ab3dafc37e14d3b43b611595bac7fde63cb31f527bd79b3a929bbb3a5454763a048d50600c540c75001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050066eb1a45aea76925bdd4292c520c32b0c834d3717742b1e1be39f86d7ba33bdd6908f7565d4c639923ff00e287ebfcebd2a38952d25a330953b6c701babb0c4375001ba800dd40066901ea9f0dbe1bb5c797a9ebd09c70d15b30fd587f4fcfd2b82be23ecc0e8853b6acf67b5b58e08c2aa8007a5701b163a50014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014010cd6e920208a00f3ff19fc30d375a2f716c3ec57879f3235e18ff00b4bdfebc1ae8a588953d3a112826790788fc13ae787dd8dcda34d6ebff002de105971efdc7e35e842bc27b1838347399adc80cd007abfc25f009b868b5ad5e1f97ef5b42e3f2723f97e7e95e7e22bfd889bc216d59ed96f0ac48028c5701b12d00140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014008403c1a00826b48e4182a280394d6fe1c787f556679f4f8d243ff2d22cc6d9f538ebf8d6d1ad386cc9714cccd37e11787aceed6768669f61c849a4cae7e8319fc6ade26a356128451dfdb5bac08154000573164f400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005001400500140050014005007ffd9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `idPais` bigint(20) UNSIGNED NOT NULL,
  `idEstado` bigint(20) NOT NULL,
  `Descripcion` varchar(800) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estados`
--

INSERT INTO `estados` (`idPais`, `idEstado`, `Descripcion`) VALUES
(1, 1, 'CHIHUAHUA'),
(2, 3, 'NUEVO MEXICO'),
(2, 4, 'TEXAS'),
(1, 6, 'SINALOA'),
(1, 7, 'NAYARIT'),
(1, 8, 'SONORA'),
(1, 9, 'DURANGO'),
(2, 13, 'FLORIDA'),
(1, 14, 'BAJA CALIFORNIA SUR'),
(3, 15, 'Ejemplo2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gruposusuarios`
--

CREATE TABLE `gruposusuarios` (
  `IdGrupoUsuario` bigint(20) UNSIGNED NOT NULL,
  `Descripcion` varchar(200) NOT NULL,
  `accesoUsuarios` tinyint(1) DEFAULT '0',
  `accesoGrupos` tinyint(1) DEFAULT '0',
  `accesoClientes` tinyint(1) DEFAULT '0',
  `accesoArticulos` tinyint(1) DEFAULT '0',
  `accesoConfiguracion` tinyint(1) DEFAULT '0',
  `accesoInventario` tinyint(1) DEFAULT '0',
  `abcBodegas` tinyint(1) DEFAULT NULL,
  `abcTipoFlujo` tinyint(1) NOT NULL,
  `ReportesInventarios` tinyint(1) NOT NULL,
  `Puntos_venta` tinyint(1) DEFAULT NULL,
  `Venta` tinyint(1) NOT NULL,
  `ReportesVenta` tinyint(1) NOT NULL,
  `Cartera` tinyint(1) NOT NULL,
  `ReportesCartera` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `gruposusuarios`
--

INSERT INTO `gruposusuarios` (`IdGrupoUsuario`, `Descripcion`, `accesoUsuarios`, `accesoGrupos`, `accesoClientes`, `accesoArticulos`, `accesoConfiguracion`, `accesoInventario`, `abcBodegas`, `abcTipoFlujo`, `ReportesInventarios`, `Puntos_venta`, `Venta`, `ReportesVenta`, `Cartera`, `ReportesCartera`) VALUES
(2, 'PRUEBAS', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(9, 'Administrador', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 'Supervisor', 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(11, 'Desarrollador', 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(12, 'Inventario', 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(21, 's', 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(22, '1', 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(23, '2', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(24, '3', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(25, '4', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(26, '5', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(27, '6', 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventarioproductos`
--

CREATE TABLE `inventarioproductos` (
  `EntradaSalida` varchar(15) NOT NULL,
  `idTipoFlujo` bigint(20) NOT NULL,
  `idBodega` bigint(20) NOT NULL,
  `idFolio` bigint(20) NOT NULL,
  `Producto` bigint(20) NOT NULL,
  `Descripcion` varchar(500) NOT NULL,
  `Cantidad` decimal(24,4) NOT NULL,
  `Precio` decimal(18,2) NOT NULL,
  `ImporteTotal` decimal(18,2) NOT NULL,
  `Registro` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `inventarioproductos`
--

INSERT INTO `inventarioproductos` (`EntradaSalida`, `idTipoFlujo`, `idBodega`, `idFolio`, `Producto`, `Descripcion`, `Cantidad`, `Precio`, `ImporteTotal`, `Registro`) VALUES
('Entrada', 4, 2, 1, 1, '1', '1.0000', '1.00', '1.00', 1),
('Entrada', 4, 2, 1, 1, '1', '1.0000', '1.00', '1.00', 2),
('Entrada', 4, 2, 2, 4, 'Platanos', '1.0000', '3.00', '3.00', 1),
('Entrada', 4, 4, 1, 4, 'Platanos', '200.0000', '3.00', '2000.00', 1),
('Entrada', 4, 4, 1, 1, 'Limones', '5.0000', '5.00', '25.00', 3),
('Entrada', 4, 4, 2, 5, 'Guayabas', '12.0000', '1.00', '12.00', 1),
('Entrada', 4, 4, 3, 4, 'Platanos', '123.0000', '3.00', '369.00', 1),
('Entrada', 4, 4, 3, 4, 'Platanos', '31.0000', '3.00', '93.00', 2),
('Entrada', 4, 4, 3, 5, 'Guayabas', '54.0000', '1.00', '54.00', 3);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `inventarios`
--
CREATE TABLE `inventarios` (
`EntradaSalida` varchar(15)
,`TIPOS_FLUJOS` varchar(200)
,`Bodega` text
,`Cliente` varchar(100)
,`Producto` bigint(20)
,`Descripcion` varchar(500)
,`Cantidad` decimal(24,4)
,`Precio` decimal(18,2)
,`ImporteTotal` decimal(18,2)
,`Registro` bigint(20) unsigned
,`idTipoFlujo` bigint(20)
,`idBodega` bigint(20)
,`idFolio` bigint(20)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientoinventario`
--

CREATE TABLE `movimientoinventario` (
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
-- Volcado de datos para la tabla `movimientoinventario`
--

INSERT INTO `movimientoinventario` (`EntradaSalida`, `idTipoFlujo`, `idBodega`, `idFolio`, `Fecha`, `idCliente`, `Factura`, `Observacion`) VALUES
('Entrada', 4, 2, 1, '2016-07-01', 20, 'factura', 'Observacion'),
('Entrada', 4, 2, 2, '2016-07-10', 34, 'fACTURA', 'Observacion'),
('Entrada', 4, 4, 1, '2016-08-04', 34, 'fa', ''),
('Entrada', 4, 4, 2, '2016-08-11', 1, '1', '1\n'),
('Entrada', 4, 4, 3, '2016-08-26', 35, 'f-1231', 'Observacion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--

CREATE TABLE `paises` (
  `idPais` bigint(20) UNSIGNED NOT NULL,
  `Descripcion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `paises`
--

INSERT INTO `paises` (`idPais`, `Descripcion`) VALUES
(1, 'MEXICO'),
(2, 'Estados Unidos Americanos'),
(3, 'Afganistan');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

CREATE TABLE `reportes` (
  `idReporte` bigint(20) NOT NULL,
  `NombreReporte` varchar(150) NOT NULL,
  `Descripcion` varchar(150) NOT NULL,
  `Consulta` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `reportes`
--

INSERT INTO `reportes` (`idReporte`, `NombreReporte`, `Descripcion`, `Consulta`) VALUES
(1, 'repInformeExistencias', 'INFORME DE EXISTENCIAS', 'call PAL_InformeExistencias');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposflujos`
--

CREATE TABLE `tiposflujos` (
  `idTipoFlujo` bigint(20) NOT NULL,
  `Descripcion` varchar(200) NOT NULL,
  `EntradaSalida` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tiposflujos`
--

INSERT INTO `tiposflujos` (`idTipoFlujo`, `Descripcion`, `EntradaSalida`) VALUES
(3, 'SALIDA POR VENTA', 'Salida'),
(4, 'ENTRADA POR COMPRA', 'Entrada'),
(5, 'Entrada por devolucion', 'Entrada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` bigint(20) UNSIGNED NOT NULL,
  `Usuario` varchar(300) NOT NULL,
  `Contra` varchar(300) NOT NULL,
  `Grupo` mediumint(9) NOT NULL,
  `Nombre` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `Usuario`, `Contra`, `Grupo`, `Nombre`) VALUES
(1, 'supervisor', '', 2, '');

-- --------------------------------------------------------

--
-- Estructura para la vista `inventarios`
--
DROP TABLE IF EXISTS `inventarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inventarios`  AS  select `a`.`EntradaSalida` AS `EntradaSalida`,(select `x`.`Descripcion` from `tiposflujos` `x` where (`a`.`idTipoFlujo` = `x`.`idTipoFlujo`)) AS `TIPOS_FLUJOS`,(select `x`.`Descripcion` from `bodegas` `x` where (`a`.`idBodega` = `x`.`idBodega`)) AS `Bodega`,(select `x`.`Nombres` from `clientes` `x` where (`b`.`idCliente` = `x`.`idCliente`)) AS `Cliente`,`a`.`Producto` AS `Producto`,`a`.`Descripcion` AS `Descripcion`,`a`.`Cantidad` AS `Cantidad`,`a`.`Precio` AS `Precio`,`a`.`ImporteTotal` AS `ImporteTotal`,`a`.`Registro` AS `Registro`,`a`.`idTipoFlujo` AS `idTipoFlujo`,`a`.`idBodega` AS `idBodega`,`a`.`idFolio` AS `idFolio` from (`inventarioproductos` `a` join `movimientoinventario` `b`) where ((`a`.`EntradaSalida` = `b`.`EntradaSalida`) and (`a`.`idTipoFlujo` = `b`.`idTipoFlujo`) and (`a`.`idFolio` = `b`.`idFolio`) and (`a`.`idBodega` = `b`.`idBodega`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`idArticulo`);

--
-- Indices de la tabla `bodegas`
--
ALTER TABLE `bodegas`
  ADD PRIMARY KEY (`idBodega`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD UNIQUE KEY `idCliente` (`idCliente`);

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD UNIQUE KEY `Estado` (`idEstado`);

--
-- Indices de la tabla `gruposusuarios`
--
ALTER TABLE `gruposusuarios`
  ADD PRIMARY KEY (`IdGrupoUsuario`);

--
-- Indices de la tabla `inventarioproductos`
--
ALTER TABLE `inventarioproductos`
  ADD PRIMARY KEY (`EntradaSalida`,`idTipoFlujo`,`idBodega`,`idFolio`,`Registro`);

--
-- Indices de la tabla `movimientoinventario`
--
ALTER TABLE `movimientoinventario`
  ADD PRIMARY KEY (`EntradaSalida`,`idTipoFlujo`,`idBodega`,`idFolio`),
  ADD KEY `EntradaSalida` (`EntradaSalida`,`idTipoFlujo`,`idBodega`);

--
-- Indices de la tabla `paises`
--
ALTER TABLE `paises`
  ADD PRIMARY KEY (`idPais`);

--
-- Indices de la tabla `tiposflujos`
--
ALTER TABLE `tiposflujos`
  ADD PRIMARY KEY (`idTipoFlujo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `Usuario` (`Usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `idArticulo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `bodegas`
--
ALTER TABLE `bodegas`
  MODIFY `idBodega` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` bigint(20) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `idEstado` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `gruposusuarios`
--
ALTER TABLE `gruposusuarios`
  MODIFY `IdGrupoUsuario` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT de la tabla `paises`
--
ALTER TABLE `paises`
  MODIFY `idPais` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tiposflujos`
--
ALTER TABLE `tiposflujos`
  MODIFY `idTipoFlujo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
