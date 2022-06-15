
import java.awt.Dimension;
import static java.lang.Thread.sleep;
import static javax.swing.BorderFactory.createTitledBorder;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import static javax.swing.WindowConstants.EXIT_ON_CLOSE;

public class salpicadero extends JFrame implements Runnable 
//En esta clase estará la ventana que muestra el estado del coche. NO ES LA CLASE OBJETIVO
{
    objetivo salpicadero_obj;
    JPanel panel_salpicadero;
            
    JPanel panel_revoluciones; //Panel que está en el salpicadero
    JPanel panel_contador_rev; //Dentro de panel revoluciones, viene este panel en el que estan las revs
    JLabel etiqueta_revoluciones;
    
    JPanel panel_velocidad;
    JPanel panel_contador_vel;
    JLabel etiqueta_velocidad;
    
    JPanel panel_km;
    JPanel panel_km_recientes;
    JPanel panel_km_total;
    JLabel etiqueta_km_recientes;
    JLabel etiqueta_km_total;
    
    public salpicadero(objetivo obj)
    {
        salpicadero_obj = obj;  

        configurarVentana();
        
        crearVentana();
   }
    
   private void configurarVentana()
   {
        setSize(500, 600); //Tamaño original de la ventana
        setTitle("Salpicadero"); //Nombre de la ventana
        setMinimumSize(new Dimension(416,500)); //Min tamñao ventana
        
        setDefaultCloseOperation(EXIT_ON_CLOSE); //Que se cierre la ventana
   }
   
    private void crearVentana()
    {        
        panel_salpicadero = new JPanel(); //Creamos panel para la pantalla
        panel_salpicadero.setLayout(null);
        panel_salpicadero.setVisible(true); //La activamos

        this.getContentPane().add(panel_salpicadero);
        
        crearPanelVelocidad();
        crearPanelRevoluciones();
        crearCuentaKM();
   
        /* Hebra o timer
        Timer timer = new Timer(1000, new ActionListener() 
        {
            public void actionPerformed(ActionEvent evt) {
                    refrescarSalpicadero();
                }
            });

        timer.start();   
        */
    }
        
    private void crearPanelVelocidad()
    {
        panel_velocidad = new JPanel(); //Crear panel (dentro del otro panel)
        etiqueta_velocidad = new JLabel();
        panel_contador_rev = new JPanel();
      
        panel_velocidad.setLayout(null);
        panel_velocidad.setVisible(true); //La activamos
        
        panel_velocidad.setBorder(createTitledBorder("Velocímetro"));
        panel_velocidad.setSize(470,150);
        panel_velocidad.setLocation(10,10); //Lo colocamos un poco a la derecha
        
        panel_contador_rev.setBorder(createTitledBorder("km/h"));
        panel_contador_rev.setSize(150, 50);
        panel_contador_rev.setLocation(150, 35);

        etiqueta_velocidad.setText("00.00");
        panel_contador_rev.add(etiqueta_velocidad);

        panel_velocidad.add(panel_contador_rev, java.awt.BorderLayout.CENTER);
        panel_salpicadero.add(panel_velocidad);
    }
    
    private void crearPanelRevoluciones()
    {
        panel_revoluciones = new JPanel(); //Crear panel (dentro del otro panel)
        etiqueta_revoluciones = new JLabel();
        panel_contador_vel = new JPanel();
      
        panel_revoluciones.setLayout(null);
        panel_revoluciones.setVisible(true); //La activamos
        
        panel_revoluciones.setBorder(createTitledBorder("Cuentarrevoluciones"));
        panel_revoluciones.setSize(470,150);
        panel_revoluciones.setLocation(10,170); //Lo colocamos debajo del otro

        panel_contador_vel.setBorder(createTitledBorder("RPM"));
        panel_contador_vel.setSize(150, 50);
        panel_contador_vel.setLocation(150, 35);

        etiqueta_revoluciones.setText("00.00");
        panel_contador_vel.add(etiqueta_revoluciones);

        panel_revoluciones.add(panel_contador_vel, java.awt.BorderLayout.CENTER);
        panel_salpicadero.add(panel_revoluciones);
    }
    
    private void crearCuentaKM()
    {
        panel_km = new JPanel(); //Crear panel (dentro del otro panel)
        etiqueta_km_recientes = new JLabel();
        panel_km_recientes = new JPanel();
      
        panel_km.setLayout(null);
        panel_km.setVisible(true); //La activamos
        
        panel_km.setBorder(createTitledBorder("CuentaKilómetros"));
        panel_km.setSize(470,200);
        panel_km.setLocation(10,330); //Lo colocamos debajo del otro

        //Parte del cuenta km reciente
        
        panel_km_recientes.setBorder(createTitledBorder("contador reciente"));
        panel_km_recientes.setSize(150, 50);
        panel_km_recientes.setLocation(150, 35);

        etiqueta_km_recientes.setText("00.00");
        panel_km_recientes.add(etiqueta_km_recientes);

        panel_km.add(panel_km_recientes, java.awt.BorderLayout.CENTER);
        panel_salpicadero.add(panel_km);
        
        //La parte del cuenta km total
        
        etiqueta_km_total = new JLabel();
        panel_km_total = new JPanel();
        
        panel_km_total.setBorder(createTitledBorder("contador total"));
        panel_km_total.setSize(150, 50);
        panel_km_total.setLocation(150, 100);
        
        etiqueta_km_total.setText("00.00");
        panel_km_total.add(etiqueta_km_total);

        panel_km.add(panel_km_total, java.awt.BorderLayout.CENTER);
    }
    
    public void refrescarSalpicadero() //Para que el controlador pueda llamar para refrescar el salpicadero
    {
        etiqueta_revoluciones.setText(String.format("%.2f", salpicadero_obj.getRevoluciones()));
        etiqueta_velocidad.setText(String.format("%.2f", salpicadero_obj.getVelocidad()));
        etiqueta_km_recientes.setText(String.format("%.4f", salpicadero_obj.getDistanciaReciente()));
        etiqueta_km_total.setText(String.format("%.2f", salpicadero_obj.getDistanciaTotal()));
    }
            
    //public refrescarSalpicadero()

    @Override
    public void run() //Que se refresquen los valores cada seg
    {
        while(true)
        {
            try {
                sleep(1000); //1s
            } catch (InterruptedException ex) {
                java.util.logging.Logger.getLogger(salpicadero.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
            }

            refrescarSalpicadero();
        }
    }
} //Fin de la clase
