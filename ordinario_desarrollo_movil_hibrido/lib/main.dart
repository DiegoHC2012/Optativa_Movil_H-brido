import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';

import 'features/auth/presentation/login_provider.dart';
import 'features/products/presentation/product_provider.dart';
import 'features/favorites/favorites_provider.dart';

void main() {
  runApp(const MixterioApp());
}

class MixterioApp extends StatelessWidget {
  const MixterioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
