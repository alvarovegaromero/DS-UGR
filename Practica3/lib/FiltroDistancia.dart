import 'Filtro.dart';
import 'Producto.dart';

class FiltroDistancia implements Filtro {
  List<Producto> ejecutar(List<Producto> productos, var valor){

    int valor_filtro = valor[0];
    List<Producto> resultado = [];

    for(var i = 0; i < productos.length; i++){
      if(productos[i].distancia <= valor_filtro) // si la distancia es menor o igual a la de la búsqueda
        resultado.add(productos[i]);
    }
    
    return resultado;
  }
}