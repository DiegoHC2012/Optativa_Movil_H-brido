import 'package:shared_preferences/shared_preferences.dart';

class SessionStorage {
  static Future<void> saveSession(String token, String userJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    await prefs.setString("user", userJson);
  }

  static Future<String?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }

  static Future<String?> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("user");
  }
}
