import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  final api = ApiService();

  Future<bool> login(String username, String password) async {
    final result = await api.post('auth/login', {
      'username': username,
      'password': password,
    });
    if (result['token'] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result['token']);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
