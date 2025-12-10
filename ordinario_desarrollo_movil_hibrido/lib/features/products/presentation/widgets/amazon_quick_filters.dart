import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../product_provider.dart';

class AmazonQuickFilters extends StatelessWidget {
  const AmazonQuickFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final filters = [
      ["active", "Activos"],
      ["inactive", "Inactivos"],
      ["today", "Hoy"],
      ["week", "Semana"],
      ["month", "Mes"],
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          final value = filters[i][0];
          final label = filters[i][1];
          final active = provider.statusFilter == value ||
              provider.dateFilter == value;

          return GestureDetector(
            onTap: () {
              if (["active", "inactive"].contains(value)) {
                provider.setStatus(value);
              } else {
                provider.setDateFilter(value);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: active ? Colors.blue : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: active ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemCount: filters.length,
      ),
    );
  }
}
