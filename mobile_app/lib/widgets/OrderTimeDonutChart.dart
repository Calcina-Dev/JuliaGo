// OrderTimeDonutChart completamente rediseñado con API, rangos y tooltip moderno
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../services/api_service.dart';
import '../utils/tooltip_manager.dart';

class OrderTimeDonutChart extends StatefulWidget {
  final void Function(Map<String, dynamic>)? onDataReady;

  const OrderTimeDonutChart({super.key, this.onDataReady});

  @override
  State<OrderTimeDonutChart> createState() => _OrderTimeDonutChartState();
}

class _OrderTimeDonutChartState extends State<OrderTimeDonutChart> {
  final GlobalKey _chartKey = GlobalKey();
  Future<Map<String, dynamic>>? futureData;
  OverlayEntry? _tooltipOverlay;
  final List<_SectionData> chartData = [];
  String subtitle = '';

  final List<Map<String, dynamic>> periodos = [
    {
      'key': 'mañana',
      'label': 'Mañana',
      'color': const Color(0xFFD6D9FF),
      'rango': '06:00 – 12:00',
    },
    {
      'key': 'tarde',
      'label': 'Tarde',
      'color': const Color(0xFF6463D6),
      'rango': '12:00 – 18:00',
    },
    {
      'key': 'noche',
      'label': 'Noche',
      'color': const Color(0xFF9ABEFF),
      'rango': '18:00 – 23:00',
    },
  ];

  @override
  void initState() {
    super.initState();
    TooltipManager.register(_removeTooltip);
    initializeDateFormatting('es').then((_) {
      final now = DateTime.now();
      final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));

      final inicio = DateFormat('yyyy-MM-dd').format(startOfWeek);
      final fin = DateFormat('yyyy-MM-dd').format(endOfWeek);

      subtitle = _getWeekRangeText(startOfWeek);

      futureData =
          ApiService.get(
            '/dashboard/ventas-por-hora?inicio=$inicio&fin=$fin',
          ).then((res) {
            if (res.statusCode == 200) {
              final decoded = ApiService.decodeResponse(res);

              // 🔹 Emitimos los datos al padre si hay callback
              if (widget.onDataReady != null) {
                widget.onDataReady!({
                  ...decoded,
                  'rango':
                      subtitle, // ← 🔥 ahora sí enviamos el rango de forma segura
                });
              }

              return {'success': true, 'data': decoded};
            } else {
              return {'success': false, 'message': 'Error al cargar los datos'};
            }
          });

      setState(() {});
    });
  }

  String _getWeekRangeText(DateTime startOfWeek) {
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final formatter = DateFormat('dd MMM', 'es');
    return 'Del ${formatter.format(startOfWeek)} al ${formatter.format(endOfWeek)}';
  }

  void _showTooltip(
    BuildContext context,
    Offset position,
    _SectionData section,
  ) {
    _removeTooltip();
    final screenSize = MediaQuery.of(context).size;
    const tooltipWidth = 180.0;
    const tooltipHeight = 100.0;

    final left = (position.dx - tooltipWidth / 2).clamp(
      12.0,
      screenSize.width - tooltipWidth - 12.0,
    );
    final top = (position.dy - tooltipHeight - 8).clamp(
      12.0,
      screenSize.height - tooltipHeight - 12.0,
    );

    _tooltipOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: left,
        top: top,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: tooltipWidth,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2E2C54),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        section.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _removeTooltip,
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  section.rango,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  '${NumberFormat.decimalPattern('es').format(section.count)} pedidos',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context, rootOverlay: false).insert(_tooltipOverlay!);
  }

  void _removeTooltip() {
    _tooltipOverlay?.remove();
    _tooltipOverlay = null;
  }

  @override
  Widget build(BuildContext context) {
    if (futureData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FutureBuilder<Map<String, dynamic>>(
      future: futureData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.data!['success']) {
          return Center(child: Text(snapshot.data!['message']));
        }

        final data = snapshot.data!['data'];
        final total = periodos.fold<int>(
          0,
          (sum, item) =>
              sum + ((data[item['key']]?['ventas'] ?? 0) as num).toInt(),
        );

        chartData.clear();
        for (var item in periodos) {
          final key = item['key'];
          final ventas = data[key]?['ventas'] ?? 0;
          chartData.add(
            _SectionData(
              label: item['label'],
              color: item['color'],
              count: ventas,
              rango: item['rango'],
            ),
          );
        }

        return GestureDetector(
          onTap: _removeTooltip,
          child: Column(
            children: [
              const Text(
                'Order Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E2C54),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 160,
                child: PieChart(
                  key: _chartKey,
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 32,
                    sections: List.generate(chartData.length, (i) {
                      final section = chartData[i];
                      final percent = total > 0
                          ? (section.count / total * 100).round()
                          : 0;
                      return PieChartSectionData(
                        value: section.count == 0
                            ? 0.01
                            : section.count.toDouble(),
                        color: section.color,
                        radius: 42,
                        title: section.count == 0 ? '' : '$percent%',
                        titleStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      );
                    }),
                    pieTouchData: PieTouchData(
                      enabled: true,
                      touchCallback: (event, response) {
                        final index =
                            response?.touchedSection?.touchedSectionIndex ?? -1;
                        if (event is FlTapUpEvent && index >= 0) {
                          final box =
                              _chartKey.currentContext?.findRenderObject()
                                  as RenderBox?;
                          if (box != null) {
                            final globalPosition = box.localToGlobal(
                              event.localPosition,
                            );
                            final section = chartData[index];
                            _showTooltip(context, globalPosition, section);
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: chartData.map((e) {
                  final percent = total > 0
                      ? (e.count / total * 100).round()
                      : 0;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: e.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              e.label,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '$percent%',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _removeTooltip();
    super.dispose();
  }
}

class _SectionData {
  final String label;
  final int count;
  final Color color;
  final String rango;

  _SectionData({
    required this.label,
    required this.count,
    required this.color,
    required this.rango,
  });
}
