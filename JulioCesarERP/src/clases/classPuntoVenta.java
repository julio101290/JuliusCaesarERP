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
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author julioc
 */
public class classPuntoVenta {
private conexion con;
    PreparedStatement ps;
    ResultSet res;
    private Sentencias_sql sql; 
    
    public long lngIdPuntoVenta;
    public String strDescripcion;
    public String strIdBodega;

    
    public classPuntoVenta(){
        sql = new Sentencias_sql();
        con = new conexion();
    }
    
    public void leerPuntoVenta(String strPuntoVenta){
        String strConsulta;
        String datos[]=new String [12];
        
        strConsulta="call PA_LeePuntoVenta ("+strPuntoVenta
                + ");";
     
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         while(res.next()){
              this.lngIdPuntoVenta=Long.valueOf(res.getString("idPuntoVenta"));
              this.strDescripcion=res.getString("Descripcion");
              this.strIdBodega=res.getString(3);
              datos[0]=res.getString("idPuntoVenta");
              datos[1]=res.getString("Descripcion");
              datos[2]=res.getString("idBodega");
                      
              res.close();
              
              
         }
         res.close();
          }catch(SQLException e){
         System.out.println(e);
 
     
          }
        }
    public boolean ingresarPuntoVenta() throws SQLException
    {               
         String strConsulta="";
         String strRespuesta="";
         
         strConsulta=strConsulta +"call PA_InsertaPuntoVenta('"+this.strDescripcion+"',"
                 +this.strIdBodega+ ");";
         ps= con.conectado().prepareStatement(strConsulta);
         
         strRespuesta= herramientas.globales.strPreguntaSiNo("Desea agregar la PuntoVenta " + this.strDescripcion);
         if (strRespuesta=="SI"){
            res = ps.executeQuery();
         }
         
         System.out.println(strConsulta);
         return true;
    }
    
    public boolean actualizarPuntoVenta() throws SQLException
    {               
         String strConsulta="";
         String strRespuesta="";
         
         strConsulta=strConsulta +"call PA_ActualizaPuntoVenta  ("+this.lngIdPuntoVenta+",'"
                 + this.strDescripcion + "'," 
                  + this.strIdBodega + "" 
                 + ");";

       ps= con.conectado().prepareStatement(strConsulta);
         
         strRespuesta= herramientas.globales.strPreguntaSiNo("Desea actualizar la PuntoVenta " + this.strDescripcion);
         if (strRespuesta=="SI"){
            res = ps.executeQuery();
         }
         
         System.out.println(strConsulta);
         return true;
    }
    
    public boolean eliminarPuntoVenta() throws SQLException
    {               
         String strConsulta="";
         String strRespuesta="";
         
         strConsulta=strConsulta +"call PA_EliminarPuntoVenta  ('"+this.lngIdPuntoVenta+"');";
         ps= con.conectado().prepareStatement(strConsulta);
         
         strRespuesta= herramientas.globales.strPreguntaSiNo("Desea eliminar la PuntoVenta " + this.strDescripcion);
         if (strRespuesta=="SI"){
            res = ps.executeQuery();
            return true;
         }
         
         
         System.out.println(strConsulta);
         return true;
    }
    
    public void leerPuntoVentas(long intDesde ,long intCuantos,DefaultTableModel tablaPuntoVentas,String strBusqueda ){
        String strConsulta;
        String datos[]=new String [3];
      
        strConsulta="CALL PA_LeePuntosVentas ("+intDesde+","+intCuantos+",'"+strBusqueda+"');";
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         while(res.next()){
              //System.out.println(res.getString("Nombres"));
              
              datos[0]=res.getString("idPuntoVenta");
              datos[1]=res.getString("Descripcion");
              //datos[2]=res.getString("idBodega");
              
          
             
              tablaPuntoVentas.addRow(datos);
         }
            res.close();
            }catch(SQLException e){
        
          JOptionPane.showInternalMessageDialog(null,"ERROR" + e.toString());
        }
        
    
        
    }
    
    public long leerCuantos(String strBusqueda){
        String strConsulta;
        long cuantos = 0;
        strConsulta="call PA_LeeCuantosPuntoVentas('" +strBusqueda +"');";
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
          System.out.println(strConsulta);
         while(res.next()){
              //System.out.println(res.getString("Nombres"));
              cuantos=Long.valueOf(res.getString("cuantos"));
       
              return cuantos;
              
         }
         res.close();
          }catch(SQLException e){
         System.out.println(e);
         System.out.println(strConsulta);
         return cuantos;
          }
       System.out.println(strConsulta);
        return cuantos;
       
        }


     
}
