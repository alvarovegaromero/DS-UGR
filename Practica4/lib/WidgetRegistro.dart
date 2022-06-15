import 'package:flutter/material.dart';
import 'Controlador.dart';

final formKeyRegistro = GlobalKey<FormState>();

class Registro extends StatefulWidget {
  Controlador _controlador;

  Registro(Controlador controlador, {Key? key})
      : _controlador = controlador,
        super(key: key);

  @override
  State<Registro> createState() => _EstadoRegistro();
}

class _EstadoRegistro extends State<Registro> {
  String _nombre_usuario = "";
  String _contrasenia = "";
  String _correo = "";
  String _direccion = "";
  bool error_registro = false;
  bool registro_completo = false; //para avisar de que el registro fue bien

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
      ),
      body:
      SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                    top: 100, bottom: 100, right: 10, left: 10),
                padding:
                    const EdgeInsets.only(top: 15, bottom: 15, right: 5, left: 5),
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
                    const Text("Introduce tus datos para registrarte: "),
                    Form(
                      key: formKeyRegistro,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 15, bottom: 2.5, right: 10, left: 10),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nombre de Usuario',
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
                            margin: const EdgeInsets.only(
                                top: 2.5, bottom: 2.5, right: 10, left: 10),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Contraseña',
                                  hintText: 'Escribe tu contraseña'),
                              obscureText: true, //que no se pueda ver el texto
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

                          Container(
                            margin: const EdgeInsets.only(
                                top: 2.5, bottom: 2.5, right: 10, left: 10),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'e-mail',
                                  hintText: 'Escribe tu e-mail'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "e-mail requerido";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                _correo = value!;
                              },
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(
                                top: 2.5, bottom: 15, right: 10, left: 10),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Dirección',
                                  hintText: 'Escribe la dirección de tu hogar'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Dirección requerida";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                _direccion = value!;
                              },
                            ),
                          ),

                          if (error_registro)
                          Container(
                            margin: const EdgeInsets.only(
                                top: 5, bottom: 7.5, right: 10, left: 10),
                            child: const Text(
                              //Lo unico que NO se puede repetir es el username
                              "ERROR - El nombre de usuario esta ocupado ya o has introducido un formato de email incorrecto",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),

                          if (registro_completo)
                          Container(
                            margin: const EdgeInsets.only(
                                top: 5, bottom: 7.5, right: 10, left: 10),
                            child: const Text(
                              //Lo unico que NO se puede repetir es el username
                              "ÉXITO - El registro fue correctamente y se te está redirigiendo a la página inicial para su inicio de sesión",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),

                          RaisedButton(
                            onPressed: () async {
                              if (formKeyRegistro.currentState!.validate()) {
                                //Si estan rellenos los campos
                                formKeyRegistro.currentState!.save(); //Guardar

                                //Si el email esta bien y el registro fue bien
                                if (widget._controlador.registrarse(
                                  _nombre_usuario, _contrasenia,
                                  _correo, _direccion)
                                  &
                                  (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_correo))
                                  )
                                {
                                  if (error_registro) { //desactivr si habia error
                                    error_registro = false;
                                  }

                                  setState(() {
                                    //eliminar si habia error y
                                    // mostrar un mensaje de éxito
                                    registro_completo = true;
                                  });

                                //Pausa para simular lo que tarda en cargar
                                  await Future.delayed(const Duration(seconds:5));

                                  Navigator.pop(context); //Regresar
                                }
                                else { //si ha habido error en registro
                                  setState(() {
                                    error_registro = true;
                                  });
                                }
                              }
                            },
                            child: const Text("Registrarse"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
