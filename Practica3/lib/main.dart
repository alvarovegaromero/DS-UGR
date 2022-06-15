import 'package:practica2/Vista.dart';

import 'Producto.dart';
import 'TipoProducto.dart';
import 'EstadoProducto.dart';
import 'Cliente.dart';
import 'Objetivo.dart';
import 'CadenaFiltros.dart';
import 'Filtro.dart';
import 'GestorFiltros.dart';
import 'FiltroPrecio.dart';
import 'FiltroDistancia.dart';
import 'FiltroEstadoProducto.dart';
import 'FiltroTipoProducto.dart';
import 'Controlador.dart';

import 'package:flutter/material.dart';

void main()
{
  // Crear gestor de filtros y Objetivo
  Objetivo objetivo = new Objetivo();
  GestorFiltros gestorFiltros = new GestorFiltros(objetivo);

  // Añadir los filtros (orden: precio, distancia, estado y tipo)
  gestorFiltros.setFiltro = new FiltroPrecio();
  gestorFiltros.setFiltro = new FiltroDistancia();
  gestorFiltros.setFiltro = new FiltroEstadoProducto();
  gestorFiltros.setFiltro = new FiltroTipoProducto(); // No sé por qué se pone un =, dart es un misterio

  // Crear Cliente
  Cliente cliente = new Cliente();

  // Añadirle al cliente el gestor de filtros
  cliente.setGestorFiltros = gestorFiltros;

  // Creacion de un catalogo de productos
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

  // Crear catalogo - coleccion de productos
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

  // Crear controlador y vista. Sobre el controlador haremos peticiones y sobre la vista veremos los resultados
  Controlador controlador = new Controlador(cliente, catalogo);
  Vista vista = new Vista(objetivo, catalogo);

  //Creamos filtros
  List<int> listaFiltro1 = [];
  List<int> listaFiltro2 = [];
  List<int> listaFiltro3 = [];
  List<int> listaFiltro4 = [];

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
  controlador.aplicarFiltros(catalogo);

  //Obtener los productos resultantes a través de la vista 
  List<Producto> catFinal = vista.getProductosFiltrados();

  //////////////////////////////////////////////////////////////////////
  //Parte de flutter
  //Añadir parte correspondiente a crear Pantalla en flutter
  runApp(MyApp(vista, controlador));

}

class MyApp extends StatelessWidget 
{
  Vista? _vista = null; //Inicialmente a null
  Controlador? _controlador = null;

  MyApp(Vista vista, Controlador controlador, {Key? key}) : //Constructor - key se puede enviiar o no
    _vista = vista,
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
      home: MyHomePage("Filtros de Productos Artísticos", _vista!, _controlador!), //! para no null
    );
  }
} //Fin de la clase MyApp

class MyHomePage extends StatefulWidget {
  
  String title;
  Vista _vista;
  Controlador _controlador;

  MyHomePage(String title, Vista vista, Controlador controlador, {Key? key}) :
    this.title = title,
    _vista = vista,
    _controlador = controlador,
    super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _valor_actual_precios = 0;
  double _valor_actual_distancia = 0;
  String? _valor_tipo = 'Ninguno';
  final _tipos_producto = ['Ninguno','Cuadro', 'Lienzo', 'Pincel', 'Lapices','Caballete', 'Escultura', 'Pinturas'];
  List<bool> _estados_seleccionados = List.generate(4, (_) => false); //4 porque tenemos 4 estados. 

  //Mejora para los _slider y selector :  no usar número mágicos (posible actualizacion)
  void _sliderDistancia() {
    int valor_filtro = _valor_actual_distancia.round();
    if(_valor_actual_distancia.round()== 0) //Si es 0, no aplicar filtro
      valor_filtro = -1;

    widget._controlador.modificarFiltro(1, [valor_filtro]);//Modificar el filtro de distancia con el valor dado
    //print("$_valor_actual_precios");
  }

  void _sliderPrecio() {
    int valor_filtro = _valor_actual_precios.round();
    if(_valor_actual_precios.round()== 0) //Si es 0, no aplicar filtro
      valor_filtro = -1;

    widget._controlador.modificarFiltro(0, [valor_filtro]); //Modificar el filtro de precio con el valor dado
    //print("$_valor_actual_precios");
  }

  void _selectorTipo() {
    if(_valor_tipo == 'Ninguno')
      widget._controlador.modificarFiltro(3, [-1]);      
    else if(_valor_tipo == 'Cuadro')
      widget._controlador.modificarFiltro(3, [0]); 
    else if(_valor_tipo == 'Lienzo')
      widget._controlador.modificarFiltro(3, [1]); 
    else if(_valor_tipo == 'Pincel')
      widget._controlador.modificarFiltro(3, [2]); 
    else if(_valor_tipo == 'Lapices')
      widget._controlador.modificarFiltro(3, [3]); 
    else if(_valor_tipo == 'Caballete')
      widget._controlador.modificarFiltro(3, [4]); 
    else if(_valor_tipo == 'Escultura')
      widget._controlador.modificarFiltro(3, [5]); 
    else if(_valor_tipo == 'Pinturas')
      widget._controlador.modificarFiltro(3, [6]);     
  }

