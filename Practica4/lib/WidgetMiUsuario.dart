import 'package:flutter/material.dart';
import 'Usuario.dart';

class MiUsuario extends StatelessWidget {
  Usuario _miusuario;

  MiUsuario(Usuario usuario, {Key? key})
    : _miusuario = usuario,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Usuario"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 100, bottom: 100, right: 10, left: 10),
              padding: const EdgeInsets.only(top: 15, bottom: 15, right: 5, left: 5),
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
                  Container( //Nombre
                    margin: const EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 15),
                    child: Row(
                      children: [
                        const Text("Nombre: ", style: TextStyle(fontSize: 16)),
                        Text(_miusuario.nombre, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                      ],
                    ),
                  ),

                  Container( //Correo
                    margin: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 15),                    
                    child: Row(
                      children: [
                        const Text("Correo: ", style: TextStyle(fontSize: 16)),
                        Text(_miusuario.correo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ),

                  Container( //Direccion
                    margin: const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 15),
                    child: Row(
                      children: [
                        const Text("Direccion: ", style: TextStyle(fontSize: 16)),
                        Text(_miusuario.direccion, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ),

                  Container( //Direccion
                    margin: const EdgeInsets.only(top: 10, bottom: 15, right: 10, left: 15),
                      child:
                        const Text("En caso de necesitar un cambio de cualquier dato, contacte con soporte@wallapart.com"),
                  ),

                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context); //Regresar a pantalla principal
                    },
                    child: const Text('Volver a la página principal'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
