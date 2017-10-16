package clasesSQLite; 
import ConexionLite.Conexion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
}