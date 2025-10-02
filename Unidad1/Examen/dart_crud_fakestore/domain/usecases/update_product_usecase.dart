import '../entities/product.dart';
import '../repository/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository _repository;
  UpdateProductUseCase(this._repository);

  Future<Product> execute(int id, Product product) {
    return _repository.update(id, product);
  }
}