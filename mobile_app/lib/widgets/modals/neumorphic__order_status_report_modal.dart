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
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFf0f0f2,
                    ), // fondo base del neumorfismo
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-2, -2),
                        blurRadius: 4,
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color, // color del estado
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF444444),
                    ),
                  ),
                ),
                Text(
                  '$count pedidos',
                  style: const TextStyle(color: Color(0xFF444444)),
                ),
              ],
            ),
          ),
        );
      }
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Center(
        // 🟢 Centra el modal
        child: ConstrainedBox(
          // 🟢 Limita el ancho
          constraints: const BoxConstraints(maxWidth: 460),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFf0f0f2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-4, -4),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(4, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reporte de Estados de Pedidos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF444444),
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        offset: Offset(-1, -1),
                        blurRadius: 1,
                      ),
                      Shadow(
                        color: Colors.black12,
                        offset: Offset(1, 1),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),
                Text(
                  fecha,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF777777),
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(),
                ...rows,
                const Divider(),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFf0f0f2),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 6,
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(4, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF444444),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Cerrar',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
