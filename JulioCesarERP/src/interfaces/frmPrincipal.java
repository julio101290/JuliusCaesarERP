
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package interfaces;

import clases.control_existencias;
import herramientas.Reportes;
import herramientas.conexion;
import static herramientas.conexion.strServidor;
import herramientas.globales;
import javax.swing.JOptionPane;
import javax.swing.JPanel;


/**
 *
 * @author ANDRES
 */
public class frmPrincipal extends javax.swing.JFrame {
control_existencias ctrl = new control_existencias();
    
    /**
     * Creates new form Interfaz_principal
     */
    public frmPrincipal() {
        initComponents();
           
             
      
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jDesktopPane1 = new javax.swing.JDesktopPane();
        jLabel1 = new javax.swing.JLabel();
        jMenuBar1 = new javax.swing.JMenuBar();
        jMenu6 = new javax.swing.JMenu();
        miDatosEmpresa = new javax.swing.JMenuItem();
        menuUbiicaciones = new javax.swing.JMenu();
        menuPaises = new javax.swing.JMenuItem();
        menuEstados = new javax.swing.JMenuItem();
        jMenuItem2 = new javax.swing.JMenuItem();
        jMenuItem1 = new javax.swing.JMenuItem();
        jMenu1 = new javax.swing.JMenu();
        jMenuItem4 = new javax.swing.JMenuItem();
        jMenu2 = new javax.swing.JMenu();
        jMenuItem3 = new javax.swing.JMenuItem();
        menuInventario = new javax.swing.JMenu();
        menuBodegas = new javax.swing.JMenuItem();
        MenuFlujo = new javax.swing.JMenuItem();
        menuEntrada = new javax.swing.JMenuItem();
        ReportesInventarios = new javax.swing.JMenuItem();
        jMenu3 = new javax.swing.JMenu();
        Ventas = new javax.swing.JMenu();
        jMenuItem5 = new javax.swing.JMenuItem();
        jMenuItem6 = new javax.swing.JMenuItem();
        jMenuItem7 = new javax.swing.JMenuItem();
        jMenu4 = new javax.swing.JMenu();
        jMenuItem8 = new javax.swing.JMenuItem();
        jMenuItem9 = new javax.swing.JMenuItem();
        jMenu5 = new javax.swing.JMenu();
        jMenuItem10 = new javax.swing.JMenuItem();
        jMenuItem11 = new javax.swing.JMenuItem();
        jMenuItem12 = new javax.swing.JMenuItem();
        jMenu7 = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));

        jDesktopPane1.setBackground(java.awt.Color.lightGray);

        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/Wallpaperpackz (22).jpg"))); // NOI18N
        jLabel1.setLabelFor(jDesktopPane1);
        jDesktopPane1.add(jLabel1);
        jLabel1.setBounds(0, 0, 1480, 590);

        jMenuBar1.setBackground(new java.awt.Color(204, 204, 204));
        jMenuBar1.setForeground(new java.awt.Color(153, 153, 153));

        jMenu6.setBorder(new javax.swing.border.MatteBorder(null));
        jMenu6.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/server-database.png"))); // NOI18N
        jMenu6.setText("Configuración         ");
        jMenu6.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        jMenu6.setDebugGraphicsOptions(javax.swing.DebugGraphics.NONE_OPTION);
        jMenu6.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N

        miDatosEmpresa.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_E, java.awt.event.InputEvent.CTRL_MASK));
        miDatosEmpresa.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        miDatosEmpresa.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/índice1231.jpeg"))); // NOI18N
        miDatosEmpresa.setText("Datos Empresa");
        miDatosEmpresa.setActionCommand("");
        miDatosEmpresa.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                miDatosEmpresaActionPerformed(evt);
            }
        });
        jMenu6.add(miDatosEmpresa);

        menuUbiicaciones.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/48px-Globe-with-clock.svg.png"))); // NOI18N
        menuUbiicaciones.setText("Ubicaciones");
        menuUbiicaciones.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N

        menuPaises.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_P, java.awt.event.InputEvent.CTRL_MASK));
        menuPaises.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        menuPaises.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/paises.png"))); // NOI18N
        menuPaises.setText("Paises");
        menuPaises.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuPaisesActionPerformed(evt);
            }
        });
        menuUbiicaciones.add(menuPaises);

        menuEstados.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_S, java.awt.event.InputEvent.CTRL_MASK));
        menuEstados.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        menuEstados.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/estados.png"))); // NOI18N
        menuEstados.setText("Estados");
        menuEstados.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuEstadosActionPerformed(evt);
            }
        });
        menuUbiicaciones.add(menuEstados);

        jMenu6.add(menuUbiicaciones);

        jMenuItem2.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_G, java.awt.event.InputEvent.CTRL_MASK));
        jMenuItem2.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        jMenuItem2.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/gente.jpeg"))); // NOI18N
        jMenuItem2.setText("Grupos usuarios");
        jMenuItem2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem2ActionPerformed(evt);
            }
        });
        jMenu6.add(jMenuItem2);

        jMenuItem1.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_U, java.awt.event.InputEvent.CTRL_MASK));
        jMenuItem1.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        jMenuItem1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/userr.png"))); // NOI18N
        jMenuItem1.setText("Usuarios");
        jMenuItem1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem1ActionPerformed(evt);
            }
        });
        jMenu6.add(jMenuItem1);

        jMenuBar1.add(jMenu6);

        jMenu1.setBorder(new javax.swing.border.MatteBorder(null));
        jMenu1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/ALUMNOS2.JPG"))); // NOI18N
        jMenu1.setText("Clientes");
        jMenu1.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        jMenu1.setPreferredSize(new java.awt.Dimension(200, 50));

        jMenuItem4.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_C, java.awt.event.InputEvent.CTRL_MASK));
        jMenuItem4.setFont(new java.awt.Font("Segoe UI", 1, 18)); // NOI18N
        jMenuItem4.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/bookmark-new.png"))); // NOI18N
        jMenuItem4.setText("Registrar");
        jMenuItem4.setBorder(new javax.swing.border.SoftBevelBorder(javax.swing.border.BevelBorder.RAISED));
        jMenuItem4.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem4ActionPerformed(evt);
            }
        });
        jMenu1.add(jMenuItem4);

        jMenuBar1.add(jMenu1);

        jMenu2.setBorder(new javax.swing.border.MatteBorder(null));
        jMenu2.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/índice.jpeg"))); // NOI18N
        jMenu2.setText("Artículos");
        jMenu2.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        jMenu2.setPreferredSize(new java.awt.Dimension(200, 50));

        jMenuItem3.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_A, java.awt.event.InputEvent.CTRL_MASK));
        jMenuItem3.setFont(new java.awt.Font("Segoe UI", 1, 18)); // NOI18N
        jMenuItem3.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/bookmark-new.png"))); // NOI18N
        jMenuItem3.setText("Registar");
        jMenuItem3.setBorder(new javax.swing.border.SoftBevelBorder(javax.swing.border.BevelBorder.RAISED));
        jMenuItem3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jMenuItem3ActionPerformed(evt);
            }
        });
        jMenu2.add(jMenuItem3);

        jMenuBar1.add(jMenu2);

        menuInventario.setBorder(new javax.swing.border.MatteBorder(null));
        menuInventario.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/inventario.png"))); // NOI18N
        menuInventario.setText("Inventario");
        menuInventario.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N

        menuBodegas.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_B, java.awt.event.InputEvent.CTRL_MASK));
        menuBodegas.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        menuBodegas.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/bodega.png"))); // NOI18N
        menuBodegas.setText("Bodegas");
        menuBodegas.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuBodegasActionPerformed(evt);
            }
        });
        menuInventario.add(menuBodegas);

        MenuFlujo.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_F, java.awt.event.InputEvent.CTRL_MASK));
        MenuFlujo.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        MenuFlujo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/flujos.png"))); // NOI18N
        MenuFlujo.setText("Flujos de inventario");
        MenuFlujo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                MenuFlujoActionPerformed(evt);
            }
        });
        menuInventario.add(MenuFlujo);

        menuEntrada.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_I, java.awt.event.InputEvent.CTRL_MASK));
        menuEntrada.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        menuEntrada.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/entrada.png"))); // NOI18N
        menuEntrada.setText("Dar entrada o Salida");
        menuEntrada.setActionCommand("");
        menuEntrada.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                menuEntradaActionPerformed(evt);
            }
        });
        menuInventario.add(menuEntrada);

        ReportesInventarios.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_R, java.awt.event.InputEvent.CTRL_MASK));
        ReportesInventarios.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        ReportesInventarios.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/web-space-px-png.png"))); // NOI18N
        ReportesInventarios.setText("Reportes");
        ReportesInventarios.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ReportesInventariosActionPerformed(evt);
            }
        });
        menuInventario.add(ReportesInventarios);

        jMenuBar1.add(menuInventario);
        jMenuBar1.add(jMenu3);

        Ventas.setBorder(new javax.swing.border.MatteBorder(null));
        Ventas.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/Calculator.png"))); // NOI18N
        Ventas.setText("Ventas");
        Ventas.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N

        jMenuItem5.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_O, java.awt.event.InputEvent.CTRL_MASK));
        jMenuItem5.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        jMenuItem5.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/Company.png"))); // NOI18N
        jMenuItem5.setText("Puntos de Venta");
        Ventas.add(jMenuItem5);

        jMenuItem6.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_V, java.awt.event.InputEvent.CTRL_MASK));
        jMenuItem6.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        jMenuItem6.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/e-commerce-px-png (1).png"))); // NOI18N
        jMenuItem6.setText("Ventas");
        Ventas.add(jMenuItem6);

        jMenuItem7.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_F, java.awt.event.InputEvent.CTRL_MASK));
        jMenuItem7.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        jMenuItem7.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/web-space-px-png.png"))); // NOI18N
        jMenuItem7.setText("Reportes de Ventas");
        Ventas.add(jMenuItem7);

        jMenuBar1.add(Ventas);

        jMenu4.setBorder(new javax.swing.border.MatteBorder(null));
        jMenu4.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/Business.png"))); // NOI18N
        jMenu4.setText("Cartera");
        jMenu4.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N

        jMenuItem8.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_T, java.awt.event.InputEvent.CTRL_MASK));
        jMenuItem8.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        jMenuItem8.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/Money.png"))); // NOI18N
        jMenuItem8.setText("Cargos / Abonos");
        jMenu4.add(jMenuItem8);

        jMenuItem9.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_H, java.awt.event.InputEvent.CTRL_MASK));
        jMenuItem9.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        jMenuItem9.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/web-space-px-png.png"))); // NOI18N
        jMenuItem9.setText("Reportes de Cartera");
        jMenu4.add(jMenuItem9);

        jMenuBar1.add(jMenu4);

        jMenu5.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/Help.png"))); // NOI18N
        jMenu5.setText("Ayuda");
        jMenu5.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N

        jMenuItem10.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_F2, 0));
        jMenuItem10.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        jMenuItem10.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/books.png"))); // NOI18N
        jMenuItem10.setText("Manual de Usuario PDF");
        jMenu5.add(jMenuItem10);

        jMenuItem11.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_W, java.awt.event.InputEvent.CTRL_MASK));
        jMenuItem11.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        jMenuItem11.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/world.png"))); // NOI18N
        jMenuItem11.setText("WEB, Tutoriales ETC");
        jMenu5.add(jMenuItem11);

        jMenuItem12.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_X, java.awt.event.InputEvent.ALT_MASK));
        jMenuItem12.setFont(new java.awt.Font("SansSerif", 1, 18)); // NOI18N
        jMenuItem12.setIcon(new javax.swing.ImageIcon(getClass().getResource("/imagenes/Information.png"))); // NOI18N
        jMenuItem12.setText("Acerca de");
        jMenu5.add(jMenuItem12);

        jMenuBar1.add(jMenu5);
        jMenuBar1.add(jMenu7);

        setJMenuBar(jMenuBar1);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jDesktopPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 1476, Short.MAX_VALUE)
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addComponent(jDesktopPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 609, Short.MAX_VALUE)
                .addGap(24, 24, 24))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jMenuItem3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem3ActionPerformed
       
        frmArticulos art = new frmArticulos();
        jDesktopPane1.add(art);
        art.show();       
            
        
    }//GEN-LAST:event_jMenuItem3ActionPerformed

    private void jMenuItem4ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem4ActionPerformed
               
          frmClientes cli = new frmClientes();       
          jDesktopPane1.add(cli);
          cli.show();          
      
    
    }//GEN-LAST:event_jMenuItem4ActionPerformed

    private void jMenuItem2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem2ActionPerformed
        frmGruposUsuarios grupo = new frmGruposUsuarios();
        jDesktopPane1.add(grupo);
        grupo.setVisible(true);
    }//GEN-LAST:event_jMenuItem2ActionPerformed

    private void jMenuItem1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jMenuItem1ActionPerformed
        frmUsuarios usuario = new frmUsuarios();
        jDesktopPane1.add(usuario);
        usuario.setVisible(true);
    }//GEN-LAST:event_jMenuItem1ActionPerformed

    private void miDatosEmpresaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_miDatosEmpresaActionPerformed
        frmInformacionEmpresa dempresa = new frmInformacionEmpresa();
        jDesktopPane1.add(dempresa);
        dempresa.setVisible(true);
    }//GEN-LAST:event_miDatosEmpresaActionPerformed

    private void menuBodegasActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuBodegasActionPerformed
        frmBodegas bodega= new frmBodegas();
        jDesktopPane1.add(bodega);
        bodega.show();   
    }//GEN-LAST:event_menuBodegasActionPerformed

    private void menuPaisesActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuPaisesActionPerformed
        frmPaises paises = new frmPaises();
        jDesktopPane1.add(paises);
        paises.setVisible(true);
    }//GEN-LAST:event_menuPaisesActionPerformed

    private void menuEstadosActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuEstadosActionPerformed
        frmEstados estados = new frmEstados();
        jDesktopPane1.add(estados);
        estados.setVisible(true);
    }//GEN-LAST:event_menuEstadosActionPerformed

    private void MenuFlujoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_MenuFlujoActionPerformed
        frmTipoFlujo flujo = new frmTipoFlujo();
        jDesktopPane1.add(flujo);
        flujo.setVisible(true);
    }//GEN-LAST:event_MenuFlujoActionPerformed

    private void menuEntradaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_menuEntradaActionPerformed
        frmMovimientos movimiento = new frmMovimientos();
        jDesktopPane1.add(movimiento);
        movimiento.setVisible(true);
    }//GEN-LAST:event_menuEntradaActionPerformed

    private void ReportesInventariosActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ReportesInventariosActionPerformed
        frmConsultaReportes reportes = new frmConsultaReportes();
        jDesktopPane1.add(reportes);
        reportes.setVisible(true);
    }//GEN-LAST:event_ReportesInventariosActionPerformed
