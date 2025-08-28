import 'dart:math';
import 'funciones.dart';
void main() {
  const precio = 25.9;
  final ventaRedondeada = precio.round();
  print(ventaRedondeada);

  Saludar(ventaRedondeada.toString());
}