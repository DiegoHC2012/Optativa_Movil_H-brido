import '../domain/entities/product.dart';

class ProductAdapter {
  static Product fromJson(Map<String, dynamic> json) {
    return Product.fromJson(json);
  }

  static Map<String, dynamic> toJson(Product product) {
    return product.toJson();
  }
}
