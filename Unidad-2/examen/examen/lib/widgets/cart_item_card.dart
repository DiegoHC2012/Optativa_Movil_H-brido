import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../core/utils/format_utils.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback? onRemove;

  const CartItemCard({super.key, required this.item, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: Image.network(item.product.image, width: 50, height: 50),
        title: Text(item.product.title,
            style: const TextStyle(color: Colors.white70, fontSize: 15)),
        subtitle: Text(
          '${item.quantity} × ${FormatUtils.formatPrice(item.product.price)} = ${FormatUtils.formatPrice(item.total)}',
          style: const TextStyle(color: Colors.tealAccent),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
