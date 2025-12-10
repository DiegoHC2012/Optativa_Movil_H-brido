import '../../products/domain/entities/product.dart';
import '../../products/domain/product_repository.dart';
import 'product_remote_ds.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;

  ProductRepositoryImpl(this.remote);

  @override
  Future<List<Product>> getProducts() => remote.getProducts();
}
