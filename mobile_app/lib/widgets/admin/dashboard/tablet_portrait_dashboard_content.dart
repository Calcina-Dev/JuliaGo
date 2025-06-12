import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/dashboard_provider.dart';
import '../../common/card_block.dart';
import '../charts/revenue_line_chart.dart';
import '../charts/order_time_donut_chart.dart';
import '../charts/top_categorias_bubbles.dart';
import '../charts/order_status_donut_chart.dart';
import '../lists/most_ordered_by_sales.dart';
import '../lists/most_ordered_by_units.dart';
import '../lists/most_ordered_food_switcher.dart';
import '../../../utils/tooltip_manager.dart';
import '../modals/revenue_report_modal.dart';
import '../modals/order_time_report_modal.dart';
import '../modals/order_status_report_modal.dart';

class TabletPortraitDashboardContent extends StatelessWidget {
  const TabletPortraitDashboardContent({super.key});

  Widget _buildRevenueChart(Map<String, dynamic> data) {
    return RevenueLineChart(
      semanaActual: List<double>.from(
          data['semana_actual']['por_dia'].map((e) => e.toDouble())),
      semanaAnterior: List<double>.from(
          data['semana_anterior']['por_dia'].map((e) => e.toDouble())),
      totalActual: (data['semana_actual']['total'] as num).toDouble(),
      variacion: (data['variacion_porcentual'] as num?)?.toDouble(),
      rango:
          '${data['semana_actual']['desde']} al ${data['semana_actual']['hasta']}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: provider.isLoading && !provider.hasData
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => TooltipManager.removeAll(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    /// Revenue
                    CardBlock(
                      height: 360,
                      title: 'Revenue',
                      onReportTap: provider.revenueData == null
                          ? null
                          : () {
                              final data = provider.revenueData!;
                              final semanaActual = data['semana_actual'];
                              final semanaAnterior = data['semana_anterior'];
                              showDialog(
                                context: context,
                                builder: (_) => RevenueReportModal(
                                  range:
                                      '${semanaActual['desde']} al ${semanaActual['hasta']}',
                                  semanaActual: List<double>.from(
                                      semanaActual['por_dia']
                                          .map((e) => e.toDouble())),
                                  semanaAnterior: List<double>.from(
                                      semanaAnterior['por_dia']
                                          .map((e) => e.toDouble())),
                                  totalActual: (semanaActual['total'] as num)
                                      .toDouble(),
                                  totalAnterior: (semanaAnterior['total']
                                          as num)
                                      .toDouble(),
                                  variacion: (data['variacion_porcentual']
                                          as num?)
                                      ?.toDouble() ?? 0.0,
                                ),
                              );
                            },
                      child: provider.revenueData == null
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : _buildRevenueChart(provider.revenueData!),
                    ),
                    const SizedBox(height: 10),

                    /// Top Categorías + Most Ordered
                    Row(
                      children: [
                        Expanded(
                          child: CardBlock(
                            height: 320,
                            title: 'Top Categorias',
                            child: TopCategoriasBubbles(
                              data: provider.categoriasMasVendidas!,
                              subtitle: 'Top por % de unidades',
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: FlipCardWrapper(
                            height: 320,
                            width: double.infinity,
                            front: CardBlock(
                              height: 320,
                              title: 'Most Ordered Food',
                              icon: const Icon(Icons.sync,
                                  color: Colors.black54, size: 20),
                              child: SingleChildScrollView(
                                child: MostOrderedByUnits(
                                  productos: provider.mostOrderedByUnits!,
                                ),
                              ),
                            ),
                            back: CardBlock(
                              height: 320,
                              title: 'Most Ordered Food',
                              icon: const Icon(Icons.sync,
                                  color: Colors.black54, size: 20),
                              child: SingleChildScrollView(
                                child: MostOrderedBySales(
                                  productos: provider.mostOrderedBySales!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// Order Time + Order Status
                    Row(
                      children: [
                        Expanded(
                          child: CardBlock(
                            height: 360,
                            title: 'Order Time',
                            onReportTap: provider.orderTimeData == null
                                ? null
                                : () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => OrderTimeReportModal(
                                        data: provider.orderTimeData!,
                                        rangoFechas:
                                            provider.orderTimeData!['rango'] ??
                                                'Rango desconocido',
                                      ),
                                    );
                                  },
                            child: OrderTimeDonutChart(
                              data: provider.orderTimeData!,
                              rango: provider.orderTimeData!['rango'] ??
                                  'Rango desconocido',
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CardBlock(
                            height: 360,
                            title: 'Order',
                            onReportTap: provider.orderStatusData == null
                                ? null
                                : () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => OrderStatusReportModal(
                                        data: provider
                                            .orderStatusData!['por_estado'],
                                        fecha:
                                            provider.orderStatusData!['fecha'],
                                      ),
                                    );
                                  },
                            child: OrderStatusDonutChart(
                              data:
                                  provider.orderStatusData!['por_estado'],
                              fecha: provider.orderStatusData!['fecha'],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
