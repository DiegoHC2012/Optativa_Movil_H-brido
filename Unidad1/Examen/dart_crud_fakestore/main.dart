import 'dart:io';

import 'client/api_client.dart';
import 'domain/entities/product.dart';
import 'domain/repository/product_repository.dart';
import 'domain/usecases/create_product_usecase.dart';
import 'domain/usecases/delete_product_usecase.dart';
import 'domain/usecases/get_all_products_usecase.dart';
import 'domain/usecases/get_product_by_id_usecase.dart';
import 'domain/usecases/update_product_usecase.dart';
import 'domain/repository/product_repository_impl.dart';

final APIClient<Map<String, dynamic>, dynamic> apiClient = APIClient();
final ProductRepository productRepository = ProductRepositoryImpl(apiClient);
final GetAllProductsUseCase getAllProductsUseCase = GetAllProductsUseCase(productRepository);
final GetProductByIdUseCase getProductByIdUseCase = GetProductByIdUseCase(productRepository);
final CreateProductUseCase createProductUseCase = CreateProductUseCase(productRepository);
final UpdateProductUseCase updateProductUseCase = UpdateProductUseCase(productRepository);
final DeleteProductUseCase deleteProductUseCase = DeleteProductUseCase(productRepository);

void main() async {
  while (true) {
    print("\n--- Menú CRUD de Productos ---");
    print("1. Crear producto");
    print("2. Listar todos los productos");
    print("3. Obtener producto por ID");
    print("4. Actualizar producto");
    print("5. Eliminar producto");
    print("0. Salir");
    stdout.write("Seleccione una opción: ");

    final option = stdin.readLineSync();

    try {
      switch (option) {
        case '1':
          await handleCreateProduct();
          break;
        case '2':
          await handleListAllProducts();
          break;
        case '3':
          await handleGetProductById();
          break;
        case '4':
          await handleUpdateProduct();
          break;
        case '5':
          await handleDeleteProduct();
          break;
        case '0':
          print("Saliendo...");
          exit(0);
        default:
          print("Opción no válida.");
      }
    } catch (e) {
      print("\nOCURRIÓ UN ERROR: ${e.toString()}");
      print("Por favor, intente de nuevo.");
    }
  }
}

// --- Funciones auxiliares para cada opción ---

Future<void> handleListAllProducts() async {
  print("\nObteniendo productos...");
  final products = await getAllProductsUseCase.execute();
  print("Se encontraron ${products.length} productos:");
  products.forEach((p) => print('  - ID: ${p.id}, Título: ${p.title}'));
}

Future<void> handleGetProductById() async {
  stdout.write("\nIngrese el ID del producto: ");
  final id = int.tryParse(stdin.readLineSync() ?? '');
  if (id == null) {
    print("ID inválido.");
    return;
  }

  print("Buscando producto...");
  final product = await getProductByIdUseCase.execute(id);
  print("Producto encontrado:");
  printProductDetails(product);
}

Future<void> handleCreateProduct() async {
  print("\n--- Crear Nuevo Producto ---");
  stdout.write("Título: ");
  final title = stdin.readLineSync() ?? '';
  stdout.write("Precio: ");
  final price = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
  stdout.write("Descripción: ");
  final description = stdin.readLineSync() ?? '';
  stdout.write("Categoría: ");
  final category = stdin.readLineSync() ?? '';

  final newProduct = Product(
    title: title,
    price: price,
    description: description,
    category: category,
    image: 'https://i.pravatar.cc',
  );

  print("Creando producto...");
  final createdProduct = await createProductUseCase.execute(newProduct);
  print("\n¡Producto creado exitosamente!");
  printProductDetails(createdProduct);
}

Future<void> handleUpdateProduct() async {
  stdout.write("\nIngrese el ID del producto a actualizar: ");
  final id = int.tryParse(stdin.readLineSync() ?? '');
  if (id == null) {
    print("ID inválido.");
    return;
  }

  print("--- Actualizar Producto ID: $id ---");
  stdout.write("Nuevo Título: ");
  final title = stdin.readLineSync() ?? '';
  stdout.write("Nuevo Precio: ");
  final price = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
  
  // En una app real, pedirías todos los campos. Aquí simplificamos.
  final productToUpdate = Product(
    title: title,
    price: price,
    description: 'Updated Description',
    category: 'electronics',
    image: 'https://i.pravatar.cc',
  );

  print("Actualizando...");
  final updatedProduct = await updateProductUseCase.execute(id, productToUpdate);
  print("\n¡Producto actualizado exitosamente!");
  printProductDetails(updatedProduct);
}

Future<void> handleDeleteProduct() async {
  stdout.write("\nIngrese el ID del producto a eliminar: ");
  final id = int.tryParse(stdin.readLineSync() ?? '');
  if (id == null) {
    print("ID inválido.");
    return;
  }
  
  print("Eliminando producto...");
  final deletedProduct = await deleteProductUseCase.execute(id);
  print("\n¡Producto eliminado exitosamente!");
  print("Detalles del producto eliminado:");
  printProductDetails(deletedProduct);
}

void printProductDetails(Product product) {
  print('''
  ------------------------------------
  ID:          ${product.id}
  Título:      ${product.title}
  Precio:      \$${product.price.toStringAsFixed(2)}
  Categoría:   ${product.category}
  Descripción: ${product.description}
  ------------------------------------
  ''');
}