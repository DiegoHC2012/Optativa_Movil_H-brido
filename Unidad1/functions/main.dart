import './function.dart';
void main() {
  void saludar(String name) => print('Hello, $name!');
  saludar('John Doe');

  saludar2(null);
  print(new Calculator(1, 2).sumar());


  const numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final filtrados_pares = numeros.where((numeros) => numeros % 2 == 0).toList();
  filtrados_pares.forEach((element) => print(element));

  final filtrados_impares = filtrador(numeros);
  filtrados_impares.forEach((element) => print(element));
}

void saludar2(String? name) => print('Hello, $name!');

Iterable<int> filtrador(Iterable<int> arreglo) {
  final filtrados_impares = arreglo.where((arreglo) => arreglo % 2 != 0).toList();
  return filtrados_impares;
}