class Animal {
  String nombre;
  Animal({required this.nombre});

  void comer() {
    print('$nombre esta comiendo');
  }
}

class Perro extends Animal {
  Perro({required super.nombre});

  void ladrar() {
    print('$nombre esta ladrando');
  }

  @override
  void comer() {
    print('El perro $nombre esta comiendo croquetas');
  }
}

void main() {
  var perro = Perro(nombre: 'Firulais');
  perro.comer();
  perro.ladrar();
}