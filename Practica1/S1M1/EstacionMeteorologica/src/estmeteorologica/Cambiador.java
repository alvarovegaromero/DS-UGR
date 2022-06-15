package estmeteorologica;

import java.util.Observer;
import java.util.Observable;
import java.util.logging.Level;
import java.util.logging.Logger;


public class Cambiador extends Thread implements Observer{
    private ObservableEstMeteorologica sujetoObservable;
    private double temperatura; //temperatura en celsius
  
    Cambiador(Observable estacion){
        sujetoObservable = (ObservableEstMeteorologica) estacion;
    }

    Cambiador(Observable estacion, Observer observador){
        super("Observador");
        sujetoObservable = (ObservableEstMeteorologica) estacion;
    }
    
    @Override
    public void update(Observable observable, Object arg)
    {
      sujetoObservable = (ObservableEstMeteorologica) observable;
      temperatura = sujetoObservable.getTemperatura_observada();
    }
    
    public double getFahrenheit()
    {
      return Math.round(((temperatura * 1.8) + 32.00)*100.0)/100.0; //Formula de conversion a Fahrenheit y redondendeo a 2 dec
    }

    public double getCelsius()
    {
        return temperatura;
    }
    
    public void setTemperaturaCelsius(double temperatura)
    {
        sujetoObservable.setTemperaturaObservadores(temperatura);
    }
    
    public boolean hayTemperaturasNuevas()
    {
        return sujetoObservable.hayTemperaturasNuevas();
    }
    
    @Override
    public void run(){
        while(true){
            update(sujetoObservable, null);
            try {
                sleep(2000);
            } catch (InterruptedException ex) {
                Logger.getLogger(Cambiador.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }    
}

