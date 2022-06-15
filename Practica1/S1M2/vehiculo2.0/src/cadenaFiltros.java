import java.util.ArrayList;
import java.util.List;

public class cadenaFiltros {
    private List<filtro> filters = new ArrayList<filtro>();
    private objetivo salpicadero;
    
    public void addFilter(filtro f){
        filters.add(f);
    }

    public double ejecutar(double revoluciones, estadoMotor estadoMotor){
        
        double rev = revoluciones;
        
        for(int i = 0 ; i  < filters.size() ; i++) //Aplicar filtros
        {
            rev = filters.get(i).ejecutar(rev, estadoMotor);
        }

        // Enviárselo al salpicadero
        salpicadero.ejecutar(rev, estadoMotor); // ejecutar objetivo - lo usamos como void porque no modifica las revs
        
        return rev;
      } 

    public void setTarget(objetivo target){
        this.salpicadero = target;
    }
}

