
/**
 *
 * @author
 */
public class FactoriaMontania extends FactoriaCarreraYBicicleta{
    
    @Override
   public Bicicleta crearBicicleta()
   {
       return new BicicletaMontania();
   }

    @Override
    public Carrera crearCarrera(int num_bicicletas) {
        CarreraMontania carrera = new CarreraMontania();
        
        for(int i = 0; i < num_bicicletas ; i++)
            carrera.aniade(crearBicicleta());
        
        return carrera;
    }
}
