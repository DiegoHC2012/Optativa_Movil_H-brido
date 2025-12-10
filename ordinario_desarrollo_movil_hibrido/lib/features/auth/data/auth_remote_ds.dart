import 'package:dio/dio.dart';
import '../domain/entities/user.dart';

class AuthRemoteDataSource {
  final dio = Dio();

  Future<User> login(String email, String password) async {
    // Paso 1: Login (obtiene token)
    final loginRes = await dio.post(
      "https://api.escuelajs.co/api/v1/auth/login",
      data: {
        "email": email,
        "password": password,
      },
    );

    final accessToken = loginRes.data["access_token"];

    // Paso 2: Obtener perfil del usuario
    final profileRes = await dio.get(
      "https://api.escuelajs.co/api/v1/auth/profile",
      options: Options(
        headers: {"Authorization": "Bearer $accessToken"},
      ),
    );

    final data = profileRes.data;

    return User(
      id: data["id"],
      email: data["email"],
      name: data["name"],
      role: data["role"], // admin | customer
      avatar: data["avatar"],
      accessToken: accessToken,
    );
  }
}
