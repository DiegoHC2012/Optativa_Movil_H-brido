// repository/product_repository_impl.dart
import '../../adapter/product_adapter.dart';
import '../../client/IRestAPIClient.dart';
import '../../domain/entities/product.dart';
import '../../domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final String _baseUrl = 'https://fakestoreapi.com/products';
  final IRestAPIClient<Map<String, dynamic>, dynamic> _apiClient;

  ProductRepositoryImpl(this._apiClient);

  @override
  Future<Product> create(Product product) async {
    try {
      final response = await _apiClient.post(_baseUrl, ProductAdapter.toJson(product));
      return ProductAdapter.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      print('Error en ProductRepositoryImpl.create: $e');
      rethrow;
    }
  }

  @override
  Future<List<Product>> getAll() async {
    try {
      final response = await _apiClient.get(_baseUrl);
      return (response as List)
          .map((productJson) => ProductAdapter.fromJson(productJson as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error en ProductRepositoryImpl.getAll: $e');
      rethrow;
    }
  }

  @override
  Future<Product> getById(int id) async {
    try {
      final response = await _apiClient.get('$_baseUrl/$id');
      return ProductAdapter.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      print('Error en ProductRepositoryImpl.getById: $e');
      rethrow;
    }
  }

  @override
  Future<Product> update(int id, Product product) async {
    try {
      final response = await _apiClient.put('$_baseUrl/$id', ProductAdapter.toJson(product));
      return ProductAdapter.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      print('Error en ProductRepositoryImpl.update: $e');
      rethrow;
    }
  }
  
  @override
  Future<Product> delete(int id) async {
    try {
      final response = await _apiClient.delete('$_baseUrl/$id');
      return ProductAdapter.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      print('Error en ProductRepositoryImpl.delete: $e');
      rethrow;
    }
  }
}