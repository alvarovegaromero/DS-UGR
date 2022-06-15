//Usaremos variante de controlador ligero

import 'AccesoAPI.dart';
import 'Cliente.dart';
import 'Producto.dart';
import 'Usuario.dart';

class Controlador {
  Cliente? _cliente;
  AccesoAPI? _acceso_api;

  List<List<int>> matriz_filtros = [];
  List<Producto> _catalogo_inicial = []; //catalogo con todos los productos

  List<Producto> get catalogo_inicial => _catalogo_inicial;

  Controlador(Cliente cli, List<Producto> catalogo_ini) {
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

    _acceso_api = new AccesoAPI();
  }

  void cambiarCatalogo(List<Producto> lista) {
    _catalogo_inicial = lista;
  }

  void modificarFiltro(int index, List<int> lista) 
  //Cambiar el valor de un filtro (para los botones)
  //0 - Precio | 1 - Distancia | 2 - Estado | 3 - Tipo
  {
    if (index <= 3) matriz_filtros[index] = lista;
  }

  void modificarFiltros(List<List<int>> filtros) //Cambiar matriz entera
  //0 - Precio | 1 - Distancia | 2 - Estado | 3 - Tipo
  {
    if (filtros.length == 4) matriz_filtros = filtros;
  }

  void aplicarFiltros() //Ejecutar - Para ver resultado, ir a vista
  {
    //Si queremos hacer con todos los productos, aplicar metodo con get catalogo inicial
    _cliente!.enviarPeticion(_catalogo_inicial, matriz_filtros); 
  }

  bool comprarProducto(int id_producto, Usuario usuario) {
    return _acceso_api!.comprarProducto(id_producto, usuario);
  }

  Producto? getProducto(int id_producto) {
    return _acceso_api!.getProducto(id_producto);
  }

  Usuario? comprobarLogin(String username, String password) {
    return _acceso_api!.comprobarLogin(username, password);
  }

  bool registrarse(String username, String password, String correo, String direccion) {
    return _acceso_api!.registrarse(username, password, direccion, correo);
  }

  List<Producto> getProductos() {
    return _acceso_api!.getProductos();
  }
}
