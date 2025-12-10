import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../product_provider.dart';

class ProductFilterSheet {
  static Future<void> show(BuildContext context) async {
    final color = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: color.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (_) {
        return Consumer<ProductProvider>(
          builder: (_, provider, __) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.90,
              maxChildSize: 0.95,
              minChildSize: 0.6,
              builder: (_, scroll) {
                return Column(
                  children: [
                    // Handle
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: color.outlineVariant,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Text(
                      "Filtros avanzados",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    Expanded(
                      child: ListView(
                        controller: scroll,
                        padding: const EdgeInsets.all(20),
                        children: [
                          // 🔍 BUSCADOR
                          TextField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              labelText: "Buscar producto",
                            ),
                            onChanged: (v) {
                              provider.search = v;
                              provider.resetVisible();
                            },
                          ),

                          const SizedBox(height: 25),

                          // 📌 CATEGORÍAS
                          Text("Categorías",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 12),

                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _chip(provider, "all", "Todas", isCategory: true),
                              _chip(provider, "electronics", "Electrónica",
                                  isCategory: true),
                              _chip(provider, "jewelery", "Joyería",
                                  isCategory: true),
                              _chip(provider, "men's clothing", "Hombre",
                                  isCategory: true),
                              _chip(provider, "women's clothing", "Mujer",
                                  isCategory: true),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // 📌 ESTADO
                          Text("Estado",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              _radio(provider, "all", "Todos"),
                              _radio(provider, "active", "Activos"),
                              _radio(provider, "inactive", "Inactivos"),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // 📅 FECHA
                          Text("Fecha",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 12),

                          Wrap(
                            spacing: 12,
                            children: [
                              _date(provider, "all", "Siempre"),
                              _date(provider, "today", "Hoy"),
                              _date(provider, "week", "Semana"),
                              _date(provider, "month", "Mes"),
                              _date(provider, "year", "Año"),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // ⭐ ORDENAMIENTO AMAZON
                          Text("Ordenar por",
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 12),

                          Column(
                            children: [
                              ListTile(
                                title: const Text("Precio"),
                                trailing: provider.sortBy == "price"
                                    ? const Icon(Icons.check, color: Colors.blue)
                                    : null,
                                onTap: () =>
                                    provider.setSorting("price", provider.sortAsc),
                              ),
                              ListTile(
                                title: const Text("Fecha de creación"),
                                trailing: provider.sortBy == "date"
                                    ? const Icon(Icons.check, color: Colors.blue)
                                    : null,
                                onTap: () =>
                                    provider.setSorting("date", provider.sortAsc),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // ASC / DESC
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(provider.sortAsc
                                  ? "Ascendente"
                                  : "Descendente"),
                              const SizedBox(width: 10),
                              Switch(
                                value: provider.sortAsc,
                                onChanged: (v) =>
                                    provider.setSorting(provider.sortBy, v),
                              ),
                            ],
                          ),

                          const SizedBox(height: 50),
                        ],
                      ),
                    ),

                    // ========== BOTÓN LIMPIAR FILTROS ==========
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: OutlinedButton(
                        onPressed: () {
                          provider.clearAllFilters();
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Limpiar filtros"),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ========== BOTÓN APLICAR ==========
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: FilledButton(
                        onPressed: () => Navigator.pop(context),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Aplicar filtros"),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  // ---------- WIDGETS DE FILTRO ----------

  static Widget _chip(provider, value, label, {bool isCategory = false}) {
    final bool selected =
        isCategory ? provider.categoryFilter == value : provider.dateFilter == value;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        if (isCategory) {
          provider.setCategory(value);
        } else {
          provider.setDateFilter(value);
        }
      },
    );
  }

  static Widget _date(provider, value, label) {
    return ChoiceChip(
      label: Text(label),
      selected: provider.dateFilter == value,
      onSelected: (_) => provider.setDateFilter(value),
    );
  }

  static Widget _radio(provider, value, label) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: provider.statusFilter,
          onChanged: (v) => provider.setStatus(v as String),
        ),
        Text(label),
      ],
    );
  }
}
