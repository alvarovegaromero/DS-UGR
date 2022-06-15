import 'Filtro.dart';
import 'Objetivo.dart';
import 'Producto.dart';

class CadenaFiltros {
  // Variables
  var arrayFiltros = [];
  Objetivo _objetivo;

  //Constructor
  CadenaFiltros(this._objetivo);

  List<Producto> ejecutar(
      List<Producto> productos, List<List<int>> valorFiltros) {
    List<Producto> productosFiltrados =
        productos; // Inicialmente no hemos fitrado nada

    for (var i = 0; i < arrayFiltros.length; i++) {
      var valor = valorFiltros[i];

      if (valor[0] !=
          -1) // Si el valor es -1 o no hay nada en la lista de estado no se aplica el filtro
      {
        var filtro = arrayFiltros[
            i]; // Filtro a aplicar (el 3er filtro (index = 2) es el array de estados)
        productosFiltrados = filtro.ejecutar(productosFiltrados, valor);
      }
    }

    _objetivo.ejecutar(productosFiltrados,
        valorFiltros); // E: no estoy segura de qué parámetros pasarle

    return productosFiltrados;
  }

  void aniadirFiltro(Filtro f) {
    //precio, distancia, estado y tipo
    arrayFiltros.add(f);
  }
}
