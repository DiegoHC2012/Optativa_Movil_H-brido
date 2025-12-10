import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/entities/product.dart';

class ProductLocalStorage {
  static const key = "local_products";

  Future<void> saveProduct(Product p) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];

    list.add(jsonEncode(p.toJson()));

    await prefs.setStringList(key, list);
  }

  Future<List<Product>> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(key) ?? [];

    return list.map((s) {
      final json = jsonDecode(s);
      return Product.fromJson(json);
    }).toList();
  }
}
