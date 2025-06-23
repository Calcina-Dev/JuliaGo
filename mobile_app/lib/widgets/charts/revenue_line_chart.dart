import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../common/legend_item.dart';

class RevenueLineChart extends StatelessWidget {
  final List<double> semanaActual;
  final List<double> semanaAnterior;
  final double totalActual;
  final double? variacion;
  final String rango;

  const RevenueLineChart({
    super.key,
    required this.semanaActual,
    required this.semanaAnterior,
    required this.totalActual,
    required this.variacion,
    required this.rango,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'S/. ${totalActual.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF007D81),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          variacion == null
              ? 'Sin datos de comparación'
              : '${variacion! >= 0 ? '+' : ''}${variacion!.toStringAsFixed(1)}% vs semana anterior',
          style: TextStyle(
            fontSize: 12,
            color: variacion == null
                ? Colors.grey
                : (variacion! >= 0 ? Colors.green : Colors.red),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Ventas del $rango',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 6,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.black.withAlpha((0.2 * 255).round()),
                  strokeWidth: 1,
                  dashArray: [4, 2],
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), 
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, _) {
                      const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
                      final index = value.toInt();
                      if (index < 0 || index >= days.length) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(days[index],
                            style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.grey.withAlpha((0.7 * 255).toInt()),
                  getTooltipItems: (touchedSpots) => touchedSpots.map((spot) {
                    return LineTooltipItem(
                      '${spot.y}',
                      const TextStyle(color: Colors.white),
                    );
                  }).toList(),
                ),
              ),
              lineBarsData: [
                _buildLine(semanaAnterior, const Color(0xFFE0E0E0)),
                _buildLine(semanaActual, const Color(0xFF4A6CF7)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            LegendItem(color: Color(0xFF4A6CF7), text: 'Semana actual'),
            SizedBox(width: 16),
            LegendItem(color: Color(0xFFE0E0E0), text: 'Semana anterior'),
          ],
        ),
      ],
    );
  }

  LineChartBarData _buildLine(List<double> data, Color color) {
    return LineChartBarData(
      isCurved: true,
      color: color,
      dotData: FlDotData(show: false),
      barWidth: 2.5,
      spots: List.generate(data.length, (i) => FlSpot(i.toDouble(), data[i])),
    );
  }
}
