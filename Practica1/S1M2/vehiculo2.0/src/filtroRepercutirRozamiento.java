public class filtroRepercutirRozamiento implements filtro
{
    public double ejecutar(double revoluciones, estadoMotor estadoMotor)
    {
        double disminucion = 1, rev_finales;
        
        rev_finales = revoluciones - disminucion;  // Se quita un valor constante
        
        if(rev_finales < 0) // Para evitar rozamiento cuando está parado
            rev_finales = 0;

        return rev_finales;
    }
}
