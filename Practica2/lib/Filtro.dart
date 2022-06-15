import 'Producto.dart';

/**
 * @brief Interfaz filtro
 * @param producto Lista de productos
 * @param valorFiltros Lista de filtros que se van a aplicar
 */
 // List<int> valorFiltros no hace falta
abstract class Filtro {
    List<Producto> ejecutar(List<Producto> productos, var valor);
}