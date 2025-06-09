import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../services/api_service.dart';
import '../utils/tooltip_manager.dart';

class OrderStatusDonutChart extends StatefulWidget {
  const OrderStatusDonutChart({super.key});

  @override
  State<OrderStatusDonutChart> createState() => _OrderStatusDonutChartState();
}

class _OrderStatusDonutChartState extends State<OrderStatusDonutChart> {
  final GlobalKey _chartKey = GlobalKey();
  Future<Map<String, dynamic>>? futureData;
  OverlayEntry? _tooltipOverlay;
  final List<_SectionData> chartData = [];
  String subtitle = '';

  final List<Map<String, dynamic>> estadosConfig = [
    {
      'key': 'pendiente',
      'label': 'Pendiente',
      'color': const Color(0xFFFFA726),
    },
    {
      'key': 'en_proceso',
      'label': 'En Proceso',
      'color': const Color(0xFF29B6F6),
    },
    {'key': 'servido', 'label': 'Servido', 'color': const Color(0xFF66BB6A)},
    {'key': 'pagado', 'label': 'Pagado', 'color': const Color(0xFFAB47BC)},
    {'key': 'cerrado', 'label': 'Cerrado', 'color': const Color(0xFF78909C)},
    {
      'key': 'cancelado',
      'label': 'Cancelado',
      'color': const Color(0xFFE53935),
    },
  ];

  @override
  void initState() {
    super.initState();
    TooltipManager.register(_removeTooltip);
    initializeDateFormatting('es').then((_) {
      final now = DateTime.now();
      subtitle = 'Hoy, ${DateFormat('dd MMM yyyy', 'es').format(now)}';
      final hoy = DateFormat('yyyy-MM-dd').format(now);

      futureData =
          ApiService.get(
            '/dashboard/estadisticas-pedidos?inicio=$hoy&fin=$hoy',
          ).then((res) {
            if (res.statusCode == 200) {
              final decoded =
                  ApiService.decodeResponse(res) as Map<String, dynamic>;
              // Si el API te devuelve la fecha, úsala:
              if (decoded.containsKey('fecha')) {
                final fecha = DateTime.parse(decoded['fecha'] as String);
                subtitle =
                    'Hoy, ${DateFormat('dd MMM yyyy', 'es').format(fecha)}';
              }
              return {
                'success': true,
                'data': decoded['por_estado'] as Map<String, dynamic>,
              };
            } else {
              return {'success': false, 'message': 'Error al cargar los datos'};
            }
          });

      setState(() {});
    });
  }

  void _showTooltip(
    BuildContext context,
    Offset position,
    _SectionData section,
  ) {
    _removeTooltip();
    final screenSize = MediaQuery.of(context).size;
    const tooltipW = 180.0, tooltipH = 80.0;
    final left = (position.dx - tooltipW / 2).clamp(
      12.0,
      screenSize.width - tooltipW - 12.0,
    );
    final top = (position.dy - tooltipH - 8).clamp(
      12.0,
      screenSize.height - tooltipH - 12.0,
    );

    _tooltipOverlay = OverlayEntry(
      builder: (_) => Positioned(
        left: left,
        top: top,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: tooltipW,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: section.color.withAlpha(200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${section.label}: ${section.count} pedidos',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_tooltipOverlay!);
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
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snap.data!['success']) {
          return Center(child: Text(snap.data!['message']));
        }

        final porEstado = snap.data!['data'] as Map<String, dynamic>;

        // Reconstruir dinámicamente solo los estados con count > 0
        chartData.clear();
        porEstado.forEach((key, value) {
          final count = (value ?? 0) as int;
          if (count > 0) {
            // Buscar label y color desde la configuración
            final cfg = estadosConfig.firstWhere(
              (c) => c['key'] == key,
              orElse: () => {'label': key, 'color': Colors.grey},
            );
            chartData.add(
              _SectionData(
                label: cfg['label'] as String,
                color: cfg['color'] as Color,
                count: count,
              ),
            );
          }
        });

        final total = chartData.fold<int>(0, (sum, s) => sum + s.count);

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
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              SizedBox(
                key: _chartKey,
                height: 130,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 25,
                    sectionsSpace: 2,
                    pieTouchData: PieTouchData(
                      enabled: true,
                      touchCallback: (e, resp) {
                        final idx =
                            resp?.touchedSection?.touchedSectionIndex ?? -1;
                        if (e is FlTapUpEvent && idx >= 0) {
                          final box =
                              _chartKey.currentContext!.findRenderObject()
                                  as RenderBox;
                          final pos = box.localToGlobal(e.localPosition);
                          _showTooltip(context, pos, chartData[idx]);
                        }
                      },
                    ),
                    sections: List.generate(chartData.length, (i) {
                      final s = chartData[i];
                      final pct = total > 0
                          ? (s.count / total * 100).round()
                          : 0;
                      return PieChartSectionData(
                        value: s.count.toDouble().clamp(0.01, double.infinity),
                        color: s.color,
                        radius: 35,
                        title: pct > 0 ? '$pct%' : '',
                        titleStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                children: chartData.map((s) {
                  final pct = total > 0 ? (s.count / total * 100).round() : 0;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 12, height: 12, color: s.color),
                      const SizedBox(width: 4),
                      Text('${s.label} ($pct%)'),
                    ],
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
  _SectionData({required this.label, required this.count, required this.color});
}
