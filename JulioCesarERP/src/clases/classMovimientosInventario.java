/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package clases;

import herramientas.conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author julio
 */
public class classMovimientosInventario {
    private conexion con;
    PreparedStatement ps;
    ResultSet res;
    private Sentencias_sql sql; 
    
    public String strTipoMovimiento;
    public long lngTipoFlujo;
    public String strFactura;
    public long lngBodega;
    public String strFecha;
    public long lngCliente;
    public long lngFolio;
    public String strObservacion;
    public String strExiste;
    
    public long   lngProducto;
    public String strDescripcionProducto;
    public double dblPrecio;
    public double dblCantidad;
    public double dblImporteTotal;
    public long   lngRegistro; 
    public long   lngPuntoVenta; 
    public long   lngVenta; 
    public long   lngRegistroVenta; 
    
    public java.util.Date Fecha = new java.util.Date();
    
    public classMovimientosInventario(){
        sql = new Sentencias_sql();
        con = new conexion();
    }
    
    public long lngUltimoFolio (String strTipoMovimiento,String strTipoFlujo,String strFolio){
        String strConsulta;
        String datos[]=new String [5];
        DecimalFormat formato = new DecimalFormat("0000");
        
        strConsulta="call PAL_UltimoFolioInventario ('"+strTipoMovimiento+ "'"
                 + ",'" + strTipoFlujo + "'"
                 + ",'" + strFolio + "'"
          
                 + ");";
             
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         while(res.next()){
              return  Long.valueOf(res.getString("siguiente"));              
         }
         res.close();
          }catch(SQLException e){
                System.out.println(e);
 
     
          }
        return 1;
    } 
    
    public boolean actualizarMovimientoInventarioVenta() throws SQLException     {                        
        String strConsulta="";          
        String strRespuesta="";                   
        strConsulta=strConsulta +"call PAC_ActualizaInventarioMaestro  ('"+
                this.strTipoMovimiento+"'"                  
                + ",'" + this.strFactura + "'"                  
                + ",'" + this.strFecha + "'"                  
                + "," + this.lngBodega + ""                  
                + "," + this.lngCliente + ""                  
                + "," + this.lngFolio + ""                  
                + "," + this.lngTipoFlujo + ""                  
                + ",'" + this.strObservacion + "'"                                   
                + ");";          
        
        ps= con.conectado().prepareStatement(strConsulta);          
        res = ps.executeQuery();          
        System.out.println(strConsulta);          
        return true;     
    }  
    
    public boolean ingresarMovimientoInventario() throws SQLException
    {               
         String strConsulta="";
         String strRespuesta="";
         
         strConsulta=strConsulta +"call PAR_INSERTAMOVIMIENTOINVENTARIO ('"+this.strTipoMovimiento+"'"
                 + ",'" + this.strFactura + "'"
                 + ",'" + this.strFecha + "'"
                 + "," + this.lngBodega + ""
                 + "," + this.lngCliente + ""
                 + "," + this.lngFolio + ""
                 + "," + this.lngTipoFlujo + ""
                 + ",'" + this.strObservacion + "'"
                 
                 + ");";
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery(); 
         System.out.println(strConsulta);
         return true;
    }
     public boolean ingresarMovimientoInventarioProducto() throws SQLException
    {               
         String strConsulta="";
         
         strConsulta=strConsulta +"call  PAR_InsertaMovimientoInventarioProducto  ('"+this.strTipoMovimiento+"'"
                 + "," + this.lngFolio + ""
                 + "," + this.lngTipoFlujo + ""
                 + "," + this.lngBodega + ""
                 
                 + "," + this.lngProducto + ""
                 + ",'" + this.strDescripcionProducto + "'"
                 + "," + this.dblPrecio + ""
                 + "," + this.dblCantidad + ""
                 + "," + this.dblImporteTotal + ""
                 + "," + this.lngRegistro + ""
                 
                 + "," + this.lngPuntoVenta + ""
                 + "," + this.lngVenta + ""
                 + "," + this.lngRegistroVenta + ""
//                
                 + ");";
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery(); 
         System.out.println(strConsulta);
         return true;
    }
     
         public boolean ingresarMovimientoInventarioProductoVenta() throws SQLException
    {               
         String strConsulta="";
         
         strConsulta=strConsulta +"call  PAR_InsertaMovimientoInventarioProducto  ('"+this.strTipoMovimiento+"'"
                 + "," + this.lngFolio + ""
                 + "," + this.lngTipoFlujo + ""
                 + "," + this.lngBodega + ""
                 
                 + "," + this.lngProducto + ""
                 + ",'" + this.strDescripcionProducto + "'"
                 + "," + this.dblPrecio + ""
                 + "," + this.dblCantidad + ""
                 + "," + this.dblImporteTotal + ""
                 + "," + this.lngRegistro + ""
                
                 + "," + this.lngPuntoVenta + ""
                 + "," + this.lngVenta + ""
                 + "," + this.lngRegistroVenta + ""
                
                 + ");";
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery(); 
         System.out.println(strConsulta);
         return true;
    }

    
    public boolean actualizarMovimientoInventarioProducto() throws SQLException 
    {               
         String strConsulta="";
         String strRespuesta="";
         
         strConsulta=strConsulta +"UPDATE INVENTARIOPRODUCTOS \n" +
                                    "SET PRODUCTO=" +this.lngProducto + "\n" +
                                    "    ,DESCRIPCION='"+this.strDescripcionProducto+"'\n" +
                                    "    ,CANTIDAD="+this.dblCantidad+"\n" +
                                    "    ,PRECIO="+this.dblPrecio+"\n" +
                                    "    ,IMPORTETOTAL="+this.dblImporteTotal+"\n" +
                                    "    ,IDPUNTOVENTA="+this.lngPuntoVenta+"\n" +
                                    "    ,IDVENTA="+this.lngPuntoVenta+"\n" +
                                    "    ,REGISTROVENTA="+this.lngRegistroVenta+"\n" +
                                    "WHERE\n" +
                                    "    ENTRADASALIDA='"+this.strTipoMovimiento+"'\n" +
                                    "    AND IDTIPOFLUJO="+this.lngTipoFlujo+"\n" +
                                    "    AND IDBODEGA="+this.lngBodega+"\n" +
                                    "    AND IDFOLIO="+this.lngFolio+"\n" +
                                    "    AND REGISTRO="+this.lngRegistro+"\n" ;

         ps= con.conectado().prepareStatement(strConsulta);
         ps.execute(); 
         System.out.println(strConsulta);
         return true;
    }
 
    public Double dblExistencia() throws SQLException
    {               
         String strConsulta="";
         String strRespuesta="";
         Double dblResultado = null;
        
         
         strConsulta=strConsulta +"call PAC_TraerExistencia  ('"+this.lngProducto+"'"
                 + "," + this.lngBodega + "" 
                 + ");";
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery(); 
         while(res.next()){
              dblResultado=res.getDouble("existencia");
         }
         res.close();
         return dblResultado;     
    }
    
    public void leerMovimiento(){
        String strConsulta;
        strExiste="NO";
        strConsulta="";
        strConsulta=strConsulta +"call PAL_LeerMovimientoInventario  ('"+this.strTipoMovimiento+"'"
            + "," + this.lngBodega + ""
            + "," + this.lngTipoFlujo + ""
            + "," + this.lngFolio + ""
            + ");";
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         while(res.next()){
              //System.out.println(res.getString("Nombres"));
              this.strFactura=res.getString("Factura");
              this.strFecha=res.getString("Fecha");
              this.Fecha=res.getDate("Fecha");
              this.lngCliente=Long.valueOf(res.getString("idCliente"));
              this.strObservacion=res.getString("Observacion");
              this.strExiste=res.getString("EXISTE");
         }
         res.close();
          }catch(SQLException e){
              JOptionPane.showInternalMessageDialog(null,"ERROR AL LEER EL INVENTARIO" + e.toString());
          }
    }
 
 public void eliminarMovimiento(){
        String strConsulta;
      
        strConsulta="";
        strConsulta=strConsulta +"call PAR_EliminamovimientoInventario   ('"+this.strTipoMovimiento+"'"
            + "," + this.lngBodega + ""
            + "," + this.lngTipoFlujo + ""
            + "," + this.lngFolio + ""
            + ");";
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         
          }catch(SQLException e){
              JOptionPane.showInternalMessageDialog(null,"ERROR AL ELIMINAR MOVIMIENTO" + e.toString());
          }
    }
    public  long lngleerUltimoRegistro(){
        String strConsulta;
        strConsulta="";
        strConsulta=strConsulta +"call PAL_UltimoRegistroInventariosProductos  ('"+this.strTipoMovimiento+"'"
            + "," + this.lngBodega + ""
            + "," + this.lngTipoFlujo + ""
            + "," + this.lngFolio + ""
            + ");";
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         while(res.next()){
              //System.out.println(res.getString("Nombres"));
              
              return res.getLong("siguiente");
             
         }
         res.close();
          }catch(SQLException e){
              JOptionPane.showInternalMessageDialog(null,"ERROR AL LEER EL INVENTARIO" + e.toString());
          }
        return 1;
    }
    
    public void leerInventariosProductos(DefaultTableModel tablaArticulos ){
        String strConsulta;
        String datos[]=new String [7];
        strConsulta="";
         strConsulta=strConsulta +"call PAL_LeeInventariosProductos  ('"+this.strTipoMovimiento+"'"
            + "," + this.lngBodega + ""
            + "," + this.lngTipoFlujo + ""
            + "," + this.lngFolio + ""
            + ");";
        
        
        
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         while(res.next()){
              //System.out.println(res.getString("Nombres"));
              
              datos[0]=res.getString("Registro");
              datos[1]=res.getString("Producto");
              datos[2]=res.getString("Descripcion");
              datos[3]=res.getString("Precio");
              datos[4]=res.getString("Cantidad");
              datos[5]=res.getString("importeTotal");
             
              tablaArticulos.addRow(datos);
         }
            res.close();
            }catch(SQLException e){
        
          JOptionPane.showInternalMessageDialog(null,"ERROR" + e.toString());
        }
    }
    
    public void eliminarMovimientoProducto(){
        String strConsulta;
      
        strConsulta="";
        strConsulta=strConsulta +"call PAR_EliminamovimientoInventarioProducto   ('"+this.strTipoMovimiento+"'"
            + "," + this.lngBodega + ""
            + "," + this.lngTipoFlujo + ""
            + "," + this.lngFolio + ""
            + "," + this.lngRegistro + ""
            + ");";
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         
          }catch(SQLException e){
              JOptionPane.showInternalMessageDialog(null,"ERROR AL ELIMINAR MOVIMIENTO" + e.toString());
          }
    }
    
     public void eliminarMovimientoProductoVenta(){
        String strConsulta;
      
        strConsulta="";
        strConsulta=strConsulta +"delete from inventarioproductos where idPuntoVenta= " + this.lngPuntoVenta
            + " and idVenta=" + this.lngVenta + ""
            + " and Registro=" + this.lngRegistro + ";";
           
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         ps.executeUpdate();
         
         
          }catch(SQLException e){
             // JOptionPane.showInternalMessageDialog(null,"ERROR AL ELIMINAR MOVIMIENTO" + e.toString());
              System.out.println(e.toString());
          }
    }
    
     public void eliminarMovimientoProductoTodoVenta(){
        String strConsulta;
      
        strConsulta="";
        strConsulta=strConsulta +"delete from inventarioproductos where idPuntoVenta= " + this.lngPuntoVenta
            + " and idVenta=" + this.lngVenta + ";";
           // + " and Registro=" + this.lngRegistro + ";";
           
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         ps.executeUpdate();
         
         
          }catch(SQLException e){
             // JOptionPane.showInternalMessageDialog(null,"ERROR AL ELIMINAR MOVIMIENTO" + e.toString());
              System.out.println(e.toString());
          }
    }
     
     
     public void eliminarTodoMovimientoProducto(){
        String strConsulta;
      
        strConsulta="";
        strConsulta=strConsulta +"call PAR_EliminamovimientoInventarioProducto   ('"+this.strTipoMovimiento+"'"
            + "," + this.lngBodega + ""
            + "," + this.lngTipoFlujo + ""
            + "," + this.lngFolio + ""
            + ");";
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         
          }catch(SQLException e){
              JOptionPane.showInternalMessageDialog(null,"ERROR AL ELIMINAR MOVIMIENTO" + e.toString());
          }
    }
}

