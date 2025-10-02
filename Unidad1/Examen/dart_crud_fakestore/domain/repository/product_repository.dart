import '../entities/product.dart';

abstract class ProductRepository {
  Future<Product> create(Product product);
  Future<List<Product>> getAll();
  Future<Product> getById(int id);
  Future<Product> update(int id, Product product);
  Future<Product> delete(int id); 
}