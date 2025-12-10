import 'dart:convert';
import 'package:http/http.dart' as http;

import '../domain/entities/product.dart';

class ProductRemoteDataSource {
  final String baseUrl = "https://fakestoreapi.com/products";

  Future<List<Product>> getProducts() async {
    final res = await http.get(Uri.parse(baseUrl));

    final List data = jsonDecode(res.body);

    return data.map((json) {
      return Product(
        id: json["id"],
        title: json["title"],
        price: (json["price"] as num).toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        active: true,
        createdAt: DateTime.now(),
      );
    }).toList();
  }
}
