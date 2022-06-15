import 'package:flutter/material.dart';

import 'Controlador.dart';
import 'Producto.dart';
import 'Usuario.dart';

class WidgetCompra extends StatelessWidget {
  late Producto _producto;
  late Controlador _controlador;
  late Usuario _usuario;

  WidgetCompra(Producto prod, Controlador cont, Usuario usuario, {Key? key})
      : super(key: key) {
    _producto = prod;
    _controlador = cont;
    _controlador.comprarProducto(prod.id_producto, usuario); //simular que compramos el producto aunque realmente no hagamos nada
    _usuario = usuario;
    (key = key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Compra"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                  top: 50, bottom: 50, right: 10, left: 10),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.orange,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, //Center Row contents horizontally,
                      children: [
                        const Text("¡Se compró \""),
                        Text(_producto.nombre,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const Text("\" con éxito!"),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 5, right: 10, left: 10),
                    margin: const EdgeInsets.all(5),
                    child: Text("Gracias " +
                        _usuario.nombre +
                        " por confiar en Wallapart"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Volver a página anterior'),
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
