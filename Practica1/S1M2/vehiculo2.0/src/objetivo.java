import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class objetivo {
    // Atributos
    double vangular = 0, vlineal = 0; //OJO, vangular = revoluciones
    double distancia_recorrida = 0, distancia_sumada = 0; //total vs la recorrida en este segundo
    //Salpicadero un_salpicadero = new Salpicadero();;
    long startTime = 0, endTime = 0;

    // Métodos
    double convertir(double rev){ // convierte las revoluciones en velocidad lineal
        double v = 2 * Math.PI * 0.15 * rev * 0.06; //v = 2πr × RPM × (60/1000)km/h,

        return v;
    }

    // double porque cabecera es asi
    double ejecutar(double revoluciones, estadoMotor estadoMotor){ // revoluciones calculadas (ya han pasado por los filtros)
        startTime = (System.currentTimeMillis()-endTime); //endtime es 0 al principio
        System.out.println(" --- Ejecutando petición ---");
        System.out.println(" ESTADO MOTOR: " + estadoMotor.toString());
   
        vangular = revoluciones;
        vlineal = convertir(revoluciones); // pasar revs a vlineal
        double vlineal_m_ms = vlineal/3600; //m/ms

        // (para que me de la distancia recorrida en el anterior)
        distancia_sumada =(vlineal_m_ms * startTime)/1000;// D = v * t (km)
        distancia_recorrida += distancia_sumada ; 

        System.out.println(" Velocidad lineal: " + String.format("%.2f", vlineal) + " km/h"); // Sólo dos decimales
        System.out.println(" Revoluciones: " + vangular + " rpm");
        System.out.println(" Distancia total: " + distancia_recorrida + " km");
        System.out.println(" Distancia reciente: " + distancia_sumada +" km" + "\n\n");
        //un_salpicadero.setVariables(distancia_recorrida, vangular, String.format("%.2f", vlineal), distancia_sumada);
        
        endTime =(System.currentTimeMillis());

        return revoluciones;
    }

    public double getRevoluciones() {
        return vangular;
    }

    public double getVelocidad() {
        return vlineal;
    }

    public double getDistanciaTotal() {
        return distancia_recorrida;
    }

    public double getDistanciaReciente() {
        return distancia_sumada;
    }
    
}
