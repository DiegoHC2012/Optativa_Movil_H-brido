import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'login_provider.dart';

class LoginScreen extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 82, color: Colors.blue),

                const SizedBox(height: 16),
                Text("Bienvenido",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                const SizedBox(height: 8),
                const Text("Inicia sesión para continuar"),

                const SizedBox(height: 32),

                TextField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(
                    labelText: "Correo electrónico",
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: passCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Contraseña",
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),

                const SizedBox(height: 28),

                provider.loading
                    ? const CircularProgressIndicator()
                    : FilledButton.icon(
                        icon: const Icon(Icons.login),
                        label: const Text("Iniciar sesión"),
                        onPressed: () async {
                          final ok = await provider.login(
                            emailCtrl.text.trim(),
                            passCtrl.text.trim(),
                          );
                          if (ok) context.go("/home");
                        },
                      ),

                const SizedBox(height: 14),

                TextButton(
                  onPressed: () => context.go("/register"),
                  child: const Text("Crear cuenta nueva"),
                ),

                if (provider.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      provider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
