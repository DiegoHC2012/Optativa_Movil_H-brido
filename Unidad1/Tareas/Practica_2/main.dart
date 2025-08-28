abstract class Recurso implements Descargable {
  String titulo;
  String autor;

  Recurso(this.titulo, this.autor);

  void descargar() {
    print('Descargando el recurso...');
  }

  void mostrarInfo() {
    print('Información del recurso:');
    print('Título: $titulo');
    print('Autor: $autor');
  }
}

class Libro extends Recurso implements Descargable {
  int paginas;

  double get tiempoEstimadoLectura => paginas / 2;

  @override
  void descargar() {
    print('Descargando el libro...');
  }

  Libro(String titulo, String autor, this.paginas) : super(titulo, autor);
}

class Revista extends Recurso implements Descargable {
  int numeroEdicion;

  set NumeroEdicion(int numeroEdicion) {
    if (numeroEdicion < 0) {
      print('El número de edición no puede ser negativo.');
    }
    this.numeroEdicion = numeroEdicion;
  } 

  @override
  void descargar() {
    print('Descargando la revista...');
  }

  Revista(String titulo, String autor, this.numeroEdicion) : super(titulo, autor);
}

interface class Descargable {
  void descargar() {}
}

void main() {
  Libro libro = Libro('El Señor de los Anillos', 'J.R.R. Tolkien', 1000);
  libro.mostrarInfo();
  libro.descargar();

  Revista revista = Revista('National Geographic', 'National Geographic Society', 1);
  revista.mostrarInfo();
  revista.descargar();

  print('Tiempo estimado de lectura del libro: ${libro.tiempoEstimadoLectura} horas');

  revista.NumeroEdicion = -1;

  //Lista de recurso para demostrar polimorfismo

  print("Lista de recursos");
  List<Recurso> recursos = [libro, revista];
  for (var recurso in recursos) {
    recurso.mostrarInfo();
    recurso.descargar();
  }
}