import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../product_provider.dart';

class AmazonSortBottomSheet {
  static void show(BuildContext context) {
    final provider = context.read<ProductProvider>();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Ordenar por",
                  style: Theme.of(context).textTheme.headlineSmall),

              const SizedBox(height: 20),

              _option(
                context,
                label: "Precio",
                selected: provider.sortBy == "price",
                onTap: () => provider.setSorting("price", provider.sortAsc),
              ),

              _option(
                context,
                label: "Fecha",
                selected: provider.sortBy == "date",
                onTap: () => provider.setSorting("date", provider.sortAsc),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.sortAsc ? "Ascendente" : "Descendente"),
                  Switch(
                    value: provider.sortAsc,
                    onChanged: (v) =>
                        provider.setSorting(provider.sortBy, v),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _option(BuildContext context,
      {required String label,
      required bool selected,
      required Function() onTap}) {
    return ListTile(
      title: Text(label),
      trailing: selected
          ? const Icon(Icons.check_circle, color: Colors.blue)
          : const Icon(Icons.circle_outlined),
      onTap: onTap,
    );
  }
}
