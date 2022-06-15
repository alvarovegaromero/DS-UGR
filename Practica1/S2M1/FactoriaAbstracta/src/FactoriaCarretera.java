/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author
 */
public class FactoriaCarretera extends FactoriaCarreraYBicicleta {
    
   @Override
   public Bicicleta crearBicicleta()
   {
       return new BicicletaCarretera();
   }

    @Override
    public Carrera crearCarrera(int num_bicicletas) {
        CarreraCarretera carrera = new CarreraCarretera();
        
        for(int i = 0; i < num_bicicletas ; i++)
            carrera.aniade(crearBicicleta());
        
        return carrera;
    }
}
