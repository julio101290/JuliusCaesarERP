-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 01, 2017 at 02:23 
-- Server version: 10.1.21-MariaDB
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistemascesar`
--

DELIMITER $$
--
-- Procedures
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
-- Table structure for table `articulos`
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
-- Dumping data for table `articulos`
--

INSERT INTO `articulos` (`idArticulo`, `Descripcion`, `Tipo`, `PrecioCosto`, `PrecioVenta`, `IVA`, `IEPS`, `codigoBarras`) VALUES
(16, 'GELATINA PRONTO PIÃ‘A', 'Producto', '7.44', '10.00', 0, 0, '7501200482151'),
(17, 'GELATINA JELLO FRAMBUESA SOBRE', 'Producto', '7.35', '10.00', 0, 0, '7622300471170'),
(18, 'GELATINA JELLO NARANJA SOBRE', 'Producto', '7.35', '10.00', 0, 0, '7622300471781'),
(19, 'GELATINA UVA SOBRE', 'Producto', '7.35', '10.00', 0, 0, '7622300470647'),
(20, 'GELATINA PIÃ‘A SOBRE', 'Producto', '7.35', '10.00', 0, 0, '7622300471095'),
(21, 'GELATINA LIMON SOBRE', 'Producto', '7.35', '10.00', 0, 0, '7622300476830'),
(23, 'GELATINA PRONTO NARANJA', 'Producto', '7.44', '10.00', 0, 0, '7501200482144'),
(27, 'GELATINA PRONTO UVA ', 'Producto', '7.44', '10.00', 0, 0, '7501200482168'),
(28, 'GELATINA PRONTO LIMON', 'Producto', '7.44', '10.00', 0, 0, '7501200482137'),
(29, 'ESCOBA  DE ESPIGA ', 'Producto', '34.13', '42.00', 0, 0, '7503013201011'),
(30, 'TRAPEADOR MAGITEL ', 'Producto', '17.38', '28.00', 0, 0, 'trapeador magitel'),
(31, 'TRAPEADOR ALGODÃ’N ', 'Producto', '22.97', '29.00', 0, 0, '101'),
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
(52, 'PAÃ‘AL ABSORSEC MEDIANO', 'Producto', '29.07', '36.00', 0, 0, '7501017375165'),
(53, 'PAÃ‘AL ABSORSEC GRANDE (14)', 'Producto', '33.48', '42.00', 0, 0, ''),
(54, 'PAÃ‘AL ABSORSEC GRANDE (40)', 'Producto', '104.17', '130.00', 0, 0, '7501017372751'),
(55, 'PAÃ‘AL ABSORSEC MEDIANO  (40)', 'Producto', '91.40', '115.00', 0, 0, '7501017372737'),
(56, 'CHICOLASTIC ETAPA 4 (40)', 'Producto', '74.26', '95.00', 0, 0, '013117011180'),
(57, 'DAWNY ROSA LIBRE ENJUAGE AROMA FLORAL 800ML', 'Producto', '16.76', '19.50', 0, 0, '7501001155841'),
(58, 'DAWNY VERDE PUREZA SILVESTRE ', 'Producto', '16.76', '19.50', 0, 0, '7590002040003'),
(59, 'DAWNY ROMANCE LILA', 'Producto', '17.01', '19.50', 0, 0, '7501001351663'),
(60, 'DAWNY PASION ROJO 800ML', 'Producto', '19.26', '23.50', 0, 0, '7501065906472'),
(61, 'DAWNY ELEGANCE NEGRO', 'Producto', '19.26', '23.50', 0, 0, '7501001109172'),
(62, 'DAWNY NATURAL BEAUTY', 'Producto', '19.26', '23.50', 0, 0, '7506339321852'),
(63, 'DDOWNY AROMA FLORAL 450ML', 'Producto', '10.82', '13.50', 0, 0, '7501001155834'),
(64, 'ENSUEÃ‘O AMARILLO MAX 450ML', 'Producto', '9.21', '11.50', 0, 0, '7501025440381'),
(65, 'ENSUEÃ‘O LILA MAX 450ML', 'Producto', '9.21', '11.50', 0, 0, '7501025440374'),
(66, 'ENSUEÃ‘O AZUL MAX 450ML', 'Producto', '9.21', '11.50', 0, 0, '7501025440367'),
(67, 'ENSUEÃ‘O AZUL COLOR 850ML', 'Producto', '14.27', '17.50', 0, 0, '7501025413019'),
(68, 'ENSUEÃ‘O BEBÃˆ 850ML', 'Producto', '14.27', '17.50', 0, 0, '7501025414153'),
(69, 'ENSUEÃ‘O LILA MAX', 'Producto', '14.27', '17.50', 0, 0, '7501025414054'),
(70, 'ENSUEÃ‘O NARANJA MAX 850ML', 'Producto', '14.27', '17.50', 0, 0, '7501025414207'),
(71, 'ENSUEÃ‘O AMARILLO COLOR 850ML', 'Producto', '14.27', '17.50', 0, 0, '7501025414009'),
(72, 'ENSUEÃ‘O COLOR DURAZNO Y FRUTOS ROJOS 740ML', 'Producto', '10.00', '16.00', 0, 0, '7501025444815'),
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
(154, 'CHAMPIÃ‘ONES REBANADOS 186GR.', 'Producto', '11.59', '15.00', 0, 0, '7501003123213'),
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
(169, 'CHILE JALAPEÃ‘O 121GR', 'Producto', '6.54', '10.00', 0, 0, '7501017005000'),
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
(249, 'AZÃ™CAR ZULCA  1K', 'Producto', '17.88', '21.50', 0, 0, '661440000014'),
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
(264, 'ACEITE CAPÃ‘ULLO 905LT', 'Producto', '25.13', '30.00', 0, 0, '7502223770805'),
(265, 'ACEITE NUTRIOLI 946LT', 'Producto', '23.40', '30.00', 0, 0, '7501039120149'),
(266, 'ACEITE MACEITE 900L', 'Producto', '23.90', '28.00', 0, 0, '7501078007029'),
(267, 'ACEITE CRISTAL 500ML', 'Producto', '11.07', '14.00', 0, 0, '7501048100217'),
(268, 'ACEITE CAPULLO 400ML', 'Producto', '11.50', '14.00', 0, 0, '75041663'),
(269, 'ACEITE NUTRIOLI 473ML', 'Producto', '11.66', '15.00', 0, 0, '7501039126004'),
(270, 'ACEITE MACEITE 500ML', 'Producto', '11.81', '15.00', 0, 0, '7501078007067'),
(271, 'CLAM PASIFIC MIX 1 L', 'Producto', '15.90', '20.00', 0, 0, '738545080019'),
(272, 'KERMATO 950ML', 'Producto', '21.57', '27.00', 0, 0, '7501059233676'),
(273, 'FRIJOL LA COSTEÃ‘A 470gr', 'Producto', '7.50', '10.00', 0, 0, '7501017042920'),
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
(303, 'JUMEX PIÃ‘A LATA 335ML', 'Producto', '6.63', '8.00', 0, 0, '7501013118117'),
(304, 'JUMEX PAPAYA Y PIÃ‘A  335ML', 'Producto', '6.63', '8.00', 0, 0, '7501013118094'),
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
(330, 'JUGO BIDA PIÃ‘A', 'Producto', '5.62', '7.00', 0, 0, '7501013191110'),
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
(366, 'JABON BAÃ‘O LIRIO 100 GR', 'Producto', '4.62', '6.50', 0, 0, '012388000084'),
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
(380, 'CAJA CHILE DOÃ‘A JUANITA ', 'Producto', '1.39', '2.00', 0, 0, '115'),
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
(404, 'PAÃ‘AL CHICOLASTIC GRANDE (4)', 'Producto', '26.22', '35.00', 0, 0, '013117054149'),
(405, 'PAÃ‘AL CHICOLASTIC ETAPA (3)', 'Producto', '22.52', '32.00', 0, 0, '013117053142'),
(406, 'PAÃ‘AL CHICOLASTIC ETAPA (2)', 'Producto', '19.28', '26.00', 0, 0, '013117010879'),
(407, 'PAÃ‘AL ABSORSEC GRANDE 14 PAÃ‘ALES', 'Producto', '33.48', '42.00', 0, 0, '7501017375189'),
(408, 'PAÃ‘AL CHICOLASTIC ETAPA 5 (14)', 'Producto', '30.68', '40.00', 0, 0, '013117011746'),
(409, 'PAÃ‘AL AFECTIVE  MEDIANO', 'Producto', '50.70', '65.00', 0, 0, '013117016260'),
(410, 'PAÃ‘AL AFECTIVE GRANDE', 'Producto', '65.14', '83.00', 0, 0, '013117016314'),
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
-- Table structure for table `bodegas`
--

CREATE TABLE `bodegas` (
  `idBodega` bigint(20) UNSIGNED NOT NULL,
  `Descripcion` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bodegas`
--

INSERT INTO `bodegas` (`idBodega`, `Descripcion`) VALUES
(5, 'ABARROTES DIANA');

-- --------------------------------------------------------

--
-- Table structure for table `cartera`
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
-- Dumping data for table `cartera`
--

