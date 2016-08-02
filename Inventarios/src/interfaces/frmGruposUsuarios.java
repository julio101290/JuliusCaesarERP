/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interfaces;

import clases.classGruposUsuarios;
import herramientas.Reportes;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;


/**
 *
 * @author julio
 */
public class frmGruposUsuarios extends javax.swing.JInternalFrame {

    /**
     * Creates new form frmGruposUsuarios
     */
    long lngNumPaginas=0;
    public frmGruposUsuarios() {
        initComponents();
        limpiar();
        defineTablaUsuarios("",1);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jpanTabla = new javax.swing.JPanel();
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
        jPanDatos = new javax.swing.JPanel();
        jTabbedPane1 = new javax.swing.JTabbedPane();
        jPanel1 = new javax.swing.JPanel();
        lblDescripcion = new javax.swing.JLabel();
        txtDescripcion = new javax.swing.JTextField();
        jLabel1 = new javax.swing.JLabel();
        txtIDGrupo = new javax.swing.JTextField();
        jPanel2 = new javax.swing.JPanel();
        chkPermiteABCConfiguracion = new javax.swing.JCheckBox();
        chkPermiteABCGrupos = new javax.swing.JCheckBox();
        chkPermiteABCUsuarios = new javax.swing.JCheckBox();
        chkPermiteABCClientes = new javax.swing.JCheckBox();
        chkPermiteABCArticulos = new javax.swing.JCheckBox();
        chkPermiteABCEntradasSalidas = new javax.swing.JCheckBox();
        PanBotones = new javax.swing.JPanel();
        btnEliminar = new javax.swing.JButton();
        btnImprimirReporte = new javax.swing.JButton();
        btnRegCliente = new javax.swing.JButton();
        btnNuevo = new javax.swing.JButton();
        salirclijButton3 = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        JTabGrupos = new javax.swing.JTable();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setIconifiable(true);
        setMaximizable(true);
        setTitle("Registro de grupos de usuarios");
        getContentPane().setLayout(new org.netbeans.lib.awtextra.AbsoluteLayout());

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
                        .addComponent(lblBuscar)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(txtBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, 168, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(cmdBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, 103, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap(21, Short.MAX_VALUE)
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
                    .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(txtBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(lblBuscar)))
                .addGap(47, 47, 47))
        );

