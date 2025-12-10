import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(child: _statCard("Ventas mensuales", "12.4K", Icons.trending_up)),
            const SizedBox(width: 12),
            Expanded(child: _statCard("Usuarios activos", "1.2K", Icons.people_alt)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _statCard("Productos", "240", Icons.inventory_2_outlined)),
            const SizedBox(width: 12),
            Expanded(child: _statCard("Reportes", "14", Icons.warning_amber)),
          ],
        ),
        const SizedBox(height: 20),

        const Text(
          "Actividad reciente",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),

        _activityTile("Nuevo usuario registrado", "Hace 5 min"),
        _activityTile("Producto agregado al catálogo", "Hace 12 min"),
        _activityTile("Admin generó reporte mensual", "Hace 1 hora"),
      ],
    );
  }

  Widget _statCard(String title, String number, IconData icon) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 12),
            Text(number,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _activityTile(String title, String time) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.check_circle_outline),
        title: Text(title),
        subtitle: Text(time),
      ),
    );
  }
}