public void ejecutarDerecho(){
    jMenuItem3.setVisible(globales.blnAccesoArticulos);
    jMenuItem4.setVisible(globales.blnAccesoClientes);
    jMenuItem2.setVisible(globales.blnAccesoGrupos);
    jMenuItem1.setVisible(globales.blnAccesoUsuarios);
    menuBodegas.setVisible(globales.blnABCBodegas);
    this.MenuFlujo.setVisible(globales.blnABCTiposFlujo);
    this.ReportesInventarios.setVisible(globales.blnReportesInventarios);
}
   
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JMenuItem MenuFlujo;
    private javax.swing.JMenuItem ReportesInventarios;
    private javax.swing.JMenu Ventas;
    public static javax.swing.JDesktopPane jDesktopPane1;
    public static javax.swing.JLabel jLabel1;
    private javax.swing.JMenu jMenu1;
    private javax.swing.JMenu jMenu2;
    private javax.swing.JMenu jMenu3;
    private javax.swing.JMenu jMenu4;
    private javax.swing.JMenu jMenu5;
    private javax.swing.JMenu jMenu6;
    private javax.swing.JMenu jMenu7;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JMenuItem jMenuItem1;
    private javax.swing.JMenuItem jMenuItem10;
    private javax.swing.JMenuItem jMenuItem11;
    private javax.swing.JMenuItem jMenuItem12;
    private javax.swing.JMenuItem jMenuItem2;
    private javax.swing.JMenuItem jMenuItem3;
    private javax.swing.JMenuItem jMenuItem4;
    private javax.swing.JMenuItem jMenuItem5;
    private javax.swing.JMenuItem jMenuItem6;
    private javax.swing.JMenuItem jMenuItem7;
    private javax.swing.JMenuItem jMenuItem8;
    private javax.swing.JMenuItem jMenuItem9;
    private javax.swing.JMenuItem menuBodegas;
    private javax.swing.JMenuItem menuEntrada;
    private javax.swing.JMenuItem menuEstados;
    private javax.swing.JMenu menuInventario;
    private javax.swing.JMenuItem menuPaises;
    private javax.swing.JMenu menuUbiicaciones;
    private javax.swing.JMenuItem miDatosEmpresa;
    // End of variables declaration//GEN-END:variables
}
