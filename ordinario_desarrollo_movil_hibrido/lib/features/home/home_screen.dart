import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../auth/presentation/login_provider.dart';
import './admin_dashboard.dart';
import '../products/presentation/create_product_screen.dart';
import './customer_welcome_screen.dart';
import '../favorites/favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int adminIndex = 0;   // 0 = Dashboard, 1 = Crear producto
  int customerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final login = context.watch<LoginProvider>();

    // Mostrar loading mientras el usuario carga
    if (login.user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final user = login.user!;
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hola, ${user.name} 👋"),

        // ⭐ Menú hamburguesa SOLO PARA ADMIN
        leading: user.role == "admin"
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<LoginProvider>().logout();
              context.go("/");
            },
          ),
        ],
      ),

      // ===================================================================================
      // ⭐ DRAWER HAMBURGUESA PARA ADMIN
      // ===================================================================================
      drawer: user.role == "admin"
          ? Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: color.primary),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Menú administrador",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),

                  // DASHBOARD
                  ListTile(
                    leading: const Icon(Icons.dashboard_outlined),
                    title: const Text("Dashboard"),
                    selected: adminIndex == 0,
                    onTap: () {
                      setState(() => adminIndex = 0);
                      Navigator.pop(context); // Cierra Drawer
                    },
                  ),

                  // CREAR PRODUCTO
                  ListTile(
                    leading: const Icon(Icons.add_box_outlined),
                    title: const Text("Crear producto"),
                    selected: adminIndex == 1,
                    onTap: () {
                      setState(() => adminIndex = 1);
                      Navigator.pop(context);
                    },
                  ),

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      "Panel Admin",
                      style: TextStyle(
                        color: color.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            )
          : null,

      // ===================================================================================
      // ⭐ BODY — DIFERENTE PARA ADMIN Y PARA CUSTOMER
      // ===================================================================================
      body: user.role == "admin"
          ? _adminBody()
          : _customerBody(),

      // ===================================================================================
      // ⭐ BOTTOM NAV PARA CUSTOMER
      // ===================================================================================
      bottomNavigationBar: user.role == "customer"
          ? NavigationBar(
              selectedIndex: customerIndex,
              onDestinationSelected: (i) => setState(() => customerIndex = i),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.storefront_outlined),
                  label: "Inicio",
                ),
                NavigationDestination(
                  icon: Icon(Icons.favorite_outline),
                  label: "Favoritos",
                ),
              ],
            )
          : null,
    );
  }

  // ===================================================================================
  // ADMIN: Dos pantallas -> Dashboard | Crear Producto
  // ===================================================================================
  Widget _adminBody() {
    switch (adminIndex) {
      case 0:
        return const AdminDashboard();
      case 1:
        return CreateProductScreen();
      default:
        return const AdminDashboard();
    }
  }

  // ===================================================================================
  // CUSTOMER: Bienvenida | Favoritos
  // ===================================================================================
  Widget _customerBody() {
    switch (customerIndex) {
      case 0:
        return CustomerWelcomeScreen();
      case 1:
        return FavoritesScreen();
      default:
        return CustomerWelcomeScreen();
    }
  }
}
