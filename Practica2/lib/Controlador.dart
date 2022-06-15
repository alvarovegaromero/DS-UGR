//Usaremos variante de controlador ligero

import 'Cliente.dart';
import 'Producto.dart';

class Controlador 
{
  Cliente? _cliente;
  List<List<int>> matriz_filtros = []; 
  List<Producto> _catalogo_inicial = []; //catalogo con todos los productos

  List<Producto> get catalogo_inicial => _catalogo_inicial;

  Controlador(Cliente cli, List<Producto> catalogo_ini)
  {
    _cliente = cli;
    _catalogo_inicial = catalogo_ini;

    //Inicializar filtros con valor "no hay filtros"
    List<int> lista_filtro1 = [-1]; 
    List<int> lista_filtro2 = [-1];
    List<int> lista_filtro3 = [-1];
    List<int> lista_filtro4 = [-1];

    //Añadir los filtros
    matriz_filtros.add(lista_filtro1);
    matriz_filtros.add(lista_filtro2);
    matriz_filtros.add(lista_filtro3);
    matriz_filtros.add(lista_filtro4);
  }

  void modificarFiltro(int index, List<int> lista) //Cambiar un filtro (para los botones)
  //0 - Precio | 1 - Distancia | 2 - Estado | 3 - Tipo
  {
    if(index <= 3)
      matriz_filtros[index] = lista;
  }

  void modificarFiltros(List<List<int>> filtros) //Cambiar matriz entera
  //0 - Precio | 1 - Distancia | 2 - Estado | 3 - Tipo
  {
    if(filtros.length == 4)
      matriz_filtros = filtros;
  }

  void aplicarFiltros(List<Producto> catalogo) //= Ejecutar 
  //Para ver resultado, ir a vista 
  {
    //Si queremos hacer con todos los productos, aplicar metodo con get catalogo inicial
    _cliente!.enviarPeticion(catalogo, matriz_filtros); //! para no ejecutar si es null 
  }

  //Flutter - Metodo que devuelve container con botones para modificar filtros
}