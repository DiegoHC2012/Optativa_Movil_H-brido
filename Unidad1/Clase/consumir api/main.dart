import 'dart:convert';
import 'dart:io';
class Usuario {
  int id;
  String nombre;
  String email;

  Usuario(this.id, this.nombre, this.email);

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(json['id'], json['name'], json['email']);
  }
}

Future<void> main() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users/1');
  final request = await HttpClient().getUrl(url);
  final response = await request.close();

  if (response.statusCode == 200) {
    final body = await response.transform(utf8.decoder).join();
    final data = jsonDecode(body);

    final user = Usuario.fromJson(data);
    print('ID: ${user.id}');
    print('Nombre: ${user.nombre}');
    print('Email: ${user.email}');
  }
  else {
    print('Error: ${response.statusCode}');
  }
}