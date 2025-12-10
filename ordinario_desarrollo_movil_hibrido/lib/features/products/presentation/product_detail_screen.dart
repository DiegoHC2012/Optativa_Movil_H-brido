import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../favorites/favorites_provider.dart';
import '../presentation/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final fav = context.watch<FavoritesProvider>();

    final p = provider.filtered.firstWhere((e) => e.id == productId);
    final isFav = fav.favoriteIds.contains(productId);

    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: color.surface,
      appBar: AppBar(
        title: Text(
          p.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
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
          // ⭐ Imagen grande tipo Amazon
          GestureDetector(
            onTap: () {},
            child: Container(
              color: const Color.fromARGB(255, 3, 3, 3),
              child: Hero(
                tag: "product_${p.id}",
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    p.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // ⭐ TÍTULO + RATING
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Row(
                  children: const [
                    Icon(Icons.star, size: 20, color: Colors.orange),
                    SizedBox(width: 3),
                    Text("4.9 (230 reseñas)",
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),
          _divider(),

          // ⭐ PRECIO + ENVÍO + STOCK
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${p.price}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 6),

                const Text(
                  "Envío GRATIS",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  p.active ? "En stock" : "No disponible",
                  style: TextStyle(
                    color: p.active ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),
          _divider(),

          // ⭐ DESCRIPCIÓN
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Descripción del producto",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text( p.description ??
                      "Producto de excelente calidad con garantía incluida. "
                      "Ideal para uso personal o profesional. Materiales premium y duraderos.",
                  style: const TextStyle(height: 1.4),
                ),
              ],
            ),
          ),

          _divider(),

          // ⭐ INFORMACIÓN ADICIONAL
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Detalles del producto",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                _infoRow("Categoría", p.category),
                _infoRow("ID del producto", p.id.toString()),
                _infoRow("Estado", p.active ? "Activo" : "Inactivo"),
              ],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),

      bottomNavigationBar: _amazonButtons(context),
    );
  }

  // ⭐ BOTONES AMAZON (Comprar ahora / Añadir al carrito)
  Widget _amazonButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade400,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {},
              child: const Text("Añadir al carrito"),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade800,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {},
              child: const Text("Comprar ahora"),
            ),
          ),
        ],
      ),
    );
  }

  // ⭐ SEPARADOR AMAZON
  Widget _divider() {
    return Container(
      height: 10,
      color: const Color.fromARGB(255, 27, 27, 27),
      margin: const EdgeInsets.symmetric(vertical: 10),
    );
  }

  // ⭐ FILA DE INFORMACIÓN
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
