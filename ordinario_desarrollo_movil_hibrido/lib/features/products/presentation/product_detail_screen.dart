import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../favorites/favorites_provider.dart';
import '../presentation/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final fav = context.watch<FavoritesProvider>();

    final p = provider.products.firstWhere((e) => e.id == productId);
    final isFav = fav.favoriteIds.contains(productId);

    return Scaffold(
      appBar: AppBar(
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
          Hero(
            tag: "product-image-$productId",
            child: Image.network(
              p.image,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.title,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),

                Text(
                  "\$${p.price}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),
                Chip(label: Text(p.category)),

                const SizedBox(height: 20),
                const Text(
                  "Descripción",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Producto de excelente calidad, importado y con garantía incluida. "
                  "Perfecto para agregar a tu colección.",
                ),

                const SizedBox(height: 30),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text("Agregar al carrito"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
