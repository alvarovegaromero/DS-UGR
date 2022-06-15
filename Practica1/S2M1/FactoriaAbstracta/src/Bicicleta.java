
import java.util.logging.Level;
import java.util.logging.Logger;



/**
 *
 * @author
 */
public abstract class Bicicleta extends Thread{
    int identificador_carrera;
    Tipo tipo; //No podemos ponerlos privados porque luego los modificamos en las subclases 
    boolean ha_abandonado = false; //Indica si la bici ha abandonado, por defecto, false
    int tiempo_abandono; //Atributo que solo nos interesa de los que han abandonado
    //TODO 
    
    @Override 
    public String toString()
    {
        return ("Bicicleta de " + tipo + " con el id " + identificador_carrera);
    }
    
    void abandona(int tiempo)
    {
        ha_abandonado = true;
        tiempo_abandono = tiempo; //Momento en el que abandona
    }
    
    boolean haAbandonado()
    {
        return ha_abandonado;
    }
    
    @Override
    public void run()
    {   
        try {
            sleep(60000); //60s que despierte a los 60s (la duracion)
        } catch (InterruptedException ex) {
            Logger.getLogger(Bicicleta.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        if(ha_abandonado)
            System.out.println(toString() + ", abandonó la carrera en el instante: " + tiempo_abandono);
        else
            System.out.println(toString() + ", ha acabado la carrera correctactamente");
    }
}
