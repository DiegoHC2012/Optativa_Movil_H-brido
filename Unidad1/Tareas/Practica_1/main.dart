abstract class Transporte {
  int capacidad;
  double velodidadMaxima;

  Transporte(this.capacidad, this.velodidadMaxima);

  void mover() {
    print('El transporte se esta moviendo');
  }
}

class Coche extends Transporte implements Cargable {
  @override
  int capacidad;
  @override
  double velodidadMaxima;

  String marca;

  double get relacionPasajerosVelocidad => capacidad / velodidadMaxima;

  set Capacidad (int c) {
    if (c > 0) {
        capacidad = c;
    }
    else {
      throw Exception('La capacidad no puede ser negativa');
    }
  }

  get Capacidad => capacidad;

  @override
  void cargar(int cantidad) {
    print('El coche se esta cargando');
  }

  Coche(this.capacidad, this.velodidadMaxima, this.marca ): super(capacidad, velodidadMaxima);

  @override
  void mover() {
    print('El coche se esta moviendo');
  }
}

class Barco extends Transporte implements Cargable {
  @override
  int capacidad;
  @override
  double velodidadMaxima;

  String tipo;

  Barco(this.capacidad, this.velodidadMaxima, this.tipo) : super(capacidad, velodidadMaxima);

  double get relacionPasajerosVelocidad => capacidad / velodidadMaxima;

  set Capacidad (int c) {
    if (c > 0) {
        capacidad = c;
    }
    else {
      throw Exception('La capacidad no puede ser negativa');
    }
  }

  get Capacidad => capacidad;

  @override
  void mover() {
    print('El barco se esta moviendo');
  }

  @override
  void cargar(int cantidad) {
    print('El barco se esta cargando');
  }
}

interface class Cargable {
  void cargar(int cantidad) {}
}



void main() {
  var coche = Coche(4, 120, 'Renault');
  coche.mover();

  var barco = Barco(4, 120, 'Velero');
  barco.mover();

  print(coche.relacionPasajerosVelocidad);
  print(barco.relacionPasajerosVelocidad);

  coche.Capacidad = 6;
  print(coche.Capacidad);

  barco.Capacidad = 6;
  print(barco.Capacidad);

  coche.cargar(10);
  barco.cargar(10);

  //Lista de transporte para demostrar polimorfismo
  print("Lista de transportes");
  List<Transporte> transportes = [coche, barco];
  for (var transporte in transportes) {
    transporte.mover();
  }
}