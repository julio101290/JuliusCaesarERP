
package interfaces;

import clases.control_cliente;
import clases.control_existencias;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.SingleSelectionModel;
import javax.swing.table.DefaultTableModel;
import static jdk.nashorn.internal.objects.NativeString.trim;

public final class frmClientes extends javax.swing.JInternalFrame {

    control_existencias ctrl = new control_existencias();
    long lngNumPaginas;
    public frmClientes() {
        initComponents();    
        limpiar();
        this.txtNumReg.setText("5");
        defineTablaClientes("",1);
        
      //Object[] tipo_doc = ctrl.combox("tipo_de_documento","id_tipo_documento");
               // combo_tipo.removeAllItems();
        //        for(int i=0;i<tipo_doc.length;i++){
        //       // combo_tipo.addItem(tipo_doc[i]);
        //       control_cliente clientes = new control_cliente(); 
        //       //clientes.ingresar_cliente()
        //                    
        //    }
        
        //        Object[] ciu = ctrl.combox("ciudad","Codigo_ciudad");
        //       // ciudad_combo.removeAllItems();
        //        for(int i=0;i<ciu.length;i++){
        //       // ciudad_combo.addItem(ciu[i]);
        //        
        //    }
    }

    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        TabDatos = new javax.swing.JTabbedPane();
        jPanel1 = new javax.swing.JPanel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        txtApellidos = new javax.swing.JTextField();
        jLabel6 = new javax.swing.JLabel();
        txtNombre1 = new javax.swing.JTextField();
        jLabel12 = new javax.swing.JLabel();
        txtLugarNacimiento = new javax.swing.JTextField();
        dteFechaNacimiento = new com.toedter.calendar.JDateChooser();
        txtIdCliente = new javax.swing.JTextField();
        jLabel11 = new javax.swing.JLabel();
        jPanel2 = new javax.swing.JPanel();
        txtRFC = new javax.swing.JTextField();
        jLabel1 = new javax.swing.JLabel();
        jPanel3 = new javax.swing.JPanel();
        jLabel4 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        txtDomicilio = new javax.swing.JTextField();
        txtTelefono = new javax.swing.JTextField();
        jLabel5 = new javax.swing.JLabel();
        txtEstado = new javax.swing.JTextField();
        jLabel8 = new javax.swing.JLabel();
        txtMunicipio = new javax.swing.JTextField();
        jLabel9 = new javax.swing.JLabel();
        txtCiudad = new javax.swing.JTextField();
        jLabel10 = new javax.swing.JLabel();
        txtCodigoPostal = new javax.swing.JTextField();
        PanTabla = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        JTabClientes = new javax.swing.JTable();
        PanBotones = new javax.swing.JPanel();
        regclientejButton1 = new javax.swing.JButton();
        cancelclijButton2 = new javax.swing.JButton();
        salirclijButton3 = new javax.swing.JButton();
        jPanel4 = new javax.swing.JPanel();
        jlblNumReg = new javax.swing.JLabel();
        txtNumReg = new javax.swing.JTextField();
        jlblNumReg2 = new javax.swing.JLabel();
        txtPagina = new javax.swing.JTextField();
        jlblTotalPaginas = new javax.swing.JLabel();
        cmdAtras = new javax.swing.JButton();
        cmdSiguiente1 = new javax.swing.JButton();
        txtIdCliente1 = new javax.swing.JTextField();
        lblBuscar = new javax.swing.JLabel();

        setIconifiable(true);
        setMaximizable(true);
        setResizable(true);
        setTitle("Registrar clientes");

        jLabel2.setText("Nombres");

        jLabel3.setText("Apellidos");

