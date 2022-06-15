
/**
 *
 * @author 
 */
public class BicicletaMontania extends Bicicleta { //implementsRunnable habra que hacerlo en algun lado
    
    private static int contador_bicis_montania = 0; //Contador del numero de bicis de montania creadas
    
    public BicicletaMontania()
    {
        identificador_carrera = contador_bicis_montania; //Dorsales en funcion de la llegada
        contador_bicis_montania++;
        tipo = Tipo.MONTANIA;                  //Crear tipo para crear un ToString común en la clase abstracta
    }
}
