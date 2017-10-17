
package interfaces;

import clases.classGruposUsuarios;
import clases.classUsuario;
import clasesSQLite.classUsuariosLite;
import herramientas.Reportes;
import herramientas.conexion;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.SingleSelectionModel;
import javax.swing.table.DefaultTableModel;
//import static jdk.nashorn.internal.objects.NativeString.trim;
import  herramientas.globales.*;
import static herramientas.globales.gboolTipoConexion;
import java.awt.Frame;
import java.io.File;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JRDesignQuery;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;

public final class frmUsuarios extends javax.swing.JInternalFrame {
    
    long lngNumPaginas;
    private conexion con;
    public frmUsuarios() {
        initComponents();    
        limpiar();
        this.txtNumReg.setText("5");
        defineTablaUsuarios("",1);
        this.txtIdUsuario.setEnabled(false);
      
        
     
    }

    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        TabDatos = new javax.swing.JTabbedPane();
        jPanel1 = new javax.swing.JPanel();
        lblUsuario = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        txtNombre = new javax.swing.JTextField();
        txtUsuario = new javax.swing.JTextField();
        jLabel12 = new javax.swing.JLabel();
        txtIdUsuario = new javax.swing.JTextField();
        lblIDUsuario = new javax.swing.JLabel();
        lblTipoUsuario = new javax.swing.JLabel();
        cboTipoUsuario = new javax.swing.JComboBox();
        txtContraseña = new javax.swing.JPasswordField();
        txtContraseña2 = new javax.swing.JPasswordField();
        PanTabla = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        JTabUsuarios = new javax.swing.JTable();
        PanBotones = new javax.swing.JPanel();
        btnRegUsuario = new javax.swing.JButton();
        cancelclijButton2 = new javax.swing.JButton();
        salirclijButton3 = new javax.swing.JButton();
        btnEliminar = new javax.swing.JButton();
        btnImprimirReporte = new javax.swing.JButton();
        jPanel4 = new javax.swing.JPanel();
        jlblNumReg = new javax.swing.JLabel();
        txtNumReg = new javax.swing.JTextField();
        jlblNumReg2 = new javax.swing.JLabel();
        txtPagina = new javax.swing.JTextField();
        jlblTotalPaginas = new javax.swing.JLabel();
        cmdAtras = new javax.swing.JButton();
        cmdSiguiente1 = new javax.swing.JButton();
        txtBuscar = new javax.swing.JTextField();
        lblBuscar = new javax.swing.JLabel();
        cmdBuscar = new javax.swing.JButton();

        setIconifiable(true);
        setMaximizable(true);
        setResizable(true);
        setTitle("Registro de usuarios");
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

        lblUsuario.setText("Usuario:");

        jLabel3.setText("Nombre:");

