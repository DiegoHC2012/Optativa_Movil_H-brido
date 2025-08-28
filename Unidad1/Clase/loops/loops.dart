void main() {
  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  for (var object in flybyObjects) {
    print('I see $object.');
  }

  final hora = DateTime.now().hour;
  if (hora < 12) {
    print('Buenos dias');
  } else if (hora < 20) {
    print('Buenas tardes');
  } else {
    print('Buenas noches');
  }

  for (int month = 1; month <= 12; month++) {
    print('Now is $month month.');
  }
}