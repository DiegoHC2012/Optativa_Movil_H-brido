class Calculator {
  final x;
  final y;
  Calculator(
    this.x,
    this.y
  );
  
  int sumar() => x + y;
  int restar() => x - y;
  int multiplicar() => x * y;
  double dividir() => x / y;
}