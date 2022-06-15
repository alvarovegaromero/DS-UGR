/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author
 */
public class BicicletaCarretera extends Bicicleta
{
    private static int contador_bicis_carretera = 0; //Contador del numero de bicis de carretera creadas
    
    public BicicletaCarretera()
    {
        identificador_carrera = contador_bicis_carretera; //Dorsales en funcion de la llegada
        contador_bicis_carretera++;
        tipo = Tipo.CARRETERA;                  //Crear tipo para crear un ToString común en la clase abstracta
    }
}
