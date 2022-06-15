// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practica2/Cliente.dart';
import 'package:practica2/Controlador.dart';
import 'package:practica2/EstadoProducto.dart';
import 'package:practica2/FiltroDistancia.dart';
import 'package:practica2/FiltroEstadoProducto.dart';
import 'package:practica2/FiltroPrecio.dart';
import 'package:practica2/FiltroTipoProducto.dart';
import 'package:practica2/GestorFiltros.dart';
import 'package:practica2/Objetivo.dart';
import 'package:practica2/Producto.dart';
import 'package:practica2/TipoProducto.dart';
import 'package:practica2/Vista.dart';

import 'package:practica2/main.dart';

void main() {
  Objetivo objetivo = new Objetivo();
  GestorFiltros gestorFiltros = new GestorFiltros(objetivo);

  gestorFiltros.setFiltro = new FiltroPrecio();
  gestorFiltros.setFiltro = new FiltroDistancia();
  gestorFiltros.setFiltro = new FiltroEstadoProducto();
  gestorFiltros.setFiltro = new FiltroTipoProducto(); // No sé por qué se pone un =, dart es un misterio

  Cliente cliente = new Cliente();

  cliente.setGestorFiltros = gestorFiltros;

  Producto producto1 = new Producto(10, 10, "Cuadro Mona Lisa", "Un cuadro sin más de mi abuela", TipoProducto.cuadro, EstadoProducto.nuevo);
  Producto producto2 = new Producto(200, 2, "Lapiz 2B", "Un lápiz bonito", TipoProducto.lapices, EstadoProducto.bueno);
  Producto producto3 = new Producto(500, 300, "Escultura David", "Escultura bien fachera", TipoProducto.escultura, EstadoProducto.bueno);
  Producto producto4 = new Producto(100, 55, "Caballete marrón", "Caballete casi sin usar", TipoProducto.caballete, EstadoProducto.excelente);
  Producto producto5 = new Producto(3, 80, "Cuadro casero", "Le he dedicado muchas horas merece la pena", TipoProducto.cuadro, EstadoProducto.nuevo);
  Producto producto6 = new Producto(12, 3,  "Pincelito", "Pincelito para pintar", TipoProducto.pincel, EstadoProducto.bueno);
  Producto producto7 = new Producto(16.55, 1, "Acuarela", "Acuarela dije", TipoProducto.pinturas, EstadoProducto.roto);
  Producto producto8 = new Producto(5, 2, "Lienzo", "Aqui dibujaba Piccaso", TipoProducto.lienzo, EstadoProducto.roto);
  Producto producto9 = new Producto(1, 1, "Lapiz roto robado", "Lapiz de mi colega de clase", TipoProducto.lapices, EstadoProducto.roto);
  Producto producto10 = new Producto(300, 3, "Pincel de acuarela", "Me vinieron dos pero solo quería uno, esta sin usar", TipoProducto.pincel, EstadoProducto.excelente);
  Producto producto11 = new Producto(200, 7, "Escultura de Hasbulla", "Escultura de Hasbulla 2", TipoProducto.escultura, EstadoProducto.bueno);
  Producto producto12 = new Producto(350, 5, "Cuadro Picassito", "Cuadro de Picasso de su etapa en París", TipoProducto.lapices, EstadoProducto.excelente);
  Producto producto13 = new Producto(20, 15, "Pinturas acrílicas", "Perfectas para tus cuadros", TipoProducto.pinturas, EstadoProducto.nuevo);
  Producto producto14 = new Producto(1, 500, "Pintura industrial", "Perfectas para tu empresa", TipoProducto.pinturas, EstadoProducto.nuevo); 
  Producto producto15 = new Producto(235, 55.3, "Escultura de Dios", "No se de donde saque esto", TipoProducto.escultura, EstadoProducto.excelente);
  Producto producto16 = new Producto(5, 7, "Caballete (o eso creo)", "No sé que es, pero lo vendo", TipoProducto.caballete, EstadoProducto.roto);

  List<Producto> catalogo = [];

  catalogo.add(producto1);
  catalogo.add(producto2);
  catalogo.add(producto3);
  catalogo.add(producto4);
  catalogo.add(producto5);
  catalogo.add(producto6);
  catalogo.add(producto7);
  catalogo.add(producto8);
  catalogo.add(producto9);
  catalogo.add(producto10);
  catalogo.add(producto11);
  catalogo.add(producto12);
  catalogo.add(producto13);
  catalogo.add(producto14);
  catalogo.add(producto15);
  catalogo.add(producto16);

  Controlador controlador = new Controlador(cliente, catalogo);
  Vista vista = new Vista(objetivo, catalogo);

  List<int> listaFiltro1 = [];
  List<int> listaFiltro2 = [];
  List<int> listaFiltro3 = [];
  List<int> listaFiltro4 = [];

  controlador.aplicarFiltros(catalogo);

  List<Producto> catFinal = vista.getProductosFiltrados();

/**
 * @brief Test que comprueba la navegabilidad entre la página principal y la de compra de un producto
 */
  testWidgets('Prueba compra de productos', (WidgetTester tester) async {

    // Build our app and trigger a frame.
    tester.binding.window.physicalSizeTestValue = const Size(720, 1280);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpWidget(MyApp(vista, controlador));

    // Verificar que se han cargado bien todos los elementos.
    expect(find.text('Cuadro Mona Lisa'), findsOneWidget); // Debe encontrar uno
    expect(find.text('Pintura del Louvre'), findsNothing); // No debe encontrar nada

    expect(find.text("Comprar Cuadro Mona Lisa"), findsOneWidget); // Botón comprar
    await tester.tap(find.text("Comprar Cuadro Mona Lisa")); // Pulsamos el botón
    await tester.pumpAndSettle();

    // Comprobar que hemos cambiado de página
    //expect(find.byType(RaisedButton), findsOneWidget);
    expect(find.text("¡El producto se ha comprado con éxito!"), findsOneWidget);

    // Volvemos a la página principal
    expect(find.byType(RaisedButton), findsOneWidget);
    await tester.tap(find.byType(RaisedButton)); // Pulsamos el botón
    await tester.pumpAndSettle();

    // Comprobamos que hemos vuelto a la página principal
    expect(find.text('Cuadro Mona Lisa'), findsOneWidget); // Debe encontrar uno
  });


/**
 * @brief Test que comprueba que los sliders de los filtros funcionen
 */
  testWidgets('Prueba sliders precio y distancia', (WidgetTester tester) async {

    // Asignamos las claves (keys)
    const dist = Key('sliderDistancia');
    const precio = Key('sliderPrecio');

    // Build our app and trigger a frame.
    tester.binding.window.physicalSizeTestValue = const Size(720, 1280);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpWidget(MyApp(vista, controlador));

    // Comprobamos que los productos estén en la página principal
    expect(find.text('Escultura de Dios'), findsOneWidget);
    expect(find.text('Lapiz roto robado'), findsOneWidget);
    expect(find.text('Escultura David'), findsOneWidget);

    // Encontrar el slider correspondiente
    expect(find.byKey(dist), findsOneWidget);
    expect(find.byKey(precio), findsOneWidget);

    // Mover el slider
    await tester.drag(find.byKey(dist), const Offset(80, 0)); // (80km)
    await tester.pumpAndSettle();

    // Pulsar el botón de aplicar filtros
    expect(find.text("Aplicar Filtros"), findsOneWidget); // Botón comprar
    await tester.tap(find.text("Aplicar Filtros")); // Pulsamos el botón
    await tester.pumpAndSettle();

    // Se reduce la lista de productos
    expect(find.text('Escultura de Dios'), findsOneWidget);
    expect(find.text('Lapiz roto robado'), findsOneWidget);
    expect(find.text('Escultura David'), findsNothing);

    // ----------------------------------------------------------------
    // Mover el slider
    await tester.drag(find.byKey(precio), const Offset(10, 0)); // (10€)
    await tester.pumpAndSettle();

    // Pulsar el botón de aplicar filtros
    expect(find.text("Aplicar Filtros"), findsOneWidget); // Botón comprar
    await tester.tap(find.text("Aplicar Filtros")); // Pulsamos el botón
    await tester.pumpAndSettle();

    // Se reduce la lista de productos
    expect(find.text('Escultura de Dios'), findsNothing);
    expect(find.text('Lapiz roto robado'), findsOneWidget);
    expect(find.text('Escultura David'), findsNothing);

  });

  testWidgets('Prueba estado de productos', (WidgetTester tester) async {

    // Build our app and trigger a frame.
    tester.binding.window.physicalSizeTestValue = const Size(720, 1280);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpWidget(MyApp(vista, controlador));

    // Comprobamos que los productos estén en la página principal
    expect(find.text('Cuadro casero'), findsOneWidget);
    expect(find.text('Lapiz roto robado'), findsOneWidget);
    expect(find.text('Escultura David'), findsOneWidget);

    // Filtramos por estado: roto
    expect(find.text('Roto'), findsOneWidget);
    await tester.tap(find.text('Roto')); 
    await tester.pumpAndSettle();

    // Pulsar el botón de aplicar filtros
    expect(find.text("Aplicar Filtros"), findsOneWidget); // Botón comprar
    await tester.tap(find.text("Aplicar Filtros")); // Pulsamos el botón
    await tester.pumpAndSettle();

    //Encuentra sólo productos rotos
    expect(find.text('Estado: Roto'), findsNWidgets(4));
    expect(find.text('Estado: Bueno'), findsNothing);
    expect(find.text('Estado: Excelente'), findsNothing);
    expect(find.text('Estado: Nuevo'), findsNothing);

  });
}
