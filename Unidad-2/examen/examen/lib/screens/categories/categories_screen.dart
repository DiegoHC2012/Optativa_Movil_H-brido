import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../products/products_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final api = ApiService();
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final data = await api.get('products');
    final categories = (data as List).map((e) => e['category'] as String).toSet().toList();
    setState(() => _categories = categories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: _categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, i) {
                return Card(
                  color: const Color(0xFF1E1E1E),
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(_categories[i], style: const TextStyle(color: Colors.white)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.white70),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductsScreen(category: _categories[i]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
