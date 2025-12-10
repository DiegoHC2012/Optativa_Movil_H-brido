import 'package:flutter/material.dart';
import '../widgets/filter_bottom_sheet.dart';

class AmazonTopBar extends StatelessWidget {
  const AmazonTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      color: color.surface,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => ProductFilterSheet.show(context), // 🔥 CORREGIDO
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: color.surfaceVariant.withOpacity(.5),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.tune),
                    SizedBox(width: 10),
                    Text("Filtros"),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: color.surfaceVariant.withOpacity(.5),
            ),
            child: const Row(
              children: [
                Icon(Icons.swap_vert),
                SizedBox(width: 6),
                Text("Ordenar"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
