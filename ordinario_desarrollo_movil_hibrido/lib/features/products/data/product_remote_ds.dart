import 'package:dio/dio.dart';
import '../../products/domain/entities/product.dart';

class ProductRemoteDataSource {
  final dio = Dio();

  Future<List<Product>> getProducts() async {
    final res = await dio.get("https://fakestoreapi.com/products");
    return (res.data as List).map((e) => Product.fromJson(e)).toList();
  }
}
