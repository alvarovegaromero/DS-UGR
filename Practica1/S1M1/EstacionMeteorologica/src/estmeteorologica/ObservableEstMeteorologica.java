package estmeteorologica;
import java.util.Observable;

/**
 *
 * @author Álvaro y Alex
 */
public class ObservableEstMeteorologica extends Observable
{
    private double temperatura; //temperatura en celsius
    private boolean hay_temperaturas_nuevas = false;

    public double getTemperatura_observada() {
        return temperatura;
    }

    public void setTemperatura_observada(double temperatura_observada) {
        this.temperatura = temperatura_observada;
        hay_temperaturas_nuevas = true;
    }

    public void setTemperaturaObservadores(double temperatura_observada)
    {
        hay_temperaturas_nuevas = true;
        setTemperatura_observada(temperatura_observada);
        setChanged();
        notifyObservers();
    }
    
    boolean hayTemperaturasNuevas()
    {
        return hay_temperaturas_nuevas;
    }
    
}
