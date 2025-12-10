import 'package:flutter/material.dart';
import '../../products/domain/entities/product.dart';
import '../../products/data/product_remote_ds.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRemoteDataSource _remote = ProductRemoteDataSource();

  List<Product> products = [];
  bool loading = false;

  // Filtros
  String search = "";
  String category = "all";
  bool sortAsc = true;

  Future<void> loadProducts() async {
    loading = true;
    notifyListeners();

    products = await _remote.getProducts();

    loading = false;
    notifyListeners();
  }

  List<Product> get filtered {
    var list = products.where((p) {
      return p.title.toLowerCase().contains(search.toLowerCase());
    });

    if (category != "all") {
      list = list.where((p) => p.category == category);
    }

    final sorted = list.toList()
      ..sort((a, b) => sortAsc
          ? a.price.compareTo(b.price)
          : b.price.compareTo(a.price));

    return sorted;
  }
}
