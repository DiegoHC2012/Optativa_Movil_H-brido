import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomerWelcomeScreen extends StatelessWidget {
  const CustomerWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: color.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ===============================
            // ENCABEZADO GRANDE
            // ===============================
            Text(
              "Bienvenido a Mixterio Shop 🛍️",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              "Explora miles de productos increíbles, ofertas y mucho más.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 20),

            // ===============================
            // BANNER IMAGEN
            // ===============================
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 25),

            // ===============================
            // CATEGORÍAS SIMULADAS
            // ===============================
            Text(
              "Categorías populares",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _CategoryCard(
                  icon: Icons.phone_android,
                  label: "Tecnología",
                ),
                _CategoryCard(
                  icon: Icons.chair_alt,
                  label: "Hogar",
                ),
                _CategoryCard(
                  icon: Icons.watch,
                  label: "Moda",
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ===============================
            // DESTACADOS (FAKE DATA)
            // ===============================
            Text(
              "Destacados",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _FeaturedCard(
                    title: "Audífonos Pro",
                    img: "https://images.unsplash.com/photo-1585386959984-a4155224a1ad",
                  ),
                  _FeaturedCard(
                    title: "Smartwatch",
                    img: "https://m.media-amazon.com/images/I/61Dc9aR8YGL._AC_UF1000,1000_QL80_.jpg",
                  ),
                  _FeaturedCard(
                    title: "Laptop Gaming",
                    img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6SVf9mrj9uz5XTmcfYcysO3Ij6TugEbC-jQ&s",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ===============================
            // BOTÓN EXPLORAR PRODUCTOS
            // ===============================
            FilledButton.icon(
              onPressed: () => context.push("/products"),
              icon: const Icon(Icons.store_mall_directory_outlined),
              label: const Text("Explorar productos"),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ===================================================================
// COMPONENTES UI
// ===================================================================

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CategoryCard({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: 100,
      height: 110,
      decoration: BoxDecoration(
        color: color.primaryContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color.primary),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final String title;
  final String img;

  const _FeaturedCard({
    required this.title,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGEN
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              img,
              height: 110,
              width: 160,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 8),

          // TÍTULO
          Text(
            title,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            "Ver más →",
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
