/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interfaces;
import clases.classGruposUsuarios;
import clases.classEstados;
import clases.classPaises;
import herramientas.Reportes;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import herramientas.globales;
import static herramientas.globales.llenarComboGlobal;

/**
 *
 * @author julio
 */
public class frmEstados extends javax.swing.JInternalFrame {

    /**
     * Creates new form frmEstados
     */
    long lngNumPaginas=0;
    public frmEstados() {
        initComponents();
        //this.cboPaises.removeAllItems();
        limpiar();
        llenarComboGlobal(this.cboPaises,"select idPais,Descripcion from Paises;",false);
        this.cboPaises.setSelectedIndex(1);
        defineTablaEstados("",1,1);
        
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        tabPaises = new javax.swing.JScrollPane();
        JTabEstados = new javax.swing.JTable();
        jPanel4 = new javax.swing.JPanel();
        jlblNumReg = new javax.swing.JLabel();
        txtNumReg = new javax.swing.JTextField();
        jlblNumReg2 = new javax.swing.JLabel();
        txtPagina = new javax.swing.JTextField();
        jlblTotalPaginas = new javax.swing.JLabel();
        cmdAtras = new javax.swing.JButton();
        cmdSiguiente = new javax.swing.JButton();
        txtBuscar = new javax.swing.JTextField();
        lblBuscar = new javax.swing.JLabel();
        cmdBuscar = new javax.swing.JButton();
        panCapturaEstados = new javax.swing.JTabbedPane();
        jpanEstado = new javax.swing.JPanel();
        jPanel1 = new javax.swing.JPanel();
        lblPais = new javax.swing.JLabel();
        cboPaises = new javax.swing.JComboBox();
        idEstado = new javax.swing.JLabel();
        txtIdEstado = new javax.swing.JTextField();
        txtNombreEstado = new javax.swing.JTextField();
        lblNombreEstado = new javax.swing.JLabel();
        PanBotones2 = new javax.swing.JPanel();
        btnRegEstado = new javax.swing.JButton();
        btnNuevo = new javax.swing.JButton();
        btnEliminar = new javax.swing.JButton();
        btnImprimirReporte = new javax.swing.JButton();
        salirclijButton = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);

        JTabEstados.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Title 1", "Title 2", "Title 3"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Long.class, java.lang.Long.class, java.lang.String.class
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }
        });
        JTabEstados.setAutoResizeMode(javax.swing.JTable.AUTO_RESIZE_OFF);
        JTabEstados.addAncestorListener(new javax.swing.event.AncestorListener() {
            public void ancestorMoved(javax.swing.event.AncestorEvent evt) {
            }
            public void ancestorAdded(javax.swing.event.AncestorEvent evt) {
                JTabEstadosAncestorAdded(evt);
            }
            public void ancestorRemoved(javax.swing.event.AncestorEvent evt) {
            }
        });
        JTabEstados.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                JTabEstadosMouseClicked(evt);
            }
        });
        tabPaises.setViewportView(JTabEstados);
        if (JTabEstados.getColumnModel().getColumnCount() > 0) {
            JTabEstados.getColumnModel().getColumn(0).setPreferredWidth(10);
            JTabEstados.getColumnModel().getColumn(1).setPreferredWidth(10);
        }

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

        cmdSiguiente.setText(">>");
        cmdSiguiente.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmdSiguienteActionPerformed(evt);
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
                        .addComponent(cmdSiguiente))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(lblBuscar)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(txtBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, 168, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(cmdBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, 103, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jlblNumReg)
                    .addComponent(txtNumReg, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jlblNumReg2)
                    .addComponent(txtPagina, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jlblTotalPaginas)
                    .addComponent(cmdAtras)
                    .addComponent(cmdSiguiente))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(lblBuscar)
                    .addComponent(cmdBuscar))
                .addGap(68, 68, 68))
        );

        lblPais.setText("Pais:");

        cboPaises.setModel(new javax.swing.DefaultComboBoxModel(new String[] { " " }));
        cboPaises.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                cboPaisesItemStateChanged(evt);
            }
        });
        cboPaises.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cboPaisesActionPerformed(evt);
            }
        });

        idEstado.setText("ID Estado:");

        lblNombreEstado.setText("Nombre Estado:");

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(idEstado)
                            .addComponent(lblNombreEstado))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(txtNombreEstado)
                            .addComponent(txtIdEstado)))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(72, 72, 72)
                        .addComponent(lblPais)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(cboPaises, 0, 222, Short.MAX_VALUE)))
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblPais)
                    .addComponent(cboPaises, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblNombreEstado)
                    .addComponent(txtNombreEstado, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(idEstado)
                    .addComponent(txtIdEstado, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(77, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout jpanEstadoLayout = new javax.swing.GroupLayout(jpanEstado);
        jpanEstado.setLayout(jpanEstadoLayout);
        jpanEstadoLayout.setHorizontalGroup(
            jpanEstadoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );
        jpanEstadoLayout.setVerticalGroup(
            jpanEstadoLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jpanEstadoLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        panCapturaEstados.addTab("Estados", jpanEstado);

        btnRegEstado.setFont(new java.awt.Font("Tahoma", 0, 1)); // NOI18N
        btnRegEstado.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/floppy_disk_save-128.png"))); // NOI18N
        btnRegEstado.setText("Registrar");
        btnRegEstado.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnRegEstadoActionPerformed(evt);
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

        btnEliminar.setFont(new java.awt.Font("Tahoma", 0, 1)); // NOI18N
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

        salirclijButton.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/cerrar.png"))); // NOI18N
        salirclijButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                salirclijButtonActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout PanBotones2Layout = new javax.swing.GroupLayout(PanBotones2);
        PanBotones2.setLayout(PanBotones2Layout);
        PanBotones2Layout.setHorizontalGroup(
            PanBotones2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanBotones2Layout.createSequentialGroup()
                .addGroup(PanBotones2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(PanBotones2Layout.createSequentialGroup()
                        .addComponent(salirclijButton, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                    .addGroup(PanBotones2Layout.createSequentialGroup()
                        .addComponent(btnNuevo, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(btnRegEstado, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(77, 77, 77)))
                .addGroup(PanBotones2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(btnEliminar, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnImprimirReporte, javax.swing.GroupLayout.PREFERRED_SIZE, 67, javax.swing.GroupLayout.PREFERRED_SIZE)))
        );
        PanBotones2Layout.setVerticalGroup(
            PanBotones2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, PanBotones2Layout.createSequentialGroup()
                .addGroup(PanBotones2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(PanBotones2Layout.createSequentialGroup()
                        .addComponent(btnEliminar, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                        .addGap(18, 18, 18))
                    .addGroup(PanBotones2Layout.createSequentialGroup()
                        .addGroup(PanBotones2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(btnRegEstado, javax.swing.GroupLayout.PREFERRED_SIZE, 68, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(btnNuevo, javax.swing.GroupLayout.PREFERRED_SIZE, 68, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addGroup(PanBotones2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(salirclijButton, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(btnImprimirReporte, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jPanel4, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(tabPaises, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(panCapturaEstados)
                    .addComponent(PanBotones2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(35, 35, 35)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(panCapturaEstados)
                    .addComponent(tabPaises, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, 96, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(PanBotones2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(28, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void JTabEstadosAncestorAdded(javax.swing.event.AncestorEvent evt) {//GEN-FIRST:event_JTabEstadosAncestorAdded
        // TODO add your handling code here:
    }//GEN-LAST:event_JTabEstadosAncestorAdded

    private void JTabEstadosMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_JTabEstadosMouseClicked
        int fila;
        String[] datosGrupo =new String[1];
        
        fila = this.JTabEstados.rowAtPoint(evt.getPoint());
        classEstados estados = new classEstados();
        long lngEstado;

        if (fila > -1){
            this.txtIdEstado.setText(String.valueOf(this.JTabEstados.getValueAt(fila, 1)));

            //            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            //            Date Fecha = new Date();
            //            this.dteFechaNacimiento.setDate(Fecha);

            estados.leerEstado(this.txtIdEstado.getText(),String.valueOf(this.JTabEstados.getValueAt(fila, 0)));

            this.txtIdEstado.setText(String.valueOf(estados.lngIdEstado));
            this.txtNombreEstado.setText(estados.strEstado);
            this.cboPaises.setSelectedItem(estados.StrPais);

            this.btnEliminar.setVisible(true);
            this.btnNuevo.setVisible(true);

            if(estados.lngIdEstado>0){
                this.btnRegEstado.setLabel("Actualizar");
            }

        }
    }//GEN-LAST:event_JTabEstadosMouseClicked

    private void cmdAtrasActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdAtrasActionPerformed
        long lngValor=0;
        if(1<Long.valueOf( this.txtPagina.getText())){
            lngValor=Long.valueOf( this.txtPagina.getText())-1;
            this.txtPagina.setText(String.valueOf(lngValor));
            defineTablaEstados(this.txtBuscar.getText(),lngValor,Long.parseLong(this.cboPaises.getSelectedItem().toString().substring(0, 4).toString()));
    }//GEN-LAST:event_cmdAtrasActionPerformed
    }
    private void cmdSiguienteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdSiguienteActionPerformed
         long lngValor=0;
        if(lngNumPaginas>Long.valueOf( this.txtPagina.getText())){
            lngValor=Long.valueOf( this.txtPagina.getText())+1;
            this.txtPagina.setText(String.valueOf(lngValor));
            defineTablaEstados(this.txtBuscar.getText(),lngValor,Long.parseLong(this.cboPaises.getSelectedItem().toString().substring(0, 4).toString()));
        }    
    }//GEN-LAST:event_cmdSiguienteActionPerformed

    private void txtBuscarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtBuscarActionPerformed

    }//GEN-LAST:event_txtBuscarActionPerformed

    private void txtBuscarKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtBuscarKeyPressed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtBuscarKeyPressed

    private void btnRegEstadoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnRegEstadoActionPerformed

        if (this.btnRegEstado.getLabel()=="Registrar"){
            classEstados estados = new classEstados();
            String strRespuesta="";

            if (this.cboPaises.getSelectedItem().toString()==""){
                JOptionPane.showInternalMessageDialog(rootPane,"Es necesario elegir un país");
                return;
            }
            estados.strEstado=this.txtNombreEstado.getText();
      
            estados.StrPais=(this.cboPaises.getSelectedItem().toString().substring(0, 4).toString());
                
            try {
                estados.ingresarEstado();
                defineTablaEstados("",1,Long.parseLong(this.cboPaises.getSelectedItem().toString().substring(0, 4).toString()));
                limpiar();
                JOptionPane.showInternalMessageDialog(rootPane,"Registrado Correctamente");
            } catch (SQLException ex) {
                Logger.getLogger(frmEstados.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

        else{
            classEstados estados =new classEstados();
            estados.lngIdEstado=Long.valueOf(this.txtIdEstado.getText());
            estados.StrPais=(this.cboPaises.getSelectedItem().toString().substring(0, 4).toString());
            estados.strEstado=this.txtNombreEstado.getText();

            try {
                if (estados.actualizarEstado()==true){
                this.defineTablaEstados(this.txtBuscar.getText(), Long.valueOf( this.txtPagina.getText()),Long.parseLong(this.cboPaises.getSelectedItem().toString().substring(0, 4).toString()));
                JOptionPane.showInternalMessageDialog(rootPane,"Actualizado Correctamente");
                }
            } catch (SQLException ex) {
                Logger.getLogger(frmGruposUsuarios.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }//GEN-LAST:event_btnRegEstadoActionPerformed

    private void btnNuevoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnNuevoActionPerformed
        limpiar();
    }//GEN-LAST:event_btnNuevoActionPerformed

    private void btnEliminarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnEliminarActionPerformed
        classEstados estados = new classEstados();
        estados.lngIdEstado=Long.valueOf(this.txtIdEstado.getText());
        estados.StrPais=(this.cboPaises.getSelectedItem().toString().substring(0, 4).toString());
        try {
            estados.eliminarEstado();
            defineTablaEstados("",1,1);
            this.limpiar();
            JOptionPane.showInternalMessageDialog(rootPane,"Eliminado Correctamente");
        } catch (SQLException ex) {
            Logger.getLogger(frmGruposUsuarios.class.getName()).log(Level.SEVERE, null, ex);
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
        strConsulta="call PA_LeeEstadoes ("+lngDesdeRegistro.toString()+","+this.txtNumReg.getText()+",'"+this.txtBuscar.getText()+"')";
        System.out.println(strConsulta);
        Reportes.lanzarReporte(strConsulta, "repGruposUsuarios");
    }//GEN-LAST:event_btnImprimirReporteActionPerformed
   
    public void defineTablaEstados(String strBusqueda,long DesdeHoja,long lngPais){
        
        long lngRegistros=1;
        long lngDesdeRegistro;
        
        
        //DEFINIMOS LA TABLA MODELO
        DefaultTableModel tablaEstados = new DefaultTableModel();
        
        //LE AGREGAMOS EL TITULO DE LAS COLUMNAS DE LA TABLA EN UN ARREGLO
        String strTitulos[]={"ID PAIS","ID ESTADO","NOMBRE"};
        
        //LE ASIGNAMOS LAS COLUMNAS AL MODELO CON LA CADENA DE ARRIBA
        tablaEstados.setColumnIdentifiers(strTitulos);
        
        
       
        
        //LE ASIGNAMOS EL MODELO DE ARRIBA AL JTABLE 
        this.JTabEstados.setModel(tablaEstados);
        
                    //AHORA A LEER LOS DATOS
        
        //ASIGNAMOS CUANTOS REGISTROS POR HOJA TRAEREMOS
        lngRegistros=(Long.valueOf(this.txtNumReg.getText()));
        
        //ASIGNAMOS DESDE QUE REGISTRO TRAERA LA CONSULTA SQL
        lngDesdeRegistro=(DesdeHoja*lngRegistros)-lngRegistros;
        
        //INSTANCEAMOS LA CLASE CLIENTE
        classEstados estados= new classEstados();
        
        //LEEMOS LA CLASE CLIENTE MANDANDOLE LOS PARAMETROS
        estados.leerEstados(lngDesdeRegistro, (Long.valueOf(this.txtNumReg.getText())),tablaEstados,strBusqueda,lngPais);
        
        //LE PONEMOS EL RESULTADO DE LA CONSULA AL JTABLE
        this.JTabEstados.setModel(tablaEstados);
        
        //ASIGNAMOS LOS VALORES A LA PAGINACION
        lngRegistros = estados.leerCuantos(this.txtBuscar.getText(),(this.cboPaises.getSelectedItem().toString().substring(0, 4).toString()));
        lngNumPaginas= (lngRegistros/ (Long.valueOf( this.txtNumReg.getText())))+1;
        this.jlblTotalPaginas.setText(" De " + ( lngNumPaginas));
        
         //TAMAÑO A LAS COLUMNAS
        JTabEstados.getColumnModel().getColumn(0).setPreferredWidth(10);
        JTabEstados.getColumnModel().getColumn(1).setPreferredWidth(10);
        JTabEstados.getColumnModel().getColumn(2).setPreferredWidth(300);
        
    }
    
    public void limpiar(){
        this.btnEliminar.setVisible(false);
        this.btnNuevo.setVisible(false);
        this.txtIdEstado.setText("");
        this.txtNombreEstado.setText("");
        this.txtBuscar.setText("");
        this.txtIdEstado.setEnabled(false);
        this.btnRegEstado.setLabel("Registrar");
  
    }
    private void salirclijButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_salirclijButtonActionPerformed
        this.dispose();
    }//GEN-LAST:event_salirclijButtonActionPerformed

    private void cboPaisesItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_cboPaisesItemStateChanged
          if (evt.getSource()==cboPaises) {
            long lngPais;
            
            //String strPais=(String)this.cboPaises.getSelectedItem();
            //JOptionPane.showInternalMessageDialog(rootPane,strPais);
            defineTablaEstados("",1,Long.valueOf(this.cboPaises.getSelectedItem().toString().substring(0, 4)));
            
        }
    }//GEN-LAST:event_cboPaisesItemStateChanged

    private void cboPaisesActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cboPaisesActionPerformed
  
    }//GEN-LAST:event_cboPaisesActionPerformed

    private void cmdBuscarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdBuscarActionPerformed
        defineTablaEstados(this.txtBuscar.getText(),1,Long.valueOf(this.cboPaises.getSelectedItem().toString().substring(0, 4)));
    }//GEN-LAST:event_cmdBuscarActionPerformed

    /**
     * @param args the command line arguments
     */


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTable JTabEstados;
    private javax.swing.JPanel PanBotones2;
    private javax.swing.JButton btnEliminar;
    private javax.swing.JButton btnImprimirReporte;
    private javax.swing.JButton btnNuevo;
    private javax.swing.JButton btnRegEstado;
    private javax.swing.JComboBox cboPaises;
    private javax.swing.JButton cmdAtras;
    private javax.swing.JButton cmdBuscar;
    private javax.swing.JButton cmdSiguiente;
    private javax.swing.JLabel idEstado;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JLabel jlblNumReg;
    private javax.swing.JLabel jlblNumReg2;
    private javax.swing.JLabel jlblTotalPaginas;
    private javax.swing.JPanel jpanEstado;
    private javax.swing.JLabel lblBuscar;
    private javax.swing.JLabel lblNombreEstado;
    private javax.swing.JLabel lblPais;
    private javax.swing.JTabbedPane panCapturaEstados;
    private javax.swing.JButton salirclijButton;
    private javax.swing.JScrollPane tabPaises;
    private javax.swing.JTextField txtBuscar;
    private javax.swing.JTextField txtIdEstado;
    private javax.swing.JTextField txtNombreEstado;
    private javax.swing.JTextField txtNumReg;
    private javax.swing.JTextField txtPagina;
    // End of variables declaration//GEN-END:variables
}
