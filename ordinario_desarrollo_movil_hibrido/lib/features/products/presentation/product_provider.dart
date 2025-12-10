import 'package:flutter/material.dart';
import '../../products/domain/entities/product.dart';
import '../../products/data/product_remote_ds.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProductProvider extends ChangeNotifier {
  final ProductRemoteDataSource _remote = ProductRemoteDataSource();

  List<Product> _allProducts = [];
  List<Product> visibleProducts = [];

  bool loading = false;

  int itemsToShow = 3;
  final int increment = 3;

  // Filtros
  String categoryFilter = "all";
  String dateFilter = "all";
  String statusFilter = "all";

  // Ordenamiento
  String sortBy = "price";
  bool sortAsc = true;

  // Búsqueda
  String search = "";

  // ===========================================================================
  // CARGAR PRODUCTOS (API + LOCALES)
  // ===========================================================================

  Future<void> loadProducts() async {
    loading = true;
    notifyListeners();

    // 1️⃣ CARGAMOS API PRIMERO
    _allProducts = await _remote.getProducts();

    // 2️⃣ MEZCLAMOS PRODUCTOS LOCALES (sin borrar los anteriores)
    await loadLocalProducts();

    // 3️⃣ MOSTRAR SOLO 3 PRODUCTOS AL INICIO
    resetVisible();

    loading = false;
    notifyListeners();
  }

  // ===========================================================================
  // GUARDAR PRODUCTO LOCAL
  // ===========================================================================

  Future<void> saveLocalProduct(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList("local_products") ?? [];

    // JSON válido
    list.add(jsonEncode(product.toJson()));

    await prefs.setStringList("local_products", list);
  }

  // ===========================================================================
  // CARGAR PRODUCTOS LOCALES
  // ===========================================================================

  Future<void> loadLocalProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList("local_products") ?? [];

    final localProducts =
        list.map((item) => Product.fromJson(jsonDecode(item))).toList();

    // MEZCLA: API + Locales
    _allProducts = [..._allProducts, ...localProducts];
  }

  // ===========================================================================
  // RESETEAR VISIBLES (3 PRODUCTOS AL INICIO)
  // ===========================================================================

  void resetVisible() {
    itemsToShow = 3;
    final filteredList = _applyFilters(_allProducts);
    visibleProducts = filteredList.take(3).toList();
    notifyListeners();
  }

  // ===========================================================================
  // CARGAR MÁS PRODUCTOS
  // ===========================================================================

  void loadMore() {
    final filteredList = _applyFilters(_allProducts);

    if (itemsToShow >= filteredList.length) return;

    itemsToShow += increment;
    visibleProducts = filteredList.take(itemsToShow).toList();

    notifyListeners();
  }

  // ===========================================================================
  // FILTROS + ORDENAMIENTO + BÚSQUEDA (LO COMPLETO)
  // ===========================================================================

  List<Product> _applyFilters(List<Product> list) {
    Iterable<Product> result = list;

    // 🔍 BÚSQUEDA
    result = result.where(
      (p) => p.title.toLowerCase().contains(search.toLowerCase()),
    );

    // 🏷️ CATEGORÍA
    if (categoryFilter != "all") {
      result = result.where((p) => p.category == categoryFilter);
    }

    // 🔵 ESTADO (activo / inactivo)
    if (statusFilter == "active") {
      result = result.where((p) => p.active == true);
    } else if (statusFilter == "inactive") {
      result = result.where((p) => p.active == false);
    }

    // 📅 FECHA
    final now = DateTime.now();
    result = result.where((p) {
      if (dateFilter == "today") {
        return p.createdAt.day == now.day &&
            p.createdAt.month == now.month &&
            p.createdAt.year == now.year;
      }
      if (dateFilter == "week") {
        return now.difference(p.createdAt).inDays <= 7;
      }
      if (dateFilter == "month") {
        return now.month == p.createdAt.month &&
            now.year == p.createdAt.year;
      }
      if (dateFilter == "year") {
        return now.year == p.createdAt.year;
      }
      return true;
    });

    // 🔄 ORDENAMIENTO
    final sorted = result.toList();

    if (sortBy == "price") {
      sorted.sort((a, b) =>
          sortAsc ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
    } else if (sortBy == "date") {
      sorted.sort((a, b) =>
          sortAsc ? a.createdAt.compareTo(b.createdAt) : b.createdAt.compareTo(a.createdAt));
    }

    return sorted;
  }

  // ===========================================================================
  // GETTER PARA DETALLE DE PRODUCTO
  // ===========================================================================
  List<Product> get filtered => _applyFilters(_allProducts);

  // ===========================================================================
  // FILTROS INTERACTIVOS
  // ===========================================================================

  void setCategory(String value) {
    categoryFilter = (categoryFilter == value) ? "all" : value;
    resetVisible();
  }

  void setDateFilter(String value) {
    dateFilter = (dateFilter == value) ? "all" : value;
    resetVisible();
  }

  void setStatus(String value) {
    statusFilter = (statusFilter == value) ? "all" : value;
    resetVisible();
  }

  void setSorting(String by, bool asc) {
    sortBy = by;
    sortAsc = asc;
    resetVisible();
  }

  void clearAllFilters() {
    categoryFilter = "all";
    dateFilter = "all";
    statusFilter = "all";
    search = "";
    sortBy = "price";
    sortAsc = true;

    resetVisible();
  }
}
