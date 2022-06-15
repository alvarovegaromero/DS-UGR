package estmeteorologica;
import static java.lang.Thread.sleep;
import java.util.List;
import java.util.ArrayList;
import java.util.Observer;
import java.util.Observable;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

/**
 *
 * @author Álvaro y Alex
 OJO a lo mejor hace falta constructor
 Cuidado que las temperaturas mantengan la posicion
 */
public class Grafica extends Thread implements Observer
{
    private ObservableEstMeteorologica sujetoObservable;
    private boolean hay_suficientes_temperaturas;
    private boolean hay_grafica_generada;
    private List<Double> temperaturas;
    private final static int MIN_NUM_TEMPERATURAS = 7;
    private boolean temperatura_actualizada;

    Grafica(Observable estacion){
      sujetoObservable = (ObservableEstMeteorologica) estacion;
      temperaturas = new ArrayList<Double>();
      hay_suficientes_temperaturas = false;
      temperatura_actualizada = false;
    }

    @Override
    public void update(Observable observable, Object arg)
    {
      if(sujetoObservable.hayTemperaturasNuevas()){
          
        sujetoObservable = (ObservableEstMeteorologica) observable;

        if(temperaturas.size() >= MIN_NUM_TEMPERATURAS)
        {
          if(!hay_suficientes_temperaturas)
            hay_suficientes_temperaturas = true;

          temperaturas.remove(0);
          //System.out.println(temperaturas);
        }

        temperaturas.add(sujetoObservable.getTemperatura_observada());
        temperatura_actualizada = true;
      }
    }
    
    public boolean temperaturaActualizada(){
        return temperatura_actualizada;
    }

    boolean haySuficientesTemperaturas()
    {
        return hay_suficientes_temperaturas;
    }
    
    boolean hayGraficaGenerada()
    {
        return hay_grafica_generada;
    }

    public ChartPanel crearGrafica()
    {
      hay_grafica_generada = true;
      
      XYSeries oSeries = new XYSeries("Estacion Meteorologica");

      oSeries.add(1, temperaturas.get(0));
      oSeries.add(2, temperaturas.get(1));
      oSeries.add(3, temperaturas.get(2));
      oSeries.add(4, temperaturas.get(3));
      oSeries.add(5, temperaturas.get(4));
      oSeries.add(6, temperaturas.get(5));
      oSeries.add(7, temperaturas.get(6));

      XYSeriesCollection oDataset = new XYSeriesCollection();
      oDataset.addSeries(oSeries);

      JFreeChart oChart = ChartFactory.createXYLineChart("Grafica Temperatura", "Semana", "Temperaturas", oDataset);

      ChartPanel oPanel = new ChartPanel(oChart);
      oPanel.setSize(450,300);
      oPanel.setLocation(0, 30);

      return oPanel;
    }
    
    @Override
    public void run(){
        while(true){
            if(sujetoObservable.hayTemperaturasNuevas())
            update(sujetoObservable, null);
            try {
                sleep(2000);
            } catch (InterruptedException ex) {
                Logger.getLogger(Cambiador.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}

