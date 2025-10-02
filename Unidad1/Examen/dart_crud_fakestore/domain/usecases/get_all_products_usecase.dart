import '../entities/product.dart';
import '../repository/product_repository.dart';

class GetAllProductsUseCase {
  final ProductRepository _repository;
  GetAllProductsUseCase(this._repository);

  Future<List<Product>> execute() {
    return _repository.getAll();
  }
}