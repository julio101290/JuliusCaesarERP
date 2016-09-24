-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-09-2016 a las 21:15:17
-- Versión del servidor: 10.1.13-MariaDB
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_ActualizaPuntoVenta` (IN `parIdPuntoVenta` INT, IN `parDescripcion` VARCHAR(500))  NO SQL
update PuntosVenta

set Descripcion=parDescripcion

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `PA_InsertaPuntoVenta` (IN `paPuntoVenta` VARCHAR(500))  NO SQL
insert into PuntosVenta(Descripcion)
values(paPuntoVenta)$$

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
SELECT idPuntoVenta
		,Descripcion
FROM	
	PuntosVenta
    WHERE
    idPuntoVenta =parPuntoVenta$$

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
(1, 'Limones', 'Producto', '5.00', '10.00', 6, 16, '1'),
(2, 'Manzanas', 'Producto', '10.00', '20.00', 12, 12, '7501314704552'),
(3, 'peras', 'Producto', '1.00', '2.00', 2, 1, '7501045401416s'),
(4, 'Platanos', 'Producto', '3.00', '4.00', 2, 3, '4'),
(5, 'Guayabas', 'Producto', '1.00', '2.00', 3, 4, '5'),
(6, 'Jicama', 'Producto', '2.00', '3.00', 43, 32, '6'),
(7, 'Limones', 'Producto', '10.00', '100.00', 0, 0, ''),
(8, 'Prueba', 'Producto', '100.00', '150.00', 0, 0, '750104540'),
(10, 'Atun', 'Producto', '100.00', '150.00', 0, 0, '7501045401416'),
(11, 'SOPA MARUCHAN CON CAMARON Y HABANERO', 'Producto', '6.24', '8.00', 1, 0, '11');

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
(4, 'Juan Jose Rios'),
(5, 'ABARROTES DIANA');

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
(00000000000000000034, 'Mariela', 'Salomon', 'Domicilio', 'jjr', '0000000', 'RFC', '1990-07-27', '', '', '', '');

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
('empresa', 'razon', 'rfc', 'telefono', 'd', 'c', '0001 MEXICO', '0001 CHIHUAHUA', 0x89504e470d0a1a0a0000000d4948445200000129000000a8080200000033608f1c000000017352474200aece1ce90000000467414d410000b18f0bfc6105000000097048597300000ec300000ec301c76fa864000001d149444154785eedd3310100000cc3a0f937ddc9c8031eb80105f7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d68b8070df7a0e11e34dc83867bd0700f1aee41c33d286c0fc2ad9163451545d20000000049454e44ae426082);

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
(2, 'PRUEBAS', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1),
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
  `Registro` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `inventarioproductos`
--

INSERT INTO `inventarioproductos` (`EntradaSalida`, `idTipoFlujo`, `idBodega`, `idFolio`, `Producto`, `Descripcion`, `Cantidad`, `Precio`, `ImporteTotal`, `Registro`) VALUES
('Entrada', 4, 2, 2, 3, 'peras', '1.0000', '1.00', '1.00', 1),
('Entrada', 4, 4, 1, 4, 'Platanos', '200.0000', '3.00', '2000.00', 1),
('Entrada', 4, 4, 1, 1, 'Limones', '5.0000', '5.00', '25.00', 3),
('Entrada', 4, 4, 2, 5, 'Guayabas', '12.0000', '1.00', '12.00', 1),
('Entrada', 4, 4, 3, 4, 'Platanos', '123.0000', '3.00', '369.00', 1),
('Entrada', 4, 4, 3, 4, 'Platanos', '31.0000', '3.00', '93.00', 2),
('Entrada', 4, 4, 3, 5, 'Guayabas', '54.0000', '1.00', '54.00', 3),
('Entrada', 4, 5, 1, 0, '', '1.0000', '0.00', '0.00', 1);

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
('Entrada', 4, 2, 2, '2016-07-10', 34, 'fACTURA', 'Observacion'),
('Entrada', 4, 3, 1, '2016-09-02', 35, 'F-1', 'Prueba'),
('Entrada', 4, 4, 1, '2016-08-04', 34, 'fa', ''),
('Entrada', 4, 4, 2, '2016-08-11', 1, '1', '1\n'),
('Entrada', 4, 4, 3, '2016-08-26', 35, 'f-1231', 'Observacion'),
('Entrada', 4, 5, 1, '2016-09-10', 17, 'fACTURA', 'Prueba');

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
  `Descripcion` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `puntosventa`
--

INSERT INTO `puntosventa` (`idPuntoVenta`, `Descripcion`) VALUES
(1, 'CAMAJOA'),
(2, 'Mochis'),
(3, 'Guasave'),
(5, 'Choix'),
(6, 'Mocorito');

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
(1, 'repInformeExistencias', 'INFORME DE EXISTENCIAS', 'call PAL_InformeExistencias'),
(2, 'repInformeVentas', 'INFORME DE VENTAS', 'call PAL_VENTASTOTALES');

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
(2, 1, 34, '2016-08-06 00:00:00', '', '', 'observaciones');

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
  MODIFY `idArticulo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT de la tabla `bodegas`
--
ALTER TABLE `bodegas`
  MODIFY `idBodega` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` bigint(20) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
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
  MODIFY `idPuntoVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
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
