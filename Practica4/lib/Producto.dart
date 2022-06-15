import 'EstadoProducto.dart';
import 'TipoProducto.dart';

class Producto {
// Declaración de variables
  double _precio = 0.0;
  double _distancia = 0.0; //en km
  var _nombre = "";
  var _descripcion = "";
  EstadoProducto _estado = EstadoProducto.nuevo;
  TipoProducto _tipoProducto = TipoProducto.lapices;
  int _id_producto = 0;
  //añadir foto ¿url
  //varl url = "http://algo.com"

// Getters y Setters
  double get precio => _precio;
  double get distancia => _distancia;
  String get nombre => _nombre;
  String get descripcion => _descripcion;
  EstadoProducto get estado => _estado;
  TipoProducto get tipo => _tipoProducto;
  int get id_producto => _id_producto;

  void set precio(double unPrecio) {
    _precio = unPrecio;
  }

  void set distancia(double unaDistancia) {
    _distancia = unaDistancia;
  }

  void set nombre(String unNombre) {
    _nombre = unNombre;
  }

  void set descripcion(String unaDescripcion) {
    _descripcion = unaDescripcion;
  }

  void set estado(EstadoProducto e) {
    _estado = e;
  }

  void set tipo(TipoProducto p) {
    _tipoProducto = p;
  }

  void set id_producto(int id) {
    _id_producto = id;
  }

  // Constructores
  //Opcion 1
  /*
  Producto(double precio, double distancia, String nombre, String descripcion, EstadoProducto estado, TipoProducto tipo){
    this._precio = precio;
    this._distancia = distancia;
    this._nombre = nombre;
    this._descripcion = descripcion;
    this._tipoProducto = tipo;
    this._estado = estado;
  }*/
  //Opcion 2 resumido
  Producto(this._precio, this._distancia, this._nombre, this._descripcion,
      this._tipoProducto, this._estado, this._id_producto);

  static TipoProducto tipoJSON(String cadena) {
    TipoProducto resultado = TipoProducto.cuadro; //por defecto cuadro

    if (cadena == 'lienzo') {
      resultado = TipoProducto.lienzo;
    } else if (cadena == 'pincel') {
      resultado = TipoProducto.pincel;
    } else if (cadena == 'lapices') {
      resultado = TipoProducto.lapices;
    } else if (cadena == 'caballete') {
      resultado = TipoProducto.caballete;
    } else if (cadena == 'escultura') {
      resultado = TipoProducto.escultura;
    }

    return resultado;
  }

  static EstadoProducto estadoJSON(String cad) {
    EstadoProducto resultado = EstadoProducto.nuevo; //por defecto

    if (cad == 'roto') {
      resultado = EstadoProducto.roto;
    } else if (cad == 'excelente') {
      resultado = EstadoProducto.excelente;
    } else if (cad == 'bueno') {
      resultado = EstadoProducto.bueno;
    }

    return resultado;
  }

  void asignarEstado(EstadoProducto e){
    _estado = e;
  }

  void asignarTipo(TipoProducto t){
    _tipoProducto = t;
  }
}