        txtNombre.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtNombreActionPerformed(evt);
            }
        });

        txtUsuario.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtUsuarioActionPerformed(evt);
            }
        });

        jLabel12.setText("Contraseña:");

        lblIDUsuario.setText("ID Usuario:");

        lblTipoUsuario.setText("Tipo Usuario:");

        cboTipoUsuario.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "Item 1", "Item 2", "Item 3", "Item 4" }));
        cboTipoUsuario.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cboTipoUsuarioActionPerformed(evt);
            }
        });

        txtContraseña.setText("jPasswordField1");

        txtContraseña2.setText("jPasswordField1");

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGap(13, 13, 13)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel3)
                    .addComponent(lblUsuario)
                    .addComponent(jLabel12)
                    .addComponent(lblTipoUsuario)
                    .addComponent(lblIDUsuario))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(txtNombre, javax.swing.GroupLayout.DEFAULT_SIZE, 256, Short.MAX_VALUE)
                    .addComponent(txtUsuario)
                    .addComponent(cboTipoUsuario, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(txtIdUsuario, javax.swing.GroupLayout.DEFAULT_SIZE, 256, Short.MAX_VALUE)
                    .addComponent(txtContraseña)
                    .addComponent(txtContraseña2))
                .addContainerGap(37, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblUsuario)
                    .addComponent(txtUsuario, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtNombre, javax.swing.GroupLayout.PREFERRED_SIZE, 19, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel3))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel12)
                    .addComponent(txtContraseña, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(7, 7, 7)
                .addComponent(txtContraseña2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblTipoUsuario)
                    .addComponent(cboTipoUsuario, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblIDUsuario)
                    .addComponent(txtIdUsuario, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(202, Short.MAX_VALUE))
        );

        TabDatos.addTab("Basicos", jPanel1);

        getContentPane().add(TabDatos, new org.netbeans.lib.awtextra.AbsoluteConstraints(419, 0, -1, 432));
        TabDatos.getAccessibleContext().setAccessibleName("Datos Basicos");

        JTabUsuarios.setModel(new javax.swing.table.DefaultTableModel(
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
        JTabUsuarios.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                JTabUsuariosMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(JTabUsuarios);

        javax.swing.GroupLayout PanTablaLayout = new javax.swing.GroupLayout(PanTabla);
        PanTabla.setLayout(PanTablaLayout);
        PanTablaLayout.setHorizontalGroup(
            PanTablaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 403, javax.swing.GroupLayout.PREFERRED_SIZE)
        );
        PanTablaLayout.setVerticalGroup(
            PanTablaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        );

        getContentPane().add(PanTabla, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 11, -1, -1));

        btnRegUsuario.setFont(new java.awt.Font("Tahoma", 0, 1)); // NOI18N
        btnRegUsuario.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/floppy_disk_save-128.png"))); // NOI18N
        btnRegUsuario.setText("Registrar");
        btnRegUsuario.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnRegUsuarioActionPerformed(evt);
            }
        });

        cancelclijButton2.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/NUEVO.png"))); // NOI18N
        cancelclijButton2.setText("");
        cancelclijButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cancelclijButton2ActionPerformed(evt);
            }
        });

        salirclijButton3.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/cerrar.png"))); // NOI18N
        salirclijButton3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                salirclijButton3ActionPerformed(evt);
            }
        });

        btnEliminar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/eliminar.png"))); // NOI18N
        btnEliminar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnEliminarActionPerformed(evt);
            }
        });

        btnImprimirReporte.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/imprimir.png"))); // NOI18N
        btnImprimirReporte.setActionCommand("");
        btnImprimirReporte.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnImprimirReporteActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout PanBotonesLayout = new javax.swing.GroupLayout(PanBotones);
        PanBotones.setLayout(PanBotonesLayout);
        PanBotonesLayout.setHorizontalGroup(
            PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanBotonesLayout.createSequentialGroup()
                .addGroup(PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(btnImprimirReporte, javax.swing.GroupLayout.PREFERRED_SIZE, 72, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnRegUsuario, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(42, 42, 42)
                .addComponent(cancelclijButton2, javax.swing.GroupLayout.PREFERRED_SIZE, 63, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(btnEliminar, javax.swing.GroupLayout.PREFERRED_SIZE, 66, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(salirclijButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(20, 20, 20))
        );
        PanBotonesLayout.setVerticalGroup(
            PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanBotonesLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(btnRegUsuario, javax.swing.GroupLayout.PREFERRED_SIZE, 61, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                        .addComponent(salirclijButton3, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                        .addComponent(btnEliminar, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                        .addComponent(cancelclijButton2, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addGap(18, 18, 18)
                .addComponent(btnImprimirReporte, javax.swing.GroupLayout.PREFERRED_SIZE, 66, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        getContentPane().add(PanBotones, new org.netbeans.lib.awtextra.AbsoluteConstraints(419, 438, 384, -1));

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

        txtBuscar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtBuscarActionPerformed(evt);
            }
        });
        txtBuscar.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                txtBuscarKeyPressed(evt);
            }
        });

        lblBuscar.setText("Buscar");

        cmdBuscar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/Search.png"))); // NOI18N
        cmdBuscar.setText("Buscar");
        cmdBuscar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdBuscarActionPerformed(evt);
            }
        });

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
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(cmdSiguiente1))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGap(4, 4, 4)
                        .addComponent(lblBuscar)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(txtBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, 168, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(cmdBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, 131, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
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
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cmdBuscar)
                    .addComponent(txtBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(lblBuscar))
                .addContainerGap(65, Short.MAX_VALUE))
        );

        getContentPane().add(jPanel4, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 444, 403, -1));

        pack();
    }// </editor-fold>//GEN-END:initComponents

    public void limpiar()
    {
        
        this.btnRegUsuario.setLabel("Registrar");
        this.txtIdUsuario.setText("");
        this.txtContraseña.setText("");
        this.txtContraseña2.setText("");
        this.txtUsuario.setText("");
        this.cboTipoUsuario.setSelectedItem(null);
        this.cboTipoUsuario.removeAllItems();
        classGruposUsuarios Grupos =new classGruposUsuarios();
        Grupos.llenarCombo(this.cboTipoUsuario);
        this.btnEliminar.setVisible(false);
        this.txtNombre.setText("");
        
        
    }
    
   
   
    
    private void btnRegUsuarioActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnRegUsuarioActionPerformed
    
        String strPass1="";
        String strPass2="";
        
        strPass1=txtContraseña.getText();
        strPass2=txtContraseña2.getText();
        
        if (strPass1.equals(strPass2)){
        } else {
            JOptionPane.showInternalMessageDialog(rootPane,"Las contraseñas no coinciden");
            return;
        }
        if (this.btnRegUsuario.getLabel()=="Registrar"){            
            classUsuario Usuario = new classUsuario();
            Usuario.strUsuario=this.txtUsuario.getText();
            Usuario.strContraseña=this.txtContraseña.getText();
            Usuario.strNombre=this.txtNombre.getText();
            Usuario.strGrupoUsuario=(this.cboTipoUsuario.getSelectedItem().toString().substring(0, 4).toString());
            Usuario.ingresar_usuario();
            JOptionPane.showInternalMessageDialog(rootPane,"Registrado Correctamente");
            defineTablaUsuarios("",1);
            limpiar();
        }
        else{
            String strRespuesta="";
            classUsuario Usuario = new classUsuario();
            Usuario.strUsuario=this.txtUsuario.getText();
            Usuario.strContraseña=this.txtContraseña.getText();
            Usuario.strNombre=this.txtNombre.getText();
            Usuario.strGrupoUsuario=( this.cboTipoUsuario.getSelectedItem().toString().substring(0, 4));
            Usuario.lngIDUsuario=Long.valueOf(this.txtIdUsuario.getText());
            
            strRespuesta= herramientas.globales.strPreguntaSiNo("Desea actualizar el usuario");
            
            if (strRespuesta=="SI"){
                Usuario.actualizar_usuario();
                JOptionPane.showInternalMessageDialog(rootPane,"Actualizado Correctamente");
                defineTablaUsuarios("",1);
                limpiar();
            }
            else{
                JOptionPane.showInternalMessageDialog(rootPane,"Operación cancelada");
            }
                
        }
    }//GEN-LAST:event_btnRegUsuarioActionPerformed

    public void defineTablaUsuarios(String strBusqueda,long DesdeHoja){
        
        long lngRegistros=1;
        long lngDesdeRegistro;
        
        //DEFINIMOS LA TABLA MODELO
        DefaultTableModel tablaUsuarios = new DefaultTableModel();
        
        //LE AGREGAMOS EL TITULO DE LAS COLUMNAS DE LA TABLA EN UN ARREGLO
        String strTitulos[]={"ID USUARIO","USUARIO","CONTRA","GRUPO","NOMBRE"};
        
        //LE ASIGNAMOS LAS COLUMNAS AL MODELO CON LA CADENA DE ARRIBA
        tablaUsuarios.setColumnIdentifiers(strTitulos);
        
        //LE ASIGNAMOS EL MODELO DE ARRIBA AL JTABLE 
        this.JTabUsuarios.setModel(tablaUsuarios);
        
                    //AHORA A LEER LOS DATOS
        
        //ASIGNAMOS CUANTOS REGISTROS POR HOJA TRAEREMOS
        lngRegistros=(Long.valueOf(this.txtNumReg.getText()));
        
        //ASIGNAMOS DESDE QUE REGISTRO TRAERA LA CONSULTA SQL
        lngDesdeRegistro=(DesdeHoja*lngRegistros)-lngRegistros;
        
        //INSTANCEAMOS LA CLASE CLIENTE
        if (gboolTipoConexion=true){
            classUsuariosLite classUsuarioL= new classUsuariosLite();
            classUsuarioL.leerUsuarios(lngDesdeRegistro, (Long.valueOf(this.txtNumReg.getText())),tablaUsuarios,strBusqueda);
        }
        else{
            classUsuario classUsuario= new classUsuario();
            classUsuario.leerUsuarios(lngDesdeRegistro, (Long.valueOf(this.txtNumReg.getText())),tablaUsuarios,strBusqueda);
            lngRegistros = classUsuario.leerCuantos("");
        }
        //LEEMOS LA CLASE CLIENTE MANDANDOLE LOS PARAMETROS
        
        
        
        //LE PONEMOS EL RESULTADO DE LA CONSULA AL JTABLE
        this.JTabUsuarios.setModel(tablaUsuarios);
        
        //ASIGNAMOS LOS VALORES A LA PAGINACION
        
        lngNumPaginas= (lngRegistros/ (Long.valueOf( this.txtNumReg.getText())))+1;
        this.jlblTotalPaginas.setText(" De " + ( lngNumPaginas));
        
    }
    
    private void salirclijButton3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_salirclijButton3ActionPerformed
        this.dispose();
    }//GEN-LAST:event_salirclijButton3ActionPerformed

    private void cancelclijButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cancelclijButton2ActionPerformed
 
    limpiar();
    }//GEN-LAST:event_cancelclijButton2ActionPerformed
    //OBTIENE EL ID DEL CLIENTE Y LO PONE EN LA CAJA DE TEXTO
    private void JTabUsuariosMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_JTabUsuariosMouseClicked
        int fila;
        String[] datosUsuario =new String[11];
        fila = this.JTabUsuarios.rowAtPoint(evt.getPoint());
        classUsuario usuario = new classUsuario();
        classUsuariosLite UsuarioLite=new classUsuariosLite();
        long lngUsuario;
        
        if (fila > -1){
            this.txtIdUsuario.setText(String.valueOf(JTabUsuarios.getValueAt(fila, 0)));
            this.txtUsuario.setText(String.valueOf(JTabUsuarios.getValueAt(fila, 1)));

            if (gboolTipoConexion==true){
                datosUsuario=UsuarioLite.leerUsuario( this.txtUsuario.getText());
            }
            else{
              datosUsuario=usuario.leerUsuario( this.txtUsuario.getText());
            datosUsuario=usuario.leerUsuario( this.txtUsuario.getText());
            }
            this.txtIdUsuario.setText(datosUsuario[0]);
            this.txtUsuario.setText(datosUsuario[1]);
            this.txtContraseña.setText(datosUsuario[2]);
            this.txtContraseña2.setText(datosUsuario[2]);
            this.cboTipoUsuario.setSelectedItem(datosUsuario[3]);
            this.txtNombre.setText(datosUsuario[4]);
            
            this.btnEliminar.setVisible(true);
            
            if(Long.valueOf( datosUsuario[0])>0){
                this.btnRegUsuario.setLabel("Actualizar");
            }
            
    }//GEN-LAST:event_JTabUsuariosMouseClicked
    }
    private void cmdSiguiente1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdSiguiente1ActionPerformed
        long lngValor=0;
        if(lngNumPaginas>Long.valueOf( this.txtPagina.getText())){
            lngValor=Long.valueOf( this.txtPagina.getText())+1;
            this.txtPagina.setText(String.valueOf(lngValor));
            defineTablaUsuarios("",lngValor);
        }
    }//GEN-LAST:event_cmdSiguiente1ActionPerformed

    private void cmdAtrasActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdAtrasActionPerformed
        long lngValor=0;
        if(1<Long.valueOf( this.txtPagina.getText())){
            lngValor=Long.valueOf( this.txtPagina.getText())-1;
            this.txtPagina.setText(String.valueOf(lngValor));
            defineTablaUsuarios("",lngValor);
            }
    }//GEN-LAST:event_cmdAtrasActionPerformed

    private void txtBuscarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtBuscarActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtBuscarActionPerformed

    private void txtBuscarKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtBuscarKeyPressed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtBuscarKeyPressed

    private void cmdBuscarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdBuscarActionPerformed
        defineTablaUsuarios(this.txtBuscar.getText(),Long.valueOf(this.txtPagina.getText()));
    }//GEN-LAST:event_cmdBuscarActionPerformed

    private void btnEliminarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnEliminarActionPerformed
        classUsuario usuario = new classUsuario();
        usuario.strUsuario=this.txtUsuario.getText();
        String strRespuesta="";

        strRespuesta=herramientas.globales.strPreguntaSiNo("¿Desea eliminar el usuario?");
        if (strRespuesta=="SI"){
            usuario.eliminar_usuario();
            defineTablaUsuarios(this.txtBuscar.getText(),Long.valueOf(this.txtPagina.getText()));
            JOptionPane.showInternalMessageDialog(rootPane,"Eliminado Correctamente");
        }
        else
        {
            JOptionPane.showInternalMessageDialog(rootPane,"Operacion Cancelada");
        }
    }//GEN-LAST:event_btnEliminarActionPerformed

    private void btnImprimirReporteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnImprimirReporteActionPerformed
            int intDesde,intCuantos;
            Long lngDesdeRegistro,lngRegistros,DesdeHoja;
            String strBusqueda,strConsulta;
            
            lngDesdeRegistro=Long.valueOf(this.txtNumReg.getText());
            lngRegistros=Long.valueOf(this.txtNumReg.getText());
            DesdeHoja=Long.valueOf(this.txtPagina.getText());
            
            lngDesdeRegistro=(DesdeHoja*lngRegistros)-lngRegistros;
            strConsulta="call PA_LeeUsuarios("+lngDesdeRegistro.toString()+","+this.txtNumReg.getText()+",'"+this.txtBuscar.getText()+"')";
            System.out.println(strConsulta);
            Reportes.lanzarReporte(strConsulta, "repUsuarios");
    }//GEN-LAST:event_btnImprimirReporteActionPerformed

    private void txtUsuarioActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtUsuarioActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtUsuarioActionPerformed

    private void txtNombreActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtNombreActionPerformed
        txtUsuario.transferFocus();
    }//GEN-LAST:event_txtNombreActionPerformed

    private void cboTipoUsuarioActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cboTipoUsuarioActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_cboTipoUsuarioActionPerformed
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTable JTabUsuarios;
    private javax.swing.JPanel PanBotones;
    private javax.swing.JPanel PanTabla;
    private javax.swing.JTabbedPane TabDatos;
    private javax.swing.JButton btnEliminar;
    private javax.swing.JButton btnImprimirReporte;
    private javax.swing.JButton btnRegUsuario;
    private javax.swing.JButton cancelclijButton2;
    private javax.swing.JComboBox cboTipoUsuario;
    private javax.swing.JButton cmdAtras;
    private javax.swing.JButton cmdBuscar;
    private javax.swing.JButton cmdSiguiente1;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JLabel jlblNumReg;
    private javax.swing.JLabel jlblNumReg2;
    private javax.swing.JLabel jlblTotalPaginas;
    private javax.swing.JLabel lblBuscar;
    private javax.swing.JLabel lblIDUsuario;
    private javax.swing.JLabel lblTipoUsuario;
    private javax.swing.JLabel lblUsuario;
    private javax.swing.JButton salirclijButton3;
    private javax.swing.JTextField txtBuscar;
    private javax.swing.JPasswordField txtContraseña;
    private javax.swing.JPasswordField txtContraseña2;
    private javax.swing.JTextField txtIdUsuario;
    private javax.swing.JTextField txtNombre;
    private javax.swing.JTextField txtNumReg;
    private javax.swing.JTextField txtPagina;
    private javax.swing.JTextField txtUsuario;
    // End of variables declaration//GEN-END:variables

     public void mostrarReporte()throws Exception{        
        JasperReport report= JasperCompileManager.compileReport(System.getProperty("user.dir").concat("/src/reportes/usuarios.jrxml"));
        JasperPrint print= JasperFillManager.fillReport(report, null,herramientas.conexion.conexion);
        JasperViewer view=new JasperViewer(print,false);
        view.setTitle("Mi primer repòrte");
        view.setExtendedState(Frame.MAXIMIZED_BOTH);
        view.setVisible(true);
    }
     
    public void runReporte(String strConsulta ,String strReporte)
            {
                con = new conexion();
                try
                {  

                    String fileName = System.getProperty("user.dir").concat("/src/reportes/"+strReporte+".jrxml");
                   

                  

                   
                   
                File theFile = new File(fileName);
                if (theFile.exists()==false){
                    JOptionPane.showInternalMessageDialog(rootPane,"No se encontro el reporte en el directorio");
                    System.exit(2);
                }
                    
                JRDesignQuery newQuery = new JRDesignQuery();
                JasperDesign jasperDesign = JRXmlLoader.load(theFile);
                newQuery.setText(strConsulta);
                jasperDesign.setQuery(newQuery);
               
                 JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
                 JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, con.conectado());
                 JasperViewer jviewer = new JasperViewer(jasperPrint,false);
                 jviewer.setTitle("Sistema de gestión de Cartera");
                 jviewer.setVisible(true);
                   
                }

                catch (Exception j)
                {
                    System.out.println("Mensaje de Error:"+j.getMessage());
                }
               
            }

}