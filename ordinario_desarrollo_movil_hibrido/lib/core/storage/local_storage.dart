import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveFavorites(List<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("favorites", ids.map((e) => e.toString()).toList());
  }

  static Future<List<int>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList("favorites");
    return data?.map((e) => int.parse(e)).toList() ?? [];
  }

  static Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("favorites");
  }
}
