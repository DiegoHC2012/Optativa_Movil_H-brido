class Persona {
  String _nombre = "";
  int _edad = 0;
  String _email = "";

  String get nombre => _nombre;
  int get edad => _edad;

  set nombre(String nombre) {
    if (nombre == "") throw Exception("El nombre no puede ser vacio");
    this._nombre = nombre;
  }
  set edad(int age) => _edad = age;

  String get email => _email;

  set email(String email) => _email = email;
}

void main() {
  var persona = new Persona();
  persona.edad = 3;
  print(persona.edad);
}