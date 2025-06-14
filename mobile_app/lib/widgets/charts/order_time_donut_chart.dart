import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utils/tooltip_manager.dart';
import '../common/donut_tooltip.dart';

class OrderTimeDonutChart extends StatefulWidget {
  final Map<String, dynamic> data;
  final String rango;

  const OrderTimeDonutChart({
    super.key,
    required this.data,
    required this.rango,
  });

  @override
  State<OrderTimeDonutChart> createState() => _OrderTimeDonutChartState();
}

class _OrderTimeDonutChartState extends State<OrderTimeDonutChart> {
  final GlobalKey _chartKey = GlobalKey();
  OverlayEntry? _tooltipOverlay;

  final List<Map<String, dynamic>> periodos = [
    {'key': 'mañana', 'label': 'Mañana', 'color': Color(0xFFD6D9FF), 'rango': '06:00 – 12:00'},
    {'key': 'tarde', 'label': 'Tarde', 'color': Color(0xFF6463D6), 'rango': '12:00 – 18:00'},
    {'key': 'noche', 'label': 'Noche', 'color': Color(0xFF9ABEFF), 'rango': '18:00 – 23:00'},
  ];

  void _showTooltip(BuildContext context, Offset position, _SectionData section) {
    _removeTooltip();
    final screenSize = MediaQuery.of(context).size;
    const tooltipWidth = 180.0;
    const tooltipHeight = 80.0;

    final left = (position.dx - tooltipWidth / 2).clamp(12.0, screenSize.width - tooltipWidth - 12.0);
    final top = (position.dy - tooltipHeight - 8).clamp(12.0, screenSize.height - tooltipHeight - 12.0);

    _tooltipOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: left,
        top: top,
        child: Material(
          color: Colors.transparent,
          child: DonutTooltip(
            label: section.label,
            rango: section.rango,
            count: section.count,
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
  void dispose() {
    _removeTooltip();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TooltipManager.register(_removeTooltip);

    final chartData = periodos.map((item) {
      final count = (widget.data[item['key']]?['ventas'] ?? 0) as int;
      return _SectionData(
        label: item['label'],
        count: count,
        color: item['color'],
        rango: item['rango'],
      );
    }).toList();

    final total = chartData.fold(0, (sum, e) => sum + e.count);

    return GestureDetector(
      onTap: _removeTooltip,
      child: Column(
        children: [
          const Text(
            'Order Time',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2E2C54)),
          ),
          const SizedBox(height: 4),
          Text(widget.rango, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: PieChart(
              key: _chartKey,
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 32,
                sections: chartData.map((section) {
                  final percent = total > 0 ? (section.count / total * 100).round() : 0;
                  return PieChartSectionData(
                    value: section.count == 0 ? 0.01 : section.count.toDouble(),
                    color: section.color,
                    radius: 42,
                    title: section.count == 0 ? '' : '$percent%',
                    titleStyle: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    borderSide: const BorderSide(color: Colors.white, width: 2),
                  );
                }).toList(),
                pieTouchData: PieTouchData(
                  enabled: true,
                  touchCallback: (event, response) {
                    final index = response?.touchedSection?.touchedSectionIndex ?? -1;
                    if (event is FlTapUpEvent && index >= 0) {
                      final box = _chartKey.currentContext?.findRenderObject() as RenderBox?;
                      if (box != null) {
                        final globalPosition = box.localToGlobal(event.localPosition);
                        _showTooltip(context, globalPosition, chartData[index]);
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
                          decoration: BoxDecoration(color: e.color, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 4),
                        Text(e.label, style: const TextStyle(fontSize: 12, color: Colors.black)),
                      ],
                    ),
                    Text('$percent%', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
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
