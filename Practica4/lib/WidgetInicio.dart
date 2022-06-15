import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practica2/API.dart';
import 'package:practica2/WidgetRegistro.dart';

import 'Usuario.dart';
import 'VistaModelo.dart';
import 'Controlador.dart';
import 'WidgetPaginaPrincipal.dart';
import 'WidgetRegistro.dart';

final formKey = GlobalKey<FormState>();

//Pantalla inicial de la aplicacion
class Inicio extends StatefulWidget {
  VistaModelo _vistamodelo;
  Controlador _controlador;

  Inicio(VistaModelo vistamodelo, Controlador controlador, {Key? key})
      : _vistamodelo = vistamodelo,
        _controlador = controlador,
        super(key: key);

  @override
  State<Inicio> createState() => _EstadoInicio();
}

class _EstadoInicio extends State<Inicio> {
  String _nombre_usuario = "";
  String _contrasenia = "";
  Usuario? _usuario = null;
  bool error_login = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicio"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                //Container con el que iniciamos sesion
                margin: const EdgeInsets.only(
                    top: 100, bottom: 100, right: 10, left: 10),
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 5, left: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    const Text("Introduce tus datos de usuario: "),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              //input para el texto
                              margin: const EdgeInsets.only(
                                  top: 15, bottom: 2.5, right: 10, left: 10),
                              child: TextFormField(
                                key: const Key('username'),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Usuario',
                                    hintText: 'Escribe tu nombre de usuario'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Nombre de usuario requerido";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _nombre_usuario = value!;
                                },
                              ),
                            ),
                            Container(
                              //input para contraseña
                              margin: const EdgeInsets.only(
                                  top: 2.5, bottom: 5, right: 10, left: 10),
                              child: TextFormField(
                                key: const Key('password'),
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Contraseña',
                                    hintText: 'Escribe tu contraseña'),
                                obscureText:
                                    true, //que no se pueda ver el texto
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Contraseña requerida";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _contrasenia = value!;
                                },
                              ),
                            ),
                            if (error_login) //Si hay error lo muestra
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 5, bottom: 7.5, right: 10, left: 10),
                                child: const Text(
                                  "ERROR - el usuario o la contraseña no son correctos",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        )),
                    RaisedButton(
                      //Boton para enviar el formulario
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          //Si estan rellenos los campos
                          formKey.currentState!.save(); //Guardar lo escrito

                          _usuario = widget._controlador
                              .comprobarLogin(_nombre_usuario, _contrasenia);
                          if (_usuario != null) {
                            //Si el usuario existe

                            if (error_login) {
                              //Si habia error quitarlo
                              setState(() {
                                error_login = false;
                              });
                            }
                            

                            //Comentado y hecho en main
                            //API.getProductosFuture(); //conseguir los nuevos productos

                            //Cuando se va a abrir la pagina principal, pasamos el catalogo
                            // TODO sería usar el getProductos y getProductosFuture
                            // con un flag por ejemplo
                            widget._controlador.cambiarCatalogo(catalogoProductos);

                            //Enviamos el catalogo inicial, para que inicialmente
                            // aparezca el catalogo completo
                            widget._vistamodelo.cambiarCatalogo(catalogoProductos);

                            sleep(const Duration(seconds: 5));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaginaPrincipal(
                                      "Filtros de Productos Artísticos",
                                      widget._vistamodelo,
                                      widget._controlador,
                                      _usuario!)),
                            );
                          } else {
                            //Si no existe el usuario, muestre mensaje de error
                            setState(() {
                              error_login = true;
                            });
                          }
                        }
                      },
                      child: const Text('Iniciar sesión'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          const Text("¿No tienes cuenta? ¡Registrate!"),
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: RaisedButton(
                              //Boton para registrarse
                              child: const Text("Registrarse"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Registro(widget._controlador)),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
