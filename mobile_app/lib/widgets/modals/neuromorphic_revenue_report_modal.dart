import 'package:flutter/material.dart';

import '../common/neumorphic_card_container.dart';
import '../common/neumorphic_button.dart'; // Aquí está también NeumorphicButtonSimple

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
    //final dias = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    //final textTheme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      //insetPadding: const EdgeInsets.symmetric(),
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
     
            child: SingleChildScrollView(
              //padding: const EdgeInsets.symmetric(vertical: 8),
              child: NeumorphicCardContainer(
                //isPressed: false,
                //isActive: true,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHeader(Theme.of(context).textTheme),
                    const Divider(height: 32, color: Colors.black12),
                    _buildTable([
                      'Lun',
                      'Mar',
                      'Mié',
                      'Jue',
                      'Vie',
                      'Sáb',
                      'Dom',
                    ]),
                    const SizedBox(height: 24),
                    _buildTotals(Theme.of(context).textTheme),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerRight,
                      child: NeumorphicButtonSimple(
                        label: 'Cerrar',
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
    );
  }

  Widget _buildHeader(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          style: textTheme.bodyMedium?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildTable(List<String> dias) {
    return Table(
      columnWidths: const {0: FlexColumnWidth()},
      border: TableBorder.symmetric(
        inside: BorderSide(color: Colors.grey.shade300),
      ),
      children: [
        _buildTableRow(dias, isHeader: true),
        _buildTableRow(
          semanaAnterior.map((v) => 'S/. ${v.toStringAsFixed(1)}').toList(),
        ),
        _buildTableRow(
          semanaActual.map((v) => 'S/. ${v.toStringAsFixed(1)}').toList(),
          isBold: true,
        ),
      ],
    );
  }

  TableRow _buildTableRow(
    List<String> cells, {
    bool isHeader = false,
    bool isBold = false,
  }) {
    return TableRow(
      decoration: isHeader
          ? BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      children: cells.map((text) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: isHeader
                    ? FontWeight.w600
                    : isBold
                    ? FontWeight.w500
                    : FontWeight.normal,
                fontSize: isHeader ? 13 : 10,
                color: Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTotals(TextTheme textTheme) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Semana anterior:',
              style: textTheme.bodyMedium?.copyWith(color: Colors.black54),
            ),
            Text(
              'S/. ${totalAnterior.toStringAsFixed(2)}',
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
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
              style: textTheme.bodyMedium?.copyWith(color: Colors.black54),
            ),
            Text(
              'S/. ${totalActual.toStringAsFixed(2)}',
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
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
              color: variacion >= 0 ? Colors.green[700] : Colors.red[700],
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
