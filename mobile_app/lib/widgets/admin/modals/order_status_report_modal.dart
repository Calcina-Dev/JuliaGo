import 'package:flutter/material.dart';

class OrderStatusReportModal extends StatelessWidget {
  final Map<String, dynamic> data;
  final String fecha;

  const OrderStatusReportModal({
    super.key,
    required this.data,
    required this.fecha,
  });

  @override
  Widget build(BuildContext context) {
    final estadosConfig = [
      {'key': 'pendiente', 'label': 'Pendiente', 'color': Color(0xFFFFA726)},
      {'key': 'en_proceso', 'label': 'En Proceso', 'color': Color(0xFF29B6F6)},
      {'key': 'servido', 'label': 'Servido', 'color': Color(0xFF66BB6A)},
      {'key': 'pagado', 'label': 'Pagado', 'color': Color(0xFFAB47BC)},
      {'key': 'cerrado', 'label': 'Cerrado', 'color': Color(0xFF78909C)},
      {'key': 'cancelado', 'label': 'Cancelado', 'color': Color(0xFFE53935)},
    ];

    final List<Widget> rows = [];

    for (var estado in estadosConfig) {
      final key = estado['key'] as String;
      final label = estado['label'] as String;
      final color = estado['color'] as Color;
      final count = data[key] ?? 0;

      if (count > 0) {
        rows.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  '$count pedidos',
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),
        );
      }
    }

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
              const Text(
                'Reporte de Estados de Pedidos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                fecha,
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              const Divider(),
              ...rows,
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
