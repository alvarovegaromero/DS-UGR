import 'package:http/http.dart' as http;
import 'dart:convert';

import 'EstadoProducto.dart';
import 'Producto.dart';
import 'TipoProducto.dart';
import 'Usuario.dart';

List<Producto> catalogoProductos = [];
bool productos_listos = false;
bool fin_registro = true;
List<StructUsernameID> usernames = [];
Usuario? user_probar = null;

class StructUsernameID {
  //Struct con el id y username, para en caso de que exista el usuario, cargar
  // sus datos
  int id_usuario = 0;
  String username = "";

  StructUsernameID(this.username, this.id_usuario);
}

class API {
  static const String _baseAddress = 'clados.ugr.es';
  static const String _applicationNameUsuarios = 'DS3_2/api/v1/usuarios';
  static const String _applicationNameProductos = 'DS3_2/api/v1/productos';

  static Producto productosfromJson(Map<String, dynamic> json) {
    return Producto(
        json['precio'],
        json['distancia'],
        json['nombre'],
        json['descripcion'],
        Producto.tipoJSON(json['tipo']),
        Producto.estadoJSON(json['estado']),
        json['id']);
  }

  static Future<bool> getProductosFuture() async {
    //Cogeriamos todos los produtos de la BD y los enviariamos
    final response = await http.get(
        Uri.https(_baseAddress, _applicationNameProductos),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      var parsedJson = jsonDecode(response.body);
      for (final item in parsedJson) {
        catalogoProductos.add(productosfromJson(item));
      }
      return true;
    } else {
      throw Exception('No se pudo obtener los productos');
      return false;
    }
  }

  ////////////// create ///////////////

  static void createUsuario(
      {required String username,
      required String password,
      required String direccion,
      required String correo}) async {
    final response = await http.post(
      Uri.https(_baseAddress, _applicationNameUsuarios),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nombreusuario': username,
        'direccion': direccion,
        'correo': correo,
        'password': password,
        'nombre': '',
        'apellidos': '',
        'telefono': 0
      }),
    );
    if (response.statusCode == 201) {
      //return Usuario.fromJson(jsonDecode(response.body));
      fin_registro = true;
    } else {
      throw Exception('Failed to create user');
      fin_registro = false;
    }
  }

  ////////////////////////////////////////////////////////////////////////////

  static StructUsernameID usuariosfromJsonToUsername(
      Map<String, dynamic> json) {
      return StructUsernameID(json['nombreusuario'], json['id']);
  }

  static Future<bool> getUsernamesFuture() async {
    //Cogeriamos todos los produtos de la BD y los enviariamos
    final response = await http.get(
        Uri.https(_baseAddress, _applicationNameUsuarios),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      var parsedJson = jsonDecode(response.body);
      for (final item in parsedJson) {
        usernames.add(usuariosfromJsonToUsername(item));
      }
      return true;
    } else {
      throw Exception('No se pudo obtener los username');
    }
  }

  ////////////////////////////////////////////////////////////////////////////

  static Usuario usuarioFromJson(Map<String, dynamic> json) {
    return Usuario.otroConstructor(
        json['nombreusuario'] as String,
        json['correo'] as String,
        json['direccion'] as String,
        json['password'] as String
    );
  }

  static Future<bool> getUsuarioFuture(int id) async {
    //Cogeriamos todos los produtos de la BD y los enviariamos
    final response = await http.get(
        Uri.https(_baseAddress, _applicationNameUsuarios + '/' + id.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      var parsedJson = jsonDecode(response.body);

      user_probar = usuarioFromJson(parsedJson); //solo hay un elemento
      return true;
    } else {
      throw Exception('No se pudo obtener el usuario');
      return false;
    }
  }
}
