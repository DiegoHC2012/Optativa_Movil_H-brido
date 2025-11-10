import 'package:flutter/material.dart';
import '../../models/purchase_model.dart';
import '../../core/utils/format_utils.dart';

class PurchaseDetailScreen extends StatelessWidget {
  final Purchase purchase;
  const PurchaseDetailScreen({super.key, required this.purchase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de compra')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Fecha: ${FormatUtils.formatDate(purchase.date)}',
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: purchase.items.length,
                itemBuilder: (context, i) {
                  final item = purchase.items[i];
                  return Card(
                    color: const Color(0xFF1E1E1E),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Image.network(item.product.image, width: 50),
                      title: Text(item.product.title,
                          style: const TextStyle(color: Colors.white70)),
                      subtitle: Text(
                        '${item.quantity} × ${FormatUtils.formatPrice(item.product.price)} = ${FormatUtils.formatPrice(item.total)}',
                        style: const TextStyle(color: Colors.tealAccent),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text('Total general: ${FormatUtils.formatPrice(purchase.total)}',
                style: const TextStyle(color: Colors.tealAccent, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
