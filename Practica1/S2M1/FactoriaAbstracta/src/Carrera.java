
import static java.lang.Thread.sleep;
import java.util.ArrayList;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author
 */
public abstract class Carrera extends Thread{
    ArrayList<Bicicleta> bicicletas = new ArrayList<Bicicleta>();
    double porcentaje_abandono; //En funcion de si es montania o carretera, valdra mas o menos
    Tipo tipo;
    int duracion_carrera = 60; //60s
    
    /* Podría tener sentido tener un constructor al que le pasemos las bicicletas
    public Carrera(ArrayList<Bicicleta> bicicletas)
    {
        this.bicicletas = bicicletas;
    }
    */
    
    @Override
    public String toString()
    {
        return ("Carrera tipo " + tipo);
    }
    
    public void aniade(Bicicleta bici) //Permite añadir bicicletas una a una
    {
      bicicletas.add(bici);
    }
    
    public int num_bicicletas()
    {
        return bicicletas.size();
    }
    
    public int duracion_carrera()
    {
        return duracion_carrera;
    }
            
    private void iniciarCarrera()
    {
        System.out.println(toString() + " ha comenzado");
        for(int i = 0 ;  i < num_bicicletas() ; i++)
        {
            bicicletas.get(i).start(); //Iniciar la bicicleta y mostrar mensaje con info de la bicicleta
            System.out.println("Ha comenzado la carrera: " + bicicletas.get(i).toString());
        }
    }
    
    @Override
    public void run()
    {
        int num_abandonos = (int) (porcentaje_abandono * num_bicicletas()); //Total de bicicletas que deben abandonar la carrera
        Random aleatorio = new Random();
        int tiempo_abandonar = aleatorio.nextInt(duracion_carrera); //Crea valor aleatorio entre 0 y 59. Todas las bicicletas abandonan a la vez
        int num_aleatorio;
        
        for(int i = 0 ; i < num_abandonos ; i++)
        {
            num_aleatorio = aleatorio.nextInt(bicicletas.size()); //Una bicicleta aleatoria
            if(!bicicletas.get(num_aleatorio).haAbandonado()) //Si no ha abandonado ya, marcamos que ha abandonado
                bicicletas.get(num_aleatorio).abandona(tiempo_abandonar); 
            else //Si ha abandonado, encontrar otra y marcar que abandona
            {
                while(bicicletas.get(num_aleatorio).haAbandonado())
                    num_aleatorio = aleatorio.nextInt(bicicletas.size());
                
                bicicletas.get(num_aleatorio).abandona(tiempo_abandonar); 
            }
                
        }
        
            //Cogemos una bicicleta aleatoria y le indicamos que "abandona".
            //TODO ¿si sale dos vecs la misma bicicleta? ¿vector de booleanos para saber si ya ha abandona?
        
        iniciarCarrera();
        
        try {
            sleep(1000 * duracion_carrera); //60 * 1000 ms = 60s
        } catch (InterruptedException ex) {
            Logger.getLogger(Carrera.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
}
