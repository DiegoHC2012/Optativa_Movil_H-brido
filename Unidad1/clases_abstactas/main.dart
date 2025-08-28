abstract class Volador {
  void volar() => print('Estoy volando');
  void aterizar() => print('Estoy aterrizando');
}

class Animal implements Volador {
  void comer() => print('Estoy comiendo');

  @override
  void volar() => print('Estoy volando');

  @override
  void aterizar() => print('Estoy aterrizando');
}

class Ave extends Volador {
  String name;
  Ave({required this.name});
}

void main() {
  var ave = Ave(name: 'Papagayo');
  ave.volar();
}