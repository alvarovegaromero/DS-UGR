class cliente {
    gestorFiltros filterManager;

    // Definir el gestor de filtros
   public void setFilterManager(gestorFiltros filterManager){
      this.filterManager = filterManager;
   }

   // Envía la petición al gestor de filtros
   public double sendRequest(double revoluciones, estadoMotor estadoMotor){
      return filterManager.filterRequest(revoluciones, estadoMotor);
   }
}
