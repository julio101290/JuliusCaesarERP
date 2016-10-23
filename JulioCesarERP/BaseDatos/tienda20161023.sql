-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 24-10-2016 a las 01:57:15
-- Versión del servidor: 10.1.16-MariaDB
-- Versión de PHP: 5.5.38

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAC_ActualizaVenta` (IN `PAR_PuntoVenta` BIGINT, IN `PAR_Venta` BIGINT, IN `PAR_FECHA` VARCHAR(15), IN `PAR_Observaciones` VARCHAR(500), IN `par_cliente` BIGINT)  NO SQL
UPDATE Ventas
SET
Fecha=PAR_FECHA
,Observaciones=PAR_Observaciones
,Cliente=par_cliente

WHERE 	PuntoVenta=PAR_PuntoVenta
		and idVenta=PAR_Venta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAC_TraerExistencia` (IN `par_producto` BIGINT, IN `par_bodega` BIGINT)  NO SQL
select (
ifnull((select sum(Cantidad)  
from inventarioproductos 
where idBodega=par_bodega 
and Producto=par_producto
and EntradaSalida='ENTRADA'
),0)
-
ifnull((select sum(Cantidad)  
from inventarioproductos 
where idBodega=par_bodega 
and Producto=par_producto
and EntradaSalida='Salida'
),0)) as existencia$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_ExisteCodigoBarras` (IN `parCodigo` VARCHAR(100))  NO SQL
SELECT 
	idArticulo
    ,Descripcion
    ,Tipo
    ,IVA
    ,IEPS
    ,PrecioCosto
    ,PrecioVenta
    ,codigoBarras
    FROM
    Articulos
    WHERE
    codigoBarras=parCodigo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_InformeExistencias` ()  NO SQL
select
    ifnull((select sum(x.Cantidad)
        from inventarioproductos x
        where x.EntradaSalida='Entrada' 
        	                                                      and x.Producto=a.Producto
             group by x.Producto
            
           ),0) -
            
          ifnull( (select sum(x.Cantidad)
        from inventarioproductos x
        where x.EntradaSalida='Salida' 
        	                                                          and x.Producto=a.Producto
             group by x.Producto 
                   
                  ),0)
             as EXISTENCIA
        ,a.Producto
        ,(select x.Descripcion from articulos x where x.idArticulo=a.Producto)as Descripcion
        ,(SELECT Logo FROM datosempresa) as logo
        FROM
        inventarioproductos a
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_LeerMovimientoVenta` (IN `PAR_PuntoVenta` BIGINT, IN `parVenta` BIGINT)  NO SQL
    DETERMINISTIC
SELECT
	
    Fecha
    ,Cliente
    ,Observaciones
    ,'SI' as EXISTE
FROM Ventas

WHERE 	idVenta=parVenta
	and PuntoVenta=PAR_PuntoVenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_LeeTotalVentasProductos` (IN `par_PuntoVenta` BIGINT, IN `par_venta` INT)  NO SQL
Select sum(importe_neto) as total
FROM VentasProductos

WHERE 	idPuntoVenta=par_PuntoVenta
	and idVenta=par_venta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_LeeVentasProductos` (IN `par_PuntoVenta` BIGINT, IN `par_venta` BIGINT)  NO SQL
Select Registro
		,Producto
		,Descripcion
        ,Precio
        ,Cantidad
        ,IVA
        ,importe_neto
FROM VentasProductos

WHERE 	idPuntoVenta=par_PuntoVenta
	and idVenta=par_venta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_ObtieneCodigo` (IN `parCodigo` VARCHAR(100))  NO SQL
SELECT 
	idArticulo
    ,Descripcion
    ,Tipo
    ,IVA
    ,IEPS
    ,PrecioCosto
    ,PrecioVenta
    ,codigoBarras
    FROM
    Articulos
    WHERE
    codigoBarras=parCodigo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_UltimoFolioInventario` (IN `parTipoMovimiento` VARCHAR(15), IN `parIdFlujo` BIGINT, IN `parIdBodega` BIGINT)  NO SQL
SELECT IFNULL(max(idFolio),0)+1 as siguiente
FROM MovimientoInventario
where EntradaSalida=parTipoMovimiento
	and idTipoFlujo=parIdFlujo
    and idBodega=parIdBodega$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_UltimoFolioVenta` (IN `parIdPuntoVenta` INT)  NO SQL
SELECT IFNULL(max(idVenta),0)+1 as siguiente
FROM Ventas
where 
     PuntoVenta=parIdPuntoVenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_UltimoRegistroInventariosProductos` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_idBodega` BIGINT, IN `PAR_idTipoFlujo` BIGINT, IN `PAR_idFolio` BIGINT)  NO SQL
SELECT IFNULL(max(Registro),0)+1 as siguiente
FROM inventarioProductos
WHERE 	EntradaSalida=PAR_EntradaSalida
	and idBodega=PAR_idBodega
    and idTipoFlujo=PAR_idTipoFlujo
    AND idFolio=PAR_idFolio$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_UltimoRegistroVentasProductos` (IN `parPuntoVenta` BIGINT, IN `idVenta` BIGINT)  NO SQL
SELECT IFNULL(max(Registro),0)+1 as siguiente
FROM VentasProductos
WHERE 	idPuntoVenta=parPuntoVenta
	and idVenta=idVenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAL_VENTASTOTALES` ()  NO SQL
SELECT b.producto 
,b.Descripcion
, (SELECT Logo FROM datosempresa) as logo 
,(Select z.Descripcion from PuntosVenta z where a.puntoventa=z.idPuntoVenta)DescPuntoVenta ,sum(b.importe_neto) as VentaProducto FROM Ventas a ,VentasProductos b 
where a.idVenta=b.idVenta 
and a.PuntoVenta=b.idPuntoVenta 
and a.puntoventa=1 
GROUP By b.Producto$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_EliminamovimientoVenta` (IN `parPuntoVenta` BIGINT, IN `parVenta` BIGINT)  NO SQL
DELETE
FROM Ventas

WHERE 	PuntoVenta=parPuntoVenta
		and idVenta=parVenta$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_EliminarTodoVentaProducto` (IN `parPuntoVenta` BIGINT, IN `parVenta` BIGINT)  NO SQL
delete
FROM VentasProductos

WHERE 	idPuntoVenta=parPuntoVenta
		and idVenta=parVenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_EliminarVentaProducto` (IN `PAR_PuntoVenta` BIGINT, IN `par_venta` BIGINT, IN `par_Registro` BIGINT)  NO SQL
delete
FROM ventasProductos

WHERE 	idPuntoVenta=PAR_PuntoVenta
	and idVenta=par_venta
    and Registro=par_Registro$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_InsertaMovimientoInventarioProducto` (IN `PAR_EntradaSalida` VARCHAR(15), IN `PAR_idFolio` BIGINT(15), IN `PAR_idTipoFlujo` BIGINT(15), IN `PAR_idBodega` BIGINT, IN `PAR_IdArticulo` BIGINT, IN `PAR_DescripcionArticulo` VARCHAR(500), IN `PAR_Precio` DECIMAL(18,2), IN `PAR_Cantidad` DECIMAL(24,4), IN `PAR_ImporteTotal` DECIMAL(18,2), IN `PAR_Registro` BIGINT, IN `PAR_PuntoVenta` BIGINT, IN `Par_Venta` BIGINT, IN `Par_RegistroVenta` BIGINT)  NO SQL
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
    ,idPuntoVenta
    ,idVenta
    ,RegistroVenta
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
    ,PAR_PuntoVenta
    ,Par_Venta
    ,RegistroVenta
    )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_INSERTAMOVIMIENTOVENTA` (IN `parPuntoVenta` BIGINT, IN `parIdVenta` BIGINT, IN `PAR_FECHA` VARCHAR(20), IN `PAR_idCliente` BIGINT, IN `PAR_Observaciones` VARCHAR(500))  NO SQL
INSERT INTO Ventas 
(
	PuntoVenta
    ,idVenta
    ,Fecha
    ,Cliente
    ,Observaciones

)
VALUES
(parPuntoVenta
,parIdVenta
,PAR_FECHA
,PAR_idCliente
,PAR_Observaciones
)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PAR_InsertaMovimientoVentaProducto` (IN `PAR_PuntoVenta` BIGINT, IN `PAR_Venta` BIGINT, IN `PAR_IdArticulo` BIGINT, IN `PAR_DescripcionArticulo` VARCHAR(500), IN `PAR_Precio` DECIMAL(18,2), IN `PAR_Cantidad` DECIMAL(24,5), IN `PAR_ImporteTotal` DECIMAL(18,2), IN `PAR_Registro` BIGINT)  NO SQL
INSERT INTO ventasProductos
(
    Cantidad
    ,Descripcion
    ,idPuntoVenta
    ,idVenta
    ,Precio
    ,Producto
    ,Importe_Neto
    ,Registro
    )
    VALUES
    (
    PAR_Cantidad
    ,PAR_DescripcionArticulo    
    ,PAR_PuntoVenta 
    ,PAR_Venta   
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizaArticulo` (IN `parIdArticulo` MEDIUMINT, IN `pardescripcion` VARCHAR(800), IN `parTipo` VARCHAR(100), IN `parIEPS` DECIMAL(18,2), IN `parIVA` DECIMAL(18,2), IN `parPrecioCosto` DECIMAL(18,2), IN `parPrecioVenta` DECIMAL(18,2), IN `parCodigoBarras` VARCHAR(100))  NO SQL
UPDATE Articulos SET
	Descripcion=pardescripcion
    ,Tipo=parTipo
    ,IEPS=parIEPS
    ,IVA=parIVA
    ,PrecioCosto=parPrecioCosto
    ,PrecioVenta=parPrecioVenta
    ,codigoBarras=parCodigoBarras
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizaPuntoVenta` (IN `parIdPuntoVenta` INT, IN `parDescripcion` VARCHAR(500), IN `parBodega` INT(100))  NO SQL
update PuntosVenta

set Descripcion=parDescripcion
	,idBodega=parBodega
where idPuntoVenta=parIdPuntoVenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizarGrupo` (IN `parIDGrupo` BIGINT, IN `parDescripcion` VARCHAR(200), IN `parAccesoConfiguracion` BOOLEAN, IN `parAccesoGrupos` BOOLEAN, IN `parAccesoUsuarios` BOOLEAN, IN `parAccesoClientes` BOOLEAN, IN `parAccesoArticulos` BOOLEAN, IN `parAccesoInventario` BOOLEAN, IN `parABCBodegas` BOOLEAN, IN `parABCTiposFlujo` BOOLEAN, IN `parReportesInventarios` BOOLEAN, IN `parPuntosVenta` BOOLEAN, IN `parVentas` BOOLEAN, IN `parReportesVentas` BOOLEAN, IN `parCartera` BOOLEAN, IN `parReportesCartera` BOOLEAN, IN `parScaner` BOOLEAN)  NO SQL
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
    ,Scaner=parScaner

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EliminarPuntoVenta` (IN `parPuntoVenta` BIGINT)  NO SQL
delete from PuntosVenta where idPuntoVenta=parPuntoVenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EliminarTipoFlujo` (IN `ParIdTipoFlujo` BIGINT)  NO SQL
delete from TiposFlujos where idTipoFlujo=ParIdTipoFlujo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_EliminarUsuario` (IN `parUsuario` VARCHAR(200))  NO SQL
delete from Usuarios where usuario=parUsuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaArticulo` (IN `parDescripcion` VARCHAR(1000), IN `parTipo` VARCHAR(100), IN `ParIEPS` DECIMAL(18,2), IN `parIVA` DECIMAL(18,2), IN `parPrecioCosto` DECIMAL(18,2), IN `parPrecioVenta` DECIMAL(18,2), IN `parCodigoBarras` VARCHAR(100))  NO SQL
INSERT INTO Articulos		
						(
                        Descripcion
                        ,Tipo
                        ,IEPS
                        ,IVA
                        ,PrecioCosto
                        ,PrecioVenta
                        ,codigoBarras
                        )
                        VALUES
                        (
                            parDescripcion
                            ,parTipo
                            ,ParIEPS
                            ,parIVA
                            ,parPrecioCosto
                            ,parPrecioVenta
                            ,parCodigoBarras
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaGrupoUsuario` (IN `ParDescripcion` VARCHAR(200), IN `parAccesoConfiguracion` BOOLEAN, IN `parAccesoGrupos` BOOLEAN, IN `parAccesoUsuarios` BOOLEAN, IN `parAccesoClientes` BOOLEAN, IN `parAccesoArticulos` BOOLEAN, IN `parAccesoInventario` BOOLEAN, IN `parABCBodegas` BOOLEAN, IN `parABCTiposFlujo` BOOLEAN, IN `parReportesInventario` BOOLEAN, IN `parPuntosVentas` BOOLEAN, IN `parVentas` BOOLEAN, IN `parReportesVentas` BOOLEAN, IN `parCartera` BOOLEAN, IN `parReportesCartera` BOOLEAN, IN `parScaner` BOOLEAN)  NO SQL
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
                            ,Scaner
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
      ,parScaner
      )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaPais` (IN `parDescripcion` VARCHAR(200))  NO SQL
insert into Paises (Descripcion)
values (parDescripcion)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaPuntoVenta` (IN `paPuntoVenta` VARCHAR(500), IN `idBodega` VARCHAR(100))  NO SQL
insert into PuntosVenta(Descripcion,idBodega)
values(paPuntoVenta,idBodega)$$

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
    ,codigoBarras
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
        or	codigoBarras LIKE CONCAT('%',parBusqueda,'%')
 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeCuantosBodegas` (IN `parBusqueda` VARCHAR(800))  NO SQL
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeeCuantosPuntoVentas` (IN `parBusqueda` VARCHAR(800))  NO SQL
SELECT COUNT(*) as cuantos
FROM PuntosVenta
where Descripcion LIKE CONCAT('%',parBusqueda,'%')$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeePuntosVentas` (IN `parDesde` INT, IN `parCuantos` INT, IN `parBusqueda` VARCHAR(500))  NO SQL
SELECT 
		idPuntoVenta
        ,Descripcion

        FROM
        PuntosVenta
        
        where Descripcion LIKE CONCAT('%',parBusqueda,'%')

 
limit parDesde,parCuantos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeePuntoVenta` (IN `parPuntoVenta` BIGINT)  NO SQL
SELECT a.idPuntoVenta
		,a.Descripcion
        ,A.idBodega
        ,(SELECT b.Descripcion from bodegas  b where
          b.idBodega=a.idBodega) as idBodegaDescripcion 
