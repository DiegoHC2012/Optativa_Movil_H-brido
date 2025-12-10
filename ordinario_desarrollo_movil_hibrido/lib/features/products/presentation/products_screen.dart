import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'product_provider.dart';
import 'widgets/filter_bottom_sheet.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();

    // Cargar productos al inicio
    Future.microtask(() {
      context.read<ProductProvider>().loadProducts();
    });

    // Scroll infinito
    scroll.addListener(() {
      if (scroll.position.pixels >= scroll.position.maxScrollExtent - 250) {
        context.read<ProductProvider>().loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    // Aspect ratio estilo Amazon
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / 2;
    final itemHeight = 300; // Alto ideal para tarjeta Amazon
    final aspectRatio = itemWidth / itemHeight;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () => ProductFilterSheet.show(context),
          ),
        ],
      ),

      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // GRID
                Expanded(
                  child: GridView.builder(
                    controller: scroll,
                    padding: const EdgeInsets.all(12),

                    itemCount: provider.visibleProducts.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: aspectRatio,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),

                    itemBuilder: (_, i) {
                      final product = provider.visibleProducts[i];
                      return _amazonCard(product);
                    },
                  ),
                ),

                // BOTÓN "VER MÁS"
                if (provider.itemsToShow < provider.filtered.length)
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: FilledButton(
                      onPressed: provider.loadMore,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text("Ver más productos"),
                    ),
                  ),
              ],
            ),
    );
  }

  // ⭐ CARD AMAZON PREMIUM
  Widget _amazonCard(product) {
    final color = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.push("/product/${product.id}"),
      child: Container(
        decoration: BoxDecoration(
          color: color.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen compacta estilo Amazon
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Info del producto
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // Título
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 6),

                    // Precio
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Rating fake Amazon
                    const Row(
                      children: [
                        Icon(Icons.star, size: 18, color: Colors.orange),
                        SizedBox(width: 4),
                        Text("4.9"),
                      ],
                    ),

                    const Spacer(),

                    // Estado
                    if (product.active)
                      const Text(
                        "En stock",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
