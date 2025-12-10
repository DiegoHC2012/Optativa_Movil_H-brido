import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../presentation/product_provider.dart';
import '../../products/domain/entities/product.dart';

class CreateProductScreen extends StatefulWidget {
  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final formKey = GlobalKey<FormState>();

  String title = "";
  String category = "";
  String? subcategory;
  String image = "";
  double? price;
  DateTime? date;
  bool active = true;
  String description = "";

  final subcats = {
    "electronics": ["Smartphones", "Laptops", "Accesorios"],
    "jewelery": ["Anillos", "Collares"],
    "men's clothing": ["Camisas", "Pantalones"],
    "women's clothing": ["Vestidos", "Blusas"],
  };

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Crear producto")),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Nombre"),
              onChanged: (v) => title = v,
              validator: (v) =>
                  v == null || v.isEmpty ? "El nombre es obligatorio" : null,
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(labelText: "Precio"),
              keyboardType: TextInputType.number,
              onChanged: (v) => price = double.tryParse(v),
              validator: (v) {
                final n = double.tryParse(v ?? "");
                if (n == null || n <= 0) return "Ingrese un precio válido";
                return null;
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Categoría"),
              value: category.isEmpty ? null : category,
              items: subcats.keys
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) {
                category = v!;
                subcategory = null;
                setState(() {});
              },
              validator: (v) =>
                  v == null ? "Seleccione una categoría" : null,
            ),

            const SizedBox(height: 16),

            if (category.isNotEmpty)
              DropdownButtonFormField<String>(
                decoration:
                    const InputDecoration(labelText: "Subcategoría"),
                value: subcategory,
                items: subcats[category]!
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => subcategory = v,
                validator: (v) =>
                    v == null ? "Seleccione una subcategoría" : null,
              ),

            const SizedBox(height: 16),

            TextFormField(
              decoration:
                  const InputDecoration(labelText: "URL de imagen"),
              onChanged: (v) => image = v,
              validator: (v) => v != null && v.startsWith("http")
                  ? null
                  : "Ingrese una URL válida",
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration:
                  const InputDecoration(labelText: "Fecha (YYYY-MM-DD)"),
              onChanged: (v) {
                try {
                  date = DateTime.parse(v);
                } catch (_) {
                  date = null;
                }
              },
              validator: (v) {
                if (date == null) return "Fecha inválida";

                final now = DateTime.now();
                if (date!.isBefore(DateTime(now.year, now.month, now.day))) {
                  return "La fecha no puede ser anterior a hoy";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(labelText: "Descripción"),
              maxLines: 3,
              onChanged: (v) => description = v,
              validator: (v) =>
                  v == null || v.isEmpty ? "Describe el producto" : null,
            ),

            const SizedBox(height: 16),

            SwitchListTile(
              title: const Text("¿Activo?"),
              value: active,
              onChanged: (v) => setState(() => active = v),
            ),

            const SizedBox(height: 20),

            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;

                final newProduct = Product(
                  id: DateTime.now().millisecondsSinceEpoch,
                  title: title,
                  price: price!,
                  description: description,
                  category: "$category - $subcategory",
                  image: image,
                  active: active,
                  createdAt: date!,
                );

                await provider.saveLocalProduct(newProduct);
                await provider.loadLocalProducts();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Producto creado")),
                );

                GoRouter.of(context).pop();
              },
              child: const Text("Crear producto"),
            ),
          ],
        ),
      ),
    );
  }
}
