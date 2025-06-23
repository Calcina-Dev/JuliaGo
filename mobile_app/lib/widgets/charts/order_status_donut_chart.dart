import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utils/tooltip_manager.dart';
import '../common/donut_tooltip.dart';

class OrderStatusDonutChart extends StatefulWidget {
  final Map<String, dynamic> data;
  final String fecha;

  const OrderStatusDonutChart({
    super.key,
    required this.data,
    required this.fecha,
  });

  @override
  State<OrderStatusDonutChart> createState() => _OrderStatusDonutChartState();
}

class _OrderStatusDonutChartState extends State<OrderStatusDonutChart> {
  final GlobalKey _chartKey = GlobalKey();
  OverlayEntry? _tooltipOverlay;

  final List<Map<String, dynamic>> estadosConfig = [
    {'key': 'pendiente', 'label': 'Pendiente', 'color': Color(0xFFFFA726)},
    {'key': 'en_proceso', 'label': 'En Proceso', 'color': Color(0xFF29B6F6)},
    {'key': 'servido', 'label': 'Servido', 'color': Color(0xFF66BB6A)},
    {'key': 'pagado', 'label': 'Pagado', 'color': Color(0xFFAB47BC)},
    {'key': 'cerrado', 'label': 'Cerrado', 'color': Color(0xFF78909C)},
    {'key': 'cancelado', 'label': 'Cancelado', 'color': Color(0xFFE53935)},
  ];

  @override
  void initState() {
    super.initState();
    TooltipManager.register(_removeTooltip);
  }

  void _showTooltip(
    BuildContext context,
    Offset position,
    _SectionData section,
  ) {
    _removeTooltip();
    final screenSize = MediaQuery.of(context).size;
    const width = 180.0, height = 80.0;
    final left = (position.dx - width / 2).clamp(
      12.0,
      screenSize.width - width - 12.0,
    );
    final top = (position.dy - height - 8).clamp(
      12.0,
      screenSize.height - height - 12.0,
    );

    _tooltipOverlay = OverlayEntry(
      builder: (_) => Positioned(
        left: left,
        top: top,
        child: Material(
          color: Colors.transparent,
          child: DonutTooltip(
            label: section.label,
            count: section.count,
            backgroundColor: section.color,
            rango: '', // sin rango
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
    final chartData = <_SectionData>[];
    final porEstado = widget.data;

    for (final e in estadosConfig) {
      final count = (porEstado[e['key']] ?? 0) as int;
      if (count > 0) {
        chartData.add(
          _SectionData(label: e['label'], color: e['color'], count: count),
        );
      }
    }

    final total = chartData.fold<int>(0, (sum, e) => sum + e.count);

    if (chartData.isEmpty) {
      return Column(
        children: [
          const Text(
            'Estado de Pedidos',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            widget.fecha,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: Center(
              child: Text(
                'No hay datos para mostrar.',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: _removeTooltip,
      child: Column(
        children: [
          const Text(
            'Estado de Pedidos',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            widget.fecha,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          SizedBox(
            key: _chartKey,
            height: 160,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 32,
                sections: chartData.map((s) {
                  final pct = total > 0 ? (s.count / total * 100).round() : 0;
                  return PieChartSectionData(
                    value: s.count.toDouble().clamp(0.01, double.infinity),
                    color: s.color,
                    radius: 42,
                    title: pct > 0 ? '$pct%' : '',
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  );
                }).toList(),
                pieTouchData: PieTouchData(
                  enabled: true,
                  touchCallback: (event, response) {
                    final idx =
                        response?.touchedSection?.touchedSectionIndex ?? -1;
                    if (event is FlTapUpEvent &&
                        idx >= 0 &&
                        idx < chartData.length) {
                      final box =
                          _chartKey.currentContext?.findRenderObject()
                              as RenderBox?;
                      if (box != null) {
                        final pos = box.localToGlobal(event.localPosition);
                        _showTooltip(context, pos, chartData[idx]);
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
              final percent = total > 0 ? (e.count / total * 100).round() : 0;
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
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
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

  _SectionData({required this.label, required this.count, required this.color});
}
