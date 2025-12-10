import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../favorites/favorites_provider.dart';
import 'product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final fav = context.watch<FavoritesProvider>();

    final p = provider.filtered.firstWhere((e) => e.id == productId);
    final isFav = fav.favoriteIds.contains(productId);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(p.title),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            onPressed: () => fav.toggleFavorite(productId),
          ),
        ],
      ),

      body: ListView(
        children: [
          Image.network(
            p.image,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),

                Text(
                  "\$${p.price}",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),
                Chip(label: Text(p.category)),

                const SizedBox(height: 20),

                const Text(
                  "Descripción",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),

                const Text(
                  "Producto de excelente calidad, importado y con garantía incluida. "
                  "Perfecto para tu colección o uso personal.",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