  void _selectorEstados(){
    List<int> estados = [];

    for(int i = 0 ; i < _estados_seleccionados.length ; i++){
      if(_estados_seleccionados[i])
        estados.add(i);
    }

    if(estados.isEmpty) //Si no hay boton seleccionado, mostrar todos
      estados.add(-1); 

    widget._controlador.modificarFiltro(2, estados); 
  }

  void _aplicarFiltros(){
    setState((){
      _sliderPrecio();
      _sliderDistancia();
      _selectorTipo();
      _selectorEstados();
      widget._controlador.aplicarFiltros(widget._controlador.catalogo_inicial);
    });
  }

  @override
  Widget build(BuildContext context) { //Llamado cada vez que llamamos a setState y para crear todo
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), //Coger valor de MyHomePage
      ),

      //Faltaria parte de botones ¿Container de columna?
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child : Center( //Colocar en medio
          child: Column( //Coge lista de hijos y los coloca verticalmente
            //mainAxisAlignment: MainAxisAlignment.end, //Abajo verticalmente
            children: <Widget>[
              Container( //Metemos botones, y le ponemos borde a la zona de botones
                margin: const EdgeInsets.only(top: 2, bottom: 2, right: 10, left: 10),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(0, 200, 186, 220), //color naranjita
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),

                child: Column( //Botones y textos
                  children: <Widget>[
                    Text("Filtro Precio: "),
                    Slider( //Paquete flutter_xlider y funcion para divisiones customs
                      key: const Key('sliderPrecio'),
                      min: 0,
                      max: 250,
                      divisions: 25,
                      label: "$_valor_actual_precios",
                      value: _valor_actual_precios,
                      onChanged: (nuevoRating){
                        setState(() => _valor_actual_precios = nuevoRating);
                      },
                    ),

                    Text("Filtro Distancia: "),
                    Slider( //Paquete flutter_xlider y funcion para divisiones customs
                      key: const Key('sliderDistancia'),
                      min: 0,
                      max: 200,
                      divisions: 10,
                      label: "$_valor_actual_distancia",
                      value: _valor_actual_distancia,
                      onChanged: (nuevoRating){
                        setState(() => _valor_actual_distancia = nuevoRating);
                      },
                    ),
                    
                    
                    Text("Filtro Tipo:"),
                    DropdownButton<String>(
                      value: _valor_tipo,
                      items: _tipos_producto.map(buildMenuItem).toList(),
                      onChanged: (valor){
                        setState(() => _valor_tipo = valor);
                      },
                    ),

                    Text("Filtro Estado:"),
                    ToggleButtons(
                      children: const <Widget>[
                        Text('Nuevo'),
                        Text('Excelente'),
                        Text('Bueno'),
                        Text('Roto'),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      borderWidth: 3,
                      borderColor: Color(0xFF939393),
                      isSelected: _estados_seleccionados,
                      onPressed: (int index){
                        setState((){
                          _estados_seleccionados[index] = !_estados_seleccionados[index];
                        });
                      },
                    ),  
                    

                    SizedBox( //Boton para aplicar los filtros
                      child : FlatButton(
                        onPressed: _aplicarFiltros, 
                        child: Text('Aplicar Filtros'),
                        color: Color.fromARGB(255, 135, 84, 182),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000)
                        ),
                      )
                    ),
                  ]
                ),
              ),

              for(int i = 0 ; i < widget._vista.getProductosFiltrados().length ; i++)
                Container(
                  margin: const EdgeInsets.only(top: 2.5, bottom: 2.5, right: 10, left: 10),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(255, 198, 177, 223),
                        width: 1.5,
                        ),
                      borderRadius: BorderRadius.circular(5),
                    ),

                  child: Column(
                    children: <Widget>[
                      widget._vista.getProductosFiltradosWidget()[i],

                       /*if(widget._vista.getCatalogo()[i].nombre == "Lapiz 2B")
                            FlatButton(
                            onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Compra()),
                            );
                            },
                            child: const Icon(Icons.shopping_cart) ,
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000)
                            ),
                            ),

                      if(widget._vista.getCatalogo()[i].nombre != "Lapiz 2B")*/
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Compra()),
                            );
                          },
                          child: Text("Comprar " + widget._vista.getCatalogo()[i].nombre),
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1000)
                          ),
                        ),
                    ]
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => //Crear para cada item, para seleccionar
    DropdownMenuItem(
      value: item,
      child: 
        Text(
          item,
        ),
      );
} //Fin clase estado

class Compra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compra"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("¡El producto se ha comprado con éxito!"),

            RaisedButton(
              onPressed: () {
                Navigator.pop(context); //Regresar a pantalla principal
              },
              child: Text('Volver a página principal'),
            ),
          ]
        ),
      ),
    );
  }
}