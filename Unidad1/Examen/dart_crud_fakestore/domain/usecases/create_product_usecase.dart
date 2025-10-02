import '../entities/product.dart';
import '../repository/product_repository.dart';

class CreateProductUseCase {
  final ProductRepository _repository;
  CreateProductUseCase(this._repository);

  Future<Product> execute(Product product) {
    return _repository.create(product);
  }
}