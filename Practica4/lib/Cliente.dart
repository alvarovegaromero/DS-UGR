import 'Producto.dart';
import 'GestorFiltros.dart';

class Cliente{
  GestorFiltros? _gestor = null;
  List<Producto> _pedido = [];

// Constructor
  Cliente();

  List<Producto> get pedido => _pedido;
  GestorFiltros? get gestor => _gestor;

/**
 * @brief Envía la petición al filter manager y devuelve la lista de productos filtrada
 * @param producto Lista de productos
 * @param valorFiltros Lista de filtros que se van a aplicar
*/
  List<Producto> enviarPeticion(List<Producto> productos, List<List<int>> valorFiltros){
    return _gestor!.filterResquest(productos, valorFiltros);
  }

  void set setGestorFiltros(GestorFiltros g){
    _gestor = g;
  }

  void aniadirProductoPedido(Producto producto) {
    _pedido.add(producto);
  }
}