/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package interfaces;

import clases.classCartera;
import clases.classPuntoVenta;
import clases.classPuntoVenta;
import clases.control_cliente;
import herramientas.Reportes;
import static herramientas.globales.llenarComboGlobal;
import static interfaces.frmPrincipal.jDesktopPane1;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import java.awt.RenderingHints.Key;
import java.awt.event.ItemEvent;
import java.awt.event.KeyEvent;
import static java.awt.event.KeyEvent.VK_ENTER;
import java.sql.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;
import javax.swing.JTextField;

/**
 *
 * @author julioc
 */
public class frmCartera extends javax.swing.JInternalFrame {

    /**
     * Creates new form frmPuntosVenta
     */
    long lngNumPaginas;
    public frmCartera() {
        initComponents();
        limpiar();
        this.cboCargoAbono.addItem("Cargo");
        this.cboCargoAbono.addItem("Abono");
        this.defineTablaCartera("", 1);
        Calendar c2 = new GregorianCalendar();
        dteFecha.setCalendar(c2);
        limpiar();

    }
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        JTabCartera = new javax.swing.JTable();
        panCapturaBodegas = new javax.swing.JTabbedPane();
        jPanel1 = new javax.swing.JPanel();
        lblDescripcion = new javax.swing.JLabel();
        txtDescripcion = new javax.swing.JTextField();
        idPuntoVenta = new javax.swing.JLabel();
        txtIdFolioCartera = new javax.swing.JTextField();
        lblDescripcion1 = new javax.swing.JLabel();
        cboCargoAbono = new javax.swing.JComboBox();
        lblDescripcion2 = new javax.swing.JLabel();
        txtImporte = new javax.swing.JTextField();
        lblClienteProveedor = new javax.swing.JLabel();
        txtNumCliente = new javax.swing.JTextField();
        lblNomCliente = new javax.swing.JLabel();
        lblDescripcion3 = new javax.swing.JLabel();
        dteFecha = new com.toedter.calendar.JDateChooser();
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
        PanBotones = new javax.swing.JPanel();
        btnRegPuntoVenta = new javax.swing.JButton();
        btnNuevo = new javax.swing.JButton();
        btnEliminar = new javax.swing.JButton();
        btnSalir = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);

        JTabCartera.setModel(new javax.swing.table.DefaultTableModel(
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
        JTabCartera.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                JTabCarteraMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(JTabCartera);

        lblDescripcion.setText("Descripcion:");

        idPuntoVenta.setText("ID Folio Cartera:");

        lblDescripcion1.setText("Cargo/Abono:");

        cboCargoAbono.setModel(new javax.swing.DefaultComboBoxModel(new String[] { " " }));
        cboCargoAbono.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                cboCargoAbonoItemStateChanged(evt);
            }
        });
        cboCargoAbono.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cboCargoAbonoActionPerformed(evt);
            }
        });

        lblDescripcion2.setText("Importe:");

        lblClienteProveedor.setText("Cliente:");

        txtNumCliente.setText("0");
        txtNumCliente.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                txtNumClienteActionPerformed(evt);
            }
        });
        txtNumCliente.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                txtNumClienteEnterCliente(evt);
            }
        });

        lblDescripcion3.setText("Fecha:");

        dteFecha.setToolTipText("");
        dteFecha.setDateFormatString("yyyy-MM-dd");

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(lblDescripcion3)
                    .addComponent(lblDescripcion1)
                    .addComponent(idPuntoVenta)
                    .addComponent(lblClienteProveedor)
                    .addComponent(lblDescripcion2)
                    .addComponent(lblDescripcion))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(txtNumCliente, javax.swing.GroupLayout.PREFERRED_SIZE, 36, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(txtIdFolioCartera, javax.swing.GroupLayout.PREFERRED_SIZE, 222, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(lblNomCliente, javax.swing.GroupLayout.PREFERRED_SIZE, 326, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                        .addComponent(dteFecha, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, 222, Short.MAX_VALUE)
                        .addComponent(cboCargoAbono, javax.swing.GroupLayout.Alignment.LEADING, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(txtDescripcion, javax.swing.GroupLayout.Alignment.LEADING)
                        .addComponent(txtImporte, javax.swing.GroupLayout.Alignment.LEADING)))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(idPuntoVenta)
                    .addComponent(txtIdFolioCartera, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(7, 7, 7)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblClienteProveedor)
                    .addComponent(txtNumCliente, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(6, 6, 6)
                .addComponent(lblNomCliente)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblDescripcion1)
                    .addComponent(cboCargoAbono, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(lblDescripcion3)
                    .addComponent(dteFecha, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 9, Short.MAX_VALUE)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(lblDescripcion2)
                    .addComponent(txtImporte, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtDescripcion, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(lblDescripcion))
                .addContainerGap())
        );

        panCapturaBodegas.addTab("Datos Basicos", jPanel1);

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
                        .addComponent(cmdSiguiente)
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addComponent(lblBuscar)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(txtBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, 168, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(cmdBuscar, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap())
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel4Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jlblNumReg)
                    .addComponent(txtNumReg, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jlblNumReg2)
                    .addComponent(txtPagina, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jlblTotalPaginas)
                    .addComponent(cmdAtras)
                    .addComponent(cmdSiguiente))
                .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addGap(18, 18, 18)
                        .addGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(txtBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(lblBuscar)))
                    .addGroup(jPanel4Layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(cmdBuscar, javax.swing.GroupLayout.PREFERRED_SIZE, 34, Short.MAX_VALUE)))
                .addContainerGap())
        );

        btnRegPuntoVenta.setFont(new java.awt.Font("Tahoma", 0, 3)); // NOI18N
        btnRegPuntoVenta.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/floppy_disk_save-128.png"))); // NOI18N
        btnRegPuntoVenta.setText("Registrar");
        btnRegPuntoVenta.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnRegPuntoVentaActionPerformed(evt);
            }
        });

        btnNuevo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/NUEVO.png"))); // NOI18N
        btnNuevo.setToolTipText("");
        btnNuevo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnNuevoActionPerformed(evt);
            }
        });

        btnEliminar.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/eliminar.png"))); // NOI18N
        btnEliminar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnEliminarActionPerformed(evt);
            }
        });

        btnSalir.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/cerrar.png"))); // NOI18N
        btnSalir.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSalirActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout PanBotonesLayout = new javax.swing.GroupLayout(PanBotones);
        PanBotones.setLayout(PanBotonesLayout);
        PanBotonesLayout.setHorizontalGroup(
            PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanBotonesLayout.createSequentialGroup()
                .addGroup(PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                    .addComponent(btnSalir, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                    .addComponent(btnNuevo, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(btnRegPuntoVenta, javax.swing.GroupLayout.PREFERRED_SIZE, 68, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(46, 46, 46)
                .addComponent(btnEliminar, javax.swing.GroupLayout.PREFERRED_SIZE, 66, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );
        PanBotonesLayout.setVerticalGroup(
            PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(PanBotonesLayout.createSequentialGroup()
                .addGroup(PanBotonesLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(btnEliminar, javax.swing.GroupLayout.PREFERRED_SIZE, 64, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnRegPuntoVenta, javax.swing.GroupLayout.PREFERRED_SIZE, 61, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnNuevo, javax.swing.GroupLayout.PREFERRED_SIZE, 61, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(btnSalir, javax.swing.GroupLayout.PREFERRED_SIZE, 65, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(22, 22, 22)
                        .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 429, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(31, 31, 31)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(panCapturaBodegas, javax.swing.GroupLayout.PREFERRED_SIZE, 376, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(PanBotones, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                    .addComponent(panCapturaBodegas, javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(PanBotones, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jPanel4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void JTabCarteraMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_JTabCarteraMouseClicked
        int fila;
        String[] datosCartera =new String[11];
        fila = this.JTabCartera.rowAtPoint(evt.getPoint());
        classCartera cartera = new classCartera();
        long lngCartera;

        if (fila > -1){
            this.txtIdFolioCartera.setText(String.valueOf(JTabCartera.getValueAt(fila, 0)));

            //            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            //            Date Fecha = new Date();
            //            this.dteFechaNacimiento.setDate(Fecha);

            cartera.leerCartera(this.txtIdFolioCartera.getText());

            this.txtIdFolioCartera.setText(String.valueOf(cartera.lngIdCartera));
            this.txtDescripcion.setText(cartera.strDescripcion);
            this.cboCargoAbono.setSelectedItem(cartera.strCargoAbono);
            this.dteFecha.setDate(Date.valueOf(cartera.strFecha));
            this.txtImporte.setText(String.valueOf(cartera.dblImporte));
            
        
            this.btnEliminar.setVisible(true);

            if(Long.valueOf( this.txtIdFolioCartera.getText())>0){
                this.btnRegPuntoVenta.setLabel("Actualizar");
            }

    }//GEN-LAST:event_JTabCarteraMouseClicked
    }
    private void cmdAtrasActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdAtrasActionPerformed
        long lngValor=0;
        if(1<Long.valueOf( this.txtPagina.getText())){
            lngValor=Long.valueOf( this.txtPagina.getText())-1;
            this.txtPagina.setText(String.valueOf(lngValor));
            defineTablaCartera("",lngValor);
        }
    }//GEN-LAST:event_cmdAtrasActionPerformed

    private void cmdSiguienteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdSiguienteActionPerformed
        long lngValor=0;
        if(lngNumPaginas>Long.valueOf( this.txtPagina.getText())){
            lngValor=Long.valueOf( this.txtPagina.getText())+1;
            this.txtPagina.setText(String.valueOf(lngValor));
            defineTablaCartera("",lngValor);
        }
    }//GEN-LAST:event_cmdSiguienteActionPerformed

    private void txtBuscarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtBuscarActionPerformed

    }//GEN-LAST:event_txtBuscarActionPerformed

    private void txtBuscarKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtBuscarKeyPressed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtBuscarKeyPressed

    private void btnRegPuntoVentaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnRegPuntoVentaActionPerformed

        if (this.btnRegPuntoVenta.getLabel()=="Registrar"){
            classCartera cartera = new classCartera();
            String strRespuesta="";

            cartera.strDescripcion=this.txtDescripcion.getText();
            cartera.strCargoAbono=(this.cboCargoAbono.getSelectedItem().toString().substring(0, 4).toString());
            cartera.dblImporte=Double.valueOf(this.txtImporte.getText());
            cartera.strFecha=((JTextField)dteFecha.getDateEditor().getUiComponent()).getText();
            cartera.lngCliente=Long.valueOf(frmCartera.txtNumCliente.getText());

            try {
                cartera.ingresarCartera();
                defineTablaCartera("",1);
                limpiar();
                JOptionPane.showInternalMessageDialog(rootPane,"Registrado Correctamente");
            } catch (SQLException ex) {
                Logger.getLogger(frmCartera.class.getName()).log(Level.SEVERE, null, ex);
                JOptionPane.showInternalMessageDialog(rootPane,"ERROR" + ex.toString());
            }

        }

        else{
            classCartera cartera = new classCartera();
            cartera.lngIdCartera=Long.valueOf(this.txtIdFolioCartera.getText());
            cartera.strDescripcion=this.txtDescripcion.getText();
            cartera.strCargoAbono=(this.cboCargoAbono.getSelectedItem().toString().substring(0, 4).toString());
            cartera.dblImporte=Double.valueOf(this.txtImporte.getText());
            cartera.strFecha=((JTextField)dteFecha.getDateEditor().getUiComponent()).getText();
            cartera.lngCliente=Long.valueOf(frmCartera.txtNumCliente.getText());
            
            try {
                if (cartera.actualizarCartera()==true){
                    this.defineTablaCartera(this.txtBuscar.getText(), Long.valueOf( this.txtPagina.getText()));
                    JOptionPane.showInternalMessageDialog(rootPane,"Actualizado Correctamente");
                }
            } catch (SQLException ex) {
                Logger.getLogger(frmGruposUsuarios.class.getName()).log(Level.SEVERE, null, ex);
                JOptionPane.showInternalMessageDialog(rootPane,"ERROR AL ACTUALIZAR" + ex.toString());
            }

        }
    }//GEN-LAST:event_btnRegPuntoVentaActionPerformed
public void defineTablaCartera(String strBusqueda,long DesdeHoja){
        
        long lngRegistros=1;
        long lngDesdeRegistro;
        
        //DEFINIMOS LA TABLA MODELO
        DefaultTableModel tablaPuntosVenta = new DefaultTableModel();
        
        //LE AGREGAMOS EL TITULO DE LAS COLUMNAS DE LA TABLA EN UN ARREGLO
        String strTitulos[]={"ID CARTERA","DESCRIPCION"};
        
        //LE ASIGNAMOS LAS COLUMNAS AL MODELO CON LA CADENA DE ARRIBA
        tablaPuntosVenta.setColumnIdentifiers(strTitulos);
        
        //LE ASIGNAMOS EL MODELO DE ARRIBA AL JTABLE 
        this.JTabCartera.setModel(tablaPuntosVenta);
        
                    //AHORA A LEER LOS DATOS
        
        //ASIGNAMOS CUANTOS REGISTROS POR HOJA TRAEREMOS
        lngRegistros=(Long.valueOf(this.txtNumReg.getText()));
        
        //ASIGNAMOS DESDE QUE REGISTRO TRAERA LA CONSULTA SQL
        lngDesdeRegistro=(DesdeHoja*lngRegistros)-lngRegistros;
        
        //INSTANCEAMOS LA CLASE CLIENTE
        classCartera cartera= new classCartera();
        
        //LEEMOS LA CLASE CLIENTE MANDANDOLE LOS PARAMETROS
        cartera.leerBodegas(lngDesdeRegistro, (Long.valueOf(this.txtNumReg.getText())),tablaPuntosVenta,strBusqueda);
        
        //LE PONEMOS EL RESULTADO DE LA CONSULA AL JTABLE
        this.JTabCartera.setModel(tablaPuntosVenta);
        
        //ASIGNAMOS LOS VALORES A LA PAGINACION
        lngRegistros = cartera.leerCuantos("");
        lngNumPaginas= (lngRegistros/ (Long.valueOf( this.txtNumReg.getText())))+1;
        this.jlblTotalPaginas.setText(" De " + ( lngNumPaginas));
        
    }
    private void btnNuevoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnNuevoActionPerformed
        limpiar();
    }//GEN-LAST:event_btnNuevoActionPerformed

    private void btnEliminarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnEliminarActionPerformed
        classCartera cartera = new classCartera();
        cartera.lngIdCartera=Long.valueOf(this.txtIdFolioCartera.getText());

        try {
            cartera.eliminarCartera();
            defineTablaCartera("",1);
            this.limpiar();
            
        } catch (SQLException ex) {
            Logger.getLogger(frmGruposUsuarios.class.getName()).log(Level.SEVERE, null, ex);
            JOptionPane.showInternalMessageDialog(rootPane,"ERROR AL ELIMINAR CARTERA" + ex.toString());
        }
    }//GEN-LAST:event_btnEliminarActionPerformed
public void limpiar()
    {
        
        this.btnRegPuntoVenta.setLabel("Registrar");
        txtDescripcion.setText("");
        txtIdFolioCartera.enable(false);
        this.txtIdFolioCartera.setText("");
        this.txtBuscar.setText("");
        this.txtImporte.setText("");
        this.txtDescripcion.setText("");
        frmCartera.txtNumCliente.setText("");
        this.lblClienteProveedor.setText("");
        this.btnEliminar.setVisible(false);
        
        
        
    }
    private void btnSalirActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSalirActionPerformed
        this.dispose();
    }//GEN-LAST:event_btnSalirActionPerformed

    private void cmdBuscarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdBuscarActionPerformed
        defineTablaCartera(this.txtBuscar.getText(),Long.valueOf(this.txtPagina.getText()));
    }//GEN-LAST:event_cmdBuscarActionPerformed

    private void cboCargoAbonoItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_cboCargoAbonoItemStateChanged
        if (evt.getSource()==cboCargoAbono) {
            
        }
    }//GEN-LAST:event_cboCargoAbonoItemStateChanged

    private void cboCargoAbonoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cboCargoAbonoActionPerformed

    }//GEN-LAST:event_cboCargoAbonoActionPerformed

    private void txtNumClienteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_txtNumClienteActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_txtNumClienteActionPerformed

    private void txtNumClienteEnterCliente(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtNumClienteEnterCliente
        if(evt.getKeyCode() == KeyEvent.VK_ENTER) {
            control_cliente cliente = new control_cliente();
            cliente.leerCliente(this.txtNumCliente.getText());
            this.lblNomCliente.setText(cliente.strNombre+" " +cliente.strApellido);
            frmCartera.cboCargoAbono.requestFocus();
        }

        if(evt.getKeyCode() == KeyEvent.VK_F3) {
            frmBuscarPersonaCartera buscarPersona = new frmBuscarPersonaCartera();
            jDesktopPane1.add(buscarPersona);
            buscarPersona.show();
        }
    }//GEN-LAST:event_txtNumClienteEnterCliente

    /**
     * @param args the command line arguments
     */
   

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTable JTabCartera;
    private javax.swing.JPanel PanBotones;
    private javax.swing.JButton btnEliminar;
    private javax.swing.JButton btnNuevo;
    private javax.swing.JButton btnRegPuntoVenta;
    private javax.swing.JButton btnSalir;
    public static javax.swing.JComboBox cboCargoAbono;
    private javax.swing.JButton cmdAtras;
    private javax.swing.JButton cmdBuscar;
    private javax.swing.JButton cmdSiguiente;
    private com.toedter.calendar.JDateChooser dteFecha;
    private javax.swing.JLabel idPuntoVenta;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JLabel jlblNumReg;
    private javax.swing.JLabel jlblNumReg2;
    private javax.swing.JLabel jlblTotalPaginas;
    private javax.swing.JLabel lblBuscar;
    private javax.swing.JLabel lblClienteProveedor;
    private javax.swing.JLabel lblDescripcion;
    private javax.swing.JLabel lblDescripcion1;
    private javax.swing.JLabel lblDescripcion2;
    private javax.swing.JLabel lblDescripcion3;
    public static javax.swing.JLabel lblNomCliente;
    private javax.swing.JTabbedPane panCapturaBodegas;
    private javax.swing.JTextField txtBuscar;
    private javax.swing.JTextField txtDescripcion;
    private javax.swing.JTextField txtIdFolioCartera;
    private javax.swing.JTextField txtImporte;
    public static javax.swing.JTextField txtNumCliente;
    private javax.swing.JTextField txtNumReg;
    private javax.swing.JTextField txtPagina;
    // End of variables declaration//GEN-END:variables
}
