import 'package:flutter/material.dart';
import '../../products/domain/entities/product.dart';
import '../../products/data/product_remote_ds.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRemoteDataSource _remote = ProductRemoteDataSource();

  List<Product> _allProducts = [];
  List<Product> visibleProducts = [];

  bool loading = false;

  int itemsToShow = 3;
  final int increment = 3;

  String search = "";
  String category = "all";
  bool sortAsc = true;

  Future<void> loadProducts() async {
    loading = true;
    notifyListeners();

    _allProducts = await _remote.getProducts();
    visibleProducts = _allProducts.take(itemsToShow).toList();

    loading = false;
    notifyListeners();
  }

  void loadMore() {
    if (itemsToShow >= _allProducts.length) return;

    itemsToShow += increment;
    visibleProducts = _allProducts.take(itemsToShow).toList();

    notifyListeners();
  }

  int get totalProductsCount => _allProducts.length;

  List<Product> get filtered {
    var list = visibleProducts.where(
      (p) => p.title.toLowerCase().contains(search.toLowerCase()),
    );

    if (category != "all") {
      list = list.where((p) => p.category == category);
    }

    final sorted = list.toList()
      ..sort((a, b) =>
          sortAsc ? a.price.compareTo(b.price) : b.price.compareTo(a.price));

    return sorted;
  }
}
