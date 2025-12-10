import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Splash
import '../../features/splash/splash_screen.dart';

// Auth
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/login_provider.dart';
import '../../features/auth/guards/auth_guard.dart';

// Home & Admin
import '../../features/home/home_screen.dart';
import '../../features/home/admin_dashboard.dart';

// Products
import '../../features/products/presentation/products_screen.dart';
import '../../features/products/presentation/product_detail_screen.dart';
import '../../features/products/presentation/create_product_screen.dart';

// Favorites
import '../../features/favorites/favorites_screen.dart';

// Roles
import '../../features/roles/access_denied_screen.dart';

// Animations
import 'custom_transitions.dart';

final appRouter = GoRouter(
  initialLocation: "/splash",

  routes: [
    /// ================================
    /// SPLASH SCREEN
    /// ================================
    GoRoute(
      path: "/splash",
      pageBuilder: (_, __) =>
          FadeTransitionPage(child: SplashScreen()),
    ),

    /// ================================
    /// AUTH
    /// ================================
    GoRoute(
      path: "/",
      pageBuilder: (_, __) =>
          FadeTransitionPage(child: LoginScreen()),
    ),

    GoRoute(
      path: "/register",
      pageBuilder: (_, __) =>
          FadeTransitionPage(child: RegisterScreen()),
    ),

    /// ================================
    /// HOME (requiere login)
    /// ================================
    GoRoute(
      path: "/home",
      redirect: AuthGuard.requireLogin,
      pageBuilder: (_, __) =>
          FadeTransitionPage(child: HomeScreen()),
    ),

    /// ================================
    /// ADMIN DASHBOARD (solo admin)
    /// ================================
    GoRoute(
      path: "/admin-dashboard",
      redirect: AuthGuard.requireAdmin,
      builder: (_, __) => AdminDashboard(),
    ),

    /// ================================
    /// PRODUCTOS
    /// ================================
    GoRoute(
      path: "/products",
      redirect: AuthGuard.requireLogin,
      pageBuilder: (_, __) =>
          FadeTransitionPage(child: ProductsScreen()),
    ),

    GoRoute(
      path: "/product/:id",
      redirect: AuthGuard.requireLogin,
      pageBuilder: (context, state) {
        final id = int.parse(state.pathParameters["id"]!);
        return FadeTransitionPage(
            child: ProductDetailScreen(productId: id));
      },
    ),

    /// ================================
    /// CREAR PRODUCTO (ADMIN)
    /// ================================
    GoRoute(
      path: "/create-product",
      redirect: AuthGuard.requireAdmin,
      pageBuilder: (_, __) =>
          FadeTransitionPage(child: CreateProductScreen()),
    ),

    /// ================================
    /// FAVORITOS
    /// ================================
    GoRoute(
      path: "/favorites",
      redirect: AuthGuard.requireLogin,
      pageBuilder: (_, __) =>
          FadeTransitionPage(child: FavoritesScreen()),
    ),

    /// ================================
    /// ACCESS DENIED
    /// ================================
    GoRoute(
      path: "/access-denied",
      builder: (_, __) => AccessDeniedScreen(),
    ),
  ],
);
