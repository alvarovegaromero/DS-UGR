//Usaremos variante de controlador ligero

import 'Producto.dart';
import 'Objetivo.dart';
import 'package:flutter/material.dart';

class VistaModelo {
  Objetivo? _objetivo;
  List<Producto> _catalogo_final = [];
  bool primera_vez = true;

  VistaModelo(Objetivo obj, List<Producto> catalogo_inicial) {
    _objetivo = obj;

    _catalogo_final = catalogo_inicial;
  }

  VistaModelo.sinLista(Objetivo obj) {
    _objetivo = obj;
  }

  void cambiarCatalogo(List<Producto> lista) {
    //Por si inicialmente no tiene lista
    _catalogo_final = lista;
  }

  void _actualizarProductos() {
    _catalogo_final = _objetivo!.catalogo_final;
  }

  List<Producto> getCatalogo() {
    return _catalogo_final;
  }

  void finPrimeraVez() {
    primera_vez = false;
  }

  List<Producto> getProductosFiltrados() {
    if (_objetivo!.catalogo_final.isNotEmpty)
      _actualizarProductos();
    else if (!primera_vez) return [];

    return _catalogo_final;
  }

  //Si el estado de un producto es nuevo, devuelve nuevo, y no estadoProducto.nuevo
  static String formateaEstadoProducto(String cadena) {
    String resultado = "Indefinido";

    if (cadena == 'EstadoProducto.bueno') {
      resultado = "Bueno";
    } else if (cadena == 'EstadoProducto.excelente') {
      resultado = "Excelente";
    } else if (cadena == 'EstadoProducto.nuevo') {
      resultado = "Nuevo";
    } else if (cadena == 'EstadoProducto.roto') {
      resultado = "Roto";
    }

    return resultado;
  }

  static String formateaTipoProducto(String cadena) {
    String resultado = "Indefinido";

    if (cadena == 'TipoProducto.cuadro') {
      resultado = "Cuadro";
    } else if (cadena == 'TipoProducto.lienzo') {
      resultado = "Lienzo";
    } else if (cadena == 'TipoProducto.pincel') {
      resultado = "Pincel";
    } else if (cadena == 'TipoProducto.lapices') {
      resultado = "Lapices";
    } else if (cadena == 'TipoProducto.caballete') {
      resultado = "Caballete";
    } else if (cadena == 'TipoProducto.escultura') {
      resultado = "Escultura";
    }

    return resultado;
  }

  //Flutter - Metodo que devuelve una lista de productos
  // OJO: si no hay producto resultado de aplicar los filtros, no actualiza los containers. Hay error de index out of range
  List<Widget>
      getProductosFiltradosWidget() //Devolver una lista con todos los widget
  {
    List<Widget> lista_widget = [];
    Widget tmp;

    if (_objetivo!.catalogo_final.isNotEmpty) {
      _actualizarProductos();
    }

    for (var i = 0; i < _catalogo_final.length; i++) {
      tmp = Container(
          margin:
              const EdgeInsets.only(top: 2.5, bottom: 2.5, right: 10, left: 10),
          padding: const EdgeInsets.all(2.5),
          /*
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.orange,
            width: 1.5,
            ),
          borderRadius: BorderRadius.circular(5),
        ),*/
          child: Column(
              //porque container solo tiene un hijo
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(_catalogo_final[i].nombre,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Precio: " +
                    _catalogo_final[i].precio.toString() +
                    "€"), //TODO ponerlo a la derecha en grande?
                Text("Distancia al producto: " +
                    _catalogo_final[i].distancia.toString() +
                    "km"),
                Text("Estado: " +
                    formateaEstadoProducto(
                        _catalogo_final[i].estado.toString())),

                /*SizedBox( //Boton Comprar
              width: 10,
              child : FlatButton(
                onPressed: () {}, 
                child: Text('Comprar'),
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000)
                ),
              )
            )*/
              ]));

      lista_widget.add(tmp);
    }

    return lista_widget;
  }
}
