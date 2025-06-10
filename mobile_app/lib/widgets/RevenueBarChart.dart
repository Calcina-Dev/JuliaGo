import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RevenueLineChart extends StatefulWidget {
  final void Function(Map<String, dynamic> data)? onDataReady;

  const RevenueLineChart({super.key, this.onDataReady});

  @override
  State<RevenueLineChart> createState() => _RevenueLineChartState();
}

class _RevenueLineChartState extends State<RevenueLineChart> {
  late Future<Map<String, dynamic>> revenueFuture;

  @override
  void initState() {
    super.initState();
    revenueFuture = ApiService.fetchRevenueData().then((res) {
      if (res['success'] == true && widget.onDataReady != null) {
        widget.onDataReady!(res['data']);
      }
      return res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: revenueFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!['success'] == false) {
          return Center(child: Text(snapshot.data!['message']));
        }

        final data = snapshot.data!['data'];
        final List<double> semanaActual = List<double>.from(
          data['semana_actual']['por_dia'].map((e) => e.toDouble()),
        );
        final List<double> semanaAnterior = List<double>.from(
          data['semana_anterior']['por_dia'].map((e) => e.toDouble()),
        );

        final desde = data['semana_actual']['desde'];
        final hasta = data['semana_actual']['hasta'];
        final variacion = data['variacion_porcentual'];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'S/. ${data['semana_actual']['total']}',
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
                  : '${variacion >= 0 ? '+' : ''}${variacion.toStringAsFixed(1)}% vs semana anterior',
              style: TextStyle(
                fontSize: 12,
                color: variacion == null
                    ? Colors.grey
                    : (variacion >= 0 ? Colors.green : Colors.red),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Ventas del $desde al $hasta',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 6,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    //horizontalInterval: 0.4,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                      dashArray: [4, 2],
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1, // <-- añade esto
                        getTitlesWidget: (value, _) {
                          final index = value.toInt();
                          if (index < 0 || index > 6)
                            return const SizedBox.shrink(); // evita etiquetas fuera de rango
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              _getDayLabel(index),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.grey.withAlpha(
                        (0.7 * 255).toInt(),
                      ), // 70% opacidad
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            '${spot.y}',
                            TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
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
                _Legend(color: Color(0xFF4A6CF7), text: 'Semana actual'),
                SizedBox(width: 16),
                _Legend(color: Color(0xFFE0E0E0), text: 'Semana anterior'),
              ],
            ),
          ],
        );
      },
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

  String _getDayLabel(int index) {
    const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    if (index < 0 || index >= days.length) return '';
    return days[index];
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
