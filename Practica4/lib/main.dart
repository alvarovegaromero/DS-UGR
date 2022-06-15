// ignore_for_file: unnecessary_new - para que no sea quisquilloso con el formato, unnecessary_new

import 'package:practica2/VistaModelo.dart';

import 'Producto.dart';
import 'TipoProducto.dart';
import 'EstadoProducto.dart';
import 'Cliente.dart';
import 'Objetivo.dart';
import 'GestorFiltros.dart';
import 'FiltroPrecio.dart';
import 'FiltroDistancia.dart';
import 'FiltroEstadoProducto.dart';
import 'FiltroTipoProducto.dart';
import 'Controlador.dart';
import 'WidgetMyApp.dart';
import 'API.dart';

import 'package:flutter/material.dart';

void main() {
  // Crear gestor de filtros y Objetivo
  Objetivo objetivo = new Objetivo();
  GestorFiltros gestorFiltros = new GestorFiltros(objetivo);

  // Añadir los filtros (orden: precio, distancia, estado y tipo)
  gestorFiltros.setFiltro = new FiltroPrecio();
  gestorFiltros.setFiltro = new FiltroDistancia();
  gestorFiltros.setFiltro = new FiltroEstadoProducto();
  gestorFiltros.setFiltro = new FiltroTipoProducto();

  // Crear Cliente
  Cliente cliente = new Cliente();

  // Añadirle al cliente el gestor de filtros
  cliente.setGestorFiltros = gestorFiltros;

  // Crear controlador y vista. Sobre el controlador haremos peticiones y sobre la vista veremos los resultados
  Controlador controlador = new Controlador(cliente,
      []); //No enviamos productos. Cuando iniciemos sesion cargamos los productos
  VistaModelo vista =
      new VistaModelo.sinLista(objetivo); //Constructor sin lista

  //Creamos filtros
  List<int> listaFiltro1 = [];
  List<int> listaFiltro2 = [];
  List<int> listaFiltro3 = [];
  List<int> listaFiltro4 = [];

  API.getUsernamesFuture(); //Los cargamos en el inicio para no tener que esperar
  API.getProductosFuture(); 

  /*
  //Modificamos los valores para los filtros que le pasaremos al controlador
  lista_filtro1.add(-1);
  controlador.modificarFiltro(0,lista_filtro1);

  lista_filtro2.add(-1);
  controlador.modificarFiltro(1,lista_filtro2);

  lista_filtro3.add(-1);
  controlador.modificarFiltro(2,lista_filtro3);

  lista_filtro4.add(6); //-1 es "no hacer nada" - Por defecto ya esta así el controlador
  controlador.modificarFiltro(3,lista_filtro4);
  */

  // Ejecutamos con los filtros que le hemos pasado
  //controlador.aplicarFiltros();

  //Obtener los productos resultantes a través de la vista
  //List<Producto> catFinal = vista.getProductosFiltrados();

  //////////////////////////////////////////////////////////////////////
  //Parte de flutter
  runApp(MyApp(vista, controlador));
}
