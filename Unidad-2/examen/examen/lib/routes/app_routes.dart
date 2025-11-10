import 'package:flutter/material.dart';
import '../screens/login/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/purchases/purchases_screen.dart';
import '../screens/profile/profile_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const home = '/home';
  static const categories = '/categories';
  static const cart = '/cart';
  static const purchases = '/purchases';
  static const profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case categories:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case purchases:
        return MaterialPageRoute(builder: (_) => const PurchasesScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('Ruta no encontrada')),
                ));
    }
  }
}