FROM	
	PuntosVenta a
    WHERE
    a.idPuntoVenta =parPuntoVenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_LeerArticulos` (IN `parDesde` BIGINT, IN `parCuantos` BIGINT, IN `parBusqueda` VARCHAR(800))  NO SQL
SELECT 	idArticulo
		,Descripcion
        ,Tipo
        ,IEPS
        ,IVA
        ,PrecioCosto
        ,PrecioVenta
        ,codigoBarras
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
,Scaner

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
  `IEPS` double NOT NULL,
  `codigoBarras` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`idArticulo`, `Descripcion`, `Tipo`, `PrecioCosto`, `PrecioVenta`, `IVA`, `IEPS`, `codigoBarras`) VALUES
(16, 'GELATINA PRONTO PIÑA', 'Producto', '7.44', '10.00', 0, 0, '7501200482151'),
(17, 'GELATINA JELLO FRAMBUESA SOBRE', 'Producto', '7.35', '10.00', 0, 0, '7622300471170'),
(18, 'GELATINA JELLO NARANJA SOBRE', 'Producto', '7.35', '10.00', 0, 0, '7622300471781'),
(19, 'GELATINA UVA SOBRE', 'Producto', '7.35', '10.00', 0, 0, '7622300470647'),
(20, 'GELATINA PIÑA SOBRE', 'Producto', '7.35', '10.00', 0, 0, '7622300471095'),
(21, 'GELATINA LIMON SOBRE', 'Producto', '7.35', '10.00', 0, 0, '7622300476830'),
(23, 'GELATINA PRONTO NARANJA', 'Producto', '7.44', '10.00', 0, 0, '7501200482144'),
(27, 'GELATINA PRONTO UVA ', 'Producto', '7.44', '10.00', 0, 0, '7501200482168'),
(28, 'GELATINA PRONTO LIMON', 'Producto', '7.44', '10.00', 0, 0, '7501200482137'),
(29, 'ESCOBA  DE ESPIGA ', 'Producto', '34.13', '42.00', 0, 0, '7503013201011'),
(30, 'TRAPEADOR MAGITEL ', 'Producto', '17.38', '28.00', 0, 0, 'trapeador magitel'),
(31, 'TRAPEADOR ALGODÒN ', 'Producto', '22.97', '29.00', 0, 0, '101'),
(32, 'SERVILLETA COCINA IRIS', 'Producto', '8.02', '10.00', 0, 0, '7501050430043'),
(33, 'TENEDOR JAGUAR ', 'Producto', '5.51', '7.00', 0, 0, '752216085059'),
(34, 'CUCHARA JAGUAR CHICA', 'Producto', '5.80', '7.00', 0, 0, '752216085028'),
(35, 'CUCHARA DKCH MEDIANA', 'Producto', '4.85', '6.00', 0, 0, '7503010810001'),
(36, 'CUCHARA FANTASY GRANDE', 'Producto', '8.15', '10.00', 0, 0, '7503004361052'),
(37, 'PLATO HONDO CHICO REYMA', 'Producto', '8.72', '11.00', 0, 0, '7502208805201'),
(38, 'CHAROLA MARIL S/DIVISION', 'Producto', '13.58', '18.00', 0, 0, '7502208805454'),
(39, 'PLATO HONDO JAGUAR', 'Producto', '12.76', '15.00', 0, 0, '752216051061'),
(40, 'CHAROLA CHICA JAGUAR ', 'Producto', '13.41', '15.50', 0, 0, '752216081044'),
(41, 'CHAROLA CHICA MARIEL', 'Producto', '13.41', '15.50', 0, 0, '7502208800558'),
(42, 'CHAROLA CON DIVISION REYMA', 'Producto', '10.46', '12.50', 0, 0, '7502208805171'),
(43, 'VASO #10 REYMA', 'Producto', '17.60', '20.50', 0, 0, '7502208800084'),
(44, 'VASO #8 JAGUAR', 'Producto', '16.40', '19.50', 0, 0, '7522116031094'),
(45, 'VASO TERMICO #8 REYMA', 'Producto', '6.57', '8.00', 0, 0, '7502208800183'),
(46, 'VASO TERMICO #10 REYMA', 'Producto', '8.48', '10.00', 0, 0, '7502208800190'),
(47, 'SERVILETA CHICA VELVET', 'Producto', '6.48', '8.50', 0, 0, '7501050420075'),
(48, 'SERVILLETA GRANDE VELVET', 'Producto', '12.74', '16.00', 0, 0, '7501050420068'),
(52, 'PAÑAL ABSORSEC MEDIANO', 'Producto', '29.07', '36.00', 0, 0, '7501017375165'),
(53, 'PAÑAL ABSORSEC GRANDE (14)', 'Producto', '33.48', '42.00', 0, 0, ''),
(54, 'PAÑAL ABSORSEC GRANDE (40)', 'Producto', '104.17', '130.00', 0, 0, '7501017372751'),
(55, 'PAÑAL ABSORSEC MEDIANO  (40)', 'Producto', '91.40', '115.00', 0, 0, '7501017372737'),
(56, 'CHICOLASTIC ETAPA 4 (40)', 'Producto', '74.26', '95.00', 0, 0, '013117011180'),
(57, 'DAWNY ROSA LIBRE ENJUAGE AROMA FLORAL 800ML', 'Producto', '16.76', '19.50', 0, 0, '7501001155841'),
(58, 'DAWNY VERDE PUREZA SILVESTRE ', 'Producto', '16.76', '19.50', 0, 0, '7590002040003'),
(59, 'DAWNY ROMANCE LILA', 'Producto', '17.01', '19.50', 0, 0, '7501001351663'),
(60, 'DAWNY PASION ROJO 800ML', 'Producto', '19.26', '23.50', 0, 0, '7501065906472'),
(61, 'DAWNY ELEGANCE NEGRO', 'Producto', '19.26', '23.50', 0, 0, '7501001109172'),
(62, 'DAWNY NATURAL BEAUTY', 'Producto', '19.26', '23.50', 0, 0, '7506339321852'),
(63, 'DDOWNY AROMA FLORAL 450ML', 'Producto', '10.82', '13.50', 0, 0, '7501001155834'),
(64, 'ENSUEÑO AMARILLO MAX 450ML', 'Producto', '9.21', '11.50', 0, 0, '7501025440381'),
(65, 'ENSUEÑO LILA MAX 450ML', 'Producto', '9.21', '11.50', 0, 0, '7501025440374'),
(66, 'ENSUEÑO AZUL MAX 450ML', 'Producto', '9.21', '11.50', 0, 0, '7501025440367'),
(67, 'ENSUEÑO AZUL COLOR 850ML', 'Producto', '14.27', '17.50', 0, 0, '7501025413019'),
(68, 'ENSUEÑO BEBÈ 850ML', 'Producto', '14.27', '17.50', 0, 0, '7501025414153'),
(69, 'ENSUEÑO LILA MAX', 'Producto', '14.27', '17.50', 0, 0, '7501025414054'),
(70, 'ENSUEÑO NARANJA MAX 850ML', 'Producto', '14.27', '17.50', 0, 0, '7501025414207'),
(71, 'ENSUEÑO AMARILLO COLOR 850ML', 'Producto', '14.27', '17.50', 0, 0, '7501025414009'),
(72, 'ENSUEÑO COLOR DURAZNO Y FRUTOS ROJOS 740ML', 'Producto', '10.00', '16.00', 0, 0, '7501025444815'),
(73, 'PINOL LAVANDA LILA 828ML', 'Producto', '14.69', '19.00', 0, 0, '7501025400118'),
(74, 'INOL FRUTAL VERDE 828ML', 'Producto', '14.69', '19.00', 0, 0, '7501025400088'),
(75, 'PINOL ROSA 828ML', 'Producto', '14.69', '19.00', 0, 0, '7501025400187'),
(76, 'PINOL LAVANDA 500ML', 'Producto', '9.19', '11.50', 0, 0, '7501025400101'),
(77, 'PINOL FLORAL 500ML', 'Producto', '9.19', '11.50', 0, 0, '7501025400170'),
(78, 'PINOL MARINO AZUL500ML', 'Producto', '9.19', '11.50', 0, 0, '7501025400149'),
(79, 'PINOL ORIGINAL 828ML', 'Producto', '15.80', '20.00', 0, 0, '7501025403485'),
(80, 'PINOL ORIGINAL 500ML', 'Producto', '10.24', '12.00', 0, 0, '7501025403027'),
(81, 'PINOL ORIGINAL 250ML', 'Producto', '6.95', '8.50', 0, 0, '7501025403010'),
(82, 'CLORALEX EL RENDIDOR 950ML', 'Producto', '9.43', '11.50', 0, 0, '75000615'),
(83, 'CLORALEX EL RENDIDOR 500ML', 'Producto', '5.34', '6.50', 0, 0, '75000608'),
(84, 'CLORALEX EL RENDIDOR 250ML', 'Producto', '3.51', '5.00', 0, 0, '75000592'),
(85, 'SUAVITEL FRESCA PRIMAVERA AZUL 850ML', 'Producto', '16.05', '20.00', 0, 0, '7509546016306'),
(86, 'SUAVITEL DELICIAM  SUAVE AMARILLO 850ML', 'Producto', '16.05', '20.00', 0, 0, '7509546016313'),
(87, 'JABON BEBE ROSA 350', 'Producto', '9.99', '13.00', 0, 0, '745819007214'),
(88, 'JABON LIRIO BLANCO', 'Producto', '11.31', '14.00', 0, 0, '012388000633'),
(89, 'JABON ZOTE ROSA 200G.', 'Producto', '6.12', '8.00', 0, 0, '7501026005688'),
(90, 'JABON ZOTE ROSA 400G.', 'Producto', '12.24', '15.00', 0, 0, '7501026005671'),
(91, 'JABON LEON CLASICO AMARILLO 350G.', 'Producto', '9.99', '13.00', 0, 0, '745819006101'),
(92, 'JABON LEON ALTO PODER ROJO 350G.', 'Producto', '9.99', '13.00', 0, 0, '745819007306'),
(93, 'JABON LEON SUAVIZANTE LILA 350G.', 'Producto', '9.99', '13.00', 0, 0, '745819007290'),
(94, 'JABON LEON ALOE VERDE 350G.', 'Producto', '9.99', '13.00', 0, 0, '745819006224'),
(95, 'JABON IBARRA PINO ANTIBACTERIAL 300G', 'Producto', '7.13', '10.00', 0, 0, '7502263230086'),
(96, 'JABON IBARRA PERLAS QUITA MANCHAS 300G.', 'Producto', '7.12', '10.00', 0, 0, '7502263230079'),
(97, 'JABON PINTO AZUL', 'Producto', '9.90', '12.00', 0, 0, 'JABON PINTO AZUL'),
(98, 'JABON FLORAL 350G.', 'Producto', '11.19', '14.00', 0, 0, '745819006170'),
(99, 'DETERGENTE JABON UTIL 500G.', 'Producto', '9.08', '12.00', 0, 0, '012388000749'),
(100, 'DETERGENTE BLANCA NIEVES 250G.', 'Producto', '6.21', '8.00', 0, 0, '7501026027550'),
(101, 'DETERGENTE BLANCA NIEVES 500G.', 'Producto', '12.41', '16.00', 0, 0, '7501026027543'),
(102, 'DETERGENTE AXION 250G.', 'Producto', '7.08', '9.00', 0, 0, '7509546018911'),
(103, 'DETERGENTE AXION 500G.', 'Producto', '12.61', '15.00', 0, 0, '7509546018928'),
(108, 'ACE NORMAL 250G', 'Producto', '7.91', '10.00', 0, 0, '7501006705942'),
(109, 'DETERENTE ACE NORMAL 500G', 'Producto', '15.38', '19.00', 0, 0, '7501007445557'),
(110, 'DETERGENTE ACE NATURALS 250G', 'Producto', '6.84', '8.50', 0, 0, '7501007497136'),
(111, 'DETERGENTE ACE NATURALS 500G', 'Producto', '12.61', '16.00', 0, 0, '7501007497129'),
(112, 'FOCA 1K', 'Producto', '26.36', '32.00', 0, 0, '7501026026546'),
(113, 'FOCA DE 500G.', 'Producto', '13.26', '16.00', 0, 0, '7501026026560'),
(114, 'FOCA 250G', 'Producto', '6.64', '8.00', 0, 0, '7501026026577'),
(115, 'DETERGENTE 123 CON SUAVIZANTE Y JAZMIN 900G LILA', 'Producto', '14.73', '20.00', 0, 0, '7501199410913'),
(116, 'DETERGENTE 123 ROSIO DE CAMPO VERDE 900G.', 'Producto', '15.32', '20.00', 0, 0, '7501199410906'),
(117, 'DETERGENTE 123  AZUL 900G', 'Producto', '15.32', '20.00', 0, 0, '7501199410937'),
(119, 'DETERGENTE ARIEL 500G.', 'Producto', '17.97', '22.00', 0, 0, '7501007455730'),
(120, 'DETERGENTE ARIEL 250G.', 'Producto', '9.23', '12.00', 0, 0, '7501065908841'),
(121, 'PAPEL ALUMINIO ALUPRCTIK 7', 'Producto', '5.55', '7.00', 0, 0, '7503009924078'),
(122, 'PAPEL ALUMINIO ALUSIN 7', 'Producto', '7.45', '10.00', 0, 0, '7503008860070'),
(123, 'FLASH MENTA FRESCA VERDE ', 'Producto', '10.56', '13.50', 0, 0, '7501025431488'),
(124, 'FLASH LAVANDA 1L', 'Producto', '10.53', '13.50', 0, 0, '7501025440299'),
(125, 'FLASH FLORAL', 'Producto', '10.53', '13.50', 0, 0, '7501025440282'),
(126, 'FLASH FLORAL 500G', 'Producto', '6.15', '8.00', 0, 0, '7501025434021'),
(127, 'FLASH LAVANDA ', 'Producto', '6.15', '8.00', 0, 0, '7501025431020'),
(128, 'FLASH BRISA MARINA', 'Producto', '6.15', '8.00', 0, 0, '7501025433024'),
(129, 'FABULOSO ANTIBACTERIAL 500G.', 'Producto', '9.43', '12.00', 0, 0, '75001162'),
(130, 'FABULOSO FRESCURA PROFUNDA 500ML', 'Producto', '9.43', '12.00', 0, 0, '75001186'),
(131, 'AXION 400ML', 'Producto', '13.58', '16.50', 0, 0, '7509546017143'),
(132, 'SALVO LIMON 300 ML', 'Producto', '11.75', '14.50', 0, 0, '7506195196984'),
(133, 'PAPEL SUAVEL 4 ROLLOS', 'Producto', '15.00', '20.00', 0, 0, '7501943457911'),
(134, 'PAPEL REGIO 4 ROLLOS', 'Producto', '14.66', '20.00', 0, 0, '7501019035548'),
(135, 'PAPEL VOGUE 1 ROLLO', 'Producto', '4.40', '6.00', 0, 0, '7501017375622'),
(136, 'SUAVILE CONTROL CAIDA CHILE 370ML', 'Producto', '21.24', '26.00', 0, 0, '7506192502559'),
(137, 'SAVILE KERATINA 370ML.', 'Producto', '21.04', '26.00', 0, 0, '7506192502542'),
(138, 'SAVILE CONTROL CAIDA MIEL 370ML', 'Producto', '21.04', '26.00', 0, 0, '7506192502528'),
(139, 'SAVILE BIOTINA 750ML', 'Producto', '29.59', '36.50', 0, 0, '7506192505499'),
(140, 'SAVILE ACEITE DE ARGON 750 ML', 'Producto', '29.59', '36.50', 0, 0, '7506192504393'),
(141, 'SAVIOLE KERATINA 750ML.', 'Producto', '29.59', '36.50', 0, 0, '7506192501040'),
(142, 'BAYGON CASA Y JARDIN 400ML', 'Producto', '29.80', '39.00', 0, 0, '7501032907570'),
(143, 'BAYGON CASA Y JARDIN 250ML', 'Producto', '23.11', '31.00', 0, 0, '7501032902025'),
(144, 'BAYGON ULTRA VERDE 250ML', 'Producto', '26.59', '34.00', 0, 0, '7501032902032'),
(145, 'VELADORA DE VASO ', 'Producto', '7.94', '10.00', 0, 0, '744831152476'),
(146, 'VELADORA DE REPUESTO ', 'Producto', '4.84', '6.50', 0, 0, '744831121915'),
(147, 'PINZAS PARA ROPA ', 'Producto', '20.93', '30.00', 0, 0, 'PINZAS PARA ROPA '),
(148, 'VEL ROSITA 450GR', 'Producto', '16.51', '21.50', 0, 0, '7509546045689'),
(149, 'ESPONJA DOBLE ESTRELLA', 'Producto', '4.43', '6.00', 0, 0, 'ESPONJA DOBLE ESTRELLA'),
(150, 'ESTROPAJO DE FIERRO', 'Producto', '5.50', '7.00', 0, 0, 'ESTROPAJO DE FIERRO'),
(151, 'ENSALADA DE LEGUMBRES 400GR.', 'Producto', '9.39', '12.50', 0, 0, '7501003124340'),
(152, 'ENSALADA DE LEGUBRS 220GR.', 'Producto', '5.90', '7.50', 0, 0, '7501003124333'),
(153, 'CHICHAROS 215GR', 'Producto', '5.44', '7.00', 0, 0, '7501003124135'),
(154, 'CHAMPIÑONES REBANADOS 186GR.', 'Producto', '11.59', '15.00', 0, 0, '7501003123213'),
(155, 'ELOTE CLEMENTE JACK 220GR.', 'Producto', '6.52', '8.50', 0, 0, '7501052471044'),
(156, 'ELOTE HERDEZ 220GR', 'Producto', '5.84', '7.50', 0, 0, '7501003124234'),
(157, 'LATA DE FRIJOL 420GR', 'Producto', '12.30', '15.00', 0, 0, '7501023508502'),
(158, 'LATA DE FRIJOL 360GR.', 'Producto', '11.24', '14.00', 0, 0, '7501023502135'),
(159, 'MAYONESA McCORNIK390GR.', 'Producto', '18.50', '24.50', 0, 0, '7501003340139'),
(160, 'MAYONESA McORNIK 105GR', 'Producto', '8.55', '10.00', 0, 0, '7501003340115'),
(161, 'MAYONESA McCORNIC 190GR.', 'Producto', '11.93', '14.00', 0, 0, '7501003340122'),
(162, 'MAYONESA McCORNIC 285GR', 'Producto', '16.13', '20.00', 0, 0, '7501003340535'),
(163, 'MOSTAZA 210GR', 'Producto', '9.27', '12.00', 0, 0, '7501003335029'),
(164, 'MOSTAZA 115GR', 'Producto', '7.06', '9.00', 0, 0, '7501003335012'),
(165, 'SALSA CASERA 210GR', 'Producto', '6.91', '8.00', 0, 0, '7501003127235'),
(166, 'SALSA PATO 225GR', 'Producto', '7.49', '10.00', 0, 0, '7501367500255'),
(167, 'SALSA VERDE   210GR', 'Producto', '7.35', '9.50', 0, 0, '7501003127334'),
(168, 'CHILES RAJAS 220 GR', 'Producto', '7.79', '10.00', 0, 0, '7501017005024'),
(169, 'CHILE JALAPEÑO 121GR', 'Producto', '6.54', '10.00', 0, 0, '7501017005000'),
(170, 'CHILE RAJAS 105GR', 'Producto', '4.45', '6.00', 0, 0, '7501017006014'),
(171, 'CHIE CHIPOTLE 105  GR', 'Producto', '7.50', '10.00', 0, 0, '7501017006021'),
(172, 'CHILE CHIPOTLE 220 GR.', 'Producto', '14.57', '19.00', 0, 0, '7501017005031'),
(173, 'CHILE MORRON 200 GR', 'Producto', '9.39', '12.00', 0, 0, '7501017050536'),
(174, 'SLSA RANCHERA 210 GR', 'Producto', '13.82', '16.00', 0, 0, '7501052473000'),
(175, 'FRASCO KNOR SUIZA 100 GR', 'Producto', '15.47', '19.00', 0, 0, '7501005180658'),
(176, 'FRASCO KNOR TOMATE', 'Producto', '13.53', '16.50', 0, 0, '7501005186674'),
(177, 'SALSA CAPSUP 320 GR', 'Producto', '9.08', '12.00', 0, 0, '75053901'),
(178, 'SALSA CAPSUPS 220 GR', 'Producto', '6.63', '10.00', 0, 0, '75014339'),
(179, 'MEDIAS CREMAS LALA  250 ML', 'Producto', '7.89', '10.00', 0, 0, '7501020515299'),
(180, 'VI9NAGRE MANZANA 500 ML', 'Producto', '8.84', '11.50', 0, 0, '7501052475202'),
(181, 'VINAGRE BLANCO 500ML', 'Producto', '6.34', '11.50', 0, 0, '7501052475004'),
(182, 'BONATUN EN ACEITE ', 'Producto', '7.90', '11.00', 0, 0, '7503005067052'),
(183, 'ATUN ANCLA EN ACEITE ', 'Producto', '7.02', '11.00', 0, 0, '7501041415585'),
(184, 'MAZATUN EN AGUA', 'Producto', '10.23', '12.50', 0, 0, '7501045401416'),
(185, 'MAZATUN EN ACEITE ', 'Producto', '10.23', '12.50', 0, 0, '7501045401409'),
(186, 'ACEITUNA 70 GR', 'Producto', '5.57', '7.00', 0, 0, '7501144990019'),
(187, 'ACEITUNA 110 GR', 'Producto', '9.81', '12.50', 0, 0, '7502265070086'),
(188, 'ACEITUNA 120 GR ', 'Producto', '9.45', '13.00', 0, 0, '7501144990026'),
(189, 'ACEITUNA 240 GR', 'Producto', '14.50', '18.50', 0, 0, '7501144990033'),
(190, 'PURE EL FTE  CHICO 210 GR', 'Producto', '4.27', '5.00', 0, 0, '7501079702817'),
(191, 'PURE HERDEZ 210 GR', 'Producto', '3.30', '4.50', 0, 0, '7501003124807'),
(192, 'SALSA 7 MARES ', 'Producto', '7.96', '12.00', 0, 0, '724836004192'),
(193, 'SALSA LA NEGRA ', 'Producto', '11.20', '12.00', 0, 0, '7503013479052'),
(194, 'SALSA DE SOYA ', 'Producto', '9.85', '12.50', 0, 0, '724836088055'),
(195, 'SALSA HUICHOL ', 'Producto', '9.90', '11.50', 0, 0, '012957100016'),
(196, 'MOLE 125GR', 'Producto', '12.76', '15.00', 0, 0, '7501003150219'),
(197, 'MOLE 235 GR', 'Producto', '23.49', '29.00', 0, 0, '7501003150233'),
(198, 'SARDINA 155GR', 'Producto', '9.54', '12.00', 0, 0, '731082002018'),
(199, 'SARDINA OVALADAN 280GR', 'Producto', '20.17', '25.00', 0, 0, '731082001004'),
(200, 'MERMELADA 270 GR', 'Producto', '11.04', '14.00', 0, 0, '7501052474069'),
(201, 'LECHERITA 100 GR', 'Producto', '7.33', '9.00', 0, 0, '7501059211209'),
(202, 'LECHERA GRANDE 387GR ', 'Producto', '16.81', '20.00', 0, 0, '7501058617873'),
(203, 'MEDIA CREMA NESTLE ', 'Producto', '6.64', '12.00', 0, 0, '7501001600426'),
(204, 'LECHE CLAVEL 360 GR', 'Producto', '11.69', '13.50', 0, 0, '7501059284555'),
(205, 'CEBADA ', 'Producto', '11.74', '15.00', 0, 0, '669864000092'),
(206, 'HORCHATAS', 'Producto', '11.74', '15.00', 0, 0, '669864000108'),
(207, 'COFEEMATE', 'Producto', '18.97', '23.50', 0, 0, '7501058619228'),
(208, 'CAL. C TOSE 100 GR', 'Producto', '8.22', '10.50', 0, 0, '7506205804489'),
(209, 'CHOCO MILK SOBRE 160 GR', 'Producto', '13.61', '18.00', 0, 0, '7506205807589'),
(210, 'NESCAFE DECAF48 GR', 'Producto', '43.33', '52.50', 0, 0, '7501059285415'),
(211, 'NESCAFE CLASICO 95GR', 'Producto', '43.33', '52.50', 0, 0, '7501059285354'),
(212, 'NESCAFE DOLCA 46 GR', 'Producto', '16.97', '20.00', 0, 0, '7501058620002'),
(213, 'NESCAFE DOLCA 80 GR', 'Producto', '28.63', '38.00', 0, 0, '7501058620019'),
(214, 'NESCAFE DOLCA 170 GR', 'Producto', '46.91', '57.00', 0, 0, '7501058616548'),
(215, 'SAL CON AJO 140 GR CON AJO', 'Producto', '16.51', '21.50', 0, 0, '7503005100063'),
(216, 'CANELA MOLIDA 35 GR', 'Producto', '13.21', '16.50', 0, 0, '7503005100049'),
(217, 'PIMIENTA MOLIDA 40 GR', 'Producto', '9.63', '12.50', 0, 0, '7503005100001'),
(218, 'PIMIENTA MOLIDA 80 GR', 'Producto', '16.59', '21.00', 0, 0, '7503005100018'),
(219, 'GERBER FRUTAS MIXTAS ', 'Producto', '8.94', '12.00', 0, 0, '75003463'),
(220, 'GERBER FRUTAS TROPICALES', 'Producto', '8.94', '12.00', 0, 0, '75003456'),
(221, 'GERBER DURAZNO', 'Producto', '8.94', '12.00', 0, 0, '75003371'),
(222, 'GERBER MANZANA', 'Producto', '8.94', '12.00', 0, 0, '75003388'),
(223, 'BOLSA DE CARBON ', 'Producto', '28.55', '37.00', 0, 0, '7501234567008'),
(224, 'SOPA ESPAGETI', 'Producto', '3.94', '5.00', 0, 0, '7503019241004'),
(225, 'MARUCHAN CON LIMON Y HABANERO', 'Producto', '6.24', '8.00', 0, 0, '041789001864'),
(226, 'MARUCHAN CON LIMON Y CHILE PIQUIN ', 'Producto', '6.24', '8.00', 0, 0, '041789001987'),
(227, 'MARUCHAN CON CAMARON', 'Producto', '6.24', '8.00', 0, 0, '041789001956'),
(228, 'AROS 1K', 'Producto', '12.47', '16.00', 0, 0, '7501722112116'),
(229, 'AROS 500 GR', 'Producto', '6.34', '9.00', 0, 0, '7501722112215'),
(230, 'ARROS 250 GR', 'Producto', '3.53', '5.00', 0, 0, '7501722112314'),
(231, 'LEVADURA SAF INSTANT 125 GR', 'Producto', '4.75', '18.50', 0, 0, '017929418229'),
(232, 'LEVADURA SAF INSTANT 500 GR', 'Producto', '51.73', '65.00', 0, 0, '017929244446'),
(233, 'SOPA FIDEO ', 'Producto', '3.94', '5.00', 0, 0, '7503019241035'),
(234, 'SOPA CODITO ', 'Producto', '3.94', '5.00', 0, 0, '7503019241080'),
(235, 'SOPA PULMILLA', 'Producto', '3.94', '5.00', 0, 0, '7503019241097'),
(236, 'MASECA', 'Producto', '9.31', '12.00', 0, 0, '7501077400050'),
(237, 'SAL MAR DE CORTEZ 1 K', 'Producto', '4.14', '5.00', 0, 0, '7501369812226'),
(238, 'AVENA  TRES MINUTOS  400GR.', 'Producto', '15.85', '19.50', 0, 0, '7501761810394'),
(239, 'ARINA DILUVIO', 'Producto', '7.28', '9.00', 0, 0, '7501404601013'),
(240, 'HARINA RICA SINALOA', 'Producto', '7.49', '9.50', 0, 0, '7501510500019'),
(241, 'HARINA DEL VALLE', 'Producto', '8.56', '10.50', 0, 0, '7501083701011'),
(242, 'HARINA SELECTA ', 'Producto', '7.70', '9.50', 0, 0, '7501404603116'),
(243, 'HARINA PARA HOT CAKES', 'Producto', '21.59', '26.50', 0, 0, '7501761869156'),
(244, 'MAIZENA BLANCA 160 GR', 'Producto', '10.19', '13.00', 0, 0, '7501005110389'),
(245, 'MAIZENA BLNCA 95 GR', 'Producto', '6.45', '9.00', 0, 0, '7501005110242'),
(246, 'REAL 100 GR', 'Producto', '7.63', '10.00', 0, 0, '013602000200'),
(247, 'REXAL 50 GR', 'Producto', '5.07', '6.50', 0, 0, '013602000101'),
(248, 'TRADIPAN LEVADURA CASERA ', 'Producto', '14.33', '18.00', 0, 0, '017929111014'),
(249, 'AZÙCAR ZULCA  1K', 'Producto', '17.88', '21.50', 0, 0, '661440000014'),
(250, 'CEREAL NESQUIK 150 GR', 'Producto', '12.17', '16.00', 0, 0, '7501059236981'),
(251, 'CHOCO CRISPIT 310 GR', 'Producto', '24.14', '30.00', 0, 0, '7501008015438'),
(252, 'FROOT LOOPS 180 GR ', 'Producto', '24.02', '30.00', 0, 0, '7501008015339'),
(253, 'CORN FLAKES KELLOGS 150 GR', 'Producto', '13.59', '16.50', 0, 0, '7501008101049'),
(254, 'CORN FLAKES MICHELL', 'Producto', '10.88', '13.00', 0, 0, '724609323796'),
(255, 'ZUCARITAS KELLOGS 260 GR', 'Producto', '21.45', '27.00', 0, 0, '7501008042984'),
(256, 'CORN FLAKES 560 GR ', 'Producto', '29.90', '38.00', 0, 0, '7501008000694'),
(257, 'CHOCO KONG MICHELL 198GR', 'Producto', '9.87', '14.00', 0, 0, '724609323833'),
(258, 'FREEZER FLAKES MICHELL 198GR', 'Producto', '10.88', '13.00', 0, 0, '724609323819'),
(259, 'MAIZORO AZUCARADA 817GR', 'Producto', '27.82', '35.00', 0, 0, '7501067712057'),
(260, 'ACEITE KARTAMUS 900LT', 'Producto', '17.33', '21.00', 0, 0, '7501048102501'),
(261, 'ACEITE CRISTAL MAIZ 1L', 'Producto', '21.83', '27.00', 0, 0, '7501048100170'),
(262, 'ACEITE HOGAR OMEGA 900LT', 'Producto', '13.39', '20.00', 0, 0, '745819008372'),
(263, 'ACEITE SARITA 900LT', 'Producto', '16.70', '20.00', 0, 0, '7502218211627'),
(264, 'ACEITE CAPÑULLO 905LT', 'Producto', '25.13', '30.00', 0, 0, '7502223770805'),
(265, 'ACEITE NUTRIOLI 946LT', 'Producto', '23.40', '30.00', 0, 0, '7501039120149'),
(266, 'ACEITE MACEITE 900L', 'Producto', '23.90', '28.00', 0, 0, '7501078007029'),
(267, 'ACEITE CRISTAL 500ML', 'Producto', '11.07', '14.00', 0, 0, '7501048100217'),
(268, 'ACEITE CAPULLO 400ML', 'Producto', '11.50', '14.00', 0, 0, '75041663'),
(269, 'ACEITE NUTRIOLI 473ML', 'Producto', '11.66', '15.00', 0, 0, '7501039126004'),
(270, 'ACEITE MACEITE 500ML', 'Producto', '11.81', '15.00', 0, 0, '7501078007067'),
(271, 'CLAM PASIFIC MIX 1 L', 'Producto', '15.90', '20.00', 0, 0, '738545080019'),
(272, 'KERMATO 950ML', 'Producto', '21.57', '27.00', 0, 0, '7501059233676'),
(273, 'FRIJOL LA COSTEÑA 470gr', 'Producto', '7.50', '10.00', 0, 0, '7501017042920'),
(274, 'GALLETAS RICANELA 113G', 'Producto', '7.98', '10.00', 0, 0, '7501000649754'),
(275, 'PAN CREMA ', 'Producto', '5.11', '6.50', 0, 0, '7501000645756'),
(276, 'GALLETA DE NIEVE FRESA', 'Producto', '13.04', '16.00', 0, 0, '7501000612147'),
(277, 'GALLETA CREMA VAINILLA', 'Producto', '13.04', '16.00', 0, 0, '7501000612161'),
(278, 'GALLETA CREMA CHOCOLATE', 'Producto', '13.04', '16.00', 0, 0, '7501000612130'),
(279, 'GALLETA MARIA ', 'Producto', '6.92', '9.00', 0, 0, '7501000658923'),
(280, 'GALLETA CRAKETS135GR', 'Producto', '7.73', '10.00', 0, 0, '7501000629770'),
(281, 'GALLETA CRAKETS 95GR', 'Producto', '6.24', '8.00', 0, 0, '7501000612543'),
(282, 'GALLETA MARAVILLA 116GR', 'Producto', '7.44', '9.50', 0, 0, '7501000641482'),
(283, 'GALLETA CHISPITA 143GR', 'Producto', '7.43', '9.50', 0, 0, '077204002352'),
(284, 'GALLETA ANIMALITO 150 GR', 'Producto', '4.78', '6.00', 0, 0, '077204000495'),
(285, 'GALLETA SALADA 137GR', 'Producto', '7.40', '10.00', 0, 0, '7501000658404'),
(286, 'ARIZONA SANDIA', 'Producto', '9.42', '11.50', 0, 0, '613008738846'),
(287, 'ARIZONA MANGO', 'Producto', '9.42', '11.50', 0, 0, '613008738808'),
(288, 'ARIZONA NEGRO C/SABOR LIMON', 'Producto', '9.42', '11.50', 0, 0, '613008738761'),
(289, 'PURE 1 KG', 'Producto', '17.90', '21.00', 0, 0, '7501079702848'),
(290, 'MANTECA INCA 250G', 'Producto', '9.36', '11.00', 0, 0, '7502223774001'),
(291, 'MANTECA INCA 500G', 'Producto', '16.38', '20.00', 0, 0, '7502223774018'),
(292, 'MANTECA INCA 1K', 'Producto', '28.89', '33.00', 0, 0, '7502223774025'),
(293, 'MANTECA LIRIO 500G', 'Producto', '10.86', '14.00', 0, 0, '7501119901019'),
(294, 'MANTECA LIRIO 1K', 'Producto', '20.36', '24.00', 0, 0, '7501119901002'),
(295, 'LECHE CLAVEL EN POLVO', 'Producto', '36.22', '41.50', 0, 0, '7501059277496'),
(296, 'NUTRILECHE 1L', 'Producto', '13.50', '15.00', 0, 0, '7501020540666'),
(297, 'CHAMOY MEGA 500 G', 'Producto', '8.39', '11.00', 0, 0, '738545020015'),
(298, 'CHAMOY MEGA 1 K', 'Producto', '13.95', '19.00', 0, 0, '738545020046'),
(299, 'JUMEX UVA 1L', 'Producto', '10.00', '18.00', 0, 0, '7501013122145'),
(300, 'JUMEX DURAZNO 1L', 'Producto', '10.00', '18.00', 0, 0, '7501013122053'),
(301, 'JUMEX NARANJA 1L', 'Producto', '10.00', '18.00', 0, 0, '7501013122138'),
(302, 'JUMEX MANZANA 1L', 'Producto', '10.00', '18.00', 0, 0, '7501013122190'),
(303, 'JUMEX PIÑA LATA 335ML', 'Producto', '6.63', '8.00', 0, 0, '7501013118117'),
(304, 'JUMEX PAPAYA Y PIÑA  335ML', 'Producto', '6.63', '8.00', 0, 0, '7501013118094'),
(305, 'JUMEX MANZANA335ML', 'Producto', '6.63', '8.00', 0, 0, '7501013118193'),
(306, 'JUMEX DURAZNO 335ML', 'Producto', '6.63', '8.00', 0, 0, '7501013118056'),
(307, 'JUMEX DURAZNO BOTELLA  450ML', 'Producto', '7.51', '10.00', 0, 0, '7501013174052'),
(308, 'JUMEX MANZANA BOTELLA 450 ML', 'Producto', '7.51', '10.00', 0, 0, '7501013174199'),
(309, 'AFGUA FRESCA JAMAICA 450ML', 'Producto', '7.18', '10.00', 0, 0, '7501013197235'),
(310, 'AGUIA FRESCA  FRSA 450ML', 'Producto', '7.18', '10.00', 0, 0, '7501013197181'),
(311, 'AGUA FRSCA LIMON 450ML', 'Producto', '7.18', '10.00', 0, 0, '7501013197242'),
(312, 'AGUA FRESCA HORCHATA 450ML', 'Producto', '7.18', '10.00', 0, 0, '7501013197273'),
(313, 'VIVE 100', 'Producto', '8.20', '10.00', 0, 0, '7506192505437'),
(314, 'KERMATO LATA 340ML', 'Producto', '8.77', '11.00', 0, 0, '7501001683207'),
(315, 'POWER UVA 1L', 'Producto', '15.00', '21.00', 0, 0, '7501055329373'),
(316, 'POWER MORA 1L ', 'Producto', '15.00', '21.00', 0, 0, '7501055317653'),
(317, 'JUGITO BIG CITRUS', 'Producto', '3.48', '5.00', 0, 0, '7506241201181'),
(318, 'JUGITO FLORIDA 7', 'Producto', '2.30', '3.50', 0, 0, '7501055333837'),
(319, 'JUGO V8', 'Producto', '7.25', '9.00', 0, 0, '7501003126221'),
(320, 'JUMEX DURAZNO 200 ML', 'Producto', '4.08', '5.00', 0, 0, '75010935'),
(321, 'JUGO JUMEX MANZANA 200 ML', 'Producto', '4.08', '5.00', 0, 0, '75010928'),
(322, 'JUGO PAU PAU UVA ', 'Producto', '2.70', '3.50', 0, 0, '7501013154146'),
(323, 'JUGO PAU PAU FRESA', 'Producto', '2.50', '3.50', 0, 0, '7501013154184'),
(324, 'JUGO PAU PAU MANZANA', 'Producto', '2.50', '3.50', 0, 0, '7501013154023'),
(325, 'JUGO BIDA MANZANA 500 ML', 'Producto', '5.62', '7.00', 0, 0, '7501013191028'),
(326, 'JUGO BIDA NARANJA', 'Producto', '5.62', '7.00', 0, 0, '7501013191134'),
(327, 'JUGO BIDA FESA', 'Producto', '5.62', '7.00', 0, 0, '7501013191219'),
(328, 'JUGO DE BIDA UVA ', 'Producto', '5.62', '7.00', 0, 0, '7501013191141'),
(329, 'JUGO BIDA GUAYABA', 'Producto', '5.62', '7.00', 0, 0, '7501013191066'),
(330, 'JUGO BIDA PIÑA', 'Producto', '5.62', '7.00', 0, 0, '7501013191110'),
(331, 'KERMATO BOTELLA 470 ML', 'Producto', '11.56', '15.00', 0, 0, '7501001609023'),
(332, 'SUERO ELECTROLIT COCO 625ML', 'Producto', '14.71', '18.00', 0, 0, '7501125104411'),
(333, 'SUERO ELECTROLIT FRESA 625ML', 'Producto', '14.71', '18.00', 0, 0, '7501125104268'),
(334, 'SUERO ELECTROLIT MANZANA', 'Producto', '14.71', '18.00', 0, 0, '7501125104343'),
(335, 'SUERO ELECTROLIT DURAZNO 625ML', 'Producto', '14.71', '18.00', 0, 0, '7501125104183'),
(336, 'CLAMATO CARTON 1L', 'Producto', '90.96', '120.00', 0, 0, '070378910003'),
(337, 'JARCIA ', 'Producto', '90.96', '120.00', 0, 0, 'JARCIA '),
(338, 'GUANTES HULE MEDIANO ', 'Producto', '11.73', '15.00', 0, 0, '7502224241274'),
(339, 'CINTA SCOTCH', 'Producto', '1.03', '2.00', 0, 0, '7501887511120'),
(340, 'LIBRETA SELECTO ', 'Producto', '10.49', '14.00', 0, 0, '7501593810005'),
(341, 'KOLA LOCA', 'Producto', '11.23', '14.00', 0, 0, '7501102614001'),
(342, 'TOP', 'Producto', '10.89', '14.00', 0, 0, '7501310010619'),
(343, 'CINTA NEGRA', 'Producto', '7.02', '10.00', 0, 0, '108'),
(344, 'CEPILLOS PARA ROPA', 'Producto', '9.25', '12.00', 0, 0, '109'),
(345, 'MAIZENAS FERSA', 'Producto', '4.67', '6.00', 0, 0, '7501005106801'),
(346, 'MAIZENA CHOCOLATE ', 'Producto', '4.67', '6.00', 0, 0, '7501005107013'),
(347, 'MAIZENA VAINILLA', 'Producto', '4.67', '6.00', 0, 0, '7501005106979'),
(348, 'KNORR CALDO DE CAMARON', 'Producto', '5.34', '7.00', 0, 0, '7501005183666'),
(349, 'KNORR TOMATE ', 'Producto', '3.27', '5.00', 0, 0, '7501005180504'),
(350, 'CAJITA CONSOMATE', 'Producto', '3.06', '5.00', 0, 0, '7501059290051'),
(351, 'KNORR SUIZA CALDO DE POLLO', 'Producto', '3.08', '5.00', 0, 0, '7501005180306'),
(352, 'KNORR SUIZA COSTILLA JUGOSO ', 'Producto', '1.89', '2.50', 0, 0, '110'),
(353, 'CAJA METLICO', 'Producto', '1.23', '2.00', 0, 0, '7501147419227'),
(354, 'PLUMA NEGRA', 'Producto', '2.68', '3.50', 0, 0, '7501014511023'),
(355, 'PLUMA AZUL', 'Producto', '2.68', '3.50', 0, 0, '7501014511016'),
(356, 'CINTA TEFLON ', 'Producto', '3.78', '5.00', 0, 0, '111'),
(357, 'SOCKET CON CADENA ', 'Producto', '13.91', '20.00', 0, 0, '112'),
(358, 'SOCKET SENSILLO', 'Producto', '8.03', '12.00', 0, 0, '113'),
(359, 'SOCKET CON CABLE', 'Producto', '8.56', '13.00', 0, 0, '114'),
(360, 'CAJA RTEIDOLITO  ', 'Producto', '12.17', '3.00', 0, 0, '7502241360088'),
(361, 'PALMOLIVE 160 GR SENSACION HUMECTANTE', 'Producto', '10.82', '14.00', 0, 0, '7509546059167'),
(362, 'PALMOLIVE 110 GR SENCACION HUMECTANTE', 'Producto', '8.46', '11.00', 0, 0, '7509546052304'),
(363, 'PALMOLIVE NEUTRO BALANCE 110GR', 'Producto', '9.91', '12.50', 0, 0, '7509546058702'),
(364, 'PALMOLIVE NEUTRO BALANCE 160 GR ', 'Producto', '12.69', '16.00', 0, 0, '7509546059273'),
(365, 'JABON LIRIO NEUTRO 150 GR', 'Producto', '6.96', '10.00', 0, 0, '012388000022'),
(366, 'JABON BAÑO LIRIO 100 GR', 'Producto', '4.62', '6.50', 0, 0, '012388000084'),
(367, 'ZEST 150GR', 'Producto', '10.41', '13.00', 0, 0, '7506306238336'),
(368, 'ZEST 100 GR', 'Producto', '8.13', '10.00', 0, 0, '7506306238237'),
(369, 'CAMAY 150 GR', 'Producto', '10.00', '13.00', 0, 0, '7506306238640'),
(370, 'CAMAY 100GR', 'Producto', '8.13', '10.00', 0, 0, '7506306238756'),
(371, 'CEPILLO DE DIENTE ', 'Producto', '7.97', '12.00', 0, 0, '6910021007206'),
(372, 'TIRA SAVILE 24ML', 'Producto', '29.14', '2.50', 0, 0, '7506192505475'),
(373, 'TIRA SEDAL ', 'Producto', '1.87', '2.50', 0, 0, '7501056340261'),
(374, 'TIRA PANTENE', 'Producto', '1.87', '2.50', 0, 0, '27506295326568'),
(375, 'HEDAN SHOULDERS', 'Producto', '32.75', '38.00', 0, 0, '7590002008898'),
(376, 'RESISTOL BOLA', 'Producto', '1.55', '2.00', 0, 0, '7502212153008'),
(377, 'RASTRILLO GILLETE', 'Producto', '13.69', '17.50', 0, 0, '7501009222729'),
(378, 'RASTRILLO BUENOS DIAS ', 'Producto', '12.69', '15.00', 0, 0, '024500163027'),
(379, 'CHUPON ', 'Producto', '2.93', '5.00', 0, 0, '7501361151026'),
(380, 'CAJA CHILE DOÑA JUANITA ', 'Producto', '1.39', '2.00', 0, 0, '115'),
(381, 'NIDO ENTRA', 'Producto', '38.24', '48.48', 0, 0, '7501059281950'),
(382, 'NIDO KINDER', 'Producto', '49.75', '62.00', 0, 0, '7501059225411'),
(383, 'CHOCOMILK SOBRE', 'Producto', '2.83', '4.00', 0, 0, '7506205802355'),
(384, 'NESCAFE CAPUCCIONO ', 'Producto', '5.84', '7.00', 0, 0, '7501059292529'),
(385, 'COLGATE TRIPLE ACCION 75ML', 'Producto', '11.87', '15.00', 0, 0, '7509546000985'),
(386, 'COLGATE TRIPLE ACCION 50ML', 'Producto', '9.74', '12.00', 0, 0, '7509546003108'),
(387, 'COLGATE TOTAL 12', 'Producto', '9.69', '15.00', 0, 0, '7509546007083'),
(388, 'PEGAMENTO ADHESIVO 8GR', 'Producto', '4.61', '6.00', 0, 0, '7501310010503'),
(389, 'MAQUILLAJE BISU', 'Producto', '41.20', '57.00', 0, 0, '094922157584'),
(390, 'MAMILA', 'Producto', '3.24', '5.00', 0, 0, '759684153358'),
(391, 'LECHE NAN 1', 'Producto', '95.38', '110.00', 0, 0, '7501059235243'),
(392, 'LECHE NAN 2', 'Producto', '86.56', '100.00', 0, 0, '7501059235250'),
(393, 'BIBERON GRANDE ', 'Producto', '13.70', '16.00', 0, 0, '759684151101'),
(394, 'CREMA HIND NATURALS 90 GR', 'Producto', '9.38', '12.00', 0, 0, '75010416'),
(395, 'CREMA HINDS NATURALS 230GR', 'Producto', '19.11', '23.00', 0, 0, '7501027875778'),
(396, 'CREMA HAINS CLASIA 90GR', 'Producto', '9.14', '12.00', 0, 0, '75010690'),
(397, 'CREMA HINS CLASICA 230 GR', 'Producto', '19.00', '23.00', 0, 0, '7501027873156'),
(398, 'SHAMPO SAVILE BIOTINA 180 GR', 'Producto', '9.50', '12.50', 0, 0, '7506192505550'),
(399, 'SHAMPO SABILE KERATINA 180 GR', 'Producto', '9.58', '12.50', 0, 0, '7506192503426'),
(400, 'SHAMPO SABILE CHILE 180 GR', 'Producto', '9.58', '12.50', 0, 0, '7506192502610'),
(401, 'vaso reyma #8', 'Producto', '16.40', '19.50', 0, 0, '7502208800077'),
(402, 'vaso #6 reyma', 'Producto', '16.40', '18.00', 0, 0, '7502208800053'),
(403, 'vaso #12 reyma', 'Producto', '17.60', '25.00', 0, 0, '7502208800091'),
(404, 'PAÑAL CHICOLASTIC GRANDE (4)', 'Producto', '26.22', '35.00', 0, 0, '013117054149'),
(405, 'PAÑAL CHICOLASTIC ETAPA (3)', 'Producto', '22.52', '32.00', 0, 0, '013117053142'),
(406, 'PAÑAL CHICOLASTIC ETAPA (2)', 'Producto', '19.28', '26.00', 0, 0, '013117010879'),
(407, 'PAÑAL ABSORSEC GRANDE 14 PAÑALES', 'Producto', '33.48', '42.00', 0, 0, '7501017375189'),
(408, 'PAÑAL CHICOLASTIC ETAPA 5 (14)', 'Producto', '30.68', '40.00', 0, 0, '013117011746'),
(409, 'PAÑAL AFECTIVE  MEDIANO', 'Producto', '50.70', '65.00', 0, 0, '013117016260'),
(410, 'PAÑAL AFECTIVE GRANDE', 'Producto', '65.14', '83.00', 0, 0, '013117016314'),
(411, 'JABON UTIL 500 G', 'Producto', '9.08', '12.00', 0, 0, '12388000749'),
(412, 'FLASH BRISA MARINA 1L', 'Producto', '10.53', '13.50', 0, 0, '7501025440305'),
(413, 'SAVILE MIEL 750', 'Producto', '29.59', '36.50', 0, 0, '7506192501026'),
(414, 'CHILE PARA NACHOS 220', 'Producto', '7.54', '10.00', 0, 0, '7501017005062'),
(415, 'GERBER PERA', 'Producto', '8.94', '12.00', 0, 0, '75003401'),
(416, 'GERBER  VERDURAS CON CARNE ARROZ', 'Producto', '8.94', '12.00', 0, 0, '7501000904242'),
(417, 'SOPA CONCHITAS', 'Producto', '3.94', '5.00', 0, 0, '7503019241066'),
(419, 'SAL YAVAROS', 'Producto', '2.19', '5.00', 0, 0, '7503000331011'),
(420, 'ACEITE AVE 900ML', 'Producto', '16.50', '20.00', 0, 0, '7501039121436'),
(421, 'ARIZONA TE NEGRO FRAMBUESA', 'Producto', '9.42', '11.50', 0, 0, '613008738785'),
(422, 'ARIZONA TE VERDE CON MIEL', 'Producto', '9.42', '11.50', 0, 0, '613008738884'),
(423, 'ARIZONA KIWI CON FRESA', 'Producto', '9.42', '11.50', 0, 0, '613008738822'),
(424, 'MANTECA LIRIO 250G', 'Producto', '7.06', '9.00', 0, 0, '7501119901057'),
(425, 'MEDIA CREMA NESTLE', 'Producto', '7.47', '9.00', 0, 0, '7501059297289'),
(426, 'NUTRI LECHE GALON 1L', 'Producto', '11.50', '13.00', 0, 0, '7502217043519'),
(427, 'HARIMASA', 'Producto', '8.99', '11.00', 0, 0, '7503004488001'),
(428, 'VANART CLASICO AZUL750ML', 'Producto', '20.65', '35.00', 0, 0, '650240033148'),
(429, 'ARINA PASCOLA', 'Producto', '11.51', '13.50', 0, 0, '7501083707013'),
(430, 'MASA DE MAIZ', 'Producto', '9.31', '12.00', 0, 0, '7501411670743');

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
(5, 'ABARROTES DIANA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cartera`
--

