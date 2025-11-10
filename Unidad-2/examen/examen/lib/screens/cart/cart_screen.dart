import 'package:flutter/material.dart';
import '../../models/cart_item_model.dart';
import '../../models/purchase_model.dart';
import '../../services/local_storage_service.dart';
import '../../widgets/cart_item_card.dart';
import '../../widgets/empty_state.dart';
import '../../core/utils/format_utils.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cart = [];

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final data = await LocalStorageService.getCart();
    setState(() => _cart = data);
  }

  double get total => _cart.fold(0, (sum, item) => sum + item.total);

  Future<void> _removeItem(CartItem item) async {
    _cart.remove(item);
    await LocalStorageService.saveCart(_cart);
    setState(() {});
  }

  Future<void> _clearCart() async {
    await LocalStorageService.clearCart();
    setState(() => _cart = []);
  }

  Future<void> _buyCart() async {
    if (_cart.isEmpty) return;
    await LocalStorageService.savePurchase(Purchase(items: _cart, date: DateTime.now()));
    await _clearCart();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Compra realizada con éxito')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrito')),
      body: _cart.isEmpty
          ? const EmptyState(message: 'Tu carrito está vacío')
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _cart.length,
                    itemBuilder: (context, i) => CartItemCard(
                      item: _cart[i],
                      onRemove: () => _removeItem(_cart[i]),
                    ),
                  ),
                ),
                Container(
                  color: const Color(0xFF1E1E1E),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Total: ${FormatUtils.formatPrice(total)}',
                          style: const TextStyle(color: Colors.tealAccent, fontSize: 20)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _buyCart,
                              child: const Text('Finalizar compra'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _clearCart,
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                              child: const Text('Limpiar carrito'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
