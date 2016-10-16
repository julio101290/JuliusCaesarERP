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
public class classCartera {
private conexion con;
    PreparedStatement ps;
    ResultSet res;
    private Sentencias_sql sql; 
    
    public Long lngIdCartera;
    public String strDescripcion;
    public String strFecha;
    public String strCargoAbono;
    public Double dblImporte;
    public Long lngCliente;

    
    public classCartera(){
        sql = new Sentencias_sql();
        con = new conexion();
    }
    
    public void leerCartera(String strCartera){
        String strConsulta;
        String datos[]=new String [12];
        
        strConsulta="SELECT idCartera\n" +
                    "        ,Fecha\n" +
                    "        ,idCliente\n" +
                    "        ,Observaciones\n" +
                    "        ,Importe\n" +
                    "        ,CargoAbono\n" +
                    "FROM cartera \n" +
                    "    where idCartera="+strCartera;
     
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         while(res.next()){
              this.lngIdCartera=Long.valueOf(res.getString("idCartera"));
              this.strDescripcion=res.getString("Observaciones");
              this.strCargoAbono=res.getString("CargoAbono");
              this.dblImporte=Double.valueOf(res.getDouble("Importe"));
              this.lngCliente=res.getLong("idCliente");
              this.strFecha=res.getString("Fecha");
              res.close();
              
              
         }
         res.close();
          }catch(SQLException e){
         System.out.println(e);
 
     
          }
        }
    public boolean ingresarCartera() throws SQLException
    {               
         String strConsulta="";
         String strRespuesta="";
         
         strConsulta=strConsulta +"INSERT INTO cartera \n" +
                                    "(`idCartera`\n" +
                                    ", `Fecha`\n" +
                                    ", `idCliente`\n" +
                                    ", `Observaciones`\n" +
                                    ", `Importe`\n" +
                                    ", `CargoAbono`) \n" +
                                    
                                    "VALUES ("+this.lngIdCartera+"\n" +
                                    "        , '"+this.strFecha+"'\n" +
                                    "        , "+this.lngCliente+""
                                    + ", '"+this.strDescripcion+"'\n" +
                                    "        , "+this.dblImporte+"\n" +
                                    "        , '"+this.strCargoAbono+"')";
         ps= con.conectado().prepareStatement(strConsulta);
         
         strRespuesta= herramientas.globales.strPreguntaSiNo("Desea agregar el movimiento " + this.strDescripcion);
         if (strRespuesta=="SI"){
            ps.execute();
         }
         
         System.out.println(strConsulta);
         return true;
    }
    
    public boolean actualizarCartera() throws SQLException
    {               
         String strConsulta="";
         String strRespuesta="";
         
         strConsulta=strConsulta +"UPDATE CARTERA SET \n" +
                                "    FECHA='"+this.strFecha+"'\n" +
                                "    ,IDCLIENTE="+this.lngCliente+"\n" +
                                "    ,OBSERVACIONES='"+this.strDescripcion+"'\n" +
                                "    ,IMPORTE="+this.dblImporte+"\n" +
                                "    ,CARGOABONO='"+this.strCargoAbono+"'\n" +
                                "WHERE IDCARTERA="+this.lngIdCartera;

       ps= con.conectado().prepareStatement(strConsulta);
         
         strRespuesta= herramientas.globales.strPreguntaSiNo("Desea actualizar la cartera " + this.lngIdCartera);
         if (strRespuesta=="SI"){
             ps.execute();
         }
         
         System.out.println(strConsulta);
         return true;
    }
    
    public boolean eliminarCartera() throws SQLException
    {               
         String strConsulta="";
         String strRespuesta="";
         
         strConsulta=strConsulta +"DELETE FROM CARTERA WHERE IDCARTERA="  +this.lngIdCartera;
         ps= con.conectado().prepareStatement(strConsulta);
         
         strRespuesta= herramientas.globales.strPreguntaSiNo("Desea eliminar el movimiento " + this.lngIdCartera);
         if (strRespuesta=="SI"){
             ps.execute();
         }
         
         System.out.println(strConsulta);
         return true;
    }
    
    public void leerCarteras(long intDesde ,long intCuantos,DefaultTableModel tablaCartera,String strBusqueda ){
        String strConsulta;
        String datos[]=new String [7];
      
        strConsulta="SELECT IDCARTERA\n" +
                    "        ,FECHA\n" +
                    "        ,IDCLIENTE\n" +
                    "        ,OBSERVACIONES\n" +
                    "        ,IMPORTE\n" +
                    "        ,CARGOABONO\n" +
                    "FROM CARTERA\n" +
                    "WHERE\n" +
                    "FECHA LIKE CONCAT('%"+strBusqueda+"%')\n" +
                    "OR IDCLIENTE LIKE CONCAT('%"+strBusqueda+"%')\n" +
                    "OR OBSERVACIONES LIKE CONCAT('%"+strBusqueda+"%')\n" +
                    "OR IMPORTE LIKE CONCAT('%"+strBusqueda+"%')\n" +
                    "OR CARGOABONO LIKE CONCAT('%"+strBusqueda+"%')\n" +
                    "OR IDCARTERA LIKE CONCAT('%"+strBusqueda+"%')\n" +
                    "\n" +
                    "LIMIT "+intDesde+","+intCuantos+" ";
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         while(res.next()){
              //System.out.println(res.getString("Nombres"));
              
              datos[0]=res.getString("IDCARTERA");
              datos[3]=res.getString("FECHA");
              datos[2]=res.getString("IDCLIENTE");
              datos[1]=res.getString("OBSERVACIONES");
              datos[4]=res.getString("IMPORTE");
              datos[5]=res.getString("CARGOABONO");
   
          
             
              tablaCartera.addRow(datos);
         }
            res.close();
            }catch(SQLException e){
        
          JOptionPane.showInternalMessageDialog(null,"ERROR" + e.toString());
        }
        
    
        
    }
    
    public long leerCuantos(String strBusqueda){
        String strConsulta;
        long cuantos = 0;
        strConsulta="SELECT IFNULL(COUNT(IDCARTERA),0) AS CUANTOS FROM CARTERA";
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
          System.out.println(strConsulta);
         while(res.next()){
              //System.out.println(res.getString("Nombres"));
              cuantos=Long.valueOf(res.getString("CUANTOS"));
       
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
