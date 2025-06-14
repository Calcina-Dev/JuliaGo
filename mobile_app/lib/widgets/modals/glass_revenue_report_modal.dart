import 'dart:ui';
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
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.20),

              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.1),),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(26, 0, 0, 0),

                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  'Reporte de Revenue',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Del $range',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Color.fromRGBO(255, 255, 255, 0.7),

                  ),
                ),
                const Divider(height: 32, color: Colors.white24),

                // Tabla
                Table(
                  columnWidths: const {0: FlexColumnWidth()},
                  border: TableBorder.symmetric(
                    inside: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.3),),
                  ),
                  children: [
                    // Cabecera
                    TableRow(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.25),

                      ),
                      children: dias.map((d) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              d,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Colors.white,
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
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
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
                                color: Colors.white,
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
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      'S/. ${totalAnterior.toStringAsFixed(2)}',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
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
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      'S/. ${totalActual.toStringAsFixed(2)}',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
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
                      color: variacion >= 0 ? Colors.green[300] : Colors.red[300],
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
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Color.fromRGBO(255, 255, 255, 0.35),

                    ),
                    child: const Text('Cerrar'),
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