        txtApellidos.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtApellidosActionPerformed(evt);
            }
        });

        jLabel6.setText("Fecha de nacimiento");

        txtNombre1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtNombre1ActionPerformed(evt);
            }
        });

        jLabel12.setText("Lugar de nacimiento");

        txtLugarNacimiento.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtLugarNacimientoActionPerformed(evt);
            }
        });

        dteFechaNacimiento.setToolTipText("");
        dteFechaNacimiento.setDateFormatString("yyyy-MM-dd");

        jLabel11.setText("Id Cliente");

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                        .addComponent(jLabel2, javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(txtNombre1, javax.swing.GroupLayout.PREFERRED_SIZE, 256, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(jLabel6, javax.swing.GroupLayout.Alignment.LEADING))
                    .addComponent(txtLugarNacimiento, javax.swing.GroupLayout.PREFERRED_SIZE, 256, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel12)
                    .addComponent(jLabel3)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 1, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(txtApellidos, javax.swing.GroupLayout.PREFERRED_SIZE, 256, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jLabel11)
                    .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                        .addComponent(txtIdCliente, javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(dteFechaNacimiento, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, 256, Short.MAX_VALUE)))
                .addContainerGap(36, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel2)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(txtNombre1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(jLabel3)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(txtApellidos, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jLabel12)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(txtLugarNacimiento, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel6)
                .addGap(18, 18, 18)
                .addComponent(dteFechaNacimiento, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel11)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(txtIdCliente, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(133, Short.MAX_VALUE))
        );

        TabDatos.addTab("Basicos", jPanel1);

        jLabel1.setText("RFC");

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(txtRFC, javax.swing.GroupLayout.PREFERRED_SIZE, 210, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel1))
                .addContainerGap(83, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1)
                .addGap(1, 1, 1)
                .addComponent(txtRFC, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(358, Short.MAX_VALUE))
        );

        TabDatos.addTab("Facturacion", jPanel2);

        jLabel4.setText("Domicilio");

        jLabel7.setText("Telefono");

        jLabel5.setText("Estado");

        jLabel8.setText("Codigo Postal");

        jLabel9.setText("Ciudad");

        jLabel10.setText("Municipio");

        javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel4)
                            .addComponent(txtDomicilio, javax.swing.GroupLayout.PREFERRED_SIZE, 234, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(txtEstado, javax.swing.GroupLayout.PREFERRED_SIZE, 234, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel5)
                            .addComponent(jLabel9)
                            .addComponent(txtCiudad, javax.swing.GroupLayout.PREFERRED_SIZE, 234, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                    .addGroup(jPanel3Layout.createSequentialGroup()
                        .addGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel3Layout.createSequentialGroup()
                                .addComponent(jLabel7)
                                .addGap(172, 172, 172))
                            .addComponent(txtTelefono, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 234, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                .addComponent(jLabel8)
                                .addComponent(txtMunicipio, javax.swing.GroupLayout.PREFERRED_SIZE, 234, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addComponent(jLabel10)
                                .addComponent(txtCodigoPostal, javax.swing.GroupLayout.PREFERRED_SIZE, 234, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(0, 0, Short.MAX_VALUE))))
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel4)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(txtDomicilio, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(20, 20, 20)
                .addComponent(jLabel5)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(txtEstado, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(jLabel9)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(txtCiudad, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jLabel7)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(txtTelefono, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(26, 26, 26)
                .addComponent(jLabel10)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(txtMunicipio, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(jLabel8)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(txtCodigoPostal, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(53, Short.MAX_VALUE))
        );

        TabDatos.addTab("Localización", jPanel3);

        JTabClientes.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        JTabClientes.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                JTabClientesMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(JTabClientes);

        javax.swing.GroupLayout PanTablaLayout = new javax.swing.GroupLayout(PanTabla);
        PanTabla.setLayout(PanTablaLayout);
        PanTablaLayout.setHorizontalGroup(
            PanTablaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 472, Short.MAX_VALUE)
        );
        PanTablaLayout.setVerticalGroup(
            PanTablaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        );

        regclientejButton1.setText("Registrar");
        regclientejButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                regclientejButton1ActionPerformed(evt);
            }
        });

        cancelclijButton2.setLabel("Nuevo");
        cancelclijButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cancelclijButton2ActionPerformed(evt);
            }
        });

        salirclijButton3.setText("Salir");
        salirclijButton3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                salirclijButton3ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout PanBotonesLayout = new javax.swing.GroupLayout(PanBotones);
        PanBotones.setLayout(PanBotonesLayout);
        PanBotonesLayout.setHorizontalGroup(
            PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanBotonesLayout.createSequentialGroup()
                .addComponent(regclientejButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 103, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(cancelclijButton2)
                .addGap(18, 18, 18)
                .addComponent(salirclijButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 81, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, Short.MAX_VALUE))
        );
        PanBotonesLayout.setVerticalGroup(
            PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanBotonesLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(regclientejButton1)
                    .addComponent(cancelclijButton2)
                    .addComponent(salirclijButton3))
                .addContainerGap(17, Short.MAX_VALUE))
        );

        jlblNumReg.setText("Registros");

        txtNumReg.setText("5");

        jlblNumReg2.setText("Pagina ");

        txtPagina.setText("1");

        jlblTotalPaginas.setText("Pagina ");

        cmdAtras.setText("<<");
        cmdAtras.setActionCommand("");
        cmdAtras.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdAtrasActionPerformed(evt);
            }
        });

        cmdSiguiente1.setText(">>");
        cmdSiguiente1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdSiguiente1ActionPerformed(evt);
            }
        });

        txtIdCliente1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtIdCliente1ActionPerformed(evt);
            }
        });
        txtIdCliente1.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                txtIdCliente1KeyPressed(evt);
            }
        });

        lblBuscar.setText("Buscar");

        javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(jlblNumReg)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(txtNumReg, javax.swing.GroupLayout.PREFERRED_SIZE, 21, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(cmdAtras)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jlblNumReg2)
                        .addGap(2, 2, 2)
                        .addComponent(txtPagina, javax.swing.GroupLayout.PREFERRED_SIZE, 21, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jlblTotalPaginas)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 57, Short.MAX_VALUE)
                        .addComponent(cmdSiguiente1)
                        .addGap(29, 29, 29))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(lblBuscar)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(txtIdCliente1)
                        .addGap(130, 130, 130))))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addGap(9, 9, 9)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jlblNumReg)
                    .addComponent(txtNumReg, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jlblNumReg2)
                    .addComponent(txtPagina, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jlblTotalPaginas)
                    .addComponent(cmdAtras)
                    .addComponent(cmdSiguiente1))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 22, Short.MAX_VALUE)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtIdCliente1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(lblBuscar))
                .addContainerGap())
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(PanTabla, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jPanel4, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(TabDatos)
                    .addComponent(PanBotones, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(PanTabla, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                        .addComponent(TabDatos, javax.swing.GroupLayout.PREFERRED_SIZE, 432, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(PanBotones, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(0, 50, Short.MAX_VALUE))
        );

        TabDatos.getAccessibleContext().setAccessibleName("Datos Basicos");

        pack();
    }// </editor-fold>//GEN-END:initComponents

    public void limpiar()
    {
      
       //combo_tipo.setName("");
       txtApellidos.setText("");
       
        
    }
    
    public void  bloquear_cajas()
    {
    
       //combo_tipo.setEnabled(false);
       txtApellidos.setEnabled(false);
           
       //ciudad_combo.setEnabled(false); 
       regclientejButton1.setEnabled(false);
       cancelclijButton2.setEnabled(false);
       txtDomicilio.setEnabled(false);
       this.txtCiudad.setEnabled(false);
       this.txtCodigoPostal.setEnabled(false);
       this.txtEstado.setEnabled(false);
       this.txtMunicipio.setEnabled(false);
       this.txtRFC.setEnabled(false);
       this.txtTelefono.setEnabled(false);
       
    }
    public void  desbloquear()
    {
     
       //combo_tipo.setEnabled(true);
  
       txtApellidos.setEnabled(true);
          
       //ciudad_combo.setEnabled(true); 
       txtDomicilio.setEnabled(true);
       regclientejButton1.setEnabled(true);
       cancelclijButton2.setEnabled(true);
        this.txtCiudad.setEnabled(true);
       this.txtCodigoPostal.setEnabled(true);
       this.txtEstado.setEnabled(true);
       this.txtMunicipio.setEnabled(true);
       this.txtRFC.setEnabled(true);
       this.txtTelefono.setEnabled(true);
       
       
    }
    
    private void regclientejButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_regclientejButton1ActionPerformed
    
      
        control_cliente control = new control_cliente();
        control.strApellido=this.txtApellidos.getText();
        control.strCiudad=this.txtCiudad.getText();
        control.strCodigoPostal=this.txtCodigoPostal.getText();
        control.strDomicilio=this.txtDomicilio.getText();
        control.strEstado=this.txtEstado.getText();
        control.strLugarNacimiento=this.txtLugarNacimiento.getText();
        control.strMunicipio=this.txtMunicipio.getText();
        control.strNombre=this.txtNombre1.getText();
        control.strRFC=this.txtRFC.getText();
        control.strTelefono=this.txtTelefono.getText();
        control.strFechaNacimiento=((JTextField)dteFechaNacimiento.getDateEditor().getUiComponent()).getText();
        
        //this.dteFecha1.setDateFormatString("YYYYMMDD");

       // JOptionPane.showInternalMessageDialog(rootPane,((JTextField)dteFechaNacimiento.getDateEditor().getUiComponent()).getText());
      //  JOptionPane.showInternalMessageDialog(rootPane,dteFechaNacimiento.getDateEditor());
        //JOptionPane.showInternalMessageDialog(rootPane,this.dteFechaNacimiento.getDate().getYear());
        control.ingresar_cliente();
 
               
    }//GEN-LAST:event_regclientejButton1ActionPerformed

    public void defineTablaClientes(String strBusqueda,long DesdeHoja){
        
        long lngRegistros=1;
        long lngDesdeRegistro;
      
        DefaultTableModel tablaClientes = new DefaultTableModel();
        
        String strTitulos[]={"ID CLIENTE","NOMBRE","APELLIDO","RFC"};
        tablaClientes.setColumnIdentifiers(strTitulos);
        this.JTabClientes.setModel(tablaClientes);
        lngRegistros=(Long.valueOf(this.txtNumReg.getText()));
        
        lngDesdeRegistro=(DesdeHoja*lngRegistros)-lngRegistros;
        control_cliente classCliente= new control_cliente();
        classCliente.leerClientes(lngDesdeRegistro, (Long.valueOf(this.txtNumReg.getText())),tablaClientes,strBusqueda);
        
        this.JTabClientes.setModel(tablaClientes);
        
        lngRegistros = classCliente.leerCuantos("");
        lngNumPaginas= (lngRegistros/ (Long.valueOf( this.txtNumReg.getText())))+1;
        this.jlblTotalPaginas.setText(" De " + ( lngNumPaginas));
        
        //JOptionPane.showInternalMessageDialog(rootPane,tablaClientes.getRowCount());
        
    }
    
    private void salirclijButton3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_salirclijButton3ActionPerformed
        this.dispose();
    }//GEN-LAST:event_salirclijButton3ActionPerformed

    private void cancelclijButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cancelclijButton2ActionPerformed
 
    limpiar();
    }//GEN-LAST:event_cancelclijButton2ActionPerformed

    private void txtLugarNacimientoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtLugarNacimientoActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtLugarNacimientoActionPerformed

    private void txtNombre1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtNombre1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtNombre1ActionPerformed

    private void txtApellidosActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtApellidosActionPerformed
        txtApellidos.transferFocus();
    }//GEN-LAST:event_txtApellidosActionPerformed
    //OBTIENE EL ID DEL CLIENTE Y LO PONE EN LA CAJA DE TEXTO
    private void JTabClientesMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_JTabClientesMouseClicked
        int fila;
        String[] datosCliente =new String[11];
        fila = this.JTabClientes.rowAtPoint(evt.getPoint());
        control_cliente cliente = new control_cliente();
        long lngCliente;
        
        
        
        if (fila > -1){
            this.txtIdCliente.setText(String.valueOf(JTabClientes.getValueAt(fila, 0)));
            
//            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd"); 
//            Date Fecha = new Date();
//            this.dteFechaNacimiento.setDate(Fecha);
            
            datosCliente=cliente.leerCliente( this.txtIdCliente.getText());
            
            this.txtIdCliente.setText(datosCliente[0]);
            this.txtNombre1.setText(datosCliente[1]);
            this.txtApellidos.setText(datosCliente[2]);
            this.txtDomicilio.setText(datosCliente[3]);
            this.txtCiudad.setText(datosCliente[4]);
            this.txtTelefono.setText(datosCliente[5]);
            this.txtRFC.setText(datosCliente[6]);
          
            this.dteFechaNacimiento.setDate(cliente.Fecha);

            
            this.txtEstado.setText(datosCliente[8]);
            this.txtMunicipio.setText(datosCliente[9]);
            this.txtCodigoPostal.setText(datosCliente[10]);
            this.txtLugarNacimiento.setText(datosCliente[11]);
            this.dteFechaNacimiento.setCursor(null);
            
    }//GEN-LAST:event_JTabClientesMouseClicked
    }
    private void cmdSiguiente1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdSiguiente1ActionPerformed
        long lngValor=0;
        if(lngNumPaginas>Long.valueOf( this.txtPagina.getText())){
            lngValor=Long.valueOf( this.txtPagina.getText())+1;
            this.txtPagina.setText(String.valueOf(lngValor));
            defineTablaClientes("",lngValor);
        }
    }//GEN-LAST:event_cmdSiguiente1ActionPerformed

    private void cmdAtrasActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdAtrasActionPerformed
        long lngValor=0;
        if(1<Long.valueOf( this.txtPagina.getText())){
            lngValor=Long.valueOf( this.txtPagina.getText())-1;
            this.txtPagina.setText(String.valueOf(lngValor));
            defineTablaClientes("",lngValor);
            }
    }//GEN-LAST:event_cmdAtrasActionPerformed

    private void txtIdCliente1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtIdCliente1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtIdCliente1ActionPerformed

    private void txtIdCliente1KeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtIdCliente1KeyPressed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtIdCliente1KeyPressed
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTable JTabClientes;
    private javax.swing.JPanel PanBotones;
    private javax.swing.JPanel PanTabla;
    private javax.swing.JTabbedPane TabDatos;
    private javax.swing.JButton cancelclijButton2;
    private javax.swing.JButton cmdAtras;
    private javax.swing.JButton cmdSiguiente1;
    private com.toedter.calendar.JDateChooser dteFechaNacimiento;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JLabel jlblNumReg;
    private javax.swing.JLabel jlblNumReg2;
    private javax.swing.JLabel jlblTotalPaginas;
    private javax.swing.JLabel lblBuscar;
    private javax.swing.JButton regclientejButton1;
    private javax.swing.JButton salirclijButton3;
    private javax.swing.JTextField txtApellidos;
    private javax.swing.JTextField txtCiudad;
    private javax.swing.JTextField txtCodigoPostal;
    private javax.swing.JTextField txtDomicilio;
    private javax.swing.JTextField txtEstado;
    private javax.swing.JTextField txtIdCliente;
    private javax.swing.JTextField txtIdCliente1;
    private javax.swing.JTextField txtLugarNacimiento;
    private javax.swing.JTextField txtMunicipio;
    private javax.swing.JTextField txtNombre1;
    private javax.swing.JTextField txtNumReg;
    private javax.swing.JTextField txtPagina;
    private javax.swing.JTextField txtRFC;
    private javax.swing.JTextField txtTelefono;
    // End of variables declaration//GEN-END:variables

   

}