
public interface filtro {
    final double incrementoVelocidad = 100; // RPM
    final double velocidadMAX = 5000.0; // RPM

    double ejecutar(double revoluciones, estadoMotor estadoMotor);

}

/*
Actualiza y devuelve las revoluciones añadiendo la cantidad incrementoVelocidad 
(un atributo del filtro, puede ser negativa o 0), que debe previamente haberse asignado
 teniendo en cuenta el estado del motor (acelerando, frenando, apagado, encendido).

incrementoVelocidad será −100 RPM  incrementoVelocidad será +100 RPM ???????
 */