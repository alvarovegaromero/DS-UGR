public class gestorFiltros {
    cadenaFiltros filterChain;

   // constructor 
   public gestorFiltros(objetivo target){
      filterChain = new cadenaFiltros();
      filterChain.setTarget(target);
   }

   // Añadir un filtro a la cadena de filtros
   public void setFilter(filtro filter){
      filterChain.addFilter(filter);
   }

   // Ejecutar los filtros de la cadena de filtros
   public double filterRequest(double revoluciones, estadoMotor estadoMotor){
       double rev;
       rev = filterChain.ejecutar(revoluciones, estadoMotor);
       return rev;
   }
}
