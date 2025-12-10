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

    // ============================================================
    // PANTALLAS PÚBLICAS
    // ============================================================
    GoRoute(
      path: "/splash",
      pageBuilder: (_, __) =>
          FadeTransitionPage(child: SplashScreen()),
    ),

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

    // ============================================================
    // SHELL ROUTE - TODAS LAS PANTALLAS QUE NECESITAN BACK
    // COMPARTEN EL MISMO NAVIGATOR → NO MÁS “There is nothing to pop”
    // ============================================================
    ShellRoute(
      builder: (_, __, child) => child,
      routes: [

        // HOME (requiere login)
        GoRoute(
          path: "/home",
          redirect: AuthGuard.requireLogin,
          pageBuilder: (_, __) =>
              FadeTransitionPage(child: HomeScreen()),
        ),

        // PRODUCTOS
        GoRoute(
          path: "/products",
          redirect: AuthGuard.requireLogin,
          pageBuilder: (_, __) =>
              FadeTransitionPage(child: ProductsScreen()),
        ),

        // DETALLE
        GoRoute(
          path: "/product/:id",
          redirect: AuthGuard.requireLogin,
          pageBuilder: (context, state) {
            final id = int.parse(state.pathParameters["id"]!);
            return FadeTransitionPage(
              child: ProductDetailScreen(productId: id),
            );
          },
        ),

        // FAVORITOS
        GoRoute(
          path: "/favorites",
          redirect: AuthGuard.requireLogin,
          pageBuilder: (_, __) =>
              FadeTransitionPage(child: FavoritesScreen()),
        ),
      ],
    ),

    // ============================================================
    // RUTAS ADMIN
    // ============================================================
    GoRoute(
      path: "/admin-dashboard",
      redirect: AuthGuard.requireAdmin,
      pageBuilder: (_, __) =>
          FadeTransitionPage(child: AdminDashboard()),
    ),

    GoRoute(
      path: "/create-product",
      redirect: AuthGuard.requireAdmin,
      pageBuilder: (_, __) =>
          FadeTransitionPage(child: CreateProductScreen()),
    ),

    // ============================================================
    // ACCESS DENIED
    // ============================================================
    GoRoute(
      path: "/access-denied",
      pageBuilder: (_, __) =>
          FadeTransitionPage(child: AccessDeniedScreen()),
    ),
  ],
);
