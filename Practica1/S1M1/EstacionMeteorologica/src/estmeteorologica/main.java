package estmeteorologica;

import java.util.Observer;


/**
 *
 * @author Álvaro y Alex
 */
public class main
{
    
  public static void main(String[] args) 
  {
     
    ObservableEstMeteorologica estacion1 = new ObservableEstMeteorologica();
   
    Observer g1 = new Grafica(estacion1);
    Pantalla p1 = new Pantalla(estacion1);
    Observer c1 = new Cambiador(estacion1);
    
     
    estacion1.addObserver(g1);
    estacion1.addObserver(c1);

    
    // Antes de aplicar hebras y concurrencias
    Ventana v1 = new Ventana(p1);
    Ventana v2 = new Ventana((Grafica) g1);
    Ventana v3 = new Ventana ((Cambiador) c1);
    
    v1.setLocation(200, 200);
    v1.setVisible(true);
    
    v2.setLocation(1200, 200);
    v2.setVisible(true);
    
    v3.setLocation(700, 200);
    v3.setVisible(true);

    Thread hebra1 = new Thread(p1);
    hebra1.start(); 
    
    Thread hebra2 = new Cambiador(estacion1);
    hebra2.start();
    
    Thread hebra3 = new Grafica(estacion1);
    hebra3.start();
   
  }
}
