import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  List<int> favoriteIds = [];

  FavoritesProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList("favorites") ?? [];
    favoriteIds = list.map(int.parse).toList();
    notifyListeners();
  }

  Future<void> toggleFavorite(int id) async {
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      "favorites",
      favoriteIds.map((e) => e.toString()).toList(),
    );

    notifyListeners();
  }
}
