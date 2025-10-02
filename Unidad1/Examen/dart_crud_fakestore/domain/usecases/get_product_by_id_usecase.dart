import '../entities/product.dart';
import '../repository/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository _repository;
  GetProductByIdUseCase(this._repository);

  Future<Product> execute(int id) {
    return _repository.getById(id);
  }
}