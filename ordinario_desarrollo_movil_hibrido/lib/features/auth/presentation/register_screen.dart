import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final dio = Dio();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final avatarCtrl =
      TextEditingController(text: "https://i.imgur.com/LDOO4Qs.jpg");

  String role = "customer";
  bool loading = false;
  String? errorMessage;

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
      errorMessage = null;
    });

    try {
      final response = await dio.post(
        "https://api.escuelajs.co/api/v1/users",
        data: {
          "name": nameCtrl.text.trim(),
          "email": emailCtrl.text.trim(),
          "password": passCtrl.text.trim(),
          "role": role,
          "avatar": avatarCtrl.text.trim(),
        },
      );

      setState(() => loading = false);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario registrado exitosamente")),
      );

      GoRouter.of(context).go("/"); // 🔥 IR DIRECTO AL LOGIN

    } on DioException catch (e) {
      setState(() => loading = false);

      if (e.response != null) {
        // Mensaje real de la API
        errorMessage = e.response?.data.toString();
      } else {
        errorMessage = "Error de conexión";
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Crear cuenta")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [

              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) =>
                    v!.isEmpty ? "Este campo es obligatorio" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (v) =>
                    v!.contains("@") ? null : "Correo inválido",
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                validator: (v) =>
                    v!.length < 6 ? "Mínimo 6 caracteres" : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField(
                value: role,
                items: const [
                  DropdownMenuItem(
                    value: "customer",
                    child: Text("Cliente"),
                  ),
                  DropdownMenuItem(
                    value: "admin",
                    child: Text("Administrador"),
                  ),
                ],
                onChanged: (v) => setState(() => role = v!),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.admin_panel_settings),
                  labelText: "Tipo de usuario",
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: avatarCtrl,
                decoration: const InputDecoration(
                  labelText: "Avatar URL",
                  prefixIcon: Icon(Icons.image_outlined),
                ),
              ),

              const SizedBox(height: 30),

              loading
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton(
                      onPressed: register,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Registrar usuario"),
                    ),

              const SizedBox(height: 16),

              // ⭐ BOTÓN "IR AL LOGIN"
              TextButton(
                onPressed: () => GoRouter.of(context).go("/"),
                child: const Text("¿Ya tienes cuenta? Iniciar sesión"),
              ),

              if (errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  errorMessage!,
                  style: TextStyle(color: color.error),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
