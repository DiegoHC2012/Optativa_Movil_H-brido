import 'package:flutter/material.dart';
import '../../models/purchase_model.dart';
import '../../services/local_storage_service.dart';
import '../../widgets/purchase_card.dart';
import '../../widgets/empty_state.dart';
import 'purchase_detail_screen.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  List<Purchase> _purchases = [];

  @override
  void initState() {
    super.initState();
    _loadPurchases();
  }

  Future<void> _loadPurchases() async {
    final data = await LocalStorageService.getPurchases();
    setState(() => _purchases = data.reversed.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Compras')),
      body: _purchases.isEmpty
          ? const EmptyState(message: 'Aún no has realizado ninguna compra.')
          : ListView.builder(
              itemCount: _purchases.length,
              itemBuilder: (context, i) {
                final p = _purchases[i];
                return PurchaseCard(
                  purchase: p,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PurchaseDetailScreen(purchase: p)),
                  ),
                );
              },
            ),
    );
  }
}
