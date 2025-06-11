import 'package:flutter/material.dart';
import '../../widgets/common/card_block.dart';
import '../RevenueBarChart.dart';
import '../OrderTimeDonutChart.dart';
import '../YourRatingBubbles.dart';
import '../OrderStatusDonutChart.dart';
import '../MostOrderedBySales.dart';
import '../MostOrderedByUnits.dart';
import '../MostOrderedFoodSwitcher.dart';
import '../../utils/tooltip_manager.dart';
import '../modal/RevenueReportModal.dart';
import '../modal/OrderTimeReportModal.dart';
import '../modal/OrderStatusReportModal.dart';

class TabletLandscapeDashboardContent extends StatefulWidget {
  const TabletLandscapeDashboardContent({super.key});

  @override
  State<TabletLandscapeDashboardContent> createState() =>
      _TabletLandscapeDashboardContentState();
}

class _TabletLandscapeDashboardContentState
    extends State<TabletLandscapeDashboardContent> with TickerProviderStateMixin {
  Map<String, dynamic>? _revenueData;
  Map<String, dynamic>? _orderTimeData;
  Map<String, dynamic>? _orderStatusData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => TooltipManager.removeAll(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT COLUMN
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    CardBlock(
                      height: 360,
                      title: 'Revenue',
                      onReportTap: _revenueData == null
                          ? null
                          : () {
                              final semanaActual = _revenueData!['semana_actual'];
                              final semanaAnterior = _revenueData!['semana_anterior'];
                              showDialog(
                                context: context,
                                builder: (_) => RevenueReportModal(
                                  range:
                                      '${semanaActual['desde']} al ${semanaActual['hasta']}',
                                  semanaActual: List<double>.from(
                                    semanaActual['por_dia'].map((e) => e.toDouble()),
                                  ),
                                  semanaAnterior: List<double>.from(
                                    semanaAnterior['por_dia'].map((e) => e.toDouble()),
                                  ),
                                  totalActual:
                                      (semanaActual['total'] as num).toDouble(),
                                  totalAnterior:
                                      (semanaAnterior['total'] as num).toDouble(),
                                  variacion:
                                      (_revenueData!['variacion_porcentual'] as num?)
                                              ?.toDouble() ??
                                          0.0,
                                ),
                              );
                            },
                      child: RevenueLineChart(
                        onDataReady: (data) {
                          setState(() {
                            _revenueData = data;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: const CardBlock(
                            height: 320,
                            title: 'Top Categorias',
                            child: TopCategoriasBubbles(),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: FlipCardWrapper(
                            height: 320,
                            width: double.infinity,
                            front: const CardBlock(
                              height: 320,
                              title: 'Most Ordered Food',
                              icon: Icon(Icons.sync, color: Colors.black54, size: 20),
                              child: SingleChildScrollView(
                                child: MostOrderedByUnits(),
                              ),
                            ),
                            back: const CardBlock(
                              height: 320,
                              title: 'Most Ordered Food',
                              icon: Icon(Icons.sync, color: Colors.black54, size: 20),
                              child: SingleChildScrollView(
                                child: MostOrderedBySales(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              // RIGHT COLUMN
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    CardBlock(
                      height: 360,
                      title: 'Order Time',
                      onReportTap: _orderTimeData == null
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                builder: (_) => OrderTimeReportModal(
                                  data: _orderTimeData!,
                                  rangoFechas:
                                      _orderTimeData!['rango'] ?? 'Rango desconocido',
                                ),
                              );
                            },
                      child: OrderTimeDonutChart(
                        onDataReady: (data) {
                          setState(() {
                            _orderTimeData = data;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    CardBlock(
                      height: 320,
                      title: 'Order',
                      onReportTap: _orderStatusData == null
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                builder: (_) => OrderStatusReportModal(
                                  data: _orderStatusData!['por_estado'],
                                  fecha: _orderStatusData!['fecha'],
                                ),
                              );
                            },
                      child: OrderStatusDonutChart(
                        onDataReady: (data, fecha) {
                          setState(() {
                            _orderStatusData = {
                              'por_estado': data,
                              'fecha': fecha,
                            };
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