INSERT INTO `cartera` (`idCartera`, `Fecha`, `idCliente`, `Observaciones`, `Importe`, `CargoAbono`) VALUES
(7, '2016-10-23', 18, 'Programacion de reporte de ventas por rango de fechas', 200, 'Cargo'),
(8, '2016-10-23', 18, 'Programacion de entradas de inventarios por rango de fechas', 200, 'Cargo'),
(9, '2016-10-23', 18, 'Programacion de la cartera mas el reporte de estado de cuenta del cliente', 350, 'Cargo'),
(10, '2016-10-23', 18, 'Modificar inventarios para que se pueda modificar los productos sin tener que eliminar todo(Cortesia)', 0, 'Cargo'),
(11, '2016-10-24', 18, 'Se ligaron las ventas con el inventario, si no tiene producto en el inventario no podra vender y en cada venda disminuira el inventario', 200, 'Cargo'),
(12, '2017-06-01', 19, 'Cargo del mes por servicios informaticos', 2000, 'Cargo'),
(13, '2017-05-11', 19, 'Anticipo de servicios', 1000, 'Abono'),
(14, '2017-06-14', 19, 'Pago 700 faltan 300', 700, 'Abono'),
(15, '2017-06-23', 19, 'ABONO', 300, 'Abono'),
(16, '2017-06-23', 19, 'Cargos del mes de Junio', 2000, 'Cargo'),
(17, '2017-06-23', 20, 'Costo por poner cesped', 1000, 'Abono'),
(18, '2017-06-23', 20, 'Se le cargo 600 pesos al jardinero', 600, 'Cargo');

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
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
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`idCliente`, `Nombres`, `Apellidos`, `Direccion`, `Ciudad`, `Telefono`, `RFC`, `FechaNacimiento`, `Estado`, `Municipio`, `CodigoPostal`, `LugarNacimiento`) VALUES
(00000000000000000017, 'PUBLICO EN GENERAL', '', 'as', 's', 's', 'XXX000X', '2015-01-01', '', '', '81110', 'CAMAJOA'),
(00000000000000000018, 'RENE', 'CAMARGO', 'TIENDA', 'CAMAJOA', '6981095875', 'DESCONOCIDO', '2016-10-23', 'SINALOA', 'EL FUERTE', '0000', 'DESCONOCIDO'),
(00000000000000000019, 'Juan Carlos', 'Ramirez Hernandez', 'Conocido', 'Los Mochis', '6681891790', 'DESCONOCIDO', '2017-05-01', 'Sinaloa', 'AHOME', '81250', 'Desconocido'),
(00000000000000000020, 'Juan Manuel Jardiner', '', '', '', '', '', '0000-00-00', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `datosempresa`
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
-- Dumping data for table `datosempresa`
--

INSERT INTO `datosempresa` (`Nombre`, `RazonSocial`, `RFC`, `Telefono`, `Direccion`, `Ciudad`, `Pais`, `Estado`, `Logo`) VALUES
('SISTEMAS CESAR', 'SISTEMAS CESAR', 'SIN RFC', '6688612348', 'JARDINES DEL BOSQUE ', 'LOS MOCHIS ', '0001 MEXICO', '0006 SINALOA', 0x89504e470d0a1a0a0000000d49484452000002720000019108020000006e74c973000000097048597300000ec400000ec401952b0e1b0000200049444154789cecdd77781545db07e099d9ddd3135208106a40403a225d05c10e1610fd2ca8bc2a0aa2288a8526222a16042952141b8a88880ad2145414b0d194de7b0d909ed3b6cd7c7f041021e59c3db3674f729efbbadef702cc3cf31002bfeceeec0c668c2100000000f040ac6e00000000a8382056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e44ab1b00001844338f681bffd0776f625999343f9779f391dd411253706a55a15e23b1695ba1d16556f70840dcc18c31ab7b0000848ae93a3dba5fdbb04a5db140dfbfa3f40fc60949b6ab6e92aee949ea34c49ec4e87408409c835805a0389aaaefddaaaefb15eb9ad8a203aed7982455b6ba27440fecf2bd36809e3a8e742d8c6184605782f3a9d7a4abba99d61a00e00c885500ce60c180b67291baee577dff4e9a79f882ff4a925249bd264293cb6dd7f424d56a45b9377afc50e093b1da9a1548530d1721f59a38ef7f4a6c7f2dc298636f0080f341ac028058c0a7fef9933c6b023d79b4cc0fc636bbedf6876c37dc45d26b47a1378490ba6a7160c250260739d42282fdaefe8e5e8f20b8270c8039205641bca339a7bd8f776705b9618dc24eb773c844a95d5793ba3a83d2e0ecc9f2dc6988528e558506cd3d93e6732c080038076215c4356ded8ac0b4d1f4d4312383259bfdf6be8e070621c1ac15f5c1f75f5316cf62bacebdb2d0b085fbb54fb0a712f7ca00c439786f15c42f7a74bfffed670d662a424855e4afa62b4be7706dea5ff27733e5ef669a91a908217df766ffd8c12ce033a33800f10c6215c429a6c8de67ff8ff90a23ac1378ff556dcb1a2e2d9d8f1edd1ffce075ee65cfa7ad5f29cf9d66ea1400c421885510a7e4d99358613e87429406260e637e2f875267315fa1efe57e7c9fa7164b59384bdbb3c5ec5900882b10ab201e315f81b2fc6b6ed54e1ed537ffc5ab1a4248fd7d193d718863c192b0a03ff8ee8b7cd6180300104210ab203e053f9bc0f27378556394fadf79815b355f4160f20814adb584f4c0ce32776b0200840e6215c41f39a8fef913df92cc5ba06f59cba594fad37c444d59a6542ca6ebf2cc71519b0e800a0f6215c41d9a731215e6712fab725ab8a4fef923973aa1d3b6acd10fef8df2a400545410ab20eee847f73339c0bfecd6759117a139a7cc58575c262dea590e404505b10ae28eb66d83196569f6c9c88ba8bf2e8eda53d5f369dbd6477f52002a2488551077e8e13da6948d7ced2ea5ea2f0b78f412367de73f96cc0b40c503b10ae20ecdca34a5aea6d19c539114607e2fcbcbe6d54e78537b0b74788115001e205641dc21556b9a52d7e52129552229c0823e0b7713d4783c1b060040ac82b82336686146590e87b006032cc87f2d5588b45d9bac9a1a808a046215c41da1514b53ca461cabfaa9e3d17c63f50214368500800788551077487a6de4f2702f2b34be3cd212413f8f468c62a66f410c403c8058057187245526c969dccb8a6d3a475881d4ac8b30e6d28c0138f29bd800008855108f249baddb3d7c4be2e434a14ec3488bd81cd8eee0d28f01624623aba606a022815805f1c8765b1f52eb126ee5249b6bc884c8cb604f25e44a88bc8e31c26557583535001509c42a884758946c37dec5ab9a50f752a171abc8eb6087139bf0d03724924d6addc99aa901a8582056419cb2f77c5068da864321c9e67af9432cd939941225b1fdb51cea844fc8b8d4927901a878205641bc22826be8245cb95a84655ccfbf439252b9748410b275bd8d57a9b0080d9a59322f00150fc42a885f24b56ac2f8af843a0d8c0dc74eb76bc844e9aa9b38b624d46b4c32225dfa6480d8a64bf42705a042825805710da755778ffb4a687d75d8039352133efc59bafa16ee2d496dc26e26520ea7d4ae6bb42705a082825805f10ebb133c2fbfef7efdb3101fb5e2e434e7d36f26bcbf0c275736a31fe9ba3bcc285b0a47dfa188c03f0500f0819915873b02109bf4fd3be4c5b3e8ce4d34e7142bcc3b77f4297627e0a4caa4665da96b0f5be79bcd6e2330fd1565d16766cf520427a57aa62e21e67c8b00401c825805e0229aca3415e9ba7e60070bf8c506cd91dd810411db782cf70d01cbcd2a1cd08d15e446612e47dfa1f63b1e89c244ffa1a9dae635fa9635dafe9d2ce82bda8e58a8d704395c62fd2662b3b6a469dba87db601e00b62158098c31853977c1e9836daec8984961d3d6fcc327b9622fa819dda6fdf6b7bb6d223fbe8c9a3657c3421a46a4d52eb12b1d16562c71b0c2f2b0320fa2056018851fe71cfa92b1698571f574af5bc359bd4ae6fde1408219a734adfba4e99f7beb66fbbc112188b8d2eb3dff1a8d0b203762772ed0e00fe20560188512ce02b7cf23676fc9029d56d76cfa4f991ef635c1aaacb73a7cbf3dee773882cc6d8e571dc3bd0d6ab2f876a009806621580d8c5f2737caf0ed0b76fe05b962457760c7c55ea709d7907e6a83fcc0d7ef3213d76807b65a141337bef27c5b65d31ac5e06310962158058e77ffb5975e5625e279c939af55ccf8d131ab6e052ed6234e75470c25075c32a93ea23841021f61e0fdaef791c272499380b008640ac0210eb98aeeb9bfef4bf3620f2bba9e21537b89e7d1b3bdd5c1abb98be73a36fd8034ce671d7b72ca4465dcfa4f9961d4e004009205601281f68f64965f93cf9db8f90af30ecc184881daeb3f7ea2b36696d426b0821841893177f2e7ff12ecbcf316b8a8b90d4aace61934dfc4d01103e885500ca1316f4cb0b6769bf2da599479937bf8c8f162552b5a670e9658e7b1e2335f99d2f5b4c5b4c5db9d8ffce0b48534d9ca538d8ee708d9a21c261b1206640ac02500ee91a9383faae4df2f279da9a9fd1053787055168da46baf2465bd71ed8ee4092cdec769465f302ef8e40949a3d51f19c6ecfc46f058ee7d2031001885500ca3d9a97c5f2b259c0870491a4a491a4ca4894a236bbb666857fec6016f0466dc68b914ac9ee71f3488d0c0b7b00a008c42a00c0387afab8f7e95e2c37cbea469078694bf71bb390c365752320dec18b5f0000a35425f0dae3b190a908216dd7a6e0e793acee02008855008051caf279da9ead5677f12f65e91c7a64afd55d807807b10a00308215e607bf98627517ffc1827eff1b83f8ec9508805110ab000023029347b0dcd3567771217a68b7be6ba3d55d80b806b10a00081bcbcfd1b6aeb3ba8b6230c60233c6b0a8bf3e0bc03910ab0080b0292b16b0fc6cabbb281e3db053fbf327abbb00f10b6215001036f9cba956b7501a75ed0aab5b00f10b621500101eed9fdf596159fb265a4a5bbfd2ea1640fc825805008447dbbad6ea16cac0f273d4d54badee02c4298855004078f49d9bac6ea16ceacff3ad6e01c429d1ea0600282754851edc45f3b2e8b143cc5740f3b2597e0ed25584100a06e97987c96041c4c9a9677ee24ac00e17a956932424e3e4545c395da85117d9ec56fc06b8d1cac31b2cfaeecd2ce8c7b09721883a8855008ac10a7269ee699a79941edca5efdba6efda444f9fe0521913826bd4136ad7179bb52135ebe1e434925205252663523e6e1dd1c37b91dfca5df54344e5202bcc875805d107b10ac0bfe8917deaeaa5eaaa2534eb245365a42adca76094b2237be991bdeaef3f20849028619b1d8992edea5ba4ab6e129ab645b19dafda8e7fac6e2124585359c0677517201e41ac8278a71f3da0ffbd4adbba5edfb3859e3c1aede935b568ef0279d12c79d12cec7009190d85facdc4765d85e6edb1dd11ed7ecaa21fdd67750b2161aac2b24ea0daf5ad6e04c41d88551097749d1e3fa86ddfa02cfc4c3fb0d3ea6efec5827e6de7466de74679f1e7d853c9def321b17d57a1e6252866f295f90aac6e2154f4c421843a59dd05883b10ab20ce28b2ba627e70ce549697cd4cb8c7cb11f3e6073f9f88bf9c8a53aa38ee7e4cbcfe4e1cc5c3c94beceaf861ab5b0020a641ac8278a16ffc53fee91bfdefd5342f4677dd2b16d35476ea98ffdd9164ce54f1f24eb69bee162e6d8930b6ac1f5fa15553874bdfbbcdea16403c825805151ccbcfd1b6ad93bff9502f276b6d4a42b33295e5f3941fbf963a5e6fbbad8fd8f87224d9a2df460c3eee2d91c36d7507201e41ac828a4c9efb9e3cef3d16f021c6acee8513c6d43f966b6b56902ad59dc3de15ea378df2fcb8d62568fb86284f6a8c5033c3ea16403c82580515102bc85596cc567efc86661eb1ba1753305dd34f1cf63ed5436cd9c176eb0352fbeb902044676a5c8ef6b2102db89a070062155428cc5ba0ae5a1cfc7c122b570f500dd336fda56dfa4bea789dfd9e81428366519831fad7c706612cd46d647513201e41ac828a435db32230fe39e62d376f80f0a2fef993ba7e95d8b2a36bf814ec709a3a9750a781a9f5b9112564f2a7028062c5f47e2e008448dfb9d137e4bec06b03e23053cf50156dfd4aefe3dd95c5b34d9d4768d832765ea22d8dcd4e1292ad6e02c423885550beb1fc1c79d604efe03bb52d6b98ae5bdd8ec568e691c0b451bea1f7d3a3fbcd9b45ac570eee03134f259450c9ea2e403c825805e598be7d43e1806ec13953ad6e24b6689bfff23ed94359fa8549f549a3962655e6486cdb351676cf0071086215944bcc5b109834dc3bf4be38599a142e260702d346fbc73c41734e732f2e3468cebd2677b6eef758dd02885310aba09c61946a5bd77907dca42cfb0a699ad5edc430aaabbf2ff33dd34bdfb69e6f61b1650724c5f48520a9d340c8b8d4ea2e409c825805e58c327bb26f781f9a7dcaea46ca077afa8477781f79ee748e3549729a78c58d1c0b7227366d63750b207e615661769f01151dcbca0c4c1aae6e5865752317c295ab5db84902a5f4d43144a9451d5d080b8274fd9d8ebe43b13b814b41fdf01edf933d62f6ac02cff8af84c6975bdd058853f0de2a281fb4adebfcaf0e608579d64c2fd948721a76b9912b41b8b4a550eb1292968e93d384daf551a9eb62e8d1fd4c0e6afbb6b1ac93fa9e2d2ce724f37b597e2ef37b118ddeba65a6ebca0f73e9a9e3ae17dec1891c5e3b11d2eb908c4bf53d5b222fc59dd8e66ac8546021b85a05e58032ffe3c0cc7128fad7462e8fd4f106e9aa1bc546ad90dd810531d2ddeda9ce549529320efad4752b95d54bf56deb91a6726ab76ca4468667e27c2ed7acdad6b5be177a475e8733c99630e11b52afb1d57d80f805b10a629b1c0c7c325659f205d2a3b43a0957a92eb5ba4a68de5e6cd89ca4d7317baf5d160cb01387b53d5bf4ad6bd5f52ba3b0b09954abe51e399df0d8d8cff7dae3da1fcb23afc391d8b68bebc569d88ab37d002802b10a62170b06026f0f56fffcd1f499082195d3852697dbbaf7169bb6b1ea3453a62aea2fdf29bf7ca7efdd86cc3cd694a4d776bffe19a95a33c23afafe1dde677a21357a57db654848aaf4e96ad8b310580b6215c4285698e71d7c273d76d0ec89c436573b1e7a5e48af8dec4e0b8f073f87e93a2acc0bce9eac2cfbcabcfbc32439cdf3ee7738a54a84759415df05c63dcba5a5c8d9fb0e75dcf188d55d807807b10a62113db4db3f61a8be7bb3795390aa356ddd7b8bad3b09b1fa1c8e66656a6b7e9697cea107769a519fcfdd6055f18d19a8ad5dc1a929e3a42eb7ba9e1d17b503f2002809c42a8839f4e451dfb007cc3a2a9508a44686adfbbdf69bef2b7d116fec9097cd53bff9403f7680fb61ec42e3cb5da3de2711ae0d9683dee7efd6f76ee3d49411a47a1df7d82f494a9a853d0050046215c4167aeab877504f969f6346719c9ce61a32516c74192a476771238410628aacae5c1c7cff55e6f7f2ad4c6ad6f34cfc16bb3c9114a1278f150eb8090503bcba0a0b4ea99230637984bf05007881580531841edce51bdd9f9e3ccabd32a956cb7ef7e3b66b7b96972bd462b1fc1c79f93ce5cb692ce0e35513632c5e7bbb6bd0eb4888e82d76fdd841ff88ffd153c7783516aac464cfa81942e356d19e17801240ac8258c10a727d2f3faaefdcc8b9aecb2d5dd5ddf9d848ec7071ae6c117aea5860fc0bda96351c6b3afa0cb6dff3788445e8e9e3be110f9a7a26dd0548b55aaed11f09b5ea456d4600ca04b10a62022bccf33e7d073d71886f59a16547f7b0c93821291696f872c45445dbb0caffd6d3480ef2a9284aae91d3a5b65d222cc30af27caf0dd0b7aee3d1531984facddc6fcec22e3edb3102c00bc42ab01ef31506de7981effba938b5aa73c028a96d9748f7458a61f4c8bec0876f6aeb7ee1520d2757f68c9f47aad58ab00e5365f9cbe9cab71f325e917f112c88d2ed0f3bee7e0cbb134d9a0200c3205681f502efbda22cfc8c5b392288edbbba5f9888ec0e6e3563155315f9b309f27733b9bce12a5e7e957be47b5c3e6fdaf60dc12923f5c37bb99f3740ea34740e78496cd1816f590078815805160bce9e2ccf99c2ed1f5f9bdd3578ac78c50db83c2f4d0a0f63eadfabfda3fb734956c703cfd8ef7d22f23a0821a42acaaa2581e9a311a7d5cbd8e174bd3041bcbc53b95bc80de20ac42ab092b6f177ffcbfd982273a926b6ece0e83f323ecfafd6f76d0f8c7f5e3fb82bc23ad893e89ef08d50a32e97ae1042ccef55d7fcac2eff5adbbacee0c6ce8220b6ec285d79a3d4e536ec74f36a0c009340ac02cbd093470bfbdf84141e4fe00451bae96e57ff17cbf5fb33116205b9dee7efa547f6465887d4aa97307921f75be8f4f471e5fbb9da869534fb142acc2be3ac5641c449a924254d68d1c17ef3fda45aa4db1703103510abc032dee7eed6b76fe052caf9dc385b97db10215caa955fcceff58d7c48dff14f445530763e31dad6dd9c43dfa8ce827e26cb74ff76fdc04e7afa84be6ffbb9a36749ed062429556a7b35a95e17d91dd8e1823f5350ee40ac022b503d30ed6565e91c0ea5249b6bc844e98a1b3894aa10587e8e7fc2106d6d44cb83b1c3e59ef8ad50bb3eafae00881ff09d20b080b6798db2fcebc8eb90aa3513de5f0e997a3e5c29c5357492d0b045244558d0af7c3995574b00c415b85a05d146734f173e7c0d9223dd3f96645cea79fb4bec86dd008a13f0153e73273dbcc7780541f04c9c2f5cd2845f4f00c405b85a05d116fcf08dc83355a8dbc83dea7dc8d41239ddaee7c6e1a454e315743df0ce0bcca2ddf30128bf2056415429ab97aabf2c8cb008a9d3c0fdd617a42aac0e2d8d50bfa96bd8e448de48d10fedd17746b6fa0980f803b10aa287e59e96a7bd1c611152a57ac2f879d803bbd6954d6cdedefef00bc6c753dd3ff6195e6f15031027205641f404bf9842233b481527a5ba5e9c86e064cd90d96fbe4fecd4ddf0709697cd77af66002a3c88551025ea8655ca92d91195f024bac7cf13ea37e3d451bc70f61d8a2ba5181eae2ef9826333005478111d5c0c40e89479ef4758c13578ac905e9b4b33a66279d934f3304248dbf10fa654dfbf8354af8d5c09427a6d9c948aed0e52b77134fb2155aabb464ef70d7b0095beb15109b46debb4adebc4666db93706408504b10aa241593e4fdb1cd1b1dbf6de4f4a1daee3d50f47f4e02e6dfbdffaa1dd2cf308cdcda2270e335f4119631c2ea172355cb91aa9529d54ab2534692d36696deab68be2a59749d7f454977d65643063c14fc67ac67e890481775f005440f0de2a301dcbcf2eec77232bcc335c416cddd93deafd58d9ef97319a9d490fed51fff851fdfd7b5660fcf7753eb16d175ba76e42e3cb715a756cc2092d2c18287cb82bcbcb3232d8eef44c5d2454cfe0dc13001511c42a305d70ee74f9d3f1868793f4da9ec90b62e4c06a6dd35ff2c76fe9c70eb0800f99f177c7ee10aad4b075bbdb76f3fddc0f6097177e1a7cef55837ddd3bd0f1c0d37cfb01a042825805e6a2a78f7bfbdfc4827e63c3b1cbe3193797587dd61b3d794cfd7e8eb26201cdca8cce8cd853496cddd97ecb7d4293d608632e3599dfeb7df62e7a68b7b17e1267ae8435d80094095602037329df7c6838531142f63b1eb1325319a3270e073f78dddbefbae057ef452d531142cc9bafae5ce47dfe1edf90defa8ebfb91c518e5d1ee7336f604317c1cc9baf6e581d790f00547870b50a4cc402be82fb3ba280c15825d5eb244cff9efbbdd0d005a68c547f59c8023eab1a384394849af5dc2f7f80ab548fb494ae153e7327ddbbd5c050a9cbadae172644da0000151d5cad021305a7bf623853b1cbe31af99e3599aa6beaaa25858f5eaf2c9d637da6228434553fb8ab7040b7c0076f307f6144a504d169f411a9b6e9af88a606203e40ac02b3d0ac4cf5cfe586874bdd7b0b751a70ec27442cfba47fcc40ff9b83e8b103d19fbd142ce053e67f54f8e0d5dae6bf90ae1bae23b6ed223435f2122acb3d1dc91f2800710262159845f9793ef319bcb4129ab671fe6f30df7e42410fec2a1c78abfad74fd19f3a44cc5be01bf160f0a337222962bbee76630395253c4e9e07a04283ed2080295841aef2dd4cc3c36db73e8084687f71ca73a707674f429a16e579c3a66bf28299fafe1d8e012f1bbba097aeea169c398e85bf3f333db893790bac3ae780e93aca3a410bf3cebd2b4c52ab229b9d54a91efdaf16004a025f8bc014eaefcb585eb6b1b1a47e535be79bf9f6533ae6f706260c517f5f16cd4923a46d5ee37bba976be474f1f2abc21d8bdd09f65e7d839fbc1dee405a984f734f0bd18a555698cff2b3f5033bf52d6bb58d7fe847f717ff71a228d46b22d4ae2f76b856a8dd10a7a461781108580756020353785fb857dfbacec8489b3d61da1212c50d7d9822fb873fa06dff3b6a337284ed0ed773e3c52b6f0c77203d71b8f0b19b0cec12ec7cfc65db2df7873b2a5cfafe9dc10fc6e8077731bf37bc266d76ecf2882daf703c3a8ca45431ad41004a04b10af8d30fecf40ebaddd8ab9662db2eee51ef2312a5ed67595e967fec606de31fd199ce1492cdd977a8edb63ee18d5295c201dde8f143e1ce26b6bad23de6d370478588e566294bbf50fe584e0fec8cb41621428316b66b7ad86ebc0b99b019240025815805bc31e67fa9afba619591b17667e28c65382de2b73343c3f2b2bc83ff8f661e89ce74a6723cf89cfdaec7c21a129c35419e33d5c05c890bb671dfb59815e6ab2b16043f7b87fb1b4d2429d5f9c42b42eb4ed8e1e25b198062c14a60c019cdcfd6766d3436d6defddee865aa22fb5e79ac62642a4228f8f924f9eb19610db1dd1ae605ee5974ff0e63034ba26dfab3b0dff58119af99f19630cdcbf6bd3ed0f742ef587b630a545410ab80337a782ff37b8d8d35f08cd018a6c881d79fd4771a8cff58a4a9f2ecc9ea5f3f873e8224a50af59b1a984a3fbcd7c0a8e2297270fa68df8807597e8e29471714614cdfbbb5f0f19b8373a6203de6577a83720e621570a6fe3c1f516a6020a9df546cd29a7b3fc5d0d4e09497d4b52ba23157143139e87fa5bf16cecebdc2a5971998881ee113abfa917d858fdd242f9a85a8f1dd2dc2a02af2ac89fe571e33f0661100a183176c004fcc57a0acf8cec848425c035fe3dd4ef194e55f2b3f7f6b5e7d5cad9678694ba1c9e524310589a250b791be672b42483f7148dfb75ddfb6def0ab47a1084c1c9a30e347e40ce939a2d0b0055a323bdc29f4a31ceea6ea0777f986f731f553512c75ddaffa93b7b9df9e4baad688f2d4204e40ac029eb42deb8cdd6423e9b54954b62a54d7ae08bc379af3fd467782d4bab3d0b895704953b17e5374d1d298a2f785ce1dc2ce0af3f47d3bf4bd5bb5ad6bb58d7f2045e6d80bcd3ee91bd5d7fdeac7c8ee2cf3838ddd046627237d20adfefd9bfff581c8e8c38208d1ac4cdff0075ccf8f171ab5b2a40150b1c14a60c05360dacbcae2cf0d0c743cf6923ddc5744c2c7bc05de413de989c37cca1181d4ac6bbbf93efbad0f18ae410b7295459fa9bf2ea2994722d9e9f7028e4786d96f7f3894835af36f6f8ee44058c5714252e2dcf5465b43dae6bf7c434d7ff3b54ca45a2dcfd82f70e574ab1b01150d3c5b053c69bb361918859352ed37f7e6decc8534d5ff4a3f5e992a346fe799b6c4f3eec2483215214412931df70df2bcbbc8fdf2073829954b6f08a1e0c763b535212d5f122fbb22dce2ac30cff0925d9a79c4ffc653c6c6f245338f7807dd4e4f1eb3ba1150d140ac026e68ee69636ff14b57758bc29eaedaa6bff49d4652ff02a46a4dd7b0c99ed76709b5eb1b3b12fc62d8e1145b774e9cb9caf1d84b98cbde40540f7e3125940f141b3637505edfbbcdc028e62ff48df85fecac18a2b959be318f1b3e1002806241ac026ed45f161adc59a95d57eecd5c80e5e7f8df1ecc0cb5f72f42a4ebef4cf8e457a953772498b00f94cd6ebfad8f67f202a1793b4422fdbba9efdd1afc7c52994f918d3dd2d6f76d0f77085395c0e417b9dd81e784eedd169c11a5b572204e40ac026ed415f38d0c7338a5f0ef43864b9ef73e2bc88da4027638ddaf7ee27ccaf47f82494a15cf984f1d7d87465e4a59f819cdce2cfd6384ba8d8c4478988f631142eaf75faaab96843d91f9949f1728cbe659dd05a8382056011fcc5b40b34e1a1868eb721b12a5b23f2e02f4f471e5fbb991542035ebb95f9d29b6ba1247e7003251b2dffeb06be474e47447528679f3e5d9ef96fe31d8e13270de8b766877789de4e784bb0954f4503df8e938967bdaea3e400501b10af860f9392ce80f7b18c6b66ef798d0ce791893bf98ca02c6dfe52095abb946cd109a4665ab8af3481daff74c5a10e13a2665d9577aa90fbc9920a2f09f10e3b0ae56290d4c1a46b3cab86eb610cbcb96177e667517a0828058057cd0ac1306debfc49e4aa46a4d33fa3987659f547f5b6a783849aeec1ef7955023835f4761106ad6f58c9f8713932329a22c9ac5ab9f73f4837b42ff609a734afdfb77ee3df025cf9b51faf71f0084086215f0a1ae5f69601449ad62f689d3f2d23986977ae24a29aee153489528edfe5f2c925edbf9d49848ee932bbffdc0fc257e06b0dd61f6d12ec1692f232568ea141c505d5930d3ea26404500b10af830766839a9d3d0d407abcc5b207f69e4ecb3228e879e179ab6e1d88f31d21537389f7ec3f819b4defce027e34bfecf656f191109fdc04ef5af9f4c9d821775dd2f8ceb8e57203e41ac021e14b968dbdb70495775e3decbf9b408fe4197aee9295ddb8b633391b075be598860bdb4b6e627abdece547ffbc192790d6079d9ca42b34e6807f103621570a01fd96be4101241145b7430a19d7fa96b7f313690a45675f61f89cd7839d51851720f99408c3ee2a579d9256d27842509db1cc61b2b8b66f48fc012cac2cf901cf3f7ab416c83587cd263910000200049444154051ce887c258c0720ea99181132a716fe61ca6c8faa63f8d8cc4d8dee719537b33002724d9ef7acce0604d559614bf5733535566da834f7aec80becfc87e4c566105b9f4f471abbb00e51bc42ae08086f9166311b17e33ee9d9c4f59f2392dcc3330506cd1de76dd1ddcfb899ced9a9e860f5d517efc26faf781e51f4d3c80cf0c4c91b5bd461e6700700ec42ae080e5661918856bd7e7dec9bf18537f5d6c6ca8d4edde50ce7eb180203a9f7c15d9ec46c66aaab6cdf8b1331792425868a6ebfa3fbf719b315ab4987f1708c4388855c0013d79d4c028a1465dee9d9c43bdf9f49491bb7938a58ad4f17aeefdf0426ad6136ad63336562ff67c215d33f05c9cd46b5ce6c7b080af3c6e5d14e2c93f009404621570602cc0cc7d1fb420b79497354be1ec3b94d7b93466c092cd7e9fc183d5f43d5b2efe45a6a966bd55a2cad4a283ca23c10af3d829382d0e1807b10a3860f9d90646916ab5b977728ebe672b52957047614f6224efb14487d4f17a52ad9681817a714f0db1ae2335ec837d4808a77fd3c27c540e631521a4671ab9fb0240118855102916f4b360d8e79920bbd3d4a5b6da3f469e90916ab548a588760a8c0ea9e30d0646b1bc6cfde0858bcb98aa3035ecab55a16a8d323fa6d8142f17e8f18356b700ca3188551029633ba90a8d0dae680d917ed8c83b3f62c7eb8d6f66144542cbf6c606ea3bfebef09754c5c09b9a42dd4665cfb57f47b8656304ecb5042201b10a22450dbdb42a665ccabd937fe95af1cb73ca62eb7c0bf75ecc20366c696ce0c5c78f6bbb361aa88343392041d30c548e052ce794d52d80720c6215448a1a5aed2934ba8c7b27e7d013870d8c2269e986b7318a329c942a346b6760a0bef39f0b7fe5e2ebd732891249ad5ae647195b1f1e1362ff600010c3205641a4f4fd466e0293f43adc3b39c7d8d19ed8d03a20ab882d3b1a18c50af32e7810ae1fd8156e91109770e3e4cae15606a0028058051133b0da1363921cd1e9dca5d34f1c3230cad4f768b9139b5e6e6014d334a4fdbbee97057cfaf60de11609f1885c53b71a36154e2807cbd640cc82580591d28fec0d770876ba9168e2bba198191965f681ea7c91aa359181f76b35959df7de91b1e566b872b5903e2c29c540f198e04eb0ba03508e41ac820ac8d84de0509e17c610518a7cdb0a76eca08151216ef364ece5da5800b7af412420564144981c447af80b3e251b124513da39cb404b08b1d839062e1492ddc8d5aa124441ffb99fe986ce4820a1c5aad8a4352a5f9fd2b342792b17809240ac82c8e82ad269d8a344c9d4bdec8d9d7456be9e05629b0d4b86f6dc3f8fb1574b49ed06a17c1896ecd8e13250df72a44a797a1c00620dc42aa8808cdd1d65e16f7668254d637ad89b0e9e8f05fcba81336dec0e213db45d27ed0eec4e0cbbbed5705a759c64e27a3a50e141ac828a081bfac266e15f765b87518a68f80d0b2212cedc7e577e986be03b09b14d174442fbf43a5cd8d4d314cc215d6964634800ce8158051590c1c547e73d742c0734f5fc5765422588679ec852aa2e9f67605aa9e375217e2426446cdbd5c014d692da5d63750ba07c83580515100be590ed8b476597ab2deb541945b0752d2bcc33b23d962889f59b85fee1b6eb7a853d85a5b0cb436a96a7d797410c825805151071790c8cd28feee7de8979e88923066ee162bb033b5d08217def56569817f6704f62582f9f90e4ca62ab2bc39dc542a46a4d925cc5ea2e40f906b10a2a206327b9d2ec93dc3b318f7ed0c84e0e67de76a554fefa03c4c2de358334688e1392c21a62ec0c3babd8ee79bc9cbe14046207c42a880876b891a13baea622212e55fd2fba6b93ba7231f7664ca2fdf5b3815142fda64810b5ed1bb44d7f1a18eee8d537dc21e215e52656497a1ddb953759dd0528f7205641640831f206aaaa1859c51a329c987c6ebd6be898a6063f19cb023e335ae28bf90ab4adeb0c0c24b5ea238494150b8c8c4daf65607f7f929266bfe70903d3459f747daf501739035032f81a0291c206fe25d254a4eb26f4f2af10f7adbd00f516a0f210abbaa14c4508892dda335fa166e8a25cbcbcb3b149edb7f5c19e4ac6c6468fdd69bbf16eab9b001501c42a8814a9db28dc214c55103537562563f71efd5e2dfc83d2a24fdb68e4162e4248687c7960ca486357e462ab2b8c4d8a2ba548d7dd616c6c9460ec1cf01281ad80010f10ab206206cea25115b3af566d9d6f3670779a21a4cc9962463f7c297ffe68609450b711cb3ea9adfdc5c0589c52456cd3c5c0408410c2d8f1d073a4767d83c3cd47aad592ae82a7aa800f88551029a1712b03a38c1d49163a9c988ced61eff18b11d2b6ad8ff1376dd4df97b153c70c0c142e6912fc6c82b14b55fb9dfdb0cdf816c458b2391e7a3e469f5cda1dae1153b00b0e83037cc4e45739285788cb6d6094666893f7d091b47414e6ab206760a4fdbe8c773bfc287270d604634369419eba72918181d85349ea7cb3b149cf91da7675dc3728c22266b0dffdb850af89d55d808a036215444aa8dfdcc0287a38ecc3cfc3234a62c31686466265f93c14abdbee6b7bb7d1e3878c8da57bb7181b28b4e8c0e1b92321b65e7d854697455a872bb1f32d8effeb677517a0428158059112ea3735f014931a3ae9332c8e8787181b484f1c0acc9dceb7192e982207df7dd1c856c0082142684ef8bb15228445c93570349783fcb0dde17e7d16a9d330f2525c908c86ae275f35f02e1600a58058051ce0a4b02f65f4033bcd7e4394a4d70ef1c0ed8b6075f1e72c2f9b73431153167f6eece071841033ba464c6cd7d5c09f6f49b0c3e91a310585ffd89b3bb1c9e59eb7e762373c52059c41ac020e88a1f329a9a1753761913a5c6b6c20cbcf0d7cf806df662244338f280b3e31369621868c5e6ddabadd6b706409849af53c9317925a97f02d1b16b1593be7f3132053811920560107a45a2d03a368e651ee9d5c40baaa9bc19118a92b16a886360834851cf48fee4fb3320d0e67081bca55b17527b175278393964ca855cf336981350b8530264ddb38474e23556b58303b880310ab800362e8b46a7a680ff74e2e2034684e6a18bb0f8c104281292339361389c08c31fa61d33f5d17c00e97a3bf599f01ec70badf9a2d75ed6152fd92d8efece719f32931b64a1c801040ac020e702d236ffa6bfbb671efe442183b07be62f875499673cafb742fcb77095616cc54be9f63e0c099220c316c68c19178f95524bd8eb1494381dd0952975b11c2067f63e14e979ce61a36d9f1d0f391bc800b40992056010782a1939fe9feeddc3bb998d8e8329266e462ba88be7bb3ff8da798dfcbb1a53050aafeb13c30e3b5888a184a2dec4e743e3b0e9b7a4a1ad583d34723c4306245cc9ac8ee94aebd3d71f69f52a7ee664d01c05910ab8003a17e3303a3e8f143f4a4e98f5791dd61bff391480a68eb57fa5f1fc8ab9db028df7fe97f2ba22d141863c6d62ad9ef78a4e8c073f3685bd6d2cc23082174f6f51d33925568d1de33f11bd7336f71af0c40b120560107d8e5112e0dff357fc6d43f969bd0ce856c37df1fe186b4dadfbff986f761592778b5543655097ef64e60ea4b4835f4962a42a868013042065e3915ea37b3f5f89fe17943a42c9df3ef4f30c6186384795db7e24a29b66ef77826cdf7bc395ba8d33046f74d0415117ca9013ea4765d0c8c527f5d68f8916158ecb7f661c66e869ea56dfca3b0df0ddae6bf78b5540a9a7dd237e241f9cb691157c2469eaada9dce6193b1d3c89e94a1a35999eaeaa517fe2a3e13af989db92f1cde05acdd412a57139ab6710d7b3771ce5ae793af090d8c6c01064024607b11c087d0a203c238dc8c6439a799df1b85d7076d37fe9fbc7856846b8f5930e01bf588edda5ecefe239064d6b21765c502f9a337696e9649f5cb64bfe311c1d01b5361602c38f5a5d23e009f7d23a8e82b8a3174f62da1ff7c9b208842464352ad3669d04cbcb425a95a132724619787cb9e50001803b10af82095d3b1c315eea259969f43b34f0a51782b5f945c4327f99eeec5e4604475e4a0b2f40b6dcb1ac7fff597aebe0549e11f8a57327dfb0679de0c75ddaf5c0ea365ccc80260a1691bc7fda66f884f4f1dd7b6ac0de9438b7e0f45ff87104248bce246f78b53cdeb0d8008c14d60c00749ae6ce0a29369aaf2c35c33fab99850a7a1d0b223973bcef4c83eff3b2f143cdc55fdfd0756901b6135a6c8f4f841ffab03bccfddadaef999d701ef062ed8b0d3ed1cf82a97d94bc358f0f389861757dbaebb9d6f3b00f0854d5cd40ee28c7ff28bea0f5f863b0a4bb6842fd799fd24af089383de276fa35c8f53c5c995857a8ded0f3c63e0c01c9a97a52efc4c5db9443f7ddce006fac529fa2b1d76aa8a927bcca762f376bcda2889b677abefe95e88520363715af5840f7fc25c6f1200c017dc0406dcd8bbdd63205699aae8db3788ad3b9bd1d205b0dde178e805ffab8f71acc972b3b40dabb50dab71729a70694ba16e2352b39e50b5064ead4a52d2ce7f04cb0a7269ee69949ba51dd9470fecd4f76dd3f7ede0756dfadf9ed8450f21cb66bfe771b1595bfecd5c44fdfe4b63998a30763cf43c642a887170b50a782a78e04a967d32dc51b6eebd9d035f31a39f6205678e93e7bd1f9d15c8082152ad16cdcae478315a3ac68cdcfe95aee9e97a6e9c09ed5c483fb4c73bc0e046cd3831d933fd7b0e27bf02602678b60a78922ebbc2c02875d512ee9d94c27ef7005cad56d4bea1a49947a299a90608cddb3b078ce2dd4b31982207270e353cdcd6bd37642a887d10ab8027c150ac326fbebcf873eecd94043bdd9e51338428266b7430c61062e15eaa0a2d3aba5f7a2f3a47a4e95bd66afb77181b8b2ba546b85b1600d101b10a78925a7742c4c82eb2cae2d94855b8f7531252bbbe73e0ab1569cb75c6180e7ff30752abbee7cd59d1c954e62b0c8c7fdef09fb2adcbadd805c7a38272006215f084932a8b6d8c1ccfc94e1c8ac2f1abe7135b77720d9d8444a9025cb39ef92d84799d8aabd470bffea919fd144bf97e0ecd33bec785add7c31c9b01c03c10ab8033fb9dfd51f8c79e3055097efca619fd94426c778dfdaec7b02094eb642d6a3edceb54a1691bcfb8b924b5aa394d5d881e3b287ff5bee1e1f67b9e88e4182200a20962157026d46980dd890606aa6b56e8bbb770efa71458101cf70fb2dffd38c2e575493c6367f7a80f87745537cfdb5f92cad54ceaea024c53fd6f0f66de7c63c3b12bc1d6ed1ebe2d01601e8855c0194e48123b5c6f6cacbcf40bbecd84c2d17ba06be8242cdaca65ae860b63c723c3a3f32ecd39dafa55fa5ee347d64b57758bda770000440e6215f0e7b86f2092240303b5dfbea739a7b9f7530641b475eaee1c381adb9d4567a644bb81f0b1a27bbf2ccc75bf2e8f73e0abf61e7d5014d76ad1e30703e39e35bceb05a952c3d16f186c9d0fca118855c01f49ab2eb6e8606020f37b83d35f8eda460dffc2d876e35dae211349623262619fc3134d4507a6e1a287a9a1870dc638b59ae7b599b66ef720218a7bab3116f8e84dc3dbff2284a4ebef8005c0a07c815805a6b05dd3d3d8406dc36a9a1bf50b5684104252876b3d931790f45a08c5e815abe16b69db2df7274c5f2a340affa8f9c828df7ea8fdf5b3e1e1b852b2fd0e785715943310abc014e21537e2b474030359d01f983004e926ec941b0252b566c27b3f4837de85118aa91bc20c3186ce2e4f0ae78e28a952c3357c8a73c028ec31b28e2c12faa1ddc1b9d38d5ffa13c139f86dec70716d0a00d341ac025360bbc3f0b19dda86d5eac63ff8f6133a6cb3bb9e7ec3f5e2349292868b6eb95a7a4ff8cc5d5f86c2b9e78b1042d8ee103b5ee799b658baea26b39a2b192bccf7bff218f31618ae406ad6955a5dc9b12500a203621598456cddd9f015923c33aa4b552f265d7143c2d4c5b66ef714259955c15a74b98cc38e5424346ce1193fcf3d629a550f26839f8ca5270e1b1f2f8aae5133906864e11b00d682580566212955a46b7b191babefdb16c9ee015ce0a4cacea7c6b85e9c265cd21463c48a2e1ba33275519a325414a7e11df146aa673807bfe5193797d46b8c88057fc11963f2c2cf941fbf89a488edb6ff09e9b579b504403495d7b7e0417951d0bb3dcbcb36301027a5264c598c53d2b8b76480fcdd4cf9abf7595e56d1234e861136babd514958d1df468c8a1ea1863d1e639c946aebdedb71d763c8d21349f543bb7dcfde15c9ea5f9c522561c63258000cca29885560aee0276fcbf30c5e774aadae748d89dea6b5a563de02e5c76fe4cf27b280efccaf9cd9891723c62209d733618a31660c6114f6debe0821bbc3d97798d4a91bae9462b80d2ee8f183de67ee648579c64b08a2fbf5cfc4e6edf83505405441ac0273d1acccc27e37a0a0dfd870e7a0d76d37dec5b7a548d09c53ea6fdfabbf2cd4776dfaf757d9997bb645303ef3937f376b283a5b9cb1333f3ffb662c3eef7fc608adaeb475be45ea7a5b2c9cc6c30af37ca31ed1776e8ca488d8aeabebc569189eaa82720b6215984ef9f1ebc0c461c696fd90a454f7c4f9a44acc6db3ae6d591bf8642c3bbc3792bb9d061101574a162fbbd2f1d0f3b1b3ab1f53e4c09827d475bf465204a7564d9cf12372c24b35a01c835805a66305b985fd6e6005b9c6860b0d9a79c67e89ec0ebe5d71a0eb34fba4b6f92ff9eb19f4f0de68cce874499d6fb177bf9754ab851392a23163c802efbca0fc3c3fc235d3ae6193a54edd79b504802520564134c8dfcf09be3bd2e0608c1d770fb0f719ccb523ae18a3270e6bdbd6e97bb7d343bbf403bb227ab8783e8c49951aa44e03b1610ba1595ba151ab58b8d97bb1e0c763e5af67445844eadedb35f0152efd00602188551025dee7eed6b76f303cdc357492d4f9668efd988a9e38acfdf39bb66b13ddba9ea93293838851a6c848d78adf400a6324d9b068438420bb03bb13494643a97527a96d179c5439eaed8783b1c0ac09ca97d3222c43d2d23d93bfb37cc915009183580551a2fdf3bb6fc4ff0c0fc79e44f7b8af84daf539b6140d8c3139808201a66b4c0e2055c1676355dbbf9dd46e48441121c43041763bb1d91911b1d3859d6e4b9b0e83b26c5e60ea4b485323aa228a9ea94b845a97706a0a002b41ac82e8f18f1dacfebad0f07021bdb66bfc3c9294cab125100965c12781196322afe3787484fdf68722af03402c805d9640f4381e7c0ebb8dbfe3af9f38ec7ff121160c706c0918c3743df8fe6b5c3255baf246c854509140ac82e82155aa3b1e1d1e49057dfff6c05b0677f0071cc91fbe212f9a15791d5cb586f3290ed90c40ec8058055165bbe1ffc4b65d22a9a0ae5911983e9aa90aa78e407898aa04260c95bf9b8968a487f7e1c414cfcb1fc4da9b420044086215449bb3df8b28b2b7449445b3e459132159a38ff90b03aff4577efc9a432d5172f47f91d469c8a11400b1046215441ba991e17afacd704f3abb80fcf50cf9e3b778b50442418f1ff43ed953ddb09a432d8c1d8fbd64eb722b875200c41888556001e98a1bc4884fa896bffb34387d34826b56f331c6d4b5bffa46fc8f9e38c4a5a0eddadb6d37dc19e1b75600c42678c10658a6e0e1ae2cf3488445c4d69d5c23a66187934b4ba0189aaafcba28f0ee8bbcbe8391da76718dfe904b290062105cad02cbb89ee0b0539db661b5ffa5bef0d68d79fcefbc1098389457a60a4ddb389f7f874b29006213c42ab08cd8ba93e3e1218844fa45a86d5deb1b7c877e701797aec039face7fbc8f77577f5d8428e55290d4a8eb1a31057b12b954032036c14d6060294a7dc31ed0b6ace152ccfdca4762ebcef0c48e03555196cf0b4c1dc5b124a991e199fc5d39da97110063205681c59822fb86ddafeff887432dbbc376d33d8ebe43e010ec48d0d327fc6f3ca5efde1cf99ba9ff4a4cf2bcf58500afd3803800b10aaca71fd8e97ff9517afa04875a188b6dae763e3a82d4accba15afc517e981bfcf00dbe67b3931a19ee319fc5e059f40098016215c4047def36dfd0fb78fd6b8e5d1ed70bef88ad3b2341e452b0c2638cb19347fd6f0ed2776fe65b19eefd827803b10a6285b661b56ff4a348d3f8941344a9edd5ce67c6e2844a7c0a5668c10fdf507e98cbf722152184d3d23d6fcf85eb5410572056410c51967d159814d15efc1720d5eb38ee1e2076ed014f5b8bc554595fb322386ba27e641ff7e2c2254d5d2f4e23556b70af0c402c835805b145fee6c3e0276379bdd151446cd2da39f82d523d8363cd728f317af44060e2108dcb62b18b88cddbbbdf9a6d466500621cc42a882d4cd794ef3e0d7ef806dfb2d89d205d71a3f3f151c80efb31217afc5060da287deb3aa6c866d4976ebadbf9c830ecf298511c801807b10a62913c777af0d3f1dccb92a454dbed0fdb6f7d00395cdc8b970bfaee2dcad22f945f172273021511c1d6f321c7fd83603b4910b72056418c527e981b98f632d254ee95b127d1f5dc38a145071c37e1ca748d9d38129cf58ebafa7b13a7b13b1c8f0eb777ef6de21400c43c885510a318a5dada5ffcaf3fc16d6df07f916ab5ecb7f5916eee8da5880e7f8d7deaefcbe4af67d0fd3b4c3da1167b2ab9c77c2a346866de1400940b10ab20a6a9eb5706c60e66de7c93ea93b474a96b0f5bd71eb8767d5cb1763da4c70faabf2d537e59400fed317b2ea1793bd773e3481abc480300c42a8879f4c83edf880769168f3d984a4288d4bab3bdcf6052a36eb97f2818f0d1ac4c79de0ce5a76fa2319d20dabadfeb1cc073f76000ca358855500eb0dc2cff5b83b4cd7c76e42f09162552ad9674c5f552af47496292a9739941dfbb4df9f6236dc7dff4f471be6f2895047b2ab9864f169b7740821085e900281720564139e1f7fa67bca6fef46d140203db1d42933652fb6bc4e6ed48dd46664f17099697adefdba66dff5bfbeb67fdc08e684e2db6e9ec7864b850bb7e34270520f641ac82f244fe6ea6fce93b2ce88fda8c24394dbaa6a7d4b93ba95203395cd8ee88dad42561c1000af8b4edebd52573d48dbf47bf01ec7049b7f571f6191cf959b900543c10aba09cd1f76df7bdd29f7139ee267418634f259c984c52ab8aad3b89cddb0b8d2e8be6fc8c527664affafb326dd39f2cfb14cd3dcd02be6836708e50bf99f3b97170910a4049205641f9c37c85c1e9a3955f17f13c10344c242189643424d5ebe02a3548b55a42951a38258da4d7e1529c9d3ece72b3e8e913faf14334eb383db4573fb49be5e770296e184ea864ebf1a0e3ce7ec856c15f4902201210aba0bc527e59189cfe32f31658ddc87f399c62462392d1103b5c62e35648144946a37f37fac71809e2f97b5ce8795928f308cd3d4d338fea3b37b2804f3fb4db9ace4b8609c1190dddc3a792ea7cbe6f00a002835805e518cd3ee97fe705fd1f0b9e2f1a44046cb347f3d970e4707265d7e0b1628b0e48b259dd0b00e500c42a28f79465f3e4b9d369e661ab1ba968b0cd2e5d7f87fdeec749e56a56f70240b901b10a2a0216f407260d57ff588eccdc9f2f8e8892d0a4b5eb85092425cdea56002867205641c5a1edda14fce0757dfb06ab1b29df70ad7aae67de122e6952e1774b06c00c10aba042618aacae5a2c7ffb113d18730b7f621d216293d652f77b6d5d6eb3ba1500ca3188555031053f1daf2c9dc30af3ac6ea43c2084a4d776f41f29b5b9daea560028f720564185c5724e2bbf2e0a7ef60e528256f712bb48cd7ace81af8897b644f6727ec60000b10162155470342f5b59f899ba623e3d75dcea5e62081644d2a2bdfdfa3ba52eb75add0b00150ac42a880f8aac2c9f17fc721acbcf46ba657b33c5047782d8b4adf3a931b0ca17003340ac8238c27c85fab6f5c1afde8bcfd5c2382ddd71df5362ebce24a50aaa5867b603103b205641fc614cdbba4e5db9485bfbabb9a7a3c7069c5459bafc4ab15d57b1fd75b170020f00151bc42a88639aaafcf88dfced47f4f471a4c85677c39bd34d52d21c0f3c2375bed9ea5600882310ab20ee692acd3ca26e58ad2cfd821ed96775371c08adaeb45fd3536cde1ea556c58260753b00c417885500ced2357dff0e75e31f74fbdfdaae8d2c2fdbea86c240322e151bb6109ab695da5e8d9352ad6e0780f805b10a407128d5b6ad57ff58aefef63d526416f4c7da6ec3d866470e17ae5c4d6a778ded96fb61592f003102621580d2304a59611ecacfa139a7b40dab94b5bf304b6f1493daf5c5d6574b9775c0556b91942ad89d006b7a01882910ab00844955f4e307e9e1bdf4f4097a641fcdcea45999cc5bc0b232394e821d2e9c5499a45621e9b5715a3a49af436a64909af5484212c7590000dc41ac02c00dcbcbd64f1ca2fbb6d3c23c7dff4e969d49cfcf5a554167ffb6615164849cf9312138a311494a25b5eb0bd5ebe04a2962e3cba3de3b00800f885500a284057c88d1a21f639b038992b5fd0000cc00b10a0000007043ac6e00000000a8382056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e2056010000006e205601e080659f52fffa09e9bad58d00002c265add000819d5f59d1bb5033be9fe1d34e714f3156241444e374949136a64e0ea1942ddc6a44a756e73eddaa4efdfa9efdf41734e16cd859d6e9c9246aa67901a1942462352b5069fb9ca3bc6d415f3fd535f4641bffd8e471c7d875ad6881cd477fc4d0fedd6f7efa0b9592ce8c7a2845d1e9c5a95d4a82bd4c810ea35c1c995ad6acf32aaac6fff5b3fb85b3fb083e666b180afe8d34252abe2ea19428d0ce192263839cdea2e41c501b15a0e3055d6fff92330fe395a985fea0762a16133e7809749fd6658108afd0879fe27f2dca98e079fb3dd744ff1355445ddf84770dc73b430af8cb91a34750e1825346881ce9f4b91991ca0278fe9fbb6b1e387f453c7585e16cbcf65012f0bf89122334d459422461163255546a2485c1e9c5285d46b6cefd557a8d7f8cce7410e6aeb57aabf2cd0776fa179d948d74a2e8210428808d8e1c469e9629336f65bef23198dcefd176de3ef81379f16da7571f61b893d89a5fe4ecba0fcf87560e2b0a21febfb77843596c9417def5665c96c7ddb7a5a982f54af63bbee0ee99a1e383139bc26e4a0f2d3b7c10fc630452ef5e3b0d8fa2ae713a349959a8870ba53c5180bf8e8b183eaeaa5da963534f328f3e69184249271a9d8e13adbd537e384e4b2e7a2949e3aae2cf95cfbe7777ae2080bfacaf893451849369c9824d4692075be59eada034bb6625a9383eacab2ba7d6b00002000494441544581692fa3323f2d9775743e319aa4d709e3d3a2a97ad60965d1e7faba5ff493c7486a35b1c3b5f6dbfbe2d42a389ccf2d0b06587e96f6e7cfdaf6f5fad1032ce71492fd4cd548a5649c545968d04c68d64e6cd9812426239b03611c7a656015cccaf8f20516a39947fc6f0ed2f76c29fa8786a4a58bedba0a0d9a93a4ca58b2516f1e3db4575bffabb67b2b420c2184249b74c50dae67df46a2744129569857d0bb03d2355bd71ecee7c75f3c979e7924f0d6d3faeecd4573e1d46a52876b8406cd71a55462b3d3c23cfdf05e6dfd4a7df796a2b9b064133b5cef7aee6d24d91042caf279f2bc19342b13c9015ebf7dfbfd831cbd9f4408214abd036fd30fee3456c7766b1fe78097cefd34386b823c672a428854abe51e3583d46960acacb667ab7ff803cc5758f453a15e63cf9445a18efd637960e6387afc20a2f4fc5f2749a9b6dbfbdaef7c34c47f43b51dff04260ca1c70e9cf90aa9dd406cdd49a8d78424262381b0fc1c7dff0e75ed2ff4c8fe337f6a7687adc7438e079f0de3f75902fdc04e79d6446dd7269697555c1062ecf2886d3abb9e790bd91da5d4517e9a1f7877045215234d1092387315ae5cedc2def66cf58f7f9e1ed95bd49850eb12b14d6752af09a9948288c00a72f4fd3bd5b52be8e17d67fee2d8ecf65b1e703c12d2cd067dff8ec09497f43d5b90ae9dffebd86617afbec5f9e46bf8a2bf7dc5604cfee60365e91c76ea18fbefd7c0854489a45625f51ad97b3d22366d134a87c04270b51ad3f4033b7d437a336f012282d8ea0a7baf87c556579dffafad8010ea84ecf70fd2776d0ace9eac6d588554455db938989ce67874f805ff2ed36307cffc2b2016f3e74e0feef60de9cd0af39020882d3ada7b3d2c5edee982b92484d0fd83f4dd9b83b3276beb57325551572f09a65476f47b11618c5405493692500925a520bb13bb3cc45309b913b02711bb2b61971b1101057ceaba5ff5bd5b114242dd4bc52b6fc2363b5255ea2b40be42e62b647e2f0b0630a2c89520366e65ebf1e099f60af38a3215dbeca47a1d647722c98e451111011352caf78658b20935eb4a3d1f3eff17498dba67ca661ef1bd39c8fdeac7e4a27f97cbc40a7203af3d7e2e531142485399ae61a1acbf568c05678e93e7bd8f1022c995c5cb3b91daf599dfabefdda66ffa93e66507674dc00ea7edd607caec415dfb8bffb5c791a662c92676bcc1d6f341f1d29617fcb94b5d7b381e7a41dbf4873c6ba2b673239383f2bcf770528abde743e1fe96cfa1b959f29753951fbe42aa8c10162e6922346826d469882ba530aad3a3fbf56debb5adeb99bf505db5c47b6087eb954f4a796a400fef2eca545cb91a494a453607966c581419c2a57d6f4108494896aeed7971a66a7fffe61ffd28535524d9a476d7d87b3d2c346a75e1a7a5cb6d8e879ed736ff159c3551dfbe0129b23cff235c29c5fe7ffd4affbdabab9606260f677e2f1225b1c3756283668c217a64aff6f76a5698affef80dd2345771dfb65ed8e4e6bf829fbe83740dbb3c427a1d9c5a95544a462e0fb6d999a62139c0fc5e9a7d929d3c4a4f9da0278fd29347b5bf7e169ab476dcf3b8d8ba7399f58155e06a35763145f6f6bb9e9e3a8e30b6f57cc8f9c8b0322e5f74cd37f2616de31f453f4b98be94d46978fe7f57ff58e67fed098490addb3dce275ffbcf5855f13e7abd7eea18c2d8dee37f8e4747943117d57da31ed136ac2efa9967ea12a1eea521febe8273a6c8b32622849cfd5f3c979a65d28fecf3f6bf112124b6b9dafdca47218e2ab1daee2ddea76f3ff75321a3a1fb9d6fb0c31946094afd6f0d52577f8f30c60949c857c8748dd4c84898b60449f6d2063216f8608cb260264248a85ddff5e66c92947aee3faaeb56065e7f82c94184907bcca762ab2b4b2b15f0173cd48515e420429c035fb5dd7477193d2bb277504ffdd01e84104e4a4d787f194e480aed77fb1ffaeecdbe21f7313980302669d55dc3270b0d5b5efc61dad675fe571f6385f90821a1465dcfd425c856ccad5a845060e25065f9d70821f79b9f8b2d3a1868e93f8281c287bbd0bc6c4488a3df8bf6dbfa94f1f1aae21dd4533fb81b2184dd099e193f92929f40ab6b7ef68fee8f10c2c995dd6fce166a5d72ee3fd16307bdcff462de428498e37fcfdaef1e50fab481f1cf2b3fcf4708257eb3093bdda57ca47e68b7fcc5146ddd2f2c78e63e90fdce7e8e879e877bc2b1095602c72ee5db0fe9a9e30821e9dadbcbce54849020ba47cd20e9758a7ea61fd97fc17f67e71ecd5e74874a9effb17eea1842c8d6b547d9998a102282fbc5e9a446c6d9b9f696f1f1e739777f2cbcefe8bc679a27556b8633ac7824bdd69966dc09d8eed00fed094c1a8a4abf11f75fca8a05eaeaef114242bd26ee573f4692841042ba5e66116deb3a75c91c8490d0b0857bfcbcf333152124b5bdda39e88da21f07678e2bad1063be779e6705390861479fc1b61bef2abb699bdd35ea7dec4e4008a1808ff90aca1e721175f552dfc887981c400839fb0ef1bcf77db1998a10129bb5f58cffbae852523f7640fef6c3926a9e7b902f54ab65a0a50b04a68ca479d90861c7bd03ed215cf123c9e67ae52352f43c5b9151416e897de69c0ebe3b1221841393dd6f7c7e7ea62284488d0ccfe4ef48722a4228f8e5347afc50e9d3fe7b9f8314bf12e21ca14e43d7b0c99ef796d97b3e58f42bf2b71f05a7bd1cd6572c881a88d5d8a5ad5951f403db4d7787fa6da9dde1b8ef29a15e63f1f2ab84fa4d2ff88f2ce03bf3a38bee526a7ffd7c76aebbc298ebfea7857a8dc556578a0d9a8734e4ccec67fe1109eb5b6dea3d9301f8bf39640c4e483af34920c47e673fc498ba7289f2fd9c1087335fa13c670a420811c1d9ff45ec493cf33d02d559a9efd8b082dcc0b8e7982a936ab5dca33f3c9370ff255d7d8b74e58d08217dcf1665d957a594d2b7ad4708e18444dbf57784f8d924556bd96eef2bd46b2cb6bf36ec855108e93bfef14f1ace0af3b1cbe37a719aadd723d8e12a6dba9a755d8f8f42082384941fbf61b4844fceb980a914e91f2ef37bb5cd6b1042d8e99242ffb4a456b3ddf1a850afb1d8ae2b4ead52fc07513d386524cd3985249b6bc414a176fd62ea54ab65bbfd6184109203f237257e1b71a6d5b34b108a5d6f554cf12ad51d8f8e70f61f89253ba2bafcc35c6dd39fa10c045106b11abb8a6ed62184848c50efaf2284a46b7a78a62c72bf36935cfc8dffd9f590f8a267abdac15d453f20f59a8431d7d5b778a62c728ff994a4d70e7d14c267beea5858b9ea3ff32f2f7679c218554a17ee048410f3796d770f2035eb2284821fbdc94e1f2f7b2463810943e889c30821e7038384666d113b7be94d59e9d7e0cae2cfe9e9e308217befa770a594123ac38e8787609b1d2124cf9d5ed22a56e62d28bafd803d95c2b8978bb1a3f740cf9445aea193b0ab98502f05cd39e51b763ff27b916873bd345dbae2865046891daeb7dffb38b23b49ad7ab884cb325a14ab920d97bab22914ccef65f9d90821ec7485f1da0cc6f6ffebe799b2c835622af6542abef28923eafa950821a9fd3562f3f62555b2dfd98fa4a5238494efe7b0acccd2262dfa36979030961f636cbbad8f7059478410d2b5e067ef843a104411c46a8c6205392ce847082141e415244853cffc40f8cf4d605a9083cece854a7dc6c3c7d934c5389c2fbfb397da4579c3a18ba227a9544794ba864ec676270b06bca31efdf79abe04fafeedeaba5f1142a44a0de9d63e0821c458d162d2525f1c4248d7941fe62284841a756d57df5cca14a472355cb5264288e69ca2d9278bfd189a9755b4000ddbec17dfd53743f0a3b78a5ee0713cfcbcf8ffec9d7780d44417c0df4cdab6abdcd17b932e08d85040ec888058419462438a9d6241051115154441101450408a8020a2802088a074a4f77a9483eb775b5267be3fb29bed7bbbc7f97d7c9adf5fb94b2633c92679f3debcd2e286f81b0a8f3e9f346db5fdf5c9518f703b010047d2dd138516e551dda398e5e3d402e38210d7fbcf83aaa0e434c34a1f0deeb61efa86bc3e965b3875bb206e55d50f4296c75fd437b5c37b4a35359bfcf731c5ea958ae213819a4addcef239a74fac8668ab48f50509682a94575f3130e44e22e17dc4e3f66e4509c94d14c4fb14235561ea34e26ebf1f00c8a9c3d2bcc9b144a3c7e5193f1c141958ce3a68943ee3a1d42b5729a50197178ab47c36c9cd06842cfd8642ec8f29c70b5d7a0300c892b2656de4f1fb7e352a4bb46ca12989a0fef587bae14700e0aeed14d782650008639c5925d625ebe6d072991c182f8e2a9731622712da91dddaf1fd00c0b5ed18d1741f0877ed2dde21ecd91ce330efda76e257cdd46bea53a929c9ce4ab4b9c9df8d2956af50507a45c479df37f5c08e72392735c467b06442699960f4b56f5bb9f41503447d7e160969abfe58d872f27e34ec8d440384ac03df666a35000069d13465f39a688de41573b593870080ebd0856ddbd1f76fafed37c6c8a822cb3f7c0300282995697c4da9a3e3ef7a58d7cb95b5df473c0055c8d4e725b4289fe65f2af5849785227ba68ca69a86ac76cbb36f86afcd5f26ba618626f43c440157a8a83fded455a2959fc8311c1dd81b6e2ff560a67e735df3d68e1f887198d765a94c766f94e4b3549bcec0571ea658bd5241c858e694668e0b0a8e2c3386df60b011181062ea35f3f635eba3f2e92b3afec8f78492d148a2772b9adb4ba218b2c17742a1ff707d439c329a16e486b720d959e2c2a900002c67e935386070a52ca902002dc8a1857900c054ab1d755535108e679ab50500edc441929f13e180a434dde788ba9d9e09c369f9a5e008876467d1ec3300c05e7f1baef83724add4d78f15b1b4e3e2c09e84d22a02009544cfa7af7957522e1be58fd50080ec4971058c320cd7ad0f00d0821c3d6e27029aa647cbf8ad26f143a9f148a0bfe3e730b93c4cb17ae5c2dff1a0bea19d3cec1ad6533db023c190945028f169ab612e4bfc9dbebe4e1f710e7d58dbbffd32fb8a852117139968fbed9ce594cede9fb441f38a79ae6d47a17b3f4088e45e708d7a3ae48b4c45b7fbddc17a6a0eebe0d146201300209f9e1ae39669bb37eb27e46e7f30cef90473d5d50000946a47f786efc529e9fc2dddf46d75cf16f7bb83349fdf59b9232e9c4a151904ebdf122ba9a95e3b8a5a0ebf2cb225f1b776f79e78ff0ef7e801ba75e172d08eefd7b28e0300d7be4b9c4e557cc7aebad2acac5d12f100aa48dea457898b5565cb5add7883abd462aad62af57893ff32a658bd72e1ef7e84f7f93e68270fb95e79d8fde613dac943204b6594797e6d355cac3ec4dff180f7a853479c431f718deca79d3858f6be620dc3f7f52c2d5c2f0863cdac9c92d946f443b63cf63ccaac0a00da913de2ac0f03e30295d58b759b1eaedb88f3c933efa9026f5194bb25ad5c0000c0725ca76e918f0883f1852de949a9228cf6a9d7d89637eadbeaf60dcec1f7ba3f1e4ace9f2edfa556ea2e517e5d0a006cd33665c84555faf97d290e80299f5fd6d2e765b68d57a754fffac339f85ecf872f91b327cbbcd42aaf5d0a008010d73e96a3592028bda26e4b9037fc14f10df25b5f1274c1a38a2c7d3b49df161e79d634025f8198c90baf682c8346a30a95e5455fe8d190ca8e0dea5f9b506655a65643ae4317b6dd9d09b91122dfeb1d3115b875e0285ca192b470aade97ba73a3f3af3f70c56ab86603be4317f6a63b51ece441f1437c5f9984be08bee4abdae9a3dab1fd28a33276245f8e934be47ce8568763ec37ce17efa72585f2f23938294d78f439005036feecf9722c00c56919f6b7be08b9edc890ac2872b23d927f891cfe0b0098facde2f764366a0c90ace3d18eb1bdfaa9e7cbf794354b8052204459fbbdba6105aa588da9db84bfb53bdbb6e3e57f76b583bb74c1c0b6881a557239f8c52a21daeecd50a91a4e494716dbe58cdc36ec1371c63879d502dd3e2faffb41fefd675ca91a53a731d7a91b77ddadf19f9caa8ab66f1b0020c11a7fd526c40b3835432bc8058f93961446081136647c429ec04413278dd44e1c00005cb536d7eeae04da9afcb730c5ea150d122c963e2fb12d6f907e9ca3edd9424b0aa9a6d1ec2c929da56c590b82856bd39e6ddd9eb9aa1553ab41a96a5cc0a2662435911784c75e645ade282f9fadeed9428b0b8010929d45b2b3d4adbfa24f2d6ceb9b99d6edb9c6d7e09aa5f71573183e6d35219f5e9f1bb3fce31cf9c739de7f220408877c2211c380d5ced46f6a7b6d52ac9c70c6dd086e8eabd6b23cfdba67c2702044fcf633927791a9d5509c3b115405b19cf5b9777185308dcd67054608a18862f5e83efde633f51ac77bbd00b862359c5e91e45f2267a226b14249a9b6e7df53da74907f59ac1dd841dd4eaac8f4dc4972eea4f2fb0a9494c2b5bd8569d58e6ddc0a57a9553641a59df4da96997a09c4342780ea1530b4a4c8f96a6fdf7f113038d4090c21c40b28b582a5ff30eec63b639c123992ad43de61dbb497572dd40eeca0ae12501572ee1439774ad9f833b227b36d3b70addb338d5ae2aab54bb92d9248f32f0200b258134845c272b85a1dddb6448b0b228855d9abad1a9e89a542ce9f12e74c54d62f07009c59c53e6666b985de99942ba658fd3f80bdfa06f6ea1b00405ef783f4dd1734fb0c9544a0142451d9b45ad9b41a009806cd2d4fbeca366e154b81a3a5fb0ab1cdafd343dde5f53fc8df4d23174eeb7d514954fef845f9e3171180a9dfccf2e4ab4ce356658b0b0c509a1310ab91b317510a34f4ff9468402929cc8bed694c8dda2338f4abcadf7a1fb89d9e2fde0142f44853000086b1bef03e7bddad91464191d7fa8b68247f60d5e711ca0467692e15b64d0779f577dab9934048d45f0d63eee6cedccd9d4191a59fbe95f5301e5902005a5224ffba147e5d0a08312ddb599f1cc1d4ac9fa81faf76eea4b79fe05c7de5451493350d5b44470094120285b9c81a87384188bbf10eeec63b4053e59fe74b4b67d1bc6c2a4b402975152beb97ebf289bdfa46cb93c399da5745bd2d1e1729cc030054ad4eec945221702d6f5436fe4c159914e6e1ea754377fb83c84bfb3988465d25f2f2d9e282295e1dd7916c7f6766847c2f265706a658fd7f82bfa52bdfa10bc9cb26674faa5bd6cabfadd013ca00807674afebd5c7985af585479f8b3a9137acaf71a8897cc7ae7cfb2e34ffa2e6edeb47dd911500b463fb5caf3f8e6bd4b3f47a8ebb29613354d9b455232c87bbfd7efe96e8cb930801cbe1a4145cb96629ab56c6571b451806d7b927f01671ea28ef1a98d56e1d349aeb786fe43efd46e0c85d115fcee444131ab3d7df2aaffe0e14593db29b6dd4aa94a3395ee8d657e8d29b5c3aaf651d5737ad5436ada67a762a4ab55d1b5d2ff460ea37b33cf306d3b045fc63a0be7c1465cbcb5f2a28407cdadf99114bcc608cac7654a1324e4fa4ea38c3f25d7af3773f42722e90b3c7958dab944dab8c7cc8eaee3f9c2f3dc8d46d6c79f2d58835d7d43d9b75c306dba4f4b0a8a06e5bdf0c00402939b60f9ab50d3baf12de2404edec4975d3cfcad6f524eb18f526ef44fcedf70b8fbf882b544a683026ff4d4cb1faff06c638b32aceaccab66a6719f0a67a648fb66b93ba7f9b766017759768270fbbdf1d2cdcff94a5cf4b913e4fc6a2667c265c8c51461536a30adbf246cb3323b5237b955d1bb503dbb503bba8ab989c3ae27e6f88d0e3094b9f97135be32c93cb92218c991af50c3f9dcbc22fdd23dc0dc4b0fc9d0f32575dad6c58811886ebd8d5a82b10616c3460b538a211f8dc297d43fe6db9b2798db70a9edb059aeaf583d594c8ae618aa24b6d6dff8ed2c5aaf772585ca526ae5293bbf616cb9031dac19deaae4dda819dea819d5491d5833b9d2f3d607de60dfeded2eaba18e801570825a4ab2580613640e86fac77c6b0b8720d5cb906dba6a375c818f5e04ef5af4deafeede4e02e2a4bdae1ddaee1bd2cfd870b3d9e0869a7ecdce81de6a9c39ec96f515709b84b7463bb5e071054d56f070a050150f5f0ee70ab0e355cf064915c3a0f6e2775169192425a90ab5d3843b38e69c70f0426d8421ccf5e7313dfbd9f6eb832b99231c5eaff376cc3166cc316023c4b4b0a3de387295bd701a5d2a269283d3342354ddf6a222a53a222a66173a6617300a0ce22f7c7c3d46deb801069f197382d930ffb18c5c2a73427340c6448aef24ad4e7d756a34e3298da0d99daa59b6dfdeba90847f4842217bc19e6945f9725384a2feaa15d657018432c6758f569fe25d79881daa1bf8010cf94d128ad629c96063d6121504a55a53cd301fa20be1fa2dc7ce24a8561d8666dd9666d018016e4b8c60ed6f6ef0042c42fdfc3199543dc7dd53dde74f6eab6dfcad65b64476edf55abfb7794f48d3e996039c45bb80e5d2c4f0e8fcbf46d7205608ad57f082829d5fafa6476c30acf8411a0a9e297efb3cdae0d2d6263e8430945b684f7e548b1bf3159deb0c2337e3868aa67c638a6d9b5bac48d0bdfd49e26a4adfa546d5a5e01367e25a9fcc2cc2269abe4e259ea7202004aadc0b6bc1157a88c92d370722ab5d89060452c070c13d56b4674bb27be468bf269d67120dae5fc7028bda27dec6c69d92ce99bf140a9e7f3b799e66d713c15630c515a98079955ca3c80a803337e59b67cd25226d67b5aa67dccd7f28ab9e28c0f8010cfa437d9a66d90cfc44a9dc534f71200208b8d6d7d33caa88253d351522a581d48b0228e079689f1fcc88ba6293b37920b67a8c715e23de77ffcc287c40bb85e53a64153b6d9b5b85a1d5cb946ec6aac26571aa658fde780588eefd45d3bb84b5e311788a66cfc39ac369ceffb75f9b16e0ccbdfd24d3bbc5bfee11b209ab2f1a7f8c5aa61ce4d4c69361c9dca2b739edf167db9629502208428004298864948f5d05ffa9d173af7127a3f9fd8a91519d99368513e713ba9e8b94ccf4f64b15a7a3ca1eed8a0eddb460b73c9beedb85d2c7f5a6fab14af17ab76fa08fb378855ff2ffb5fd35683418245e8d647dbb951d9f93b7516a9bbffe43a79134ad0dc0bfa6fc7346c618b512a200adade2dcace8d4008397f8aa91732c7f5998e6c0e54b906397dd46f0c2784a9db587864302e8f1a8826ff7dcc7410ff348c72d6eadeada1fb0c3b6a3965abf7e781dab73dfe568639b78ca9652f4fd5f6a3959b58d5652a000046e14660edc81e7d83895e4d2c2a1cef2daf2d79a05cf2f071bce5e181faa6fc5bacfa2a064cd5dafa86b23b56e2f872e06fb030c70bc3f20f3ca56f2a1b571affd672bc95dde28f580d04f96621c6e2ba1fdf640257ab93346979d2b4556ccb1b10cb01425455e415735d43baeac5074dfeef30c5ea3f0d230a825e0a2d1d4acb96e33e3a4cf53afa06c9bd107f2bbfb69a9880f42981e5f4f1352276ca43fd35025743836801801cdf0f0088e371c5aa653835aed50000a8e8f1a74db83c189f472bf115f42d65003eb76175e3cf979b724b53e5e5b3a5b99f063d30bea71109d6cb3af9e5e14d1509a0054409eb11ab00802b95259ac5b0b16be1e5db8c871f0100e02ab5ec6366d9272c32bc9149de45d7cb0f2a5bd795a15f93ff2da658fdc7e10b33f7670036a0097a029706957c15b6a32f1445c09f433111b18acb59ac225dbae3088230f17379975429c2a1f7565369ee450000c1e2adf09a204c8dfa00008a12adf06aa2187506691c311e00c05e7dbdbeb6472e9e15678c0b4ce89858bfa2c7f3d94871ea6879cd12644ff6ffdff7cbfe8f57108dca83010f33c9f39606c2556a96e59cbe9a0ae1e5dbfc5920347f9216a65e53fbfb732dfd87eb4ed7a430cf3366a0bcfabbbf3141b7c9df802956af5ca8222726ae00c0bb92070010a1d288df6529549050452a435fda91ddfa869e47375e68d4d4c4b1308a9f97a1e2474434adbcce46c12b561183434cca5412754f5a2458cbd697cffc1021e13e95a5c8593262a2facadee97a70e90348cd101ef3d6cd96977f1331ef7fe91022cd9d28affe8e22243cfa5ca004358c16a5d6318d17452e433d06659b572fc435eb1bffa4795e23302a9311d8ef11163e25f255910af55dc25878e029c7172b517a4500a0aae2f9e45569c11453b2fe1f618ad52b1469d174e7c0ceae571f4b54479157ccd537228500fa7c4382352a69c957ce81f7b846f44ec8960b00f24fdfea1bdc3537c5df8a96495b353ebed85a3ed1935e5bb4500e6e32087b731652860dd17da92c51c52b566999f46ca6ce55fa867a7067e0ffc52fdf733d7bb77bcc40f0b812389dc7252d9d090080107fe7c37136e2ef7a48cf0f4565c9f5667f65dbfa047a04a092e8fee865e9fb998019ebc051fcadf705ee45be7a4ae5926e429a39ae64c05daed1cf184a797ccd4469d92c7d33707824c7fb4630654a6984d2bc6235c29be5d3565124ed1f6756754c58c4f90a0688df7ee6f9ec0d23cba3c9158e2956af4814595a3c9d9c3ba5eedbe61cd445dd1397ab08952571f627eab6f50080ac76dee7cd68e0ffde0768545491e5a533c9b953eafeedcec15dd5dd7fc63bc2391395cd6bf5bed84ef795dac23f0c63de9d90b66ac8e0f2ca83aa6babe592e2007995d40869f40d6d352925fe24fb41e7cea8a23b009380ca80d4ed9496cdd22e9c51b7ac75bed023ce5552ea2c767ff18eee3e83abd464c353ff441b83c5667b7bbaaec6d19222cffbcf4b8ba6c55397978a6e65fd72e7e02ecafae52839d536e41dfeae8743adeebe40649450eea488dd795ce2e2afc88533eab6f5ce215dc989837135733b3dd3de25a78e0000caac12986c84e466836e6948cd28c378902d09a765028076f15c88f1dc2830172dd2066756b5bd3689bfb737703ca88abc72816bcce0cb2f7267f25fc00cb0b922e178cbe32f8a9fbf4d358d1617b846f4e63bf7b2f41f8aac8ec80b8194d2c25cf747afa8bb36e9cdedefccc061851869243b12e278a1d71071f29bdebe5e7d8cbfeb11eb9323c06a8fda57519ee7a3a1cacedff5e6b651d30ddfa5844061655f63e1d35695cd6b359fa13bbe861825a7314d5a871435f37ececac34d0631dee0c508aba78aa4e771c5b5af2af3f971f53ada91bda42097e665a38c2a00806c0ecb034f8b0ba702a55ad6f19267efb6f47d85efd6376a35504248ee05f7a867f4ef32b2daedefcc48c8e88a2b55737cf0ad73446f72e628f5b8c419e3a46f2759fa0de56ebd0f580e18d6eb5e4e295042551544b7bc7eb9346722751601c330575d6d7bed331c69b1c0c8ef412e9e937ff82681fb8200780b53bb2153afa92e9b91d56ee93948fcf633a0945c385332f85ea1f7f396fb9fa2bc10b10402504a722e78de1da41edd0b00c862738c9d1d98169fe65f02dd0e5f567771b6f5cdf29a2520bab563fb827246da7c379f44b7575b6cd667df66ea371727bd491549ddfaab73fb7aa17b5fe1e181c89e546e2ef126ce70ea920000200049444154e58d2956af50f8bb7b8260f54c7a530fab907f9aa7fcb19a6dd094bda93377f50dc8f029153dca9e3fe59fe669077652671100207b92f5958f98c611f297fa5d5e833f31fc5d0f238bd5f3d948ea710180bc7281ba790daedf84bba933dbf206638d968a1e75cf66f9a779da811d7a5f6073585ff9886d1aafd2e3c5f842e1041e3fa37888343fe1f0410040165bf29c4dfe6f1900228402944f0d10eccb0910b67a4a8b0bf5ecafa1618b89c0d46da21dd90b00eab1fd5c86376683ef350425a589df7cac6bc3e2ac8fa51fe7b257b5e06eeecc36bf0ea579b52bea2a51b7ad97572ed00effa5e737c6a919b6919f0796618f1394929e34f17b65c30acfac8f68fe252aba3d534689333fc41995c191822c164018340d44372929a4f997a82402c27ca76efc3d8f320d5b44334ea0947464b151d1ad6e59ab6e595b86fb233cf88ca5df50eff62303c19122ce1ca7171b90e67caaac5cc0346cc1dd7c37dbe27a9496e9bb2d4e75c76fd2cff3b5437fe925c15172baed8dc981292aa9c7454b0a0100d769548651e970edef91d72c010065fd0f81621539920161a0a4d44553fef6fbd986cd3d5fbea7eef81d089196cc90572fc2556ae16ab571c56a20bab5b327b023d9f2c2fb7f577649930431c5ea950bdfa93b77f50dd2c2a9cad675e4e2595a98ab6cfb4dd9f69b0700596d604f4694d0a202c39f13f102dba683a5ef2b11ca65000000aee97351099bb9731dbbb22dae97164c91b7aea317cf92c25cb27d83ba7d03f8fa02426871813f3f38c7736d3a087d5e6602fc3be2c5e83d91b555e1c16790605177ff492e9da7c58520895495e3f5e3b0d898666d4108fae8508c516a06dfb16bfc638806c518304618b30d427362904be70000a767b2575f5fe6f3338daf81950b00403bba97bbfe36fd9f88e3f91efd996b6e92164f5377fc4e0bf368ee0525f782b2691500209b1dd993a9a2d0e27c7fd24a7b1277d3dd429f57706a7a1987c20bdc6d3dd81b6e5736fca86cff8d9c3946722e68674ffa63a21916a765a0b44cb6514bdcb40d77ddada52785e72df651d3a515df92b32768611e753ba92c0121512bc2078231ae543da8621dc30addfab0adda498ba6a93b7ea7053924379be4662b7fac06df6d01552545797eabacd5cedf7497a5cf2b215668aa2facb23ca727cd2f13cc5557237b127595287fac169e18614c6d11c3e20a15496e763ca66f5caba17df40c65cb5a79e50275df36ea2cd68eee0df21dc38cd06b08aa19970f9ac9df0d8a681834b9d250b7ae13174ed54e1cd493b3ebc599bdd5461906713cd7ee2e4bdf570c1d25225455dce35e829242dbc8a9c816359841ddb65e5c38553b7e00541548a4be6ebcd3d26f68ecbe6220ce1ca7fdb589bbf771feb6fbcb76862b0e4a95cd6bb0233942c207a291d347718d7a9753719d16e6395fe881abd4b4be340e47c973a4acfd5e5af29576fe34221ad554afccd07f3596458295bfeb61e1a101e5e66d1b0029ca076711302c4a4ebbd22a80caeb96c94bbe22e74e514d054d459452dfc38c5816040b77dbfd964706a1a49488cdc9c5b338b5c2e5ac14504df58c7e96e45eb0bcf05ec8accb33f135f5d02efbd08f71dd440ad912a26e59a36c5ca51ddb4b0af39160c5751a0a3d87b08d5a96799026e58b2956ff9fa0ce225a98474a0abd21042c87780125a7a2b4cc72b7ff50671129cc03671195a5c0be705a2698b6a62b134a69713e29ca0767095524a014580e0916949c86d3324b2993f78f8616e5d1a202ea2ca28aecbd2dbc8052d2516a46d4d5681393b2628a5513131313139372c30cb031313131313129374cb16a6262626262526e9862d5c4c4c4c4c4a4dc30c5aa898989898949b9618a5513131313139372c314ab262626262626e58629564d4c4c4c4c4cca0d53ac9a9898989898941ba65835313131f9b7a3eed9a2ac5b468bf2ffd703f927608a55131393bf11f78411c57ddb275654dce4bf0bcdcd76bddadbfde1cbdafeedffebb1fc1330c56a28a4304ffd6315b9743ee186a78f7ac60ff34c7c4d2fd4656262a2edfe5359b318c9324429d66d7225a01ed9a31783a2099540368982295683d0ce9d74f6efe81a33485e3a23d1b69e4f46c86b96c8ab1682abf8ef189b89c9ff1df2a6d54029255aac62dd26ff6bf442cb0000aa39fb29074cb11a042dccd3754d5a5294705b9f92aa178b36313121678e805ed04323a51e6cf2bfc2a8026bdaeacb0553ac06a32a7aa14a9af8ac0d71de829aa611d8c404008052ea72825e8edca85d6f72e5c1346e05ba64c5a64428074c4b7a30a2c7bb91f8578062dfcd544cb16a62024089d7f68b316298fff5684ca2822b55b78f5f04ae12a679dbfff558fe0998623508e2b3fd96a5b8b1efc34115b91c876462f2ff0aa5400900208c019b62f58a866dd0ec7f3d847f0ea6ca1f047516ea1bc86a4fb4adb13e81885919dec44417ab0000804c6dd5e45f84295683a04e9fb6ea4849b8b1cf6e4c4da747131300a094520200606aab26ff264c23703086037052e262d558ed2f4dac524d4584504a0121c47209ace36aaad7a34a6ff85f831040e89fec754234aaa908100588f18be8c7c0ff4af152153db8103006e66f787309014a0033e5f64353aabf0b14218af1659dd4bb466bcae684a1aa82fed6c7c6240cf32e07418a0bf40d94929e7063e36344631981e51573a51fe7d29cf3400872a4b08dae1606bc85d3334b195861ae34e343f5e04e5a940f4051723a7bcd4d96a75e431c1fcfd0b4c3bbe5df7e2497ce21c1826b36e06fbe1b57ad1d57c39387a56f3f253917c062137a3cc95ddb316854791795550bb5130771cd06c2fd4f227b52e9273c7e40f9f31792751c140557accab4bc81bbf696383f97d455ac6c5e4b8eec250539001457aec1b6edc836bbf6b2c400a5e2bc49eaa65524ff12a80ab23a70dd46d66746e22a35430e547e5d2a7d370d92d31c1fcc0d3a416eb6f4f33c72ea0853ad36d7b50fcea81ca33775e7efea9f6b48fe45644f61ea37e53a7641c9a53f6924eb98e7ebf1e4e4215a520880707a26dbe15e4bcf41715ea2ba73a3f2e72fd4db6913ae4317945221b48bec2ccf872f1167b1a5d710ae4397a00bdfb042ddb29652ca77ecca5e7b4b3c3d528f8b9c39460a72a9ab04006851befb9d67bdfb3046f624a64e23fe9e47e35c6ad10eeef44c1a0908f3773cc4dfdb3ba19f9be4e780e4c1956b04b6a245f9f28ab9dac94328259dbfaf3f53ad4e5c17a5a9eaa655eaae4db4281fa756c08d5b71edef4182b5f43114e42aeb966a47f781aa3035eab337ddcdd46d14e7e095df579063fba9ab04399299c6d7b0edeec4c969f1b4050072e18c38eb23edd83edd0887532ab0edeeb4f47939f2d1b2a49e3ac2d46b12c35c4f0a72d50d2bd4637bc1e5448e64a6712baedd5d28eef1fc7b4034a60cf8b7e11ad94fddf13b00d8c77ec3b6bc31b1b6aff751776d8ad5965271f29bd24ff342fecdd46c609fb028c62746ddf9bbfba3a1b43097a9d794a9594fbb749e1cfa8b6a2adbf206dbab93504cc59a9c3e2a7efd91b2792d7224239b83e45d024d450ccbdff590f0c40864b1c568ab6efdd5f5ee60303cb058cef6fc58eed6fbbc7b776d727f3c94e65ff25e45bda68e8f164074572f72f6a4f8f547ca9fbff8745facab20b84a4d4b9f97b9f6f7c4188976fa88bc7496fceb52087307631ab5b4f61bc634bf3646f3a8433a7fda3d768876e200aa58956ddc9a3a8bb4bd5ba82c31d5ebd8df99892a550f3c589a3351fcf633e0f89465077ced3565cd12cf57ef1b51ce2829c536e253b655bb0897b06f9b67fa58ede85e94920e9c40f32f022188e38447060b0f0d88a601534d537e5b2e4e19453d6ea6712b9c51859c3ba91ddf0f94f2b7df6f1dfc0ec49c57a9fbb78b5fbea71dde8d52d2116f2179d9de4e1f1e243cfc6c60a7daf103ce215d01c0f2d80b42cfc1deebcb3ee31ef79276e82fef4108f1773e647d66648c5f1900e41573c5afdea786537d14accf8fe5ef7cc83fd47ddbdc1fbcc036bec6f6da67a157b1778bebd5c78010e078c787f399862d629fd9409c33519eff39d8931cd37f31a491bc668967d24864b50342b4300f59edf6d15f314ddbc43e95b26995f8d5fb243b0ba765528468410e508aec0eeb536f70b7f5881a97a2c8f2aa85e2d7e369608a188cf9bb7b5afabc8c1cc9d1baa39228cdff5c5a3a13240f0000c3ea69aa902399bfef09a1dbe3c816730a4ba9b271a567d248ea2c62ae6a892b572717ce6847f70221dc4d77d95efe10c26603d2b79f8973260a3d9eb03cf96ac40b91e64f96be9f494577d078ec49428f27f8ae7de29952ff7b30d75683a0c53e97a5a4d4841b135fc07b94d9b4f8e558e9a77920582c8347272ffacbf6fa24b0d800403b7354fa3e6a5227edd411d7e8676861aed0bdafe3b365d6a1e31d1fcee71f7c0a00d4bffe94167d116344ea819d25cf7553b7aee3ef7c2879ded6a4591b1c537e468e64aaa9d28a6f3d9fbd117e09eae1dde4e421002079975ca30780aad8867fe298f2134a4e0355f1ccfc50d73f4876967bcc409a7f89efd657e8370c00b4e3fbd59dbf471b0975163b87f75436ad0200fededec90b77a5fc78d8f6fa64e4482617ceb8df7fde336574342d5f3bb8c3f95c7779d542d034a641334b9f972dfd87b1edefd13feedaa1bf9c237a6b8776c5b80f9187949fe37cbe9b76e2007bf5f5c9b336d8864fb0bf33c3fede6cc4f1dad993ceb79e0c893f46699900008a6c787a2b7ffce2f9f47500b00dffc43e7e11ae528b9614b95eefa39d3818d297f4f37ce7b09ee4c4014bffe1c9f3b6267ff3bb7dd497c0b05451c4d913c4f993a30d52ddb64e9c309cba9dd6a75e757c38df367c82e393c56c9b0e0020ffb258f9f397181728af5ae81afa887674afa5ef2bc9f3b6267dbdc1fece4c6fa7733e11e77e1a7475c66751ff6e02d0825ce7a07bb5c3bbf95bba254d5bcddfd6032895572e90164f8f7d63a545d341960000192f0242c866075e401c0f0c0b0c8b6c496c537f2c072d29748de84df32e469c2332f59b617d8aa3c852f0b06343ce1cf526785215ef3d59f3bd67fc309c9691fce5daa42f5601cf538f4b9c13f39c8478be18e37e771029c8b1bf393569ee9fc973feb00c1a8d1886ba9cee4f46c8bfff14ada9b8608ae7f3b7a9c7c9b5bed93a681477f33dc0724088bc62aee7f3b7a2f6a8c8ce971f94167c0eb2c8346c9e347d4dcaf243495fac62ea37a5ae1269f604d7eb7dc3e7978168fbb7bbc7bd489d4596decf3bc67f671b36c1317e11d7b12b00281b574abf2c8ed0e7d6750060dca840a82c3b5f7e509c37994a1ea65e93a469ab53961f4a9afe0bd3a019753bc5d99fb85eeb137b3cff364cb11a84e1b284137759a231b39eaafbb6493fcc461c6f7f6b9ad0b917b239b87677257fbe4237a1c88bbff44e4b43ce999bed7af5319065b6757bcb13238cff5b7a0e611ab7020079d9d7da913d917bdcbcc635b21f28b2d06fa8f5b977f56515a67a1dc7673f209b030094f5cb696e76601369d92cd7cb0f7a667f0200cacaf940087fcfa35cfb7b985a0ded1f7c0b98a10539eaae8d00202d9c423d2eb6553beb53af591e7c1ad76e0800e2822991ef8cabc4f9ca43b420172c36fb3b33ac03de4276070070edee744c5bcdd46b0a00cacff3e495f3c3db6a47f6badee80f8accd46fe6f86c99e393ef85879f151e78da3e6262d2ccdf841e4f020050e2f9f48d44b370b8270ca72e274ecfb40d9b60fc135fd592edd40d00c8d913ea861581c7a3b40cef96e80600ede461cfc74329c2f677bfe63a74611bb5b43ce39da6c8c182475afca5346d0cf082f5cda9c2034fe9ff645bb7b7bf3303580e0094b5df539f300bbaf683bbdcef3f4f358deff104dfadaf6f888cedb549b85a1d00707ff22ab9703ae2d5494b678a5347235eb08f9c223c34c0db69ab76f677bfd6170ee4358bfd29eb00f447020088ef367a667c403d2ea1f70b96973ec0d5eb5a5e789f6dd21a00c47993b5d347a2dd5500707cbec23e6e9e6dd457d637a7e2b40c00c0199593e66d4d59b0c3f1d55ac7e4e5499397277db51657f79b5ed59d1b75d305d3a855f80991d52edcd7df77e4efc46720291d5d27a314e94bbcce6269d638644b727c381fec49282955e8390400d403db69b484a3947abe7847fe710e4aade098b088bdfe36ef893bf714fa0ef50e298a5895572f92bffb0271bcfdf549b6d133f87b1eb5bd3a3169ca4fb86255005036ad8af6e67abe194f4e1c0400a1477fc7f8c5b85a6d00c035ea393efe4e78e06900d00eef767f18c5960b404e1e728eec079acadff1a061780084accfbd8b6b5f0500d2571f68678e86b63a7f0a00c0f71804227dfba9766c3f0008ddfb3a262ec5d5eb0200ae56c7fed142e1e16701403bbac7fdfef3d1c6f32fc414ab41d012afb64a6d7600a09a464b0ac9f9d3e4d87e75ef5675c70665eb3a75f31a75cb5a75eb3a65fb06f5af3fd4033bb463fbc8b99360e4fd0ab708491e71ca28d054be7bdf40fb30aa5c83efd00500a8c7a59d39163e1e69c997b4280f3992ad43c604b91b70bca5d710c098ca9238731c68a14e52e4d279f7e76f83c7c55dd749e8de2f5081c695aa33f59a0000504a8a83ea40d1c23c208416e601a5cacedf112f080f0dd0db32b51a30751b01a5f24fdf92dc6ce5972500c0dd7a9f7eb1b8627500d08eeed575d910942d6b49d6710010ee7e846dd92e6830a919f67767e1ccaa54553c93df0e7fdba59fe6ea5f7feb90314c9d46c16d2b080f3d83532a0000c9bf049e04f2ae29eb96a93b3600cb595f19ef5543010000616ced370c39928110cfd4d1c6f30000283543ef9d7a3c0020ff389b4a1e4bff614c7d6fc01f7bf50d4c9d460088bafde24addb74d9a33914a22dfb927d7a663e018987a4dbcca992c469cec4bf327832ca1b40cfd63ea1f8960e1ef7800004074cb2b42d71400403bb8539afd099544feae47d86b3b05755ab7b177314c9121702262b57befada2000039735459bf1c675416ee7d4c8f1c4318739dba0320e07870c6ca7a8dac76a6496bae6d07b6c5f55ec18619c4702058704615a666035cb34188ef8276d86b67666ad68f784efeee47f4f560aa69d1a4518491f00200802f75a2f2ebf7243f87bbb623caa8e23ded0db70142a0c8ba1d251c79e50279f96cd054cbe32f32b58316440d533f89584ccded14e74ca48accddfe007bfdedc6738babd5b18f9b871c29a0c89ecfdf0ad70eb5b327e4e5b301806ddccad2e795a08f09c70bbd86e8931b65d34a258a3897164e0549c429e996c75f0ab91bc2bd8f0300953cd2e22f037751d1439dc50080f850f33e397f4a5e360b00d8462d85be4303c78338def2c820b6595b005036af5182a7a1ff664c97a5002835a482346fb276648f76746f198c1b28cc01475efbbd76f21000f0773e1cb28b6dd3415a3e1b00c8f9334c83e681bb48ee0569e92c00e03bf7d267b881302dae67ea36d14e1df605dd0774aac8aed71ea7b9d92829d5faf247e1ee7fd467af467cf0128bfef2131564891cdd8732ab04061ae1aab5b563fbd5dd5bb4edbfe9aa39dbe23aef2efd4b4d29cdbb18bacaa22ae294b78152644fb6f41f1e6e2147c9697cb73ee297ef01d1a4efa6d95efe3070af76fca07e0c13295c1dd91c60b140913ef2783d59a8248ab33e06005ca516d3f49af0f108ddfb89f33f078ea76ea7b11ca0afc601a5a088a0a9f2fa1f714a3ad7a99bbfa160717cf603b88ac1d784ba9deeb79fa2920757ab637d3acce44e29d213fb6136fc37d2b28e2bdbd6038075c09b38cc814eb8f73179c55c929f434557c82eea76badee84f3d2e5cb5b665c0c848d74f417f4a033a451c8f2c36ea71e96b66e2b4b1a0a95ce79e81eb7f7ce79edc2d5d916089d7231761efbbc0b0b1b3e269a7bdd3a9a80e5f0ccb36bf56d9f8330090ace3e0d31a4b81f38a55a004344dfc7a0200b0d7f9e71928391df1162a79b47ddbe08e07435ad3a27c71da1800c4366ec5dff548d8d9bd6b1611bd96a49fe6d1dc0b28b58275f0e8905db86235aedd9df2aa85dac9c3daf9d321330971fa589025c0d8d27f048479fb23c1627beb8b923eeda9e8f64c7c8d6d715d88f719b9705afeed4700107abfe0b7aff8e03b7593bf9baae56643b0698716e579b7c256cdc5191f50490484843eaf447090e405dba8e925bddb518fcb336138d3fc3a1cd6e9bf1053acfaa11e97b1bc272f9d59f613857d41e4753f0000dba603ae5a2bf4d8ea75bdbd87cd79e59fbd4651eea6bbc23b411cef18ff1dc9bb882a540a79fd946deb49f61900e06eee1cc1958068e4cc510040b6245ca95a8491132aaf5d425585a9543d30db144eaf08004089fce72f00c03468867db37ed0d582c052183ed49d1bf5c4b0dc75b74473cce1ef78505af0392d295237aea44f0c47a9016fa65ef940f280a646080f6039cb80b7b4833bd9e6d742dccbe124eb1829c80100a1c7138813c20f101e1ec8dd7a1f4ead10e8d981380e312c25329565e9fb19e071e2fad7e1a46037488c0387212d9aa6e72e177af40fef8516e5135d45a85031d4778c52e9cbb10080522ab02dae8f700d169b63ea2a28ce476172485af215f5380180efde2f42a72585ba83154aaf88822d7e282d4317abb4285f3d7e002c36a16b9f90e689a549c1987a9fa85242ce487e8eeffc517de898ba8dbc623578e522067a9a6e4a2950aa1ddf4f3d4ec098b9e6e6809332205840f24438a7a6b93f1e4a251171bce5a9d7228cf9e461ef39c2346cea2c16bffd1400d85637451c98f0c053f2aa85a0c8eaf6df829a8b6e72ea3000208b0d550bfd56782fca9ecc34bf4eddb68e7a5cdafeedec8d7706ee95e67e060048b0b06dda47ead8629fba120a73a142a5a001fb2c6d4662732fb2e49dd7f202ae512ff2782c76b6e58dca9fbf802c697bb7e098be87ff124cb11a8061c5e505b6610b945e0957ad85abd4c015aba3d4749494866d76e078c00c108d6a1ac812c822759550573129cc93667ea8651d07088daea345f9e4c81e00b0f8d6d582f0153824c579217bd49d1b0180a95c83a9db24f280590e077bab02009565f1ebf14008b2392c8f0e09d70ea5f953f40fabd07350881fa9375114a5ba4d8cbdfa86c0e6c6e4573b791800b85b021435a3cc4058890265d7267d83691a35dd287224f3f7f496e64fa69247fa71aea5b77f9d86a95895641d03495436afe1da45985e70d775e2aeeb14feff18c8ab1781aae0e434dee7d51c0ac384df586058fd97a5ee1279d57700c0777d3c861246458fb2660900a0e434ae7d97f003a445d340910121e181a743ce438a0bd4237b0180addf345a0003b258c1522df4bf92a8ac5ea477ca77bc3742a70ba75245028484879e09e914a76592f3a7a9a6aa270fd1e27cb6757b1469a52d7e10c6c6130584c45258dd5e2b1165f96836079ce99bc3455a68883c008e07af0986aa47f60000dbac2d0e9c7e61469f92864f07496eb6ba7f3b00a0aab5bc8b2681502aaff91e000063ae7de7909deaa15d7a7671c39c137a2d556b012000aaacfb41e8f14460a724ef2200e06a75706a14b50f63e1dec7d46deb805269c5b741625596d4833b0180a9591f570c7b360040378c87eff2b96d5314f4ed22799768ee05ef78a2050122c477eea5fcf90ba5545e393fb64bffbf0453acfa315e2db67643fbb8084b567e1816312cf00240324aaf08000c80bcc8e7a812fcf99097cda28a8c6c49b87ed3089d1acb5472b0b55951b4e3070080bfb777426525b4dd7f90ac6300c0dd7847e0aaa10eb9705afcee0b00c0956b0af7f40a1d8caef56aaade7548a088f17da7b91700212ed010e7cbd7181ef446ce9ed0377477896870377796174da3aaa2eed8008f3e678873b6dd9dca8e0d00e0fee005ebe077b84edd2f370f86a6c9bf2c0600a6591b48a86833cbe9ea32b9789616e6a2e454aedd9d310e57562fd47520cb4303c26d06eab6dff461b0d7dc14e13cf939fab22e77e783098569cabf2c22b9170040b8ffc9f0f80d75e7eff2aa8500c0b66ac7dd1c2a0cb0cfd55959b51028e55a2516601601cc78efb09e733fc663ec5b6244347afd389f618046f2568d4cc04a2139ba1700d86b827438841062180a10bed6232f9b05faa2fee32f85473149cb67abbbff0000be73af70372b726c9f7e76b67964b10a2ea76e43d68eefa7a2dbb055a8bbfed0030ad898c2896dd31ea565d0825c75f79f54910c8b0b7595904be70080ebfa78428f0df5550741c1493bb45d1ba9a60100db21c2bcd03f9ed637a3b44c5a90a3eed912389e7f2da6cb921fbf37661c21de119a1b6f7ba0ad52d3e475cb0000a76742a4a74d7f0df41304fe5ffeed075015c098bb31d6b73b1ce5cf35fa4688af0a009073a7dc6f3d05b288d32bdade980c6141abc898b9ab2ae205a66ee3a0bd01ba0b4e4a0d1415548b74ed7aa717cf7af744316a794f989c4a050b00d0e2422afb0bd6f2b7dec7dfd71f100255153f7ddd39b8ab67ca28edf06e7f385382a847f7ea4ed786ab519c2096d38504c93a41dd4edd81397a378ab4720100208b8d0d939adae1dd9e89af020053adb675f098f0d6f2a695400862b9102fa752d0545d8d46166bb866af1dd9e39e30020070d55ad6e7de0d6f8d2a54040070bbd42d6b010027787f2280b1be8840350d62fac9fb137f46f287f71e62f1be950994c110aca0a750a4a03b37b08d5b06eea708792d10216ee41e97ee978e33aab0d7dd1a7256f5cf35d2d71f0300dbe41a4bdf57c2bbd5fd6651522aaa5c23e2b8489edfe64c2f1a5f005077ffa96f706d3bc4be32af1f0621e4b4dfd5515eb70c340d312c1fc9ae130bdfdb1412e2a6fce5353571611f93d0f15cd5c23b9e53b1bcc4ff2598daaa1fbf580d73878b0bc31d374063a345f9b4a80000203523a29aa51df3e5160896e5eaf6df414f4d9c60a88f7662bfbe11b81642dd4e75f76671fa1872f11cd3b08575c8981091a9a37b4e52d10d9a82abd60ef5980814c34929414e83be6b0fd756bda1c0821525c5ccc662b5215ea0ae12aac8418ecd1c6fed3f0c6756557efa563b7b829e392a9f392aff3807a76532ad6fe65ab5631a34c7556bc73f37d77d922160553b5e380eb12c0550fe58059432916c0f06b4a488e6e700004a4a099c8ed0a23ce5cf35e2f4b15412d96b6fb1bdf03e4a0d4d780400da9ecd00802a55074b02333cea2cf67eaf6d4941939ee27ce5cf359ee96341f4706d3a5a5ffa2062a7a8426500504f1ea4a207316cc4272451507a2500004da5b21c2b21914f1da4c58551d34ef99ec6f84dd3d8660700048088a69d3d091c1f6251f797d609d680d55387f57416b85603a0c4503f48ce0565cd6271ce446058fece87ac8347474c07a89d3d0100cc552d5014055d3de80fb32605b9b85603eff6d9130080588ea91e7921d37f693e2f0d1ae0ccaf6cff0d005046a5f019736cfc3e8cc1651e726d3b0000164f494441544248d60900008665a22cac1a30d5eaaab0160048519e9961d214ab01f81618c2bdcce3c1d0d810e39746a4285fd762d9da0d237efac971af140cf9e8a8fbb60000b225256af324e74ee91bce67efc695abe3ea75a1a4483dba0f888638c1f2f84b46cc4c38fa855359024d0b0c2bf4edf56bdb38a54290d3a0cf278586f988eafa07cea8548ae46379ef078ea8a1f1420c2b74ef2b74efab1ddb2f2d9caa6e5f0f8a4cf22f915f162bbf2c0600ae5337db8b1fc499efd41b9f078033439dab4b81e5f4abd30533ae113914c4db8bab5877032139178a1f6e836bd4c315abd1821cede461049472826df827dccd77476bae1eda0500d196c7a241dd4e6fb2c0fc4bc53dafc5d5eba24ad5a120473b79182801de621b3a9eeb10d5ba88322a01002dc805005cab01b247cd01143f5857d75415d4981ef5f61480730040722e449bee20df3386e2bf2d3e01ac9d3d09a21bd91c600d12c914906e9a0e312c1b2f91ba634351b7264c9d4628b502bd784e3b7b1210a0a454c798af71fd281e0f00342f1b00986a51e76dea9e2dfe3fdcfea5626ff2548badd4751f23b09e7afc11cfdabead0080d22ac66e1b8e3f7147b073993e1e642d7d3cfe15074f8408ec7f1ba658f5e33704f17125da0d25a2b6ea2ed1cd5fb84ee42ca0467a2014a897a88a1e3e88acd684165669619efe61c58e14b03b68de25ada80055a8c8dfd6836ddb916dd23adce73e087d0cb20444c355426db6818143a19763bc9661da2a52150a103b4b2280bf8a00302c30912f99a9dfd4f6da67e0716917ce68c7f6296b96a8fbb60180f2ebb292a3fbecefcdf6fa2ac7c4082a45c98925d2421c8f58ce98cce3605fcad05ef22fe90a104ecba008930b6768fe25945145e8fa38dba63dd3b8558ce473547483aa02004e4d2c3135c9cfd1d708516a05c4b0243b0b15e4e08c2ac2bd8fb16dda338daf899d618ec9f48babd80be1f1e3557955858a9e18b32a26a31239710000c8d9931029f52304bc9ed1625bc3d1c3c328a5e4c86e0000960bf164f66babc14e5524e7bcbe812b56a592a89d3c8c1cc9b86235e1e167b9d637e18657074e31432144777df71ad5235d88a62fbeea7f06c45b535dc4c6b1e46fe486347e532a89dec7267a4ec4a844c967eecd9211c784d5b0de97cb6cecff1d53acfaf1971f8ff1cec4c0583d0a7c2b8af2f527353cb40600e45f9792429f0370a05b84a682b7a25629017f21e8712300c0b6ed601d3a3efe865ef48f8e9eed335c270810992121b6c68b87c2df405e008faa7f68622189ba1c425647292e0f563b53b73153b7317fc783dabeade23713d4fddb49d671f7d8c18e0fbe2dfd13602cdc26ea58c1b0c8910290a5ff155bac1a11235ce75e96479f4bac23a98c23a4be5f5fb8fb11e1b11713eb1400a56700c6fae486a9dd30d1e611d1d732a92c19211c11c1d5ea00ac0300edc48168c7107d35816199abae8eb3773de618f9b47f2458c11624562980770e4708682a60df3be87336b6f41f16d18b3b163e67f868534992974d2e9d438e143da75b60f264e448a6f93911330886400dc16f4c7f15432b48fcf3e59b3187a48a438e146382181bc34744cf09f52fc774590ac0f748c59a8ac6c0789d028dc03e475f14e62e4f65499cfe2e80ef3508acb081193db901d5541adb37871065d32af18bd1dec03bdfcc802a717b4b0680039d92c2fce96980800ff5f73184599827a7ae1f904be7623b1991c23c3d29205bb771ecf4f141dd36bbd63e6e1edba82500680776125f56815818b2aab4441fdad1bde217a3d5809c3e28606e8452622e151baead611147a5630401979a8a44d3e49fe78b5f7fe4750bf0755ab65f1f58ce58fe88e66b9328a8520d945a014829a9918c755c23dd523834ff2200b02d6f8cbf16b2fe1b5142d4c37b0000d7ac173aedc3d8fbb6122de86e1bd2454bdc338ee7f50968b46c9ae28c71204bec35de90562af91df4f4b91a7539c3f3a685a01ed80100b8724d7fe839eb7b6b4a7d6c0851d62c11bf1ceb2f11616802c12fa9773c6e57a9e3d1f66d03005cb94684c8b47f1fa6580dc0670089b3da5a28248211d89f8a252cce9d1cfe8b9614e3cc2ab641a301825e06c4f17a941e7516a3982e94ee0923dc63074bcbbed1e7aac8f78ec5f83cf947a62af24ff3e4f5cba9e1701460240c17ab08b3c61653bd76d02e9f053bfc53e2adb0463472e14c8cc128ab1752450184f988d1bd3131c218485168ec6f38d8679a0bf0c18e80bc7cb6eb9587a565df40809ac50656108ba94a32beac58aa6fed3c06b4a4505af295ea0bf045169b6eab27d959b19ab99daed71ef34c1a29aff95eff1ae28adec8ce401b633488b348fa7e8612501d01718221d171f91524d193ede9813dd1609a78735d69678e05baf304a21dde030809dd423354c400a765022050153d54866d165ae60831acf7d15594c0e497866753ec87d67bccf953d2775f68013fb42e8d48a4ccc9e4d411f58fd580903fd546802ec8b56e0f004089bafdb7183d2a1b7f2639d90048e8ded73f668b1555a804005aec7419aae21ef5b47bc27069c53cbf6e6a88e460b1cab5ede81dcfb675b1c6b36915b9740100f15d7ac7eafa5f832956fdf8d7edcb1619e97f46fdcd8d95861023189544cf8c714034a1e7605ca32e604c0a72030fd0ebafd1fc4b11730503001022cd9facfcfa3d2024f41aa2db82704a055d1e939c0be17554825a5f38ed7cfa4ecfa491caca057e3d39a07e080e2bc909be9c0f28252dc459da48b20a014974bde7311491833ba30d463b7e40fa710e00e5aeeb14e8804a0b72d59d1bb5237b4ad1740d93401ceb3acc55de100b75d71fd18e51b7aef34c1d4d1599bbeed6c01cceb88e7fc531769807aa584dff5e9393870c9d2022dafeed254fde267ef99e5ec300000021fee6ce00a01ddb4f2e9d8f324445fcea7d75df36c4b096decfebceb128b39ab726d2a9c3d457393872ebfd3b9c4fde264e1fabeddce8ff2f2f18177599892002d1330d6947f6a8d1ab0ce12ab5f4b23c4088387d6cb89a4e45b7ba770b72a4241616c572e0f0cf0f2216ec636a5f0500541649b1ffd1c535bdaeb946c44b64285536ac2819d24d9cf5110d10c0facab4b26b53787a2969e90ca094bff3216c24e30c9837b3edeed2edb1d20f5f472be84465495a300580229b9dbde1f6c05dfc6d3d0080641d8f3a21d35471c63865fb6f083396beaf60c321dcf026091e307bf3ddba7e2f7d3f339ad98caa8ab4700a0045166bec48ee7f0fa6580dc067e42c5bc2016af8a60768ab382d53b7ee6a7bb7061e2c2f9eae1dde8d6b35e0ef7810d993816149b0f8147a3c811c294034d7a867221a03b5833bc5b99f01a56cf36b2dbd061bff677cb9eea4b99f469346d459e41ade9b649f0186b50e79c75859090a3f08cb436bf82aeb911881b00d5be8566bed62a80a68a41d907f591cf94ba169e2e4b740550163cb632ff8ffafc8ce177ab8dee8eb7ca18767eaa8a8a62da279a7f6828589e2171634d49637e80ab4fce3ecc80b7e92c7f3e96b402972245b5e181bb807d7f1897c84622fe2a20a9550852a0040f22e4a8ba645fd4416e4b8460fa0ce22e0f8c05c837cd73e881740913c1fbd4c23d9dfa49fe74b3fcf074af97b1f33aa96e2d40a4ca5ea00400bf3e4ef6275ea1efd0c2d29048e0f4cf18338de1be585905f7db96cb81b6ed3df2c69de64ff032989caaa85813a9975d068dd00a01ddd1bae6d4bcbbea68579c2dd8f440c0d8a8191ab0859ac110bb5b2ad6f06005015ed807fdac75e7dbd3e3956f76e31728886434e1d768f1f06a21ba757645afb134db02ddb0100cdb9a01dd91b78bcbc7eb9bc7a11d81c42afc186393ad0091957afabfb4e6b077644168d944a5f7fac1d3f00085907bce9cf3c050000c2034f238b0d54c5f5f653110385e5df7f9696ce044ad95bba06eafd7e6f8660b1ca54abad3b85688776d188b5922895bf19af1ddd0708599f7dd3b400eb986235009f38a4f1856a8460ac4f04aedfa0b40ade3a5cab161a82415efbbdb4f84b54a1b2e3ddaf016394920e1cafeeda14a2d6f0ddfa00002dc8f18c1f06010b300020af5de21af534682ad7a18b6de4d4c07489969e83f5f220ca9f6b5c23fb85be9c8a2cfd38c739a41bc9bd0098b1bdee2d31e61d2d6fd15552949a1e9efdd5d06070980f2dd3b0b93e4357f76e0ed9c53669ada72957f76ef14c7f37c427826467395f7e503db40b048bedcd2f821c8c19d6481a27ff38b764606771fee72182503bb2a7e4b9eee4d2396058dbb009712eca5a5ffc00f102753b9daf3c4c72822c66dad1bd2503bb90fc1c5cb5b663d2f210951d57aee1ed82d288a5dc0c10c7db868dd7ef98f4dd34cfc74343723e5367b134f7d3920177d392429492ee18bf28d08d1957aaa66721d00eee92667d08016ba55455a40553a4991f228c85870658fa041408e378db2b1fea5125e2e22f3d1fbfe27788333a9d37a9e4d9ceb4a41025a7393e5e88027da739de9bd39f52a342e2e583d22bda06bf0308a9dbd6bb863d22ce9be4fef0e592273ab927beeefec89f4b016756e16fed0e00a0a9ee3103036d2de4cc3179c9576ce36b84de09571f3372f71b0a6808cc3537eba25a5af485df9dd591627f7d92fe5b7ba68c12bf7a2fa43413c9bfe4f9fc6de74b0f802c31f59ada272c0e7c5fbcb65300bd8a868eb271a538e94d24581c23a7e08c2a7e2f8480b92f122c969e0341b7664d181efacc48a2e7b337f4daccfcbd8f71b7f508b9166473e8455549d671cfd4d141335142a4a5b3c449230140e8fab86dd0a8a08686e905054b0496171e1908005491dd9f8c08799c40163d93df14174d0700fe9e5edced0f80090000201a654afb2f44f963b57bcc4000b03cf6a2d07350a2cd4bfa75d4330aa5ac38eaf73f5215e70b3db413070121b64d07eefadbb4833be55f97a29474fbb009ccd537e847b95eedadeedecc5e73b3f0c053b4b800a565b2cdaf0545f67cfabafceb52a0146756e13b7547152ad1a27c65e746edd02ee005fe8e07acfd4784179dd08eec718f1decb51f22cc366fabcb4e9273413bbc9b96140266d8a66dac8346e1b05885e287dbd09242ee9a9b6c636685eca28a5c7c5f3320846f7f8f75c4c490bdea8e0daeb79f462c6b1b338b6dda0600c0e3a294229b839614bade7956dbbf1d00b8d6edd90e5d504a3a785ceade2dca9aefa9e8c699552dfd8771e109d23455fcea7df9b71fa96121c70cdbe86a945915344dcb3aae2f5fa1a414fefea72cf73f152d957f2884488ba689f32683e4018b4db8a51baedd908a1ef5c00e75db3a2094bdae93eda50f2296b22f79ea7672ee240024cfdf162d5baf81f2db7271ca686f30226fe15ade8032ab80aa92ecb3eae1bf4074239663afbdc53af06d14161a4425d1fdce003d2f34aedd90bbe96e9c924e2e9d57b6ad27a70ea3a454bec71396079f0e2f26a36c58e1f9fc6daf119813bc9d6a1ac9ced28eeca11e176239b66d47ebc0b7519833b3387dacfed5b68d9cc2051b182f0b45767ffababafe07bfe68d1053fb2aa1f7f341bd68aa6bd433ba0a8b522b08ddfbe36ab5c999a3e277d3704665fbeb9370ad84fd933d9fbe2eaf5c00007c97ded6816f473c469cf9a1f4dd17002074ef677962b86e87a084c80ba7488ba6eb33399494cab6b81ea55600c943ce9f568fec015541162bd7fe1ecb93af867b5189733f95e64d0200fef607983a8dd4bffe5036af4116abf5a9d7b8bb7b0200153dc53d9a0380f0f0404b9fa00a6ee28c71d2e2e9402953bd0edfb50faa541d1499641d977e9e472f9d479cc0dfd7cff2f88b11eb085159f4bcff82b2790d00e06a75b80e5d706a05927751ddbe413bbe1fd993f82ebd855e4342dc47a8b3a8f8a1d6809075c4443e2caba5f8f5c7d2c2a9402953b516d7ad2f53b906a8b276e6b8bc7201b97816713cdfadafa5efcbf1d635fa17608a553fea8e0dae91fd0121ebc0b7f97b1e4db4b9736067edd411609894e58703ff4f8b0b8afb750423973742d8e6b08d5f1498b88414e4963c79abf7188cf9eefdac4fbeaaef92d72c11a78e06d1adaf6d208400635cbb91edd54f2306edf87aa5eef75f5036ad044afcc6408c11c2b86e23cb8037d9c6a105d1744afa752497ce591e7b417824c2c4a2e4c95bc9c573b6e19f4428aa43a9e78b31f28fb311424cc316243f878a6ec78445b8724d7dbff4dd34f19bf18812ff220d4288e5d8f65daccfbe196b314f53950d3f89f33fa7e74f51a2f93dcb30a698e15ab7b73e3f3651db20006887fe728d7e861617f8d5058c5152aa6df844b6e50dd15ab9df7a52d9b61ea5a4277fbb259ed44eb4b8c0f5d693dab17d88101af04300c26ccb1b6d43c6a0b0927f018da9b8e07379fee75491bd578d1020cc5d7dbdf5e58f50b4d4e700d459e47eeb29f5c8ee089d5e7dbd75f0185c39b2b14ed9b4d2fdee606058c7a74be3b1a82784ba6ba338631cc93ecb34b9c6f2f0b34c93d6110ed234cf9451f2aa857e1b26c3b02d6fb4bd3eb9f4d0e748488bbf14bf7a1f3076bc3787691eeab2e445969c2fddaf9d3a0208591e7d2ef0c9d74e1e728f1e4072ce43c043ebfd153a74b10e7c3bea734b8867c27079dd326f438c9123c5f1d1027fc5aac2dce25ed70380a5cfcb7a31f040d483bbdcef0ca0c505484fbda8f78b315bb789f5cd29386c1526084aa565b3a46fc6534984c0b68dafb10e1d1f6237f65da75af24427a67623eb6b9f458c83500fef768f1e408bf242c753a7b1f5ada9a58ce7df872956fd50778976701724a7b1759bc4abf704e07aed71ede4214bcfc17cd7c743766959c7d5cd6b694911caacccd66b82eb36416149e9487696ae06a1f48a4cedab82e26d9cc5e4c2695a5204aa02162bcea8822b578f676e4872b34976961eb8021c8f1cc938ad628ccf3100a87bb7228ec30d5a84a721d4470208c5c82aa09d3eaa27e247291570d55a219664ea2a21174e83ab844822c21825a5a28ad5e22dd048292dc82579d9b4a4902a0ae27894948a33ab9441a0fa5164eddc495a940f92081c8fd232996ab562bbf86a678e928be7d9fa4d4b49ac113c72929d4572ce53d18330033c8f92d3707ac552955d1d529847b3b388ab18340dd91cb862359c59a574894ea9969d457d9d229e47c969a8b44ea9c7a51dd801f664b641f332bc02e503a5e4d239929d059208821557aa862f23da87e45fd28eedc719954bc9c54834eddc29c4b2e1595040d3b4f3a768de252a7910cb026fc1a9e9a842a518093dfc1772f604c9b94029c1a915989a0d02172948d6b19267ee0200eba0511127f15496e8c5b3a420076489528aac769c511957ac1667203b2d2e20d959d45944551559ed38b34afc6d23a3c8243b8b16e67aa5b5d5ce6454469779ce7f28a65835313131f96fa3eedce87aa32f00d8477fe5f58236f9a7604e344c4c4c4cfedb109f63ed7fdabb7f962aa33880e3e778afdde4624849b455d0a090824208bd0357a7c606975e42d466535b8d2d42442fa0a917a0abad8a9885112a198166977cfeb444441962fc321ef97ce6333cdb77787ebf738e780a89069255809376b0b490526a8d4e1ee36f020d21ab0027aadad92a5e2da69c7fde1be6d4905580385595cae2d04b3c7e1cf8f2f85eeaede7c1a1f6c4cd3f1ea3b1bc600310a3feb4b377ff76bdfd3e0f5d688f4f7566667fd982ab3feff69e3c289616f2d981eedcfcd1e3c434904960802055d97bf6e8eb8ba7dfaf03eb3fd31e9b6a5fbfd1377ca92e0ecab7abc5e2cbeac3661ee87666ef76a66ffdefcfe59f90558048d5e6c6fedc9df2cdca6fd732e79453dff98bdd87cf0f5990e5b490558068755dbd7b5d6eac95ebcbf5c7ad549479f05cebca68be7cad7575e4ef1ef3a029641500c29804068030b20a0061641500c2c82a00849155000823ab0010465601208cac02401859058030b20a0061641500c2c82a00849155000823ab0010465601208cac02401859058030b20a0061be0183d51de4babddc4b0000000049454e44ae426082);

-- --------------------------------------------------------

--
-- Table structure for table `estados`
--

CREATE TABLE `estados` (
  `idPais` bigint(20) UNSIGNED NOT NULL,
  `idEstado` bigint(20) NOT NULL,
  `Descripcion` varchar(800) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `estados`
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
-- Table structure for table `gruposusuarios`
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
-- Dumping data for table `gruposusuarios`
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
-- Table structure for table `inventarioproductos`
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
-- Dumping data for table `inventarioproductos`
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
('Entrada', 4, 5, 2, 12, 'GELATINA PRONTO PIÃ‘A', '2.0000', '7.44', '14.88', 1, 0, 0, 0),
('Entrada', 4, 5, 2, 13, 'GELATINA PRONTO UVA', '2.0000', '7.44', '14.88', 2, 0, 0, 0),
('Entrada', 4, 5, 2, 14, 'GELATINA PRONTO LIMON', '2.0000', '7.44', '14.88', 3, 0, 0, 0),
('Entrada', 4, 5, 3, 13, 'GELATINA PRONTO UVA', '2.0000', '7.44', '14.88', 1, 0, 0, 0),
('Entrada', 4, 5, 3, 14, 'GELATINA PRONTO LIMON', '2.0000', '7.44', '14.88', 2, 0, 0, 0),
('Entrada', 4, 5, 3, 15, 'GELATINA PRONTO FRESA', '2.0000', '7.44', '14.88', 3, 0, 0, 0),
('Entrada', 4, 5, 3, 16, 'GELATINA PRONTO PIÃ‘A', '2.0000', '7.44', '14.88', 4, 0, 0, 0),
('Entrada', 4, 5, 3, 17, 'GELATINA JELLO FRAMBUESA SOBRE', '2.0000', '7.35', '14.70', 5, 0, 0, 0),
('Entrada', 4, 5, 3, 18, 'GELATINA JELLO NARANJA SOBRE', '2.0000', '7.35', '14.70', 6, 0, 0, 0),
('Entrada', 4, 5, 3, 19, 'GELATINA UVA SOBRE', '2.0000', '7.35', '14.70', 7, 0, 0, 0),
('Entrada', 4, 5, 3, 20, 'GELATINA PIÃ‘A SOBRE', '2.0000', '7.35', '14.70', 8, 0, 0, 0),
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
-- Stand-in structure for view `inventarios`
-- (See below for the actual view)
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
-- Table structure for table `metodopago`
--

CREATE TABLE `metodopago` (
  `Clave` varchar(5) NOT NULL,
  `Descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `movimientoinventario`
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
-- Dumping data for table `movimientoinventario`
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
-- Table structure for table `paises`
--

CREATE TABLE `paises` (
  `idPais` bigint(20) UNSIGNED NOT NULL,
  `Descripcion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `paises`
--

INSERT INTO `paises` (`idPais`, `Descripcion`) VALUES
(1, 'MEXICO'),
(2, 'Estados Unidos Americanos'),
(3, 'Afganistan');

-- --------------------------------------------------------

--
-- Table structure for table `puntosventa`
--

CREATE TABLE `puntosventa` (
  `idPuntoVenta` int(11) NOT NULL,
  `Descripcion` varchar(500) NOT NULL,
  `idBodega` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `puntosventa`
--

INSERT INTO `puntosventa` (`idPuntoVenta`, `Descripcion`, `idBodega`) VALUES
(1, 'CAMAJOA', '5');

-- --------------------------------------------------------

--
-- Table structure for table `reportes`
--

CREATE TABLE `reportes` (
  `idReporte` bigint(20) NOT NULL,
  `NombreReporte` varchar(150) NOT NULL,
  `Descripcion` varchar(150) NOT NULL,
  `Consulta` varchar(150) NOT NULL,
  `programa` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reportes`
--

INSERT INTO `reportes` (`idReporte`, `NombreReporte`, `Descripcion`, `Consulta`, `programa`) VALUES
(1, 'repInformeExistencias', 'INFORME DE EXISTENCIAS', 'call PAL_InformeExistencias', 'INV'),
(2, 'repInformeVentas', 'INFORME DE VENTAS', 'call PAL_VENTASTOTALES', 'VEN'),
(3, 'repInformeVentasFecha', 'INFORME DE VENTAS POR FECHA', 'SELECT * FROM VENTAS', 'VEN'),
(4, 'repInformeExistenciasFecha', 'REPORTE DE COMPRAS POR FECHA', '?', 'INV'),
(5, 'repEstadoCuenta', 'Estado de cuenta', '?', 'CAR');

-- --------------------------------------------------------

--
-- Table structure for table `reportescampos`
--

CREATE TABLE `reportescampos` (
  `idReporte` int(11) NOT NULL,
  `nombreCampo` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reportescampos`
--

INSERT INTO `reportescampos` (`idReporte`, `nombreCampo`) VALUES
(3, 'rFechas'),
(4, 'rFechas');

-- --------------------------------------------------------

--
-- Table structure for table `tiposflujos`
--

CREATE TABLE `tiposflujos` (
  `idTipoFlujo` bigint(20) NOT NULL,
  `Descripcion` varchar(200) NOT NULL,
  `EntradaSalida` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tiposflujos`
--

INSERT INTO `tiposflujos` (`idTipoFlujo`, `Descripcion`, `EntradaSalida`) VALUES
(3, 'SALIDA POR VENTA', 'Salida'),
(4, 'ENTRADA POR COMPRA', 'Entrada'),
(5, 'Entrada por devolucion', 'Entrada');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` bigint(20) UNSIGNED NOT NULL,
  `Usuario` varchar(300) NOT NULL,
  `Contra` varchar(300) NOT NULL,
  `Grupo` mediumint(9) NOT NULL,
  `Nombre` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `Usuario`, `Contra`, `Grupo`, `Nombre`) VALUES
(1, 'supervisor', '', 2, '');

-- --------------------------------------------------------

--
-- Table structure for table `ventas`
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
-- Dumping data for table `ventas`
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
-- Table structure for table `ventasproductos`
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
-- Dumping data for table `ventasproductos`
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
(1, 7, 12, 406, 'PAÃ‘AL CHICOLASTIC ETAPA (2)', '1.0000', '26.00', '0.00', '26.00'),
(1, 7, 13, 406, 'PAÃ‘AL CHICOLASTIC ETAPA (2)', '1.0000', '26.00', '0.00', '26.00'),
(1, 7, 14, 406, 'PAÃ‘AL CHICOLASTIC ETAPA (2)', '1.0000', '26.00', '0.00', '26.00'),
(1, 8, 15, 56, 'CHICOLASTIC ETAPA 4 (40)', '1.0000', '95.00', '0.00', '95.00'),
(1, 9, 16, 212, 'NESCAFE DOLCA 46 GR', '1.0000', '20.00', '0.00', '20.00'),
(1, 11, 17, 161, 'MAYONESA McCORNIC 190GR.', '1.0000', '14.00', '0.00', '14.00'),
(1, 12, 18, 47, 'SERVILETA CHICA VELVET', '1.0000', '8.50', '0.00', '8.50'),
(1, 13, 19, 280, 'GALLETA CRAKETS135GR', '1.0000', '10.00', '0.00', '10.00'),
(1, 14, 20, 296, 'NUTRILECHE 1L', '1.0000', '15.00', '0.00', '15.00'),
(1, 14, 21, 250, 'CEREAL NESQUIK 150 GR', '1.0000', '16.00', '0.00', '16.00');

-- --------------------------------------------------------

--
-- Structure for view `inventarios`
--
DROP TABLE IF EXISTS `inventarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inventarios`  AS  select `a`.`EntradaSalida` AS `EntradaSalida`,(select `x`.`Descripcion` from `tiposflujos` `x` where (`a`.`idTipoFlujo` = `x`.`idTipoFlujo`)) AS `TIPOS_FLUJOS`,(select `x`.`Descripcion` from `bodegas` `x` where (`a`.`idBodega` = `x`.`idBodega`)) AS `Bodega`,(select `x`.`Nombres` from `clientes` `x` where (`b`.`idCliente` = `x`.`idCliente`)) AS `Cliente`,`a`.`Producto` AS `Producto`,`a`.`Descripcion` AS `Descripcion`,`a`.`Cantidad` AS `Cantidad`,`a`.`Precio` AS `Precio`,`a`.`ImporteTotal` AS `ImporteTotal`,`a`.`Registro` AS `Registro`,`a`.`idTipoFlujo` AS `idTipoFlujo`,`a`.`idBodega` AS `idBodega`,`a`.`idFolio` AS `idFolio` from (`inventarioproductos` `a` join `movimientoinventario` `b`) where ((`a`.`EntradaSalida` = `b`.`EntradaSalida`) and (`a`.`idTipoFlujo` = `b`.`idTipoFlujo`) and (`a`.`idFolio` = `b`.`idFolio`) and (`a`.`idBodega` = `b`.`idBodega`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`idArticulo`),
  ADD UNIQUE KEY `codigoBarras` (`codigoBarras`);

--
-- Indexes for table `bodegas`
--
ALTER TABLE `bodegas`
  ADD PRIMARY KEY (`idBodega`);

--
-- Indexes for table `cartera`
--
ALTER TABLE `cartera`
  ADD PRIMARY KEY (`idCartera`);

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD UNIQUE KEY `idCliente` (`idCliente`);

--
-- Indexes for table `estados`
--
ALTER TABLE `estados`
  ADD UNIQUE KEY `Estado` (`idEstado`);

--
-- Indexes for table `gruposusuarios`
--
ALTER TABLE `gruposusuarios`
  ADD PRIMARY KEY (`IdGrupoUsuario`);

--
-- Indexes for table `inventarioproductos`
--
ALTER TABLE `inventarioproductos`
  ADD PRIMARY KEY (`EntradaSalida`,`idTipoFlujo`,`idBodega`,`idFolio`,`Registro`);

--
-- Indexes for table `movimientoinventario`
--
ALTER TABLE `movimientoinventario`
  ADD PRIMARY KEY (`EntradaSalida`,`idTipoFlujo`,`idBodega`,`idFolio`),
  ADD KEY `EntradaSalida` (`EntradaSalida`,`idTipoFlujo`,`idBodega`);

--
-- Indexes for table `paises`
--
ALTER TABLE `paises`
  ADD PRIMARY KEY (`idPais`);

--
-- Indexes for table `puntosventa`
--
ALTER TABLE `puntosventa`
  ADD UNIQUE KEY `idPuntoVenta` (`idPuntoVenta`),
  ADD KEY `idPuntoVenta_2` (`idPuntoVenta`),
  ADD KEY `idPuntoVenta_3` (`idPuntoVenta`);

--
-- Indexes for table `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`idReporte`);

--
-- Indexes for table `reportescampos`
--
ALTER TABLE `reportescampos`
  ADD PRIMARY KEY (`idReporte`);

--
-- Indexes for table `tiposflujos`
--
ALTER TABLE `tiposflujos`
  ADD PRIMARY KEY (`idTipoFlujo`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `Usuario` (`Usuario`);

--
-- Indexes for table `ventasproductos`
--
ALTER TABLE `ventasproductos`
  ADD PRIMARY KEY (`idPuntoVenta`,`idVenta`,`Registro`),
  ADD KEY `idVenta` (`idVenta`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articulos`
--
ALTER TABLE `articulos`
  MODIFY `idArticulo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=431;
--
-- AUTO_INCREMENT for table `bodegas`
--
ALTER TABLE `bodegas`
  MODIFY `idBodega` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `cartera`
--
ALTER TABLE `cartera`
  MODIFY `idCartera` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` bigint(20) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `estados`
--
ALTER TABLE `estados`
  MODIFY `idEstado` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `gruposusuarios`
--
ALTER TABLE `gruposusuarios`
  MODIFY `IdGrupoUsuario` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `paises`
--
ALTER TABLE `paises`
  MODIFY `idPais` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `puntosventa`
--
ALTER TABLE `puntosventa`
  MODIFY `idPuntoVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tiposflujos`
--
ALTER TABLE `tiposflujos`
  MODIFY `idTipoFlujo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
