import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';

import 'features/auth/presentation/login_provider.dart';
import 'features/products/presentation/product_provider.dart';
import 'features/favorites/favorites_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Crear el provider MANUALMENTE para restaurar sesión antes del runApp
  final loginProvider = LoginProvider();
  await loginProvider.restoreSession();

  runApp(MixterioApp(loginProvider: loginProvider));
}

class MixterioApp extends StatelessWidget {
  final LoginProvider loginProvider;

  const MixterioApp({super.key, required this.loginProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>.value(value: loginProvider),
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
