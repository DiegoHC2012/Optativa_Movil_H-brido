import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import './favorites_provider.dart';
import '../products/presentation/product_provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fav = context.watch<FavoritesProvider>();
    final products = context.watch<ProductProvider>();

    final favorites = products.products
        .where((p) => fav.favoriteIds.contains(p.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
      ),

      body: favorites.isEmpty
          ? const Center(
              child: Text(
                "No tienes productos favoritos aún 💙",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favorites.length,
              itemBuilder: (_, i) {
                final p = favorites[i];

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(p.image, height: 55),
                    ),
                    title: Text(p.title),
                    subtitle: Text("\$${p.price}"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go("/product/${p.id}"),
                  ),
                );
              },
            ),
    );
  }
}
