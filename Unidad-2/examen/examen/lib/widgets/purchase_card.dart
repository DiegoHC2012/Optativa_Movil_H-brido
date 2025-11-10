import 'package:flutter/material.dart';
import '../models/purchase_model.dart';
import '../core/utils/format_utils.dart';

class PurchaseCard extends StatelessWidget {
  final Purchase purchase;
  final VoidCallback? onTap;

  const PurchaseCard({super.key, required this.purchase, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(
          'Compra del ${FormatUtils.formatDate(purchase.date)}',
          style: const TextStyle(color: Colors.white70),
        ),
        subtitle: Text(
          '${purchase.items.length} productos - Total ${FormatUtils.formatPrice(purchase.total)}',
          style: const TextStyle(color: Colors.tealAccent),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white60),
        onTap: onTap,
      ),
    );
  }
}
