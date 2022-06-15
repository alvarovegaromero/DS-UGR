package estmeteorologica;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import static java.lang.Thread.sleep;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;
import javax.swing.Timer;

//JTextfield caja_Texto = new JTextField();
//JComboBox para listas

/**
 *
 * @author Alvaro y Alex
 */
public class Ventana extends JFrame
{
    private Pantalla observador_pantalla;
    private Grafica observador_grafica;
    private Cambiador observador_cambiador;
    private static JPanel panel;
    private JPanel panel_pantalla = new JPanel();
    private JPanel panel_grafica = new JPanel(); 
    private JPanel panel_cambiador = new JPanel();



  public Ventana(Pantalla p)
  {
    observador_pantalla = p;  

    configurarVentana();
    
    ventanaPantalla();
   }
  
  public Ventana(Grafica g)
  {
    observador_grafica = g;
        
    configurarVentana();
    
    ventanaGrafica();
  }
  
   public Ventana(Cambiador c)
  {
    observador_cambiador = c;
    
    configurarVentana(); 

    ventanaCambiador();    
  }

/////////////////////////////////////////////////////////////////////////////////
   
   private void configurarVentana()
   {
        setSize(500, 500); //Tamaño original de la ventana
        setTitle("App - Estación meteorológica"); //Nombre de la ventana
        setMinimumSize(new Dimension(200,200));
        
        setDefaultCloseOperation(EXIT_ON_CLOSE); //Que se cierre la ventana
   }
 
/////////////////////////////////////////////////////////////////////////////////

  private void ventanaPantalla()//Vamos al panel de la pantalla
  {
        JPanel panel_pantalla = new JPanel(); //Creamos panel para la pantalla
        panel_pantalla.setLayout(null);
        panel_pantalla.setVisible(true); //La activamoss

        this.getContentPane().add(panel_pantalla);

        JLabel etiqueta = new JLabel("Pantalla");
        etiqueta.setBounds(200,0, 100,40);
        panel_pantalla.add(etiqueta);

                
            observador_pantalla.pullTemperaturas(); //Obtener la última temperatura
            JLabel etiqueta_pantalla = new JLabel();
            
            if(observador_pantalla.hayTemperaturasNuevas())
            {
                etiqueta_pantalla.setText( "Temperatura en Celsius: "+ observador_pantalla.getCelsius() +
                " - Temperatura en Fahrenheit: " + observador_pantalla.getFahrenheit()); //Etiqueta que muestre las temperaturas
                etiqueta_pantalla.setForeground(Color.black);
            }
            else
            {
                etiqueta_pantalla.setText("ERROR - NO HAY TEMPERATURAS NUEVAS"); 
                etiqueta_pantalla.setForeground(Color.red);
            }
               etiqueta_pantalla.setBounds(10,50, 400,40);
               panel_pantalla.add(etiqueta_pantalla);
               
    Timer timer = new Timer(100, new ActionListener() {
        public void actionPerformed(ActionEvent evt) {
            
            //Refresh the panel
            if(observador_pantalla.hayTemperaturasNuevas())
            {
                etiqueta_pantalla.setText( "Temperatura en Celsius: "+ observador_pantalla.getCelsius() +
                " - Temperatura en Fahrenheit: " + observador_pantalla.getFahrenheit()); //Etiqueta que muestre las temperaturas
                etiqueta_pantalla.setForeground(Color.black);
            }
            
            
            else
            {
              etiqueta_pantalla.setText("ERROR - NO HAY TEMPERATURAS NUEVAS");
            }
        }
    }); 
    
    timer.start();               
            
        }
    
  

/////////////////////////////////////////////////////////////////////////////////