        javax.swing.GroupLayout jpanTablaLayout = new javax.swing.GroupLayout(jpanTabla);
        jpanTabla.setLayout(jpanTablaLayout);
        jpanTablaLayout.setHorizontalGroup(
            jpanTablaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jpanTablaLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel4, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );
        jpanTablaLayout.setVerticalGroup(
            jpanTablaLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jpanTablaLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(65, Short.MAX_VALUE))
        );

        getContentPane().add(jpanTabla, new org.netbeans.lib.awtextra.AbsoluteConstraints(10, 214, -1, -1));

        lblDescripcion.setText("Descripcion:");

        jLabel1.setText("ID Grupo:");

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(lblDescripcion)
                    .addComponent(jLabel1))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(txtDescripcion, javax.swing.GroupLayout.DEFAULT_SIZE, 152, Short.MAX_VALUE)
                    .addComponent(txtIDGrupo))
                .addContainerGap(264, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblDescripcion)
                    .addComponent(txtDescripcion, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(txtIDGrupo, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(135, Short.MAX_VALUE))
        );

        jTabbedPane1.addTab("Datos Grupo", jPanel1);

        chkPermiteABCConfiguracion.setText("Permite Acceso Configuracion");

        chkPermiteABCGrupos.setText("Permite Acceso Grupos");

        chkPermiteABCUsuarios.setText("Permite Acceso Usuarios");

        chkPermiteABCClientes.setText("Permite Acceso Clientes");

        chkPermiteABCArticulos.setText("Permite Acceso Articulos");

        chkPermiteABCEntradasSalidas.setText("Permite Dar Entrada y Salida a Inventario");
        chkPermiteABCEntradasSalidas.setToolTipText("");

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(chkPermiteABCConfiguracion)
                        .addGap(90, 90, 90)
                        .addComponent(chkPermiteABCEntradasSalidas))
                    .addComponent(chkPermiteABCGrupos)
                    .addComponent(chkPermiteABCUsuarios)
                    .addComponent(chkPermiteABCClientes)
                    .addComponent(chkPermiteABCArticulos))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(chkPermiteABCConfiguracion)
                    .addComponent(chkPermiteABCEntradasSalidas))
                .addGap(18, 18, 18)
                .addComponent(chkPermiteABCGrupos)
                .addGap(18, 18, 18)
                .addComponent(chkPermiteABCUsuarios)
                .addGap(18, 18, 18)
                .addComponent(chkPermiteABCClientes)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 14, Short.MAX_VALUE)
                .addComponent(chkPermiteABCArticulos)
                .addContainerGap())
        );

        jTabbedPane1.addTab("Derechos", jPanel2);

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

        btnRegCliente.setFont(new java.awt.Font("Tahoma", 0, 1)); // NOI18N
        btnRegCliente.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/floppy_disk_save-128.png"))); // NOI18N
        btnRegCliente.setText("Registrar");
        btnRegCliente.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnRegClienteActionPerformed(evt);
            }
        });

        btnNuevo.setFont(new java.awt.Font("Tahoma", 0, 1)); // NOI18N
        btnNuevo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/NUEVO.png"))); // NOI18N
        btnNuevo.setText("");
        btnNuevo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnNuevoActionPerformed(evt);
            }
        });

        salirclijButton3.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/cerrar.png"))); // NOI18N
        salirclijButton3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                salirclijButton3ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout PanBotonesLayout = new javax.swing.GroupLayout(PanBotones);
        PanBotones.setLayout(PanBotonesLayout);
        PanBotonesLayout.setHorizontalGroup(
            PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, PanBotonesLayout.createSequentialGroup()
                .addGap(25, 25, 25)
                .addGroup(PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(salirclijButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                    .addComponent(btnNuevo, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                    .addComponent(btnRegCliente, javax.swing.GroupLayout.PREFERRED_SIZE, 68, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(96, 96, 96)
                .addGroup(PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(btnEliminar, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnImprimirReporte, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        PanBotonesLayout.setVerticalGroup(
            PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, PanBotonesLayout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(btnRegCliente, javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(btnEliminar, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 68, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(btnNuevo)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(btnImprimirReporte, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                    .addComponent(salirclijButton3, javax.swing.GroupLayout.PREFERRED_SIZE, 62, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );

        javax.swing.GroupLayout jPanDatosLayout = new javax.swing.GroupLayout(jPanDatos);
        jPanDatos.setLayout(jPanDatosLayout);
        jPanDatosLayout.setHorizontalGroup(
            jPanDatosLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanDatosLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanDatosLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jTabbedPane1)
                    .addComponent(PanBotones, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanDatosLayout.setVerticalGroup(
            jPanDatosLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanDatosLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jTabbedPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 225, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(PanBotones, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        getContentPane().add(jPanDatos, new org.netbeans.lib.awtextra.AbsoluteConstraints(391, 11, -1, -1));

        JTabGrupos.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Title 1", "Title 2"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Long.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, true
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        JTabGrupos.setAutoResizeMode(javax.swing.JTable.AUTO_RESIZE_OFF);
        JTabGrupos.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                JTabGruposMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(JTabGrupos);
        if (JTabGrupos.getColumnModel().getColumnCount() > 0) {
            JTabGrupos.getColumnModel().getColumn(0).setMinWidth(50);
            JTabGrupos.getColumnModel().getColumn(0).setPreferredWidth(50);
            JTabGrupos.getColumnModel().getColumn(0).setMaxWidth(50);
            JTabGrupos.getColumnModel().getColumn(1).setMinWidth(300);
            JTabGrupos.getColumnModel().getColumn(1).setPreferredWidth(300);
        }

        getContentPane().add(jScrollPane1, new org.netbeans.lib.awtextra.AbsoluteConstraints(19, 11, 354, 197));

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void JTabGruposMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_JTabGruposMouseClicked
            int fila;
        String[] datosGrupo =new String[1];
        fila = this.JTabGrupos.rowAtPoint(evt.getPoint());
        classGruposUsuarios grupos = new classGruposUsuarios();
        long lngCliente;
        
        if (fila > -1){
            this.txtIDGrupo.setText(String.valueOf(this.JTabGrupos.getValueAt(fila, 0)));
            
//            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd"); 
//            Date Fecha = new Date();
//            this.dteFechaNacimiento.setDate(Fecha);
            
            datosGrupo=grupos.leerGrupo(this.txtIDGrupo.getText());
            
            this.txtIDGrupo.setText(datosGrupo[0]);
            this.txtDescripcion.setText(datosGrupo[1]);
            this.chkPermiteABCConfiguracion.setSelected(grupos.blnAccesoConfiguracion);
            this.chkPermiteABCGrupos.setSelected(grupos.blnAccesoGrupos);
            this.chkPermiteABCUsuarios.setSelected(grupos.blnAccesoUsuarios);
            this.chkPermiteABCClientes.setSelected(grupos.blnAccesoClientes);
            this.chkPermiteABCArticulos.setSelected(grupos.blnAccesoArticulos);
            this.chkPermiteABCEntradasSalidas.setSelected(grupos.blnAccesoInventarios);
            
            this.btnEliminar.setVisible(true);
            this.btnNuevo.setVisible(true);
            
            if(Long.valueOf( datosGrupo[0])>0){
                this.btnRegCliente.setLabel("Actualizar");
            }
            
    }
    }//GEN-LAST:event_JTabGruposMouseClicked

    private void cmdAtrasActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdAtrasActionPerformed
long lngValor=0;
        if(1<Long.valueOf( this.txtPagina.getText())){
            lngValor=Long.valueOf( this.txtPagina.getText())-1;
            this.txtPagina.setText(String.valueOf(lngValor));
            defineTablaUsuarios("",lngValor);
            }    }//GEN-LAST:event_cmdAtrasActionPerformed

    private void cmdSiguiente1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdSiguiente1ActionPerformed
        long lngValor=0;
      
        if(lngNumPaginas>Long.valueOf( this.txtPagina.getText())){
            lngValor=Long.valueOf( this.txtPagina.getText())+1;
            this.txtPagina.setText(String.valueOf(lngValor));
            defineTablaUsuarios("",lngValor);
        }
   
    }//GEN-LAST:event_cmdSiguiente1ActionPerformed

    private void txtBuscarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtBuscarActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtBuscarActionPerformed

    private void txtBuscarKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtBuscarKeyPressed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtBuscarKeyPressed

    private void cmdBuscarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdBuscarActionPerformed
        defineTablaUsuarios(this.txtBuscar.getText(),Long.valueOf(this.txtPagina.getText()));
    }//GEN-LAST:event_cmdBuscarActionPerformed

    private void btnImprimirReporteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnImprimirReporteActionPerformed
        int intDesde,intCuantos;
        Long lngDesdeRegistro,lngRegistros,DesdeHoja;
        String strBusqueda,strConsulta;
            
        lngDesdeRegistro=Long.valueOf(this.txtNumReg.getText());
        lngRegistros=Long.valueOf(this.txtNumReg.getText());
        DesdeHoja=Long.valueOf(this.txtPagina.getText());
            
        lngDesdeRegistro=(DesdeHoja*lngRegistros)-lngRegistros;
        strConsulta="call PA_LeeGruposUsuarios ("+lngDesdeRegistro.toString()+","+this.txtNumReg.getText()+",'"+this.txtBuscar.getText()+"')";
        System.out.println(strConsulta);
        Reportes.lanzarReporte(strConsulta, "repGruposUsuarios");    
    }//GEN-LAST:event_btnImprimirReporteActionPerformed

    private void btnRegClienteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnRegClienteActionPerformed

        if (this.btnRegCliente.getLabel()=="Registrar"){
                classGruposUsuarios grupos = new classGruposUsuarios();
                String strRespuesta="";

                
                
                grupos.strDescripcion=this.txtDescripcion.getText();
                grupos.blnAccesoConfiguracion=this.chkPermiteABCConfiguracion.isSelected();
                grupos.blnAccesoGrupos=this.chkPermiteABCGrupos.isSelected();
                grupos.blnAccesoUsuarios=this.chkPermiteABCUsuarios.isSelected();
                grupos.blnAccesoClientes=this.chkPermiteABCClientes.isSelected();
                grupos.blnAccesoArticulos=this.chkPermiteABCArticulos.isSelected();
                grupos.blnAccesoInventarios=this.chkPermiteABCEntradasSalidas.isSelected();
                
             
                    try {
                        grupos.ingresarGrupo();
                        defineTablaUsuarios("",1);
                        limpiar();
                        JOptionPane.showInternalMessageDialog(rootPane,"Registrado Correctamente");
                    } catch (SQLException ex) {
                        Logger.getLogger(frmGruposUsuarios.class.getName()).log(Level.SEVERE, null, ex);
                    }
                
                    
                }
              
        else{
            classGruposUsuarios grupos =new classGruposUsuarios();
            grupos.lngIDGrupo=Long.valueOf(this.txtIDGrupo.getText());
            grupos.strDescripcion=this.txtDescripcion.getText();
          
            grupos.blnAccesoConfiguracion=this.chkPermiteABCConfiguracion.isSelected();
            grupos.blnAccesoGrupos=this.chkPermiteABCGrupos.isSelected();
            grupos.blnAccesoUsuarios=this.chkPermiteABCUsuarios.isSelected();
            grupos.blnAccesoClientes=this.chkPermiteABCClientes.isSelected();
            grupos.blnAccesoArticulos=this.chkPermiteABCArticulos.isSelected();
            grupos.blnAccesoInventarios=this.chkPermiteABCEntradasSalidas.isSelected();
            try {
                grupos.actualizarGrupo();
                this.defineTablaUsuarios(this.txtBuscar.getText(), Long.valueOf( this.txtPagina.getText()));
                JOptionPane.showInternalMessageDialog(rootPane,"Actualizado Correctamente");
            } catch (SQLException ex) {
                Logger.getLogger(frmGruposUsuarios.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }//GEN-LAST:event_btnRegClienteActionPerformed

    private void btnNuevoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnNuevoActionPerformed
        limpiar();
    }//GEN-LAST:event_btnNuevoActionPerformed

    private void salirclijButton3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_salirclijButton3ActionPerformed
        this.dispose();
    }//GEN-LAST:event_salirclijButton3ActionPerformed

    private void btnEliminarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnEliminarActionPerformed
        classGruposUsuarios grupos = new classGruposUsuarios();
        grupos.lngIDGrupo=Long.valueOf(this.txtIDGrupo.getText());
        try {
            grupos.eliminarGrupo();
            defineTablaUsuarios("",1);
            JOptionPane.showInternalMessageDialog(rootPane,"Eliminado Correctamente");
        } catch (SQLException ex) {
            Logger.getLogger(frmGruposUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
    }//GEN-LAST:event_btnEliminarActionPerformed

    public void limpiar(){
        this.btnEliminar.setVisible(false);
        this.btnNuevo.setVisible(false);
        this.txtDescripcion.setText("");
        this.txtBuscar.setText("");
        this.txtIDGrupo.setEnabled(false);
        this.btnRegCliente.setLabel("Registrar");
        this.chkPermiteABCConfiguracion.setSelected(false);
        this.chkPermiteABCGrupos.setSelected(false);
        this.chkPermiteABCUsuarios.setSelected(false);
        this.chkPermiteABCClientes.setSelected(false);
        this.chkPermiteABCArticulos.setSelected(false);
        this.chkPermiteABCEntradasSalidas.setSelected(false);
        
    }
   
    public void defineTablaUsuarios(String strBusqueda,long DesdeHoja){
        
        long lngRegistros=1;
        long lngDesdeRegistro;
        
        
        //DEFINIMOS LA TABLA MODELO
        DefaultTableModel tablaGrupos = new DefaultTableModel();
        
        //LE AGREGAMOS EL TITULO DE LAS COLUMNAS DE LA TABLA EN UN ARREGLO
        String strTitulos[]={"ID PAIS","NOMBRE"};
        
        //LE ASIGNAMOS LAS COLUMNAS AL MODELO CON LA CADENA DE ARRIBA
        tablaGrupos.setColumnIdentifiers(strTitulos);
        
        
       
        
        //LE ASIGNAMOS EL MODELO DE ARRIBA AL JTABLE 
        this.JTabGrupos.setModel(tablaGrupos);
        
                    //AHORA A LEER LOS DATOS
        
        //ASIGNAMOS CUANTOS REGISTROS POR HOJA TRAEREMOS
        lngRegistros=(Long.valueOf(this.txtNumReg.getText()));
        
        //ASIGNAMOS DESDE QUE REGISTRO TRAERA LA CONSULTA SQL
        lngDesdeRegistro=(DesdeHoja*lngRegistros)-lngRegistros;
        
        //INSTANCEAMOS LA CLASE CLIENTE
        classGruposUsuarios classGruposUsuarios= new classGruposUsuarios();
        
        //LEEMOS LA CLASE CLIENTE MANDANDOLE LOS PARAMETROS
        classGruposUsuarios.leerGrupos(lngDesdeRegistro, (Long.valueOf(this.txtNumReg.getText())),tablaGrupos,strBusqueda);
        
        //LE PONEMOS EL RESULTADO DE LA CONSULA AL JTABLE
        this.JTabGrupos.setModel(tablaGrupos);
        
        //ASIGNAMOS LOS VALORES A LA PAGINACION
        lngRegistros = classGruposUsuarios.leerCuantos("");
        lngNumPaginas= (lngRegistros/ (Long.valueOf( this.txtNumReg.getText())))+1;
        this.jlblTotalPaginas.setText(" De " + ( lngNumPaginas));
        
         //TAMAÑO A LAS COLUMNAS
        JTabGrupos.getColumnModel().getColumn(0).setPreferredWidth(70);
        JTabGrupos.getColumnModel().getColumn(1).setPreferredWidth(300);
        
    }
    
    
    /**
     * @param args the command line arguments
     */
    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTable JTabGrupos;
    private javax.swing.JPanel PanBotones;
    private javax.swing.JButton btnEliminar;
    private javax.swing.JButton btnImprimirReporte;
    private javax.swing.JButton btnNuevo;
    private javax.swing.JButton btnRegCliente;
    private javax.swing.JCheckBox chkPermiteABCArticulos;
    private javax.swing.JCheckBox chkPermiteABCClientes;
    private javax.swing.JCheckBox chkPermiteABCConfiguracion;
    private javax.swing.JCheckBox chkPermiteABCEntradasSalidas;
    private javax.swing.JCheckBox chkPermiteABCGrupos;
    private javax.swing.JCheckBox chkPermiteABCUsuarios;
    private javax.swing.JButton cmdAtras;
    private javax.swing.JButton cmdBuscar;
    private javax.swing.JButton cmdSiguiente1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanDatos;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTabbedPane jTabbedPane1;
    private javax.swing.JLabel jlblNumReg;
    private javax.swing.JLabel jlblNumReg2;
    private javax.swing.JLabel jlblTotalPaginas;
    private javax.swing.JPanel jpanTabla;
    private javax.swing.JLabel lblBuscar;
    private javax.swing.JLabel lblDescripcion;
    private javax.swing.JButton salirclijButton3;
    private javax.swing.JTextField txtBuscar;
    private javax.swing.JTextField txtDescripcion;
    private javax.swing.JTextField txtIDGrupo;
    private javax.swing.JTextField txtNumReg;
    private javax.swing.JTextField txtPagina;
    // End of variables declaration//GEN-END:variables
}


