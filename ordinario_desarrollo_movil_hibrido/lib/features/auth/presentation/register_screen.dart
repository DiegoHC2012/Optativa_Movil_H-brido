import 'package:flutter/material.dart';
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
  String? error;

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      await dio.post(
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario registrado exitosamente")),
      );

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        loading = false;
        error = "Error al registrar usuario";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                decoration: const InputDecoration(labelText: "Nombre"),
                validator: (v) =>
                    v!.isEmpty ? "Este campo es obligatorio" : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (v) =>
                    v!.contains("@") ? null : "Correo inválido",
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Contraseña"),
                validator: (v) =>
                    v!.length < 6 ? "Mínimo 6 caracteres" : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField(
                value: role,
                items: const [
                  DropdownMenuItem(
                      value: "customer", child: Text("Cliente")),
                  DropdownMenuItem(value: "admin", child: Text("Admin")),
                ],
                onChanged: (v) => setState(() => role = v!),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: avatarCtrl,
                decoration: const InputDecoration(labelText: "Avatar URL"),
              ),
              const SizedBox(height: 24),

              loading
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton(
                      onPressed: register,
                      child: const Text("Registrar usuario"),
                    ),

              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(error!, style: const TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
