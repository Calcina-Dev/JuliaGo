import 'package:flutter/material.dart';

class RevenueReportModal extends StatelessWidget {
  final String range;
  final List<double> semanaActual;
  final List<double> semanaAnterior;
  final double totalActual;
  final double totalAnterior;
  final double variacion;

  const RevenueReportModal({
    super.key,
    required this.range,
    required this.semanaActual,
    required this.semanaAnterior,
    required this.totalActual,
    required this.totalAnterior,
    required this.variacion,
  });

  @override
  Widget build(BuildContext context) {
    final dias = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              'Reporte de Revenue',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Del $range',
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const Divider(height: 32),

            // Tabla
            Table(
              columnWidths: const {0: FlexColumnWidth()},
              border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey.shade300),
              ),
              children: [
                // Cabecera
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey.shade100),
                  children: dias.map((d) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          d,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                // Semana anterior
                TableRow(
                  children: semanaAnterior.map((v) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          'S/. ${v.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                // Semana actual
                TableRow(
                  children: semanaActual.map((v) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          'S/. ${v.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Totales y variación
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Semana anterior:',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'S/. ${totalAnterior.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Semana actual:',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'S/. ${totalActual.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Variación: ${variacion.toStringAsFixed(2)}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: variacion >= 0 ? Colors.green[700] : Colors.red[600],
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Botón cerrar
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFFF1F1F1),
                ),
                child: const Text('Cerrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
