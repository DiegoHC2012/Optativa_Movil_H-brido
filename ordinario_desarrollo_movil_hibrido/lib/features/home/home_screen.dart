import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../auth/presentation/login_provider.dart';
import './admin_dashboard.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<LoginProvider>().user!;

    final pagesCustomer = [
      _CustomerHomeMenu(),
      _CustomerFavorites(),
    ];

    final pagesAdmin = [
      AdminDashboard(),
      _AdminCreateProduct(),
      _AdminSettings(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Hola, ${user.name} 👋"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<LoginProvider>().logout();
              context.go("/");
            },
          )
        ],
      ),

      body: user.role == "admin"
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: index,
                  onDestinationSelected: (i) => setState(() => index = i),
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      label: Text("Dashboard"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.add_box_outlined),
                      label: Text("Crear"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings_outlined),
                      label: Text("Ajustes"),
                    ),
                  ],
                ),
                Expanded(child: pagesAdmin[index]),
              ],
            )
          : pagesCustomer[index],

      bottomNavigationBar: user.role == "customer"
          ? NavigationBar(
              height: 65,
              selectedIndex: index,
              onDestinationSelected: (i) => setState(() => index = i),
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
}

class _CustomerHomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton.icon(
        icon: const Icon(Icons.store_mall_directory_outlined),
        label: const Text("Explorar productos"),
        onPressed: () => context.go("/products"),
      ),
    );
  }
}

class _CustomerFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton.icon(
        icon: const Icon(Icons.favorite_border),
        label: const Text("Ver favoritos"),
        onPressed: () => context.go("/favorites"),
      ),
    );
  }
}

class _AdminCreateProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton.icon(
        icon: const Icon(Icons.add_box_outlined),
        label: const Text("Crear producto"),
        onPressed: () => context.go("/create-product"),
      ),
    );
  }
}

class _AdminSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Ajustes del administrador"));
  }
}