    private void ventanaGrafica() //Vamos al panel de la grafica
    {
        
        JPanel panel_grafica = new JPanel();
        panel_grafica.setLayout(null);
        panel_grafica.setVisible(true);

        this.getContentPane().add(panel_grafica);

        JLabel etiqueta = new JLabel("Grafica");
        etiqueta.setBounds(200, 0, 100, 40);

        panel_grafica.add(etiqueta);
      
        JLabel etiqueta_error = new JLabel("ERROR - NO HAY SUFICIENTES TEMPERATURAS");
        etiqueta_error.setForeground(Color.red);
        etiqueta_error.setBounds(50, 100, 300, 40);

        if(observador_grafica.haySuficientesTemperaturas())
        {
            panel_grafica.add(observador_grafica.crearGrafica());
        }
        else
        {
            panel_grafica.add(etiqueta_error);
        }
                
    Timer timer = new Timer(1000, new ActionListener() {
        public void actionPerformed(ActionEvent evt) {
            
            //Refresh the panel
            if(observador_grafica.haySuficientesTemperaturas())
            {
                if(observador_grafica.hayGraficaGenerada())
                {
                    panel_grafica.add(observador_grafica.crearGrafica());
                    
                    panel_grafica.removeAll();
                    panel_grafica.revalidate();
                    panel_grafica.repaint();
                    
                    panel_grafica.add(observador_grafica.crearGrafica());
                    panel_grafica.add(etiqueta);

                }
                
                else //no hay grafica generada
                {               
                    panel_grafica.add(observador_grafica.crearGrafica());
                    panel_grafica.remove(etiqueta_error);
                    panel_grafica.revalidate();
                    panel_grafica.repaint();
                }
            }
            
            else
            {
              panel_grafica.add(etiqueta_error);
            }
        }
    }); 
    
    timer.start();
}

/////////////////////////////////////////////////////////////////////////////////

    private void ventanaCambiador()
    {
        JPanel panel_cambiador = new JPanel(); //Creamos panel para la pantalla
        panel_cambiador.setLayout(null);
        panel_cambiador.setVisible(true); //La activamoss

        this.getContentPane().add(panel_cambiador);

        JLabel etiqueta = new JLabel("Cambiador");
        etiqueta.setBounds(200,0, 100,40);
        panel_cambiador.add(etiqueta);
        
        JTextField entrada = new JTextField(); //Celda de texto para poner la temperatura leida
        entrada.setBounds(10,150, 100,40);
        panel_cambiador.add(entrada);
        
        JButton boton_introducir = new JButton("Temperatura ingresada"); //Boton para ingresar los datosç
        boton_introducir.setBounds(100,200,200,40);
        panel_cambiador.add(boton_introducir);

        ActionListener oyente = new ActionListener() //Vamos al origen al tocar el boton volver
        {
        @Override
          public void actionPerformed(ActionEvent ae)
          {
              double nuevatemp = Double.valueOf(entrada.getText());
              observador_cambiador.setTemperaturaCelsius(nuevatemp); //Darle temperatura a la estacion para que avise a los demas
          }
        };

        boton_introducir.addActionListener(oyente);      
        
        JLabel etiqueta_pantalla = new JLabel();
        
        if(observador_cambiador.hayTemperaturasNuevas())
            etiqueta_pantalla.setText( "Temperatura en Celsius: "+ observador_cambiador.getCelsius() +
            " - Temperatura en Fahrenheit: " + observador_cambiador.getFahrenheit()); //Etiqueta que muestre las temperaturas
        else
        {
            etiqueta_pantalla.setText("ERROR - NO HAY TEMPERATURAS NUEVAS"); 
            etiqueta_pantalla.setForeground(Color.red);
        }

        etiqueta_pantalla.setBounds(10, 50, 400,40);
        panel_cambiador.add(etiqueta_pantalla);
        
        Timer timer = new Timer(1000, new ActionListener() 
        {
            public void actionPerformed(ActionEvent evt) {
                
                //Refresh the panel
                if(observador_cambiador.hayTemperaturasNuevas())
                {
                    etiqueta_pantalla.setText( "Temperatura en Celsius: "+ observador_cambiador.getCelsius() +
                    " - Temperatura en Fahrenheit: " + observador_cambiador.getFahrenheit()); //Etiqueta que muestre las temperaturas
                    etiqueta_pantalla.setForeground(Color.black);
                }
                
                else
                {
                    etiqueta_pantalla.setText("ERROR - NO HAY TEMPERATURAS NUEVAS"); 
                    etiqueta_pantalla.setForeground(Color.red);
                }
            }
        });

        timer.start();
    }
    
    
}
