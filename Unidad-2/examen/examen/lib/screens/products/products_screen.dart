import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../models/cart_item_model.dart';
import '../../services/api_service.dart';
import '../../services/local_storage_service.dart';
import '../../core/utils/format_utils.dart';
import '../products/product_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  final String category;
  const ProductsScreen({super.key, required this.category});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final api = ApiService();
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final data = await api.get('products/category/${widget.category}');
    setState(() {
      _products = (data as List).map((e) => Product.fromJson(e)).toList();
    });
  }

  Future<void> _addToCart(Product product) async {
    final cart = await LocalStorageService.getCart();

    // 🔸 Calcular cantidad total actual
    int totalCantidad = cart.fold(0, (sum, i) => sum + i.quantity);

    if (totalCantidad + 1 > 7) {
      await _showLimitDialog(
        context,
        'Límite alcanzado',
        'Solo puedes tener un máximo de 7 productos en total dentro del carrito.',
      );
      return;
    }

    // 🔸 Calcular total monetario actual
    double totalCarrito = cart.fold(0, (sum, i) => sum + i.total);
    totalCarrito += product.price;

    if (totalCarrito > 5000) {
      await _showLimitDialog(
        context,
        'Límite de monto excedido',
        'El total del carrito no puede superar los \$5000 MXN.',
      );
      return;
    }

    // 🔸 Si el producto ya existe, aumentar cantidad
    final existing = cart.indexWhere((i) => i.product.id == product.id);
    if (existing != -1) {
      cart[existing].quantity += 1;
    } else {
      cart.add(CartItem(product: product, quantity: 1));
    }

    await LocalStorageService.saveCart(cart);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.title} agregado al carrito')),
      );
    }
  }

  Future<void> _showLimitDialog(BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.tealAccent.shade200, size: 60),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Entendido', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: _products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: _products.length,
              itemBuilder: (context, i) {
                final p = _products[i];
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(p.image, fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          p.title,
                          style: const TextStyle(color: Colors.white70),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        FormatUtils.formatPrice(p.price),
                        style: const TextStyle(color: Colors.tealAccent, fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      ElevatedButton.icon(
                        onPressed: () => _addToCart(p),
                        icon: const Icon(Icons.add_shopping_cart),
                        label: const Text('Agregar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.tealAccent.shade400,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(100, 35),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
