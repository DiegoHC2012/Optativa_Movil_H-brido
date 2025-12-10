import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateProductScreen extends StatefulWidget {
  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final formKey = GlobalKey<FormState>();

  String category = "electronics";
  String? subcategory;
  final priceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: const Text("Crear producto"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              DropdownButtonFormField(
                value: category,
                decoration: const InputDecoration(labelText: "Categoría"),
                items: const [
                  DropdownMenuItem(
                      value: "electronics", child: Text("Electronics")),
                  DropdownMenuItem(value: "clothes", child: Text("Clothes")),
                ],
                onChanged: (v) {
                  setState(() {
                    category = v!;
                    subcategory = null;
                  });
                },
              ),

              const SizedBox(height: 16),

              if (category == "electronics")
                DropdownButtonFormField(
                  value: subcategory,
                  decoration:
                      const InputDecoration(labelText: "Subcategoría"),
                  items: const [
                    DropdownMenuItem(value: "phone", child: Text("Phone")),
                    DropdownMenuItem(value: "laptop", child: Text("Laptop")),
                  ],
                  onChanged: (v) => setState(() => subcategory = v),
                  validator: (v) =>
                      v == null ? "Selecciona subcategoría" : null,
                ),

              const SizedBox(height: 16),

              TextFormField(
                controller: priceCtrl,
                decoration:
                    const InputDecoration(labelText: "Precio del producto"),
                keyboardType: TextInputType.number,
                validator: (v) {
                  final p = double.tryParse(v ?? "");
                  if (p == null || p <= 0) return "Precio inválido";
                  return null;
                },
              ),

              const SizedBox(height: 30),

              FilledButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Guardar producto"),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Producto guardado")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
