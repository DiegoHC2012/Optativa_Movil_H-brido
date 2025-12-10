import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccessDeniedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: const Text("Acceso denegado"),
      ),
      body: const Center(
        child: Text(
          "No tienes permiso para acceder a esta sección",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
