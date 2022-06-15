package estmeteorologica;
import static java.lang.Thread.sleep;
import java.util.Observable;
import java.util.logging.Level;
import java.util.logging.Logger;
;

/**
 *
 * @author Álvaro y Alex
 */

public class Pantalla extends Thread{

    private ObservableEstMeteorologica sujetoObservable;
    
    private double temperatura; //temperatura en celsius

    Pantalla(ObservableEstMeteorologica estacion)
    {
      sujetoObservable = estacion;
    }

    public void pullTemperaturas()
    {
      temperatura = sujetoObservable.getTemperatura_observada();
    }

    public boolean hayTemperaturasNuevas()
    {
        return sujetoObservable.hayTemperaturasNuevas();
    }
  
    public double getFahrenheit()
    {
      return Math.round(((temperatura * 1.8) + 32.00)*100.0)/100.0; //Formula de conversion a Fahrenheit
    }

    public double getCelsius()
    {
        return temperatura;
    }
    
    
   
    @Override
    public void run(){
        while(true){
                System.out.println(temperatura);
                pullTemperaturas();
                try {
                    sleep(2000);
                } catch (InterruptedException ex) {
                     Logger.getLogger(Pantalla.class.getName()).log(Level.SEVERE, null, ex);
                }
        }
    }
    
}
