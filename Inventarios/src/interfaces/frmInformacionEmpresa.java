/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interfaces;

import clases.classDatosEmpresa;
//import static com.sun.javafx.tk.Toolkit.getToolkit;
import java.awt.Dialog;
import java.awt.Image;
import java.io.File;
import javax.swing.ImageIcon;
import javax.swing.JFileChooser;
import herramientas.globales;
import static herramientas.globales.llenarComboGlobal;
import java.io.FileInputStream;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author julio
 */
public class frmInformacionEmpresa extends javax.swing.JInternalFrame{

    /**
     * Creates new form frmInformacionEmpresa
     */
    Image logo;
    String strInicio;
    
    public frmInformacionEmpresa() {
        initComponents();
        String strQuery;
        strQuery="select idPais,Descripcion from Paises";
    
        this.txtCiudad.setText(globales.gstrCiudad);
        this.txtDireccion.setText(globales.gstrDireccion);
        this.cboEstado.setToolTipText(globales.gstrEstado);
        this.txtNombre.setText(globales.gstrNombre);
        this.cboPais.setToolTipText(globales.gstrPais);
        this.txtRFC.setText(globales.gstrRFC);
        this.txtRazonSocial.setText(globales.gstrRazonSocial);
        this.txtTelefono.setText(globales.gstrTelefono);
        strInicio="S";
        llenarComboGlobal(this.cboPais,strQuery);
        strInicio="N";
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        lblNombreEmpresa = new javax.swing.JLabel();
        txtNombre = new javax.swing.JTextField();
        lblRazonSocial = new javax.swing.JLabel();
        lblRFC = new javax.swing.JLabel();
        lblTelefono = new javax.swing.JLabel();
        lblDireccion = new javax.swing.JLabel();
        lblCiudad = new javax.swing.JLabel();
        lblEstado = new javax.swing.JLabel();
        lblPais = new javax.swing.JLabel();
        txtRazonSocial = new javax.swing.JTextField();
        txtRFC = new javax.swing.JTextField();
        txtTelefono = new javax.swing.JTextField();
        txtCiudad = new javax.swing.JTextField();
        txtDireccion = new javax.swing.JTextField();
        lblLogo = new javax.swing.JLabel();
        lblImagen = new javax.swing.JLabel();
        cboEstado = new javax.swing.JComboBox();
        cboPais = new javax.swing.JComboBox();
        txtImagen = new javax.swing.JTextField();
        btnSeleccionar = new javax.swing.JButton();
        btnGuardar = new javax.swing.JButton();
        btnSalir = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("Datos globales de la persona moral o fisica");

        lblNombreEmpresa.setText("Nombre:");

        lblRazonSocial.setText("Razon Social:");

        lblRFC.setText("RFC:");

        lblTelefono.setText("Teléfono:");

        lblDireccion.setText("Dirección:");

        lblCiudad.setText("Ciudad:");
        lblCiudad.setToolTipText("");

        lblEstado.setText("Estado:");

        lblPais.setText("País:");

        lblLogo.setText("Logo:");

        cboEstado.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "" }));

        cboPais.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "" }));
        cboPais.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                cboPaisItemStateChanged(evt);
            }
        });

        btnSeleccionar.setText("Seleccionar");
        btnSeleccionar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSeleccionarActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(lblPais)
                            .addComponent(lblRazonSocial)
                            .addComponent(lblNombreEmpresa)
                            .addComponent(lblRFC)
                            .addComponent(lblTelefono)
                            .addComponent(lblDireccion)
                            .addComponent(lblCiudad)
                            .addComponent(lblEstado)
                            .addComponent(lblLogo))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(txtNombre)
                            .addComponent(txtRazonSocial, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(txtRFC, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(txtTelefono, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(txtCiudad, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(txtDireccion, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(jPanel1Layout.createSequentialGroup()
                                        .addComponent(txtImagen, javax.swing.GroupLayout.PREFERRED_SIZE, 130, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addGap(18, 18, 18)
                                        .addComponent(btnSeleccionar, javax.swing.GroupLayout.PREFERRED_SIZE, 182, javax.swing.GroupLayout.PREFERRED_SIZE))
                                    .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                                        .addComponent(cboEstado, javax.swing.GroupLayout.Alignment.LEADING, 0, 221, Short.MAX_VALUE)
                                        .addComponent(cboPais, javax.swing.GroupLayout.Alignment.LEADING, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                                .addGap(0, 0, Short.MAX_VALUE))))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(67, 67, 67)
                        .addComponent(lblImagen, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(lblNombreEmpresa)
                            .addComponent(txtNombre, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(lblRazonSocial)
                            .addComponent(txtRazonSocial, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addComponent(lblRFC))
                    .addComponent(txtRFC, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblTelefono)
                    .addComponent(txtTelefono, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblDireccion)
                    .addComponent(txtDireccion, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblCiudad)
                    .addComponent(txtCiudad, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblPais)
                    .addComponent(cboPais, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblEstado)
                    .addComponent(cboEstado, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 42, Short.MAX_VALUE)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblLogo)
                    .addComponent(txtImagen, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnSeleccionar))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(lblImagen, javax.swing.GroupLayout.PREFERRED_SIZE, 136, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        btnGuardar.setText("Guardar");
        btnGuardar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnGuardarActionPerformed(evt);
            }
        });

        btnSalir.setText("Salir");
        btnSalir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSalirActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(85, 85, 85)
                .addComponent(btnGuardar)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(btnSalir, javax.swing.GroupLayout.PREFERRED_SIZE, 90, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(66, 66, 66))
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnGuardar)
                    .addComponent(btnSalir))
                .addGap(38, 38, 38))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnSeleccionarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSeleccionarActionPerformed
        JFileChooser archivo = new JFileChooser();
        
        int ventana = archivo.showOpenDialog(null);
       
        if (ventana == JFileChooser.APPROVE_OPTION){
            
            File file = archivo.getSelectedFile();
           
            this.txtImagen.setText(String.valueOf(file));
            
            logo = getToolkit().getImage(this.txtImagen.getText());
            
            
            logo=logo.getScaledInstance(250,Math.round(250*(250/logo.getWidth(null))), Image.SCALE_DEFAULT);
            //logo=logo.getScaledInstance(100,100, Image.SCALE_DEFAULT);
            
            this.lblImagen.setIcon(new ImageIcon(logo));
        }
    }//GEN-LAST:event_btnSeleccionarActionPerformed

    private void btnSalirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSalirActionPerformed
        this.dispose();
    }//GEN-LAST:event_btnSalirActionPerformed

    private void cboPaisItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_cboPaisItemStateChanged
                                                 
          if (evt.getSource()==cboPais) {
            String strPais="0";
            
            try{
                if(strInicio=="N"){
                    strPais=(this.cboPais.getSelectedItem().toString().substring(0, 4));
                    llenarComboGlobal(this.cboEstado,"select idEstado,Descripcion from Estados"
                        + " where idPais="+strPais);
                }
            }
            catch(Exception e){
                strPais="0";
            }  
        }
    }//GEN-LAST:event_cboPaisItemStateChanged

    private void btnGuardarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnGuardarActionPerformed
        classDatosEmpresa empresa = new classDatosEmpresa();
        try {
            empresa.EliminarEmpresa();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "ERROR AL ELIMINAR ");
        }
        
        empresa.Direccion=this.txtDireccion.getText();
        empresa.Estado=this.cboEstado.getSelectedItem().toString();
        empresa.strCiudad=this.txtCiudad.getText();
        empresa.Pais=this.cboPais.getSelectedItem().toString();
        empresa.Nombre=this.txtNombre.getText();
        empresa.RFC=this.txtRFC.getText();
        empresa.Telefono=this.txtTelefono.getText();
        empresa.RazonSocial=this.txtRazonSocial.getText();
        
      
        try {
            if (empresa.ingresarDatosEmpresa()==true){
                JOptionPane.showMessageDialog(null, "INFORMACION GUARDADA ");
                this.dispose();
            }
        } catch (SQLException ex) {
            Logger.getLogger(frmInformacionEmpresa.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showMessageDialog(null, "ERROR AL GUARDAR ");
        }
        
    }//GEN-LAST:event_btnGuardarActionPerformed

    /**
     * @param args the command line arguments
     */
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnGuardar;
    private javax.swing.JButton btnSalir;
    private javax.swing.JButton btnSeleccionar;
    private javax.swing.JComboBox cboEstado;
    private javax.swing.JComboBox cboPais;
    private javax.swing.JPanel jPanel1;
    javax.swing.JLabel lblCiudad;
    javax.swing.JLabel lblDireccion;
    javax.swing.JLabel lblEstado;
    javax.swing.JLabel lblImagen;
    javax.swing.JLabel lblLogo;
    javax.swing.JLabel lblNombreEmpresa;
    javax.swing.JLabel lblPais;
    javax.swing.JLabel lblRFC;
    javax.swing.JLabel lblRazonSocial;
    javax.swing.JLabel lblTelefono;
    private javax.swing.JTextField txtCiudad;
    private javax.swing.JTextField txtDireccion;
    private javax.swing.JTextField txtImagen;
    private javax.swing.JTextField txtNombre;
    private javax.swing.JTextField txtRFC;
    private javax.swing.JTextField txtRazonSocial;
    private javax.swing.JTextField txtTelefono;
    // End of variables declaration//GEN-END:variables
}
