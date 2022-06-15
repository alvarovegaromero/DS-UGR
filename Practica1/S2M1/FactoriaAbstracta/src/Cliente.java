
import java.util.Scanner;

/**
 *
 * @author 
 * Es como el "main"
 */
public class Cliente {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        System.out.println("Introduzca cuantas bicicletas quieres en las carreras: ");
        Scanner entrada = new Scanner(System.in); // Para leer el número de bicicletas
        
        int num_bicicletas = entrada.nextInt();
        
        // Usar factorias concretas y
        // crear carrera montania y carrera carretera hacerles .start
        
        FactoriaCarreraYBicicleta fc = new FactoriaCarretera();        
        FactoriaCarreraYBicicleta fm = new FactoriaMontania();
        
        fc.crearCarrera(num_bicicletas).start();
        fm.crearCarrera(num_bicicletas).start();
        
        
    }
    
}
