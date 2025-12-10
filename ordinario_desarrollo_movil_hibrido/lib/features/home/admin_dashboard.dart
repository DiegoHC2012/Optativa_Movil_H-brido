import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ========================================================
          //   ⭐ TITULO PRINCIPAL
          // ========================================================
          Text(
            "Panel de administración",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // ========================================================
          //   ⭐ METRIC CARDS
          // ========================================================
          Row(
            children: [
              Expanded(
                child: _metricCard(
                  context,
                  title: "Ventas mensuales",
                  value: "12.4K",
                  icon: Icons.trending_up,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _metricCard(
                  context,
                  title: "Usuarios activos",
                  value: "1.2K",
                  icon: Icons.people_alt_outlined,
                  color: Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _metricCard(
                  context,
                  title: "Productos",
                  value: "240",
                  icon: Icons.inventory_2_outlined,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _metricCard(
                  context,
                  title: "Reportes",
                  value: "14",
                  icon: Icons.warning_amber_rounded,
                  color: Colors.red,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // ========================================================
          //   ⭐ GRÁFICA DECORATIVA
          // ========================================================
          Text(
            "Rendimiento semanal",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _chartDummy(color),

          const SizedBox(height: 30),

          // ========================================================
          //   ⭐ ACTIVIDAD RECIENTE
          // ========================================================
          Text(
            "Actividad reciente",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          _activityTile("Nuevo usuario registrado", "Hace 5 min", Icons.person_add_alt),
          _activityTile("Producto agregado al catálogo", "Hace 12 min", Icons.inventory_outlined),
          _activityTile("Reporte mensual generado", "Hace 1 hora", Icons.analytics_outlined),
          _activityTile("Admin modificó un producto", "Hace 2 horas", Icons.edit_note),
        ],
      ),
    );
  }

  // ================================================================
  // ⭐ CARD PRINCIPAL DE MÉTRICA
  // ================================================================
  Widget _metricCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: scheme.surfaceVariant,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color.withOpacity(.15),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 14),

            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // ⭐ GRÁFICA SIMULADA
  // ================================================================
  Widget _chartDummy(ColorScheme color) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: color.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        painter: _ChartPainter(color.primary),
      ),
    );
  }

  // ================================================================
  // ⭐ ACTIVIDAD RECIENTE
  // ================================================================
  Widget _activityTile(String title, String time, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: Colors.blue.withOpacity(.1),
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title),
        subtitle: Text(time),
      ),
    );
  }
}

// =====================================================================
// ⭐ PINTOR DE LA GRÁFICA
// =====================================================================
class _ChartPainter extends CustomPainter {
  final Color color;

  _ChartPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(.6)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * .7);
    path.quadraticBezierTo(
        size.width * .2, size.height * .3, size.width * .4, size.height * .5);
    path.quadraticBezierTo(
        size.width * .6, size.height * .8, size.width * .8, size.height * .4);
    path.quadraticBezierTo(
        size.width * .9, size.height * .2, size.width, size.height * .3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
