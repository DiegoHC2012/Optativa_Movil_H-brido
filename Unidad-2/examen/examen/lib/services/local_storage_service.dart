import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item_model.dart';
import '../models/purchase_model.dart';

class LocalStorageService {
  static const _cartKey = 'cart';
  static const _purchasesKey = 'purchases';

  static Future<List<CartItem>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_cartKey);
    if (data == null) return [];
    return (jsonDecode(data) as List).map((e) => CartItem.fromJson(e)).toList();
  }

  static Future<void> saveCart(List<CartItem> cart) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cartKey, jsonEncode(cart.map((e) => e.toJson()).toList()));
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  static Future<void> savePurchase(Purchase purchase) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_purchasesKey);
    List<Purchase> purchases = [];
    if (data != null) {
      purchases = (jsonDecode(data) as List).map((e) => Purchase.fromJson(e)).toList();
    }
    purchases.add(purchase);
    await prefs.setString(_purchasesKey, jsonEncode(purchases.map((e) => e.toJson()).toList()));
  }

  static Future<List<Purchase>> getPurchases() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_purchasesKey);
    if (data == null) return [];
    return (jsonDecode(data) as List).map((e) => Purchase.fromJson(e)).toList();
  }
}
