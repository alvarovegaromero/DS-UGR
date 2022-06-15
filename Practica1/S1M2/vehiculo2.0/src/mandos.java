
import java.awt.Color;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import static java.lang.Thread.sleep;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JToggleButton;
import javax.swing.SwingConstants;
import javax.swing.Timer;
import static javax.swing.WindowConstants.EXIT_ON_CLOSE;
import javax.swing.border.Border;

/**
 *
 * @author 
 */
public class mandos extends JFrame implements Runnable
{
    JPanel panel_mandos;
    JLabel etiqueta_estado = new JLabel(); //Apagado - Acelerando - Encendido y Frenando
    JToggleButton boton_encender = new JToggleButton(); //Encender - Apagar
    JToggleButton boton_acelerar = new JToggleButton(); //Acelerar - Soltar acelerador
    JToggleButton boton_freno = new JToggleButton(); //Frenar - Soltar freno
    estadoMotor estado_motor = (estadoMotor.APAGADO); //inicialmente apagado
    cliente client;
    objetivo obj;

    public mandos(cliente client, objetivo obj) //Le pasamos el cliente??
    {
        this.client = client;
        this.obj = obj;
        
        configurarVentana();
        
        crearVentana();
        
        /* Timer o hebra
        Timer timer = new Timer(1000, new ActionListener() //Timer para enviar la informacion - Podría hacerse con hebra con sleep y sendRequest simplemente
        {
            public void actionPerformed(ActionEvent evt) {
                    client.sendRequest(obj.getRevoluciones(),estado_motor);
                }
            });

        timer.start();
        */
    }
    
    private void configurarVentana()
    {
        setSize(600, 300); //Tamaño original de la ventana
        setTitle("Mandos"); //Nombre de la ventana
        setMinimumSize(new Dimension(600, 300)); //Min tamaño ventana

        setDefaultCloseOperation(EXIT_ON_CLOSE); //Que se cierre la ventana
    }  
   
    private void crearVentana()
    {        
        panel_mandos = new JPanel(); //Creamos panel para todo el controlador
        panel_mandos.setLayout(null);
        panel_mandos.setVisible(true); //La activamos

        this.getContentPane().add(panel_mandos);
        
        panel_mandos.setBorder(BorderFactory.createTitledBorder("mandos"));
        
        //Etiqueta del estado del coche
        
        etiqueta_estado.setForeground(Color.red);
        Border border = BorderFactory.createLineBorder(Color.BLACK, 2);
        etiqueta_estado.setBorder(border);
        etiqueta_estado.setBounds(150,20, 300,100);
        etiqueta_estado.setText("APAGADO");
        etiqueta_estado.setHorizontalAlignment(SwingConstants.CENTER); //Centrarlo horizontal y verticalmente
        etiqueta_estado.setVerticalAlignment(SwingConstants.CENTER);        
        panel_mandos.add(etiqueta_estado);
        
        //Boton para encender y apagar el coche
        
        boton_encender.setForeground(Color.GREEN);
        boton_encender.setBounds(30, 150, 150, 50);
        boton_encender.setText("ENCENDER");
        
        boton_encender.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                boton_encendido(evt);
            }
        });
        
        panel_mandos.add(boton_encender);
        
        //Boton para acelerar y dejar de acelerar
        
        boton_acelerar.setText("ACELERAR"); 
        boton_acelerar.setBounds(220, 150, 150, 50);
        
        boton_acelerar.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                boton_acelerar(evt);
            }
        });
        
        panel_mandos.add(boton_acelerar);
        
        //Boton para frenar y dejar de frenar

        boton_freno.setText("FRENAR");        
        boton_freno.setBounds(410, 150, 150, 50);
        boton_freno.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                boton_freno(evt);
            }
        });
        
        panel_mandos.add(boton_freno);
    }
    
    private void boton_encendido(ActionEvent evt) //Metodo que simula las acciones que hace el boton de encendido
    {
        if(etiqueta_estado.getText().equals("APAGADO"))  //Si está apagado, encender y sus acciones asociadas
        {
            etiqueta_estado.setText("ENCENDIDO");
            etiqueta_estado.setForeground(Color.GREEN);            
            //etiqueta_estado.setForeground(Color.BLACK);                  
            estado_motor = (estadoMotor.ENCENDIDO); //Cambiar el estado del motor
            boton_encender.setText("APAGAR");
            boton_encender.setForeground(Color.RED);
        } 
        else //Si está encendido, apagar y sus acciones(puede apagar mientras frena y acelera aunque no se recomiende)
        {
            etiqueta_estado.setText("APAGADO");
            etiqueta_estado.setForeground(Color.RED);
            estado_motor = (estadoMotor.APAGADO);
            boton_encender.setText("ENCENDER");
            boton_encender.setForeground(Color.GREEN);
        }
    }
    
    private void boton_acelerar(ActionEvent evt) //Acciones del boton de acelerar
    {
        if(etiqueta_estado.getText().equals("ENCENDIDO") ) //Solo si está encendido puede acelerar
        {
            etiqueta_estado.setText("ACELERANDO"); //Cambiamos el estado del coche
            etiqueta_estado.setForeground(Color.BLACK);
            estado_motor = (estadoMotor.ACELERANDO);
            
            boton_acelerar.setText("Soltar acelerador"); //Cambiamos el texto del boton
            boton_acelerar.setForeground(Color.RED);
        }
        else if(etiqueta_estado.getText().equals("ACELERANDO"))//Si esta ya acelerando, dejamos de acelerar
        {
            etiqueta_estado.setText("ENCENDIDO");
            etiqueta_estado.setForeground(Color.GREEN);
            //etiqueta_estado.setForeground(Color.BLACK);                  
            estado_motor = (estadoMotor.ENCENDIDO);
            
            boton_acelerar.setText("ACELERAR");
            boton_acelerar.setForeground(Color.black);
        }     
    }

    private void boton_freno(ActionEvent evt) //Acciones del boton de frenar
    {
        if(etiqueta_estado.getText().equals("ENCENDIDO")) //Solo frena si está encendido
        {
            etiqueta_estado.setText("FRENANDO");
            etiqueta_estado.setForeground(Color.BLACK);
            
            estado_motor = (estadoMotor.FRENANDO);

            
            boton_freno.setText("Soltar freno");
            boton_freno.setForeground(Color.red);
        }
        
        else if(etiqueta_estado.getText().equals("FRENANDO")) 
        {
            etiqueta_estado.setText("ENCENDIDO");
            etiqueta_estado.setForeground(Color.GREEN);
            
            estado_motor = (estadoMotor.ENCENDIDO);

            boton_freno.setText("FRENAR");
            boton_freno.setForeground(Color.BLACK);
        }   
    } 

    @Override
    public void run() {
        while(true)
        {
            try {
                sleep(1000); //1s
            } catch (InterruptedException ex) {
                Logger.getLogger(mandos.class.getName()).log(Level.SEVERE, null, ex);
            }

            client.sendRequest(obj.getRevoluciones(),estado_motor);
        }
    }
}
