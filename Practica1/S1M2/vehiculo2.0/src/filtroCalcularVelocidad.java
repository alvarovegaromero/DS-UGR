public class filtroCalcularVelocidad implements filtro{

    public double ejecutar(double revoluciones, estadoMotor estadoMotor){
        double rev = revoluciones;
        
        if(estadoMotor == estadoMotor.ACELERANDO)
            rev += incrementoVelocidad; // +100
        else if(estadoMotor == estadoMotor.FRENANDO)
            rev -= incrementoVelocidad; // -100

        if(rev > velocidadMAX) //Supera el Maximo
            rev = velocidadMAX;
        else if (rev < 0) //Si es menor que el minimo que es 0
            rev = 0;
        
        return rev;
    }
}

/*
Actualiza y devuelve las revoluciones añadiendo la cantidad incrementoVelocidad 
(un atributo del filtro, puede ser negativa o 0), que debe previamente haberse asignado
 teniendo en cuenta el estado del motor (acelerando, frenando, apagado, encendido).

incrementoVelocidad será −100 RPM  incrementoVelocidad será +100 RPM ???????
 */