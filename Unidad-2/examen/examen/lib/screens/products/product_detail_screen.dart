import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../models/cart_item_model.dart';
import '../../services/local_storage_service.dart';
import '../../core/utils/format_utils.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  bool _adding = false;

  Future<void> _addToCart() async {
    setState(() => _adding = true);
    final cart = await LocalStorageService.getCart();

    // Calcular la cantidad total actual en el carrito
    int totalCantidad = cart.fold(0, (sum, i) => sum + i.quantity);

    // Si se intenta agregar más productos que superan el máximo (7)
    if (totalCantidad + _quantity > 7) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Solo puedes tener 7 productos en total en el carrito.')),
      );
      setState(() => _adding = false);
      return;
    }

    // Calcular el total monetario actual
    double totalCarrito = cart.fold(0, (sum, i) => sum + i.total);
    totalCarrito += widget.product.price * _quantity;

    if (totalCarrito > 5000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El total del carrito no puede superar los \$5000')),
      );
      setState(() => _adding = false);
      return;
    }

    // Buscar si el producto ya existe en el carrito
    final existing = cart.indexWhere((i) => i.product.id == widget.product.id);
    if (existing != -1) {
      cart[existing].quantity += _quantity;
    } else {
      cart.add(CartItem(product: widget.product, quantity: _quantity));
    }

    await LocalStorageService.saveCart(cart);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto agregado al carrito')),
    );
    setState(() => _adding = false);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text(p.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(child: Image.network(p.image, fit: BoxFit.contain)),
            const SizedBox(height: 20),
            Text(p.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            Text(FormatUtils.formatPrice(p.price),
                style: const TextStyle(color: Colors.tealAccent, fontSize: 22)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (_quantity > 1) setState(() => _quantity--);
                    },
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.white70)),
                Text('$_quantity',
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                    onPressed: () => setState(() => _quantity++),
                    icon: const Icon(Icons.add_circle_outline, color: Colors.white70)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _adding ? null : _addToCart,
              icon: const Icon(Icons.add_shopping_cart),
              label: _adding
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Agregar al carrito'),
            ),
          ],
        ),
      ),
    );
  }
}
