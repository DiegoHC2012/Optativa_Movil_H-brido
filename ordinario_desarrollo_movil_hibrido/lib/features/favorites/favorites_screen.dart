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

    final favorites = products.filtered
        .where((p) => fav.favoriteIds.contains(p.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: const Text("Favoritos"),
      ),

      body: favorites.isEmpty
          ? const Center(
              child: Text("No tienes productos favoritos 💙"),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favorites.length,
              itemBuilder: (_, i) {
                final p = favorites[i];

                return Card(
                  child: ListTile(
                    leading: Image.network(p.image, width: 50),
                    title: Text(p.title),
                    subtitle: Text("\$${p.price}"),
                    trailing: const Icon(Icons.chevron_right),

                    // FIX DEFINITIVO: usar push, nunca go
                    onTap: () => context.push("/product/${p.id}"),
                  ),
                );
              },
            ),
    );
  }
}