CREATE TABLE `cartera` (
  `idCartera` bigint(20) NOT NULL,
  `Fecha` date DEFAULT NULL,
  `idCliente` bigint(20) DEFAULT NULL,
  `Observaciones` varchar(1000) DEFAULT NULL,
  `Importe` double DEFAULT NULL,
  `CargoAbono` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cartera`
--

INSERT INTO `cartera` (`idCartera`, `Fecha`, `idCliente`, `Observaciones`, `Importe`, `CargoAbono`) VALUES
(3, '2016-10-17', 17, 'sdsgfd', 1000, 'Cargo'),
(4, '2016-10-17', 17, 'Deudas del cliente', 4000, 'Cargo'),
(5, '2016-10-17', 17, 'Deudas simples', 4000, 'Cargo'),
(6, '2016-10-17', 17, 'pago', 5000, 'Abono');

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
(00000000000000000017, 'PUBLICO EN GENERAL', '', 'as', 's', 's', 'XXX000X', '2015-01-01', '', '', '81110', 'CAMAJOA');

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
('ABARROTES DIANA', 'ABARROTES DIANA', 'SIN RFC', '6981095875', 'CALLE PRINCIPAL', 'CAMAJOA', '0001 MEXICO', '0006 SINALOA', 0x89504e470d0a1a0a0000000d49484452000000ab0000006f08020000001cf3a7ec000000017352474200aece1ce90000000467414d410000b18f0bfc6105000000097048597300000ec300000ec301c76fa8640000011149444154785eedd20101000008c320fb97be411819b8c5d6005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d03740dd03540d7005d036cdb036bd59d8557f0adcf0000000049454e44ae426082);

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
  `ReportesCartera` tinyint(1) NOT NULL,
  `Scaner` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `gruposusuarios`
--

INSERT INTO `gruposusuarios` (`IdGrupoUsuario`, `Descripcion`, `accesoUsuarios`, `accesoGrupos`, `accesoClientes`, `accesoArticulos`, `accesoConfiguracion`, `accesoInventario`, `abcBodegas`, `abcTipoFlujo`, `ReportesInventarios`, `Puntos_venta`, `Venta`, `ReportesVenta`, `Cartera`, `ReportesCartera`, `Scaner`) VALUES
(2, 'PRUEBAS', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(9, 'Administrador', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 'Supervisor', 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11, 'Desarrollador', 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(12, 'Inventario', 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(21, 's', 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(22, '1', 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(23, '2', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(24, '3', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(25, '4', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(26, '5', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(27, '6', 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);

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
  `Registro` bigint(20) UNSIGNED NOT NULL,
  `idPuntoVenta` bigint(20) NOT NULL,
  `idVenta` bigint(20) NOT NULL,
  `RegistroVenta` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `inventarioproductos`
--

INSERT INTO `inventarioproductos` (`EntradaSalida`, `idTipoFlujo`, `idBodega`, `idFolio`, `Producto`, `Descripcion`, `Cantidad`, `Precio`, `ImporteTotal`, `Registro`, `idPuntoVenta`, `idVenta`, `RegistroVenta`) VALUES
('Entrada', 4, 2, 3, 0, '', '1.0000', '0.00', '0.00', 2, 0, 0, 0),
('Entrada', 4, 2, 3, 0, '', '1.0000', '0.00', '0.00', 3, 0, 0, 0),
('Entrada', 4, 4, 1, 4, 'Platanos', '200.0000', '3.00', '2000.00', 1, 0, 0, 0),
('Entrada', 4, 4, 1, 1, 'Limones', '5.0000', '5.00', '25.00', 3, 0, 0, 0),
('Entrada', 4, 4, 2, 5, 'Guayabas', '12.0000', '1.00', '12.00', 1, 0, 0, 0),
('Entrada', 4, 4, 3, 4, 'Platanos', '123.0000', '3.00', '369.00', 1, 0, 0, 0),
('Entrada', 4, 4, 3, 4, 'Platanos', '31.0000', '3.00', '93.00', 2, 0, 0, 0),
('Entrada', 4, 4, 3, 5, 'Guayabas', '54.0000', '1.00', '54.00', 3, 0, 0, 0),
('Entrada', 4, 5, 1, 13, 'GELATINA PRONTO UVA', '15.0000', '7.44', '111.60', 1, 0, 0, 0),
('Entrada', 4, 5, 2, 12, 'GELATINA PRONTO PIÑA', '2.0000', '7.44', '14.88', 1, 0, 0, 0),
('Entrada', 4, 5, 2, 13, 'GELATINA PRONTO UVA', '2.0000', '7.44', '14.88', 2, 0, 0, 0),
('Entrada', 4, 5, 2, 14, 'GELATINA PRONTO LIMON', '2.0000', '7.44', '14.88', 3, 0, 0, 0),
('Entrada', 4, 5, 3, 13, 'GELATINA PRONTO UVA', '2.0000', '7.44', '14.88', 1, 0, 0, 0),
('Entrada', 4, 5, 3, 14, 'GELATINA PRONTO LIMON', '2.0000', '7.44', '14.88', 2, 0, 0, 0),
('Entrada', 4, 5, 3, 15, 'GELATINA PRONTO FRESA', '2.0000', '7.44', '14.88', 3, 0, 0, 0),
('Entrada', 4, 5, 3, 16, 'GELATINA PRONTO PIÑA', '2.0000', '7.44', '14.88', 4, 0, 0, 0),
('Entrada', 4, 5, 3, 17, 'GELATINA JELLO FRAMBUESA SOBRE', '2.0000', '7.35', '14.70', 5, 0, 0, 0),
('Entrada', 4, 5, 3, 18, 'GELATINA JELLO NARANJA SOBRE', '2.0000', '7.35', '14.70', 6, 0, 0, 0),
('Entrada', 4, 5, 3, 19, 'GELATINA UVA SOBRE', '2.0000', '7.35', '14.70', 7, 0, 0, 0),
('Entrada', 4, 5, 3, 20, 'GELATINA PIÑA SOBRE', '2.0000', '7.35', '14.70', 8, 0, 0, 0),
('Entrada', 4, 5, 3, 21, 'GELATINA LIMON SOBRE', '2.0000', '7.35', '14.70', 9, 0, 0, 0),
('Entrada', 4, 5, 3, 23, 'GELATINA PRONTO NARANJA', '2.0000', '7.44', '14.88', 10, 0, 0, 0),
('Entrada', 4, 5, 8, 30, 'TRAPEADOR MAGITEL ', '3.0000', '17.38', '52.14', 2, 0, 0, 0),
('Entrada', 4, 5, 8, 29, 'ESCOBA  DE ESPIGA ', '5.0000', '34.13', '170.65', 4, 0, 0, 0),
('Entrada', 4, 5, 8, 32, 'SERVILLETA COCINA IRIS', '5.0000', '8.02', '40.10', 6, 0, 0, 0),
('Entrada', 4, 5, 8, 33, 'TENEDOR JAGUAR ', '4.0000', '5.51', '22.04', 8, 0, 0, 0),
('Entrada', 4, 5, 8, 34, 'CUCHARA JAGUAR CHICA', '4.0000', '5.80', '23.20', 10, 0, 0, 0),
('Entrada', 4, 5, 8, 36, 'CUCHARA FANTASY GRANDE', '1.0000', '8.15', '8.15', 12, 0, 0, 0),
('Entrada', 4, 5, 8, 37, 'PLATO HONDO CHICO REYMA', '1.0000', '8.72', '8.72', 14, 0, 0, 0),
('Entrada', 4, 5, 8, 41, 'CHAROLA CHICA MARIEL', '4.0000', '13.41', '53.64', 16, 0, 0, 0),
('Entrada', 4, 5, 8, 39, 'PLATO HONDO JAGUAR', '3.0000', '12.76', '38.28', 18, 0, 0, 0),
('Entrada', 4, 5, 8, 40, 'CHAROLA CHICA JAGUAR ', '4.0000', '13.41', '53.64', 20, 0, 0, 0),
('Entrada', 4, 5, 8, 38, 'CHAROLA MARIL S/DIVISION', '1.0000', '13.58', '13.58', 22, 0, 0, 0),
('Entrada', 4, 5, 8, 42, 'CHAROLA CON DIVISION REYMA', '5.0000', '10.46', '52.30', 24, 0, 0, 0),
('Entrada', 4, 5, 8, 45, 'VASO TERMICO #8 REYMA', '4.0000', '6.57', '26.28', 26, 0, 0, 0),
('Entrada', 4, 5, 8, 46, 'VASO TERMICO #10 REYMA', '3.0000', '8.48', '25.44', 28, 0, 0, 0),
('Entrada', 4, 5, 9, 401, 'vaso reyma #8', '1.0000', '16.40', '16.40', 2, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '12.0000', '12.74', '152.88', 12, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLET123', '312.0000', '12.74', '3974.88', 14, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 18, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 20, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 22, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 24, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 26, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 30, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 32, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 34, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 36, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 38, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 40, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 42, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 44, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 46, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 48, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 50, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 52, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 54, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 56, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 58, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 60, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 62, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 64, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 66, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 68, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 70, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 72, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 74, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 76, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 78, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 82, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 84, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 90, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 92, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 94, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 96, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 98, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 100, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 102, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 104, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 106, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 108, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 110, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 112, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 114, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 118, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 119, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 123, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 125, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 129, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 131, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 133, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 135, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 137, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 139, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 141, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 143, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 145, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 147, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 149, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 151, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 153, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 155, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 159, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 160, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 162, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 164, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 166, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 168, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 170, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 172, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 174, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 176, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 178, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 180, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 182, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 184, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 188, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 191, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 193, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 195, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 197, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 201, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 203, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 205, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 207, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 209, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 211, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 212, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 213, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 215, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 217, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 218, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 219, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 221, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 223, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 225, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 227, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 229, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 231, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 233, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 235, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 237, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 239, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 241, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 243, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 245, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 247, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 250, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 252, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 254, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 260, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 261, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 263, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 265, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 267, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 269, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 271, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 273, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 280, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 282, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 284, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 286, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 288, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 289, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 291, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 293, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 295, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 297, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 299, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 301, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 303, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 305, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 307, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 309, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 311, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 313, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 315, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 317, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 319, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 321, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 323, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 325, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 327, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 329, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 331, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 333, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 335, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 337, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 339, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 341, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 342, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 343, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 344, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 345, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 346, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 348, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 350, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 352, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 354, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 358, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 359, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 360, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 362, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 364, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 366, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 368, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 370, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 372, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 374, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 376, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 378, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 380, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 382, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 384, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 386, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 388, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 390, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 391, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 393, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 395, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 397, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 398, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 400, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 402, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 404, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 406, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 408, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 410, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 412, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 416, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 418, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 420, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 422, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 424, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 426, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 428, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 430, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 432, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 434, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 436, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 438, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 440, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 442, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 444, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 446, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 448, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 450, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 452, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 454, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 456, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 457, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 459, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 460, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 461, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 462, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 464, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 469, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 471, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 473, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 475, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 477, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 479, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 481, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 483, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 485, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 487, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 489, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 491, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 493, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 495, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 496, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 498, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 500, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 502, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 504, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 506, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 508, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 510, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 512, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 514, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 516, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 518, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 520, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 522, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 524, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 526, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 528, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 530, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 532, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 534, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 537, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 538, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 539, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 540, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 541, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 542, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 543, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 544, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 545, 0, 0, 0),
('Entrada', 4, 5, 10, 48, 'SERVILLETA GRANDE VELVET', '10.0000', '12.74', '127.40', 546, 0, 0, 0),
('Salida', 0, 5, 0, 176, 'null', '1.0000', '16.50', '16.50', 1, 1, 1, 0),
('Salida', 0, 5, 0, 190, 'null', '1.0000', '5.00', '5.00', 2, 1, 1, 0),
('Salida', 0, 5, 0, 191, 'null', '1.0000', '4.50', '4.50', 3, 1, 2, 0),
('Salida', 0, 5, 0, 296, 'null', '1.0000', '15.00', '15.00', 4, 1, 3, 0),
('Salida', 0, 5, 0, 133, 'null', '1.0000', '20.00', '20.00', 5, 1, 4, 0),
('Salida', 0, 5, 0, 135, 'null', '1.0000', '6.00', '6.00', 6, 1, 5, 0),
('Salida', 0, 5, 0, 135, 'null', '1.0000', '6.00', '6.00', 7, 1, 5, 0),
('Salida', 0, 5, 0, 97, 'null', '1.0000', '12.00', '12.00', 8, 1, 5, 0),
('Salida', 0, 5, 0, 146, 'null', '1.0000', '6.50', '6.50', 9, 1, 6, 0),
('Salida', 0, 5, 0, 295, 'null', '1.0000', '41.50', '41.50', 11, 1, 7, 0),
('Salida', 0, 5, 0, 406, 'null', '1.0000', '26.00', '26.00', 12, 1, 7, 0),
('Salida', 0, 5, 0, 406, 'null', '1.0000', '26.00', '26.00', 13, 1, 7, 0),
('Salida', 0, 5, 0, 406, 'null', '1.0000', '26.00', '26.00', 14, 1, 7, 0),
('Salida', 0, 5, 0, 56, 'null', '1.0000', '95.00', '95.00', 15, 1, 8, 0),
('Salida', 0, 5, 0, 212, 'null', '1.0000', '20.00', '20.00', 16, 1, 9, 0),
('Salida', 0, 5, 0, 161, 'null', '1.0000', '14.00', '14.00', 17, 1, 11, 0),
('Salida', 0, 5, 0, 47, 'null', '1.0000', '8.50', '8.50', 18, 1, 12, 0),
('Salida', 0, 5, 0, 280, 'null', '1.0000', '10.00', '10.00', 19, 1, 13, 0),
('Salida', 0, 5, 0, 296, 'null', '1.0000', '15.00', '15.00', 20, 1, 14, 0),
('Salida', 0, 5, 0, 250, 'null', '1.0000', '16.00', '16.00', 21, 1, 14, 0);

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
-- Estructura de tabla para la tabla `metodopago`
--

CREATE TABLE `metodopago` (
  `Clave` varchar(5) NOT NULL,
  `Descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('Entrada', 4, 5, 1, '2016-09-10', 17, 'F', ''),
('Entrada', 4, 5, 2, '2016-09-10', 17, 'F', ''),
('Entrada', 4, 5, 3, '2016-09-10', 17, '', '\n'),
('Entrada', 4, 5, 4, '2016-09-12', 17, '', ''),
('Entrada', 4, 5, 5, '2016-09-12', 17, '', ''),
('Entrada', 4, 5, 6, '2016-09-30', 17, '', ''),
('Entrada', 4, 5, 7, '2016-09-30', 17, '', ''),
('Entrada', 4, 5, 8, '2016-09-30', 17, '', ''),
('Entrada', 4, 5, 9, '2016-10-01', 17, '', ''),
('Entrada', 4, 5, 10, '2016-10-01', 17, '', 'QWEQ'),
('Entrada', 4, 5, 11, '2016-10-01', 17, '', ''),
('Entrada', 4, 5, 12, '2016-10-02', 1, '1', 's');

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
-- Estructura de tabla para la tabla `puntosventa`
--

CREATE TABLE `puntosventa` (
  `idPuntoVenta` int(11) NOT NULL,
  `Descripcion` varchar(500) NOT NULL,
  `idBodega` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `puntosventa`
--

INSERT INTO `puntosventa` (`idPuntoVenta`, `Descripcion`, `idBodega`) VALUES
(1, 'CAMAJOA', '5');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

CREATE TABLE `reportes` (
  `idReporte` bigint(20) NOT NULL,
  `NombreReporte` varchar(150) NOT NULL,
  `Descripcion` varchar(150) NOT NULL,
  `Consulta` varchar(150) NOT NULL,
  `programa` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `reportes`
--

INSERT INTO `reportes` (`idReporte`, `NombreReporte`, `Descripcion`, `Consulta`, `programa`) VALUES
(1, 'repInformeExistencias', 'INFORME DE EXISTENCIAS', 'call PAL_InformeExistencias', 'INV'),
(2, 'repInformeVentas', 'INFORME DE VENTAS', 'call PAL_VENTASTOTALES', 'VEN'),
(3, 'repInformeVentasFecha', 'INFORME DE VENTAS POR FECHA', 'SELECT * FROM VENTAS', 'VEN'),
(4, 'repInformeExistenciasFecha', 'REPORTE DE COMPRAS POR FECHA', '?', 'INV'),
(5, 'repEstadoCuenta', 'Estado de cuenta', '?', 'CAR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportescampos`
--

CREATE TABLE `reportescampos` (
  `idReporte` int(11) NOT NULL,
  `nombreCampo` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `reportescampos`
--

INSERT INTO `reportescampos` (`idReporte`, `nombreCampo`) VALUES
(3, 'rFechas'),
(4, 'rFechas');

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
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idVenta` bigint(20) NOT NULL,
  `PuntoVenta` bigint(20) NOT NULL,
  `Cliente` bigint(20) DEFAULT NULL,
  `Fecha` datetime NOT NULL,
  `MetodoDePago` varchar(5) NOT NULL,
  `NumCtaPago` varchar(20) NOT NULL,
  `Observaciones` varchar(800) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idVenta`, `PuntoVenta`, `Cliente`, `Fecha`, `MetodoDePago`, `NumCtaPago`, `Observaciones`) VALUES
(1, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(2, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(3, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(4, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(5, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(6, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(7, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(8, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(9, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(10, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(11, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(12, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(13, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(14, 1, 17, '2016-10-01 00:00:00', '', '', ''),
(15, 1, 0, '2016-10-02 00:00:00', '', '', ''),
(16, 1, 17, '2016-10-09 00:00:00', '', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventasproductos`
--

CREATE TABLE `ventasproductos` (
  `idPuntoVenta` bigint(20) NOT NULL,
  `idVenta` int(11) NOT NULL,
  `Registro` bigint(20) NOT NULL,
  `Producto` bigint(20) NOT NULL,
  `Descripcion` varchar(500) NOT NULL,
  `Cantidad` decimal(24,4) NOT NULL,
  `Precio` decimal(18,2) NOT NULL,
  `IVA` decimal(18,2) NOT NULL,
  `Importe_Neto` decimal(18,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ventasproductos`
--

INSERT INTO `ventasproductos` (`idPuntoVenta`, `idVenta`, `Registro`, `Producto`, `Descripcion`, `Cantidad`, `Precio`, `IVA`, `Importe_Neto`) VALUES
(1, 1, 1, 176, 'FRASCO KNOR TOMATE', '1.0000', '16.50', '0.00', '16.50'),
(1, 1, 2, 190, 'PURE EL FTE  CHICO 210 GR', '1.0000', '5.00', '0.00', '5.00'),
(1, 2, 3, 191, 'PURE HERDEZ 210 GR', '1.0000', '4.50', '0.00', '4.50'),
(1, 3, 4, 296, 'NUTRILECHE 1L', '1.0000', '15.00', '0.00', '15.00'),
(1, 4, 5, 133, 'PAPEL SUAVEL 4 ROLLOS', '1.0000', '20.00', '0.00', '20.00'),
(1, 5, 6, 135, 'PAPEL VOGUE 1 ROLLO', '1.0000', '6.00', '0.00', '6.00'),
(1, 5, 7, 135, 'PAPEL VOGUE 1 ROLLO', '1.0000', '6.00', '0.00', '6.00'),
(1, 5, 8, 97, 'JABON PINTO AZUL', '1.0000', '12.00', '0.00', '12.00'),
(1, 6, 9, 146, 'VELADORA DE REPUESTO ', '1.0000', '6.50', '0.00', '6.50'),
(1, 7, 11, 295, 'LECHE CLAVEL EN POLVO', '1.0000', '41.50', '0.00', '41.50'),
(1, 7, 12, 406, 'PAÑAL CHICOLASTIC ETAPA (2)', '1.0000', '26.00', '0.00', '26.00'),
(1, 7, 13, 406, 'PAÑAL CHICOLASTIC ETAPA (2)', '1.0000', '26.00', '0.00', '26.00'),
(1, 7, 14, 406, 'PAÑAL CHICOLASTIC ETAPA (2)', '1.0000', '26.00', '0.00', '26.00'),
(1, 8, 15, 56, 'CHICOLASTIC ETAPA 4 (40)', '1.0000', '95.00', '0.00', '95.00'),
(1, 9, 16, 212, 'NESCAFE DOLCA 46 GR', '1.0000', '20.00', '0.00', '20.00'),
(1, 11, 17, 161, 'MAYONESA McCORNIC 190GR.', '1.0000', '14.00', '0.00', '14.00'),
(1, 12, 18, 47, 'SERVILETA CHICA VELVET', '1.0000', '8.50', '0.00', '8.50'),
(1, 13, 19, 280, 'GALLETA CRAKETS135GR', '1.0000', '10.00', '0.00', '10.00'),
(1, 14, 20, 296, 'NUTRILECHE 1L', '1.0000', '15.00', '0.00', '15.00'),
(1, 14, 21, 250, 'CEREAL NESQUIK 150 GR', '1.0000', '16.00', '0.00', '16.00');

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
  ADD PRIMARY KEY (`idArticulo`),
  ADD UNIQUE KEY `codigoBarras` (`codigoBarras`);

--
-- Indices de la tabla `bodegas`
--
ALTER TABLE `bodegas`
  ADD PRIMARY KEY (`idBodega`);

--
-- Indices de la tabla `cartera`
--
ALTER TABLE `cartera`
  ADD PRIMARY KEY (`idCartera`);

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
-- Indices de la tabla `puntosventa`
--
ALTER TABLE `puntosventa`
  ADD UNIQUE KEY `idPuntoVenta` (`idPuntoVenta`),
  ADD KEY `idPuntoVenta_2` (`idPuntoVenta`),
  ADD KEY `idPuntoVenta_3` (`idPuntoVenta`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`idReporte`);

--
-- Indices de la tabla `reportescampos`
--
ALTER TABLE `reportescampos`
  ADD PRIMARY KEY (`idReporte`);

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
-- Indices de la tabla `ventasproductos`
--
ALTER TABLE `ventasproductos`
  ADD PRIMARY KEY (`idPuntoVenta`,`idVenta`,`Registro`),
  ADD KEY `idVenta` (`idVenta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `idArticulo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=431;
--
-- AUTO_INCREMENT de la tabla `bodegas`
--
ALTER TABLE `bodegas`
  MODIFY `idBodega` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `cartera`
--
ALTER TABLE `cartera`
  MODIFY `idCartera` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` bigint(20) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
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
-- AUTO_INCREMENT de la tabla `puntosventa`
--
ALTER TABLE `puntosventa`
  MODIFY `idPuntoVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
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
