/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package herramientas;

import clases.classGruposUsuarios;
import java.io.File;
import java.io.FileInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import javax.swing.JComboBox;
import javax.swing.JOptionPane;

/**
 *
 * @author julio
 */
 public class globales {
    public static long     lngIDGrupo;
    public static long     lngIDUsuario;
    public static boolean  blnAccesoConfiguracion;
    public static boolean  blnAccesoGrupos;
    public static boolean  blnAccesoUsuarios;
    public static boolean  blnAccesoClientes;
    public static boolean  blnAccesoArticulos;
    public static boolean  blnAccesoInventarios;
    public static boolean  blnABCBodegas;
    public static boolean  blnABCTiposFlujo;
    public static boolean  blnReportesInventarios;
    
    public static boolean  blnABCPuntosVenta;
    public static boolean  blnAccesoVenta;
    public static boolean  blnReportesVentas;
    public static boolean  blnAccesoCartera;
    public static boolean  blnReportesCartera;
    
    //DATOS EMPRESA
    public static String gstrCiudad;
    public static String gstrDireccion;
    public static String gstrEstado;
    public static File Logo;
    public static FileInputStream fLogo;
    public static String gstrNombre;
    public static String gstrPais;
    public static String gstrRazonSocial;
    public static String gstrRFC;
    public static String gstrTelefono;
    
    
    public static String[ ] LicenciaEmpresas = {"Prueba"
            , "Julio"
            , "Julio"
            , "Julio"
            , "Julio"
            , "Julio"
            , "Julio"
            , "Julio"
            };
    
    private static conexion con;
    private static PreparedStatement ps;
    private static ResultSet res;
    
   //TEMPORALES
   public static String gstrCliente;
   public static long glngArticulo;

    
    public static void obtenerDerechosGrupo(){
        classGruposUsuarios grupos = new classGruposUsuarios();
        grupos.leerGrupo(String.valueOf(lngIDGrupo));
        blnAccesoConfiguracion=grupos.blnAccesoConfiguracion;
        blnAccesoGrupos=grupos.blnAccesoGrupos;
        blnAccesoUsuarios=grupos.blnAccesoUsuarios;
        blnAccesoClientes=grupos.blnAccesoClientes;
        blnAccesoArticulos=grupos.blnAccesoArticulos;
        blnAccesoInventarios=grupos.blnAccesoInventarios;
        
        blnABCBodegas=grupos.blnABCBodegas;
        blnABCTiposFlujo=grupos.blnABCTiposFlujo;
        blnReportesInventarios=grupos.blnReportesInventarios;
    }
    
 
    public static String strPreguntaSiNo(String strMensaje){
        int seleccion = JOptionPane.showOptionDialog(
            null, // Componente padre
            strMensaje, //Mensaje
            "Seleccione una opción", // Título
            JOptionPane.YES_NO_CANCEL_OPTION,
            JOptionPane.QUESTION_MESSAGE,
            null,    // null para icono por defecto.
            new Object[] { "Si", "No"},    // null para YES, NO y CANCEL
            "Si");
        
        if (seleccion != -1)
            {
                if((seleccion + 1)==1)
                    {
                    return "SI";
                    }
                else
                    {
                    return "NO";
                    }
            }
    return null;
    } 
    
    public static void llenarComboGlobal(JComboBox Combo,String strConsulta,boolean blnLimpiar){
     
            
        con = new conexion();
        String datos[]=new String [2];
        DecimalFormat formato = new DecimalFormat("0000");
        
        int intDesde=0;
        int intCuantos=1000;
        String strBusqueda="";
                
        if (blnLimpiar==true){
            Combo.removeAllItems();
        }
      
      
        try{
         
         ps= con.conectado().prepareStatement(strConsulta);
         res = ps.executeQuery();
         
         while(res.next()){
             
              datos[0]=formato.format( res.getDouble(1));
              datos[1]=res.getString(2) ;
             
              
              Combo.addItem(datos[0] + " "+ datos[1]);
         }
            res.close();
            System.out.println(res.getWarnings());
            }catch(SQLException e){
         System.out.println(e);
        }
        
    }
    
      static String sha1(String input) throws NoSuchAlgorithmException {
        MessageDigest mDigest = MessageDigest.getInstance("SHA1");
        byte[] result = mDigest.digest(input.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < result.length; i++) {
            sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
        }
         
        return sb.toString();
    }
      
    
 
  
      public static boolean verificaLicencia() throws NoSuchAlgorithmException{
          String Licencia;
          boolean blnEncontro=false;
          
          Licencia=sha1(gstrCiudad+gstrDireccion+gstrEstado+gstrNombre+gstrPais+gstrRazonSocial+gstrRFC+gstrTelefono);
          
          for(int i = 0; i <= 7;  i++){
              if(LicenciaEmpresas[i].equals(Licencia)){
                  blnEncontro=true;
              } 
	
            }

          
          return blnEncontro;
        }
      

}
