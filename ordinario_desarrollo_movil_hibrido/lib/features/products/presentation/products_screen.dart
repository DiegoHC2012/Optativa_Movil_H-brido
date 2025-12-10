import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'product_provider.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    if (!provider.loading && provider.products.isEmpty) {
      provider.loadProducts();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
      ),

      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Buscador
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Buscar producto",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (v) {
                      provider.search = v;
                      provider.notifyListeners();
                    },
                  ),
                ),

                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .70,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: provider.filtered.length,
                    itemBuilder: (_, i) {
                      final p = provider.filtered[i];

                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => context.go("/product/${p.id}"),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Imagen
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                  child: Image.network(
                                    p.image,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  p.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, bottom: 8, right: 8),
                                child: Text(
                                  "\$${p.price}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
