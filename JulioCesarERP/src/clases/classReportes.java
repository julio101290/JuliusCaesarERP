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
 * @author julio
 */
public class classReportes {
    private conexion con;
    PreparedStatement ps;
    ResultSet res;
    private Sentencias_sql sql; 
   
    public String strNombreReporte;
    public String strConsulta;
    public classReportes(){
        sql = new Sentencias_sql();
        con = new conexion();
}
    
public void leerReporte(String strReporte){
        String strConsulta;
        String datos[]=new String [12];
        
        strConsulta="select NombreReporte,Consulta from reportes where idReporte="+Long.valueOf(strReporte)
                + ";";
     
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         while(res.next()){
              this.strNombreReporte=res.getString("NombreReporte");
              this.strConsulta=res.getString("Consulta");
           
                      
              res.close();
              
              
         }
         res.close();
          }catch(SQLException e){
         System.out.println(e);
 
     
          }
        }
}
