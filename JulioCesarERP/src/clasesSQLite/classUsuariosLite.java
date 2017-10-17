package clasesSQLite; 
import ConexionLite.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author julioleyva Generacion Automatica
 */

public class classUsuariosLite  extends Conexion {
    public String stridUsuario;
    public String strUsuario;
    public String strContra;
    public String strGrupo;
    public String strNombre;

    public void  insertaUsuarios(){

    String q="";

       q=" INSERT INTO  usuarios ("
         +" idUsuario"
         +",Usuario"
         +",Contra"
         +",Grupo"
         +",Nombre"
         + " )VALUES ( "
         + " '"+stridUsuario + "' "
         + ", '"+strUsuario + "' "
         + ", '"+strContra + "' "
         + ", '"+strGrupo + "' "
         + ", '"+strNombre + "' "
        +")";
        //se ejecuta la consulta
        try {
            PreparedStatement pstm = connection.prepareStatement(q);
            pstm.execute();
            pstm.close();
         }catch(Exception e){
            System.out.println(e);
        }
    }
    
    //BUSCA USUARIO
     public boolean  blnBuscaUsuario(){
        ResultSet result = null;
        String q="";
        boolean r=false;

       q=" select * from usuarios "
         + " where  "
         + " Usuario= '"+strUsuario + "' "
         + "and contra= '"+strContra + "' ";
       
        //se ejecuta la consulta
        try {
            PreparedStatement pstm = connection.prepareStatement(q);
            result= pstm.executeQuery();
            while (result.next()) {
               r=true;
            }
            pstm.close();
         }catch(Exception e){
            System.out.println(e);
        }
        return r;
    }
     
       public void leerUsuarios(long intDesde ,long intCuantos,DefaultTableModel tablaClientes,String strBusqueda ){
        String strConsulta;
        ResultSet result = null;
        String datos[]=new String [6];
        DecimalFormat formato = new DecimalFormat("0000");
        strConsulta="SELECT idUsuario,"
                + "Usuario"
                + ",Contra"
                + ",Grupo"
                + ",Nombre"
                + " FROM usuarios"
                + " where nombre like '%"+strBusqueda+"%' " +
                    "or idUsuario like '%"+strBusqueda+"%' " +
                    "or Nombre like '%"+strBusqueda+"%' " +
                    "limit "+intCuantos+" offset "+ intDesde 
                + " ";
      
        try{
         
          PreparedStatement pstm = connection.prepareStatement(strConsulta);
          result= pstm.executeQuery();
   
         
         while(result.next()){
              //System.out.println(res.getString("Nombres"));
              datos[0]=result.getString("idUsuario");
              datos[1]=result.getString("Usuario");
              datos[2]=result.getString("Contra");
              //FALTA EL NOMBRE
              datos[3]=formato.format(result.getInt("Grupo")); //+" "+ result.getString("Grupo");
              datos[4]=result.getString("Nombre");
              
              tablaClientes.addRow(datos);
         }
         result.close();
          }catch(SQLException e){
         System.out.println(e);
        
    }
        
}
       
       
    
    public String[] leerUsuario(String strUsuario){
        String strConsulta;
        ResultSet result = null;
        DecimalFormat formato = new DecimalFormat("0000");
        String datos[]=new String [6];
      
        
                strConsulta="SELECT idUsuario,"
                + "Usuario"
                + ",Contra"
                + ",Grupo"
                + ",Nombre"
                + " FROM usuarios"
                + " where Usuario = '"+ strUsuario+"'";
     
      
        try{
         
          PreparedStatement pstm = connection.prepareStatement(strConsulta);
          result= pstm.executeQuery();
         
         while(result.next()){
              //System.out.println(res.getString("Nombres"));
              datos[0]=result.getString("IdUsuario");
              datos[1]=result.getString("Usuario");
              datos[2]=result.getString("Contra");
              datos[3]=formato.format(result.getInt("Grupo"));//+" "+res.getString("Grupo");
              datos[4]=result.getString("Nombre");
              datos[5]=result.getString("idGrupo");
           
              result.close();
              return datos;
              
         }
         result.close();
          }catch(SQLException e){
         System.out.println(e);
 
         return datos;
          }
      
        return datos;
        }
    
    
}