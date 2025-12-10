import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../auth/presentation/login_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      final provider = context.read<LoginProvider>();

      if (provider.user != null) {
        context.go("/home");
      } else {
        context.go("/");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.primaryContainer.withOpacity(0.85),
      body: Center(
        child: Hero(
          tag: "app-logo",
          child: Icon(
            Icons.shopping_bag_rounded,
            size: 130,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
