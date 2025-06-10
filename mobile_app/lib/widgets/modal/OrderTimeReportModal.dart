import 'package:flutter/material.dart';

class OrderTimeReportModal extends StatelessWidget {
  final Map<String, dynamic> data;
  final String rangoFechas; // <-- nuevo

  const OrderTimeReportModal({
    super.key,
    required this.data,
    required this.rangoFechas,
  });

  @override
  Widget build(BuildContext context) {
    final montoTotal = ['mañana', 'tarde', 'noche']
        .map((p) => (data[p]['monto'] ?? 0) as num)
        .fold<num>(0, (prev, monto) => prev + monto);

    final labels = {
      'mañana': 'Mañana (6am–12pm)',
      'tarde': 'Tarde (12pm–6pm)',
      'noche': 'Noche (6pm–11pm)',
    };

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reporte por Franja Horaria',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Del $rangoFechas',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              const Divider(),
              ...['mañana', 'tarde', 'noche'].map((periodo) {
                final ventas = data[periodo]['ventas'];
                final monto = data[periodo]['monto'];
                final porcentaje = montoTotal == 0
                    ? '0.0'
                    : (monto / montoTotal * 100).toStringAsFixed(1);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        labels[periodo]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text('$ventas pedidos'),
                          const SizedBox(width: 16),
                          Text('S/. ${monto.toStringAsFixed(2)}'),
                          const SizedBox(width: 16),
                          Text(
                            '$porcentaje%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: double.parse(porcentaje) >= 50
                                  ? Colors.green[700]
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
              const Divider(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F1F1),
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Cerrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
