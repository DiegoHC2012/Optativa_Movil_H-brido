import 'dart:io';
// Importamos los módulos que creamos en la carpeta 'lib'.
// Asegúrate de que el nombre 'movie_project' coincida con el de tu pubspec.yaml.
import '../lib/services/api_service.dart';
import '../lib/formatters/formatter_factory.dart';

Future<void> main() async {
  // 1. Solicitar el formato de salida al usuario.
  print('Seleccione el formato de salida:');
  print('1. JSON');
  print('2. XML');
  print('3. CSV');
  stdout.write('Ingrese el número o el nombre del formato: ');

  String? choice = stdin.readLineSync()?.trim().toLowerCase();
  String formatType;

  switch (choice) {
    case '1':
    case 'json':
      formatType = 'json';
      break;
    case '2':
    case 'xml':
      formatType = 'xml';
      break;
    case '3':
    case 'csv':
      formatType = 'csv';
      break;
    default:
      print('Opción no válida. Saliendo del programa.');
      return;
  }

  print('\nObteniendo datos de películas populares...');

  try {
    // 2. Consumir la API a través de nuestro servicio.
    final apiService = MovieApiService();
    final allMovies = await apiService.fetchData();
    
    // 3. Tomar solo los primeros 10 registros.
    final moviesToFormat = allMovies.take(10).toList();
    
    if (moviesToFormat.isEmpty) {
        print("No se encontraron películas.");
        return;
    }

    // 4. Utilizar la fábrica para crear el formateador correcto.
    final factory = ConcreteFormatterFactory(formatType);
    final formatter = factory.createFormatter();

    // 5. Formatear y mostrar los datos en la consola.
    final formattedData = formatter.format(moviesToFormat);
    
    print('\n--- Resultado en formato ${formatType.toUpperCase()} ---\n');
    print(formattedData);
    
  } catch (e) {
    print('\nOcurrió un error: ${e.toString()}');
  }
}

