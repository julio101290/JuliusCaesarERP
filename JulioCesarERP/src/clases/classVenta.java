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
public class classVenta {
    private conexion con;
    PreparedStatement ps;
    ResultSet res;
    private Sentencias_sql sql; 
    
    public long lngPuntoVenta;
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
    
    public java.util.Date Fecha = new java.util.Date();
    
    public classVenta(){
        sql = new Sentencias_sql();
        con = new conexion();
    }
    
    public long lngUltimoFolio (String strPuntoVenta){
        String strConsulta;
        String datos[]=new String [5];
        DecimalFormat formato = new DecimalFormat("0000");
        
        strConsulta="call PAL_UltimoFolioVenta ("+strPuntoVenta+ ""

          
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
    
   
    
    public boolean ingresarMovimientoVenta() throws SQLException
    {               
         String strConsulta="";
         String strRespuesta="";
         
         strConsulta=strConsulta +"call PAR_INSERTAMOVIMIENTOVENTA ('"+this.lngPuntoVenta+"'"
                 + "," + this.lngFolio + ""
                 + ",'" + this.strFecha + "'"
                 + "," + this.lngCliente + ""
                 + ",'" + this.strObservacion + "'"
                 + ");";
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery(); 
         System.out.println(strConsulta);
         return true;
    }
     public boolean ingresarMovimientoVentaProducto() throws SQLException
    {               
         String strConsulta="";
         
         strConsulta=strConsulta +"call  PAR_InsertaMovimientoVentaProducto   ('"+this.lngPuntoVenta+"'"
                 + "," + this.lngFolio + ""
                 
                 + "," + this.lngProducto + ""
                 + ",'" + this.strDescripcionProducto + "'"
                 + "," + this.dblPrecio + ""
                 + "," + this.dblCantidad + ""
                 + "," + this.dblImporteTotal + ""
                 + "," + this.lngRegistro + ""
                
                 + ");";
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery(); 
         System.out.println(strConsulta);
         return true;
    }
    
    
    public boolean actualizarMovimientoVenta() throws SQLException
    {               
         String strConsulta="";
         String strRespuesta="";
         
         strConsulta=strConsulta +"call PAC_ActualizaVenta  ('"+this.lngPuntoVenta+"'"
                 + "," + this.lngFolio + ""
                 + ",'" + this.strFecha + "'"
                 + ",'" + this.strObservacion + "'"
                 + ",'" + this.lngCliente + "'"
                 
                 
                 + ");";
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery(); 
         System.out.println(strConsulta);
         return true;
    }
 
    
    
    public void leerMovimiento(){
        String strConsulta;
        strExiste="NO";
        strConsulta="";
        strConsulta=strConsulta +"call PAL_LeerMovimientoVenta  ("+this.lngPuntoVenta+""

        
            + "," + this.lngFolio + ""
            + ");";
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         while(res.next()){
              //System.out.println(res.getString("Nombres"));
              this.strFecha=res.getString("Fecha");
              this.Fecha=res.getDate("Fecha");
              this.lngCliente=Long.valueOf(res.getString("Cliente"));
              this.strObservacion=res.getString("Observaciones");
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
        strConsulta=strConsulta +"call PAR_EliminamovimientoVenta   ('"+this.lngPuntoVenta+"'"
            + "," + this.lngFolio + ""
            + ");";
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         
          }catch(SQLException e){
              JOptionPane.showInternalMessageDialog(null,"ERROR AL ELIMINAR MOVIMIENTO" + e.toString());
          }
    }
    public  long lngleerUltimoVentaRegistro(){
        String strConsulta;
        strConsulta="";
        strConsulta=strConsulta +"call PAL_UltimoRegistroVentasProductos  ("+this.lngPuntoVenta+""
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
    
    public void leerVentaProductos(DefaultTableModel tablaArticulos ){
        String strConsulta;
        String datos[]=new String [7];
        strConsulta="";
         strConsulta=strConsulta +"call PAL_LeeVentasProductos  ("+this.lngPuntoVenta+""
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
              datos[5]=res.getString("importe_neto");
             
              tablaArticulos.addRow(datos);
         }
            res.close();
            }catch(SQLException e){
        
          JOptionPane.showInternalMessageDialog(null,"ERROR" + e.toString());
        }
    }
    
    public void eliminarVentaProducto(){
        String strConsulta;
      
        strConsulta="";
        strConsulta=strConsulta +"call PAR_EliminarVentaProducto   ("+this.lngPuntoVenta+""
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
    
    public void eliminarTodoVentaProducto(){
        String strConsulta;
      
        strConsulta="";
        strConsulta=strConsulta +"call PAR_EliminarTodoVentaProducto   ("+this.lngPuntoVenta+""
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

