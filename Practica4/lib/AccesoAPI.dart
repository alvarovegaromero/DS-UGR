// ignore_for_file: unnecessary_new

import 'API.dart';

import 'EstadoProducto.dart';
import 'Producto.dart';
import 'TipoProducto.dart';
import 'Usuario.dart';
import 'dart:io';

class AccesoAPI {
  static const String _baseAddress = 'clados.ugr.es';
  static const String _applicationName = 'DS3_2/api/v1/';

  bool comprarProducto(int id_producto, Usuario usuario) {
    //No hace nada pero contemplado para cuando llegase su momento
    //return _acceso_api.comprarProducto(id_producto, usuario);
    //print(usuario.nombre + " " + usuario.correo + " " + usuario.direccion);
    return true;
  }

  Producto? getProducto(int id_producto) {
    //No usado
    return null;
  }

  Usuario? comprobarLogin(String nombre_usuario, String password) {
    
    if(usernames.isEmpty)
      API.getUsernamesFuture();
      
    int indice_encontrado = 0;
    bool encontrado = false;
    
    for(int i = 0 ;  (i < usernames.length) & (!encontrado); i++) {
      if(usernames[i].username == nombre_usuario)
      {
        indice_encontrado = i; //se aumenta indice no se por qué
        encontrado = true; //existe el usuario
      }
    }

    if(encontrado){ //Si existe, comprobar que la password es la misma
      API.getUsuarioFuture(usernames[indice_encontrado].id_usuario);
      if(user_probar?.contrasenia == password){
        return user_probar;
      }
    }
    return null;
  }

  bool registrarse(
      String username, String password, String direccion, String correo) {
    API.createUsuario(
        username: username,
        password: password,
        correo: correo,
        direccion: direccion);

    return fin_registro;
  }

  List<Producto> getProductos() {
    //Al final no lo usamos pero deberiamos
    // problema es que al ser future el getProductosFuture, vista y controlador
    // hacen que se llame al getProductosFuture y se dupliquen producto al inicialmente
    // no ver que esta relleno
    if (catalogoProductos.isEmpty) {
      API.getProductosFuture(); //obtener de la API
    }

    return catalogoProductos;
  }
}
