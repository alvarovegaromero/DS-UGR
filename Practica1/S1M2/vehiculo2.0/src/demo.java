
import java.util.concurrent.TimeUnit;

public class demo 
{
    public static void main(String[] args) throws InterruptedException 
    {
        objetivo obj = new objetivo();
        gestorFiltros filterManager = new gestorFiltros(obj); //Creamos un objeto objetivo que se lo añadimos al gestor de filtros creaado
        filterManager.setFilter(new filtroRepercutirRozamiento()); //Creamos filtro 1 y lo añadimos
        filterManager.setFilter(new filtroCalcularVelocidad()); //Lo mismo con filtro 2
  
        cliente client = new cliente(); //Creamos cliente y le añadimos el gestor de filtros
        client.setFilterManager(filterManager);  
        
        salpicadero prueba = new salpicadero(obj); //Ventana salpicadero
        prueba.setLocation(600, 20); //Poner el salpicadero a la derecha
        prueba.setVisible(true);
        
        mandos controlador = new mandos(client, obj); //Ventana controlador
        controlador.setLocation(0, 20); //Poner controlador a la izq
        controlador.setVisible(true);
        
        Thread hilo1 = new Thread(prueba);
        Thread hilo2 = new Thread(controlador);

        hilo1.start();
        hilo2.start();
        //prueba.run();
        //controlador.run();
        
        //Ojo, revoluciones que se pasan las "previas"
        /* Para probar el salpicadero
        client.sendRequest(0, estadoMotor.APAGADO);     
            TimeUnit.SECONDS.sleep(1);
        client.sendRequest(0, estadoMotor.ENCENDIDO);
            TimeUnit.SECONDS.sleep(1);
        client.sendRequest(0, estadoMotor.ACELERANDO);
            TimeUnit.SECONDS.sleep(1);
        client.sendRequest(100, estadoMotor.ACELERANDO);
            TimeUnit.SECONDS.sleep(1);
        client.sendRequest(200, estadoMotor.ACELERANDO);
            TimeUnit.SECONDS.sleep(1);
        client.sendRequest(300, estadoMotor.ACELERANDO);     
            TimeUnit.SECONDS.sleep(1);
        client.sendRequest(400, estadoMotor.ACELERANDO);
                TimeUnit.SECONDS.sleep(1);
        client.sendRequest(500, estadoMotor.FRENANDO);
                TimeUnit.SECONDS.sleep(1);
        client.sendRequest(400, estadoMotor.FRENANDO);
                TimeUnit.SECONDS.sleep(1);
        client.sendRequest(300, estadoMotor.FRENANDO);
                TimeUnit.SECONDS.sleep(1);
        client.sendRequest(200, estadoMotor.ACELERANDO);
                TimeUnit.SECONDS.sleep(1);
        client.sendRequest(300, estadoMotor.FRENANDO);
                TimeUnit.SECONDS.sleep(1);
        client.sendRequest(200, estadoMotor.FRENANDO);
                TimeUnit.SECONDS.sleep(1);
        client.sendRequest(100, estadoMotor.FRENANDO);
                TimeUnit.SECONDS.sleep(1);
        client.sendRequest(0, estadoMotor.APAGADO);
                TimeUnit.SECONDS.sleep(1);
*/
     }
}

