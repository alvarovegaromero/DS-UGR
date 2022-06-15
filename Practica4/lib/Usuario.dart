class Usuario {
  String _nombre = "";
  String _nombreusuario = "";
  String _apellidos = "";
  String _correo = "";
  String _direccion = "";
  String _contrasenia = ""; //usado para el fromJson solo
  int _telefono = 0;

  Usuario(String nombre, String correo, String direccion) {
    _nombre = nombre;
    _correo = correo;
    _direccion = direccion;
  }

  Usuario.otroConstructor(String nombre, String correo, String direccion, String password) {
    _nombre = nombre;
    _correo = correo;
    _direccion = direccion;
    _contrasenia = password;
  }

  String get nombre => _nombre;
  String get correo => _correo;
  String get direccion => _direccion;
  String get contrasenia => _contrasenia; //get para comprobar s esta bien

  void set nombre(String unNombre) {
    _nombre = unNombre;
  }

  void set correo(String unCorreo) {
    _correo = unCorreo;
  }

  void set direccion(String unaDireccion) {
    _direccion = unaDireccion;
  }
}
