import 'Producto.dart';

class Objetivo{
    List<Producto> _catalogo_final = []; 

    List<Producto> get catalogo_final => _catalogo_final;

    /**
    * @brief Método que saca por pantalla los productos filtrados por las categorías seleccionadas
    * @param valorFiltros Array de valores de filtros
    */
    void ejecutar(List<Producto> productos, var valorFiltros){
      _catalogo_final = productos;
      
      print("Resumen de Objetivo: ");
      for(var i = 0; i < productos.length; i++){
        var nombre = productos[i].nombre;
        var precio = productos[i].precio;
        var distancia = productos[i].distancia;
        var descripcion = productos[i].descripcion;
        var estado = productos[i].estado.toString().split('.').last; // ej: de "EstadoProducto.roto" imprime "roto"
        var tipo = productos[i].tipo.toString().split('.').last;

        var j = i+1;

        print("---------------------- PRODUCTO $j ----------------------");
        print("Nombre: $nombre");
        print("Precio: $precio");
        print("Distancia: $distancia");
        print("Descripcion: $descripcion");
        print("Estado: $estado");
        print("Tipo: $tipo");
      }
    }
}