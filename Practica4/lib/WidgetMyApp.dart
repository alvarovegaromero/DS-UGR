import 'package:practica2/VistaModelo.dart';
import 'package:practica2/WidgetInicio.dart';

import 'Controlador.dart';

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  VistaModelo? _vistamodelo = null; //Inicialmente a null
  Controlador? _controlador = null;

  MyApp(VistaModelo vistamodelo, Controlador controlador, {Key? key})
    : //Constructor - key se puede enviiar o no
      _vistamodelo = vistamodelo,
      _controlador = controlador,
      super(key: key);

  // Root de la aplicacion
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compra-Venta de Arte',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Inicio(_vistamodelo!, _controlador!),
      //home: MyHomePage("Filtros de Productos Artísticos", _vista!, _controlador!), //! para no null
    );
  }
} //Fin de la clase MyApp