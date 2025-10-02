import '../entities/product.dart';
import '../repository/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository _repository;
  DeleteProductUseCase(this._repository);

  Future<Product> execute(int id) {
    return _repository.delete(id);
  }
}