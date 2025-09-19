class Trabajador {
  String nombre;
  int edad;
  String puesto;

  Trabajador(this.nombre, this.edad, this.puesto);

  factory Trabajador.progamador(String nombre, int edad) {
    return Trabajador(nombre, edad, 'Programador');
  }

  factory Trabajador.analista(String nombre, int edad) {
    return Trabajador(nombre, edad, 'Analista');
  }
}

void main() {
  var trabajador = Trabajador.progamador('John Doe', 30);
  print('Nombre: ${trabajador.nombre}');
  print('Edad: ${trabajador.edad}');
  print('Puesto: ${trabajador.puesto}');
}