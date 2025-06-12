import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/dashboard_provider.dart';
import '../../../utils/tooltip_manager.dart';
import '../../common/card_block.dart';
import '../modals/revenue_report_modal.dart';
import '../modals/order_time_report_modal.dart';
import '../modals/order_status_report_modal.dart';
import '../charts/revenue_line_chart.dart';
import '../charts/order_time_donut_chart.dart';
import '../charts/order_status_donut_chart.dart';
import '../charts/top_categorias_bubbles.dart';
import '../lists/most_ordered_by_units.dart';
import '../lists/most_ordered_by_sales.dart';
import '../lists/most_ordered_food_switcher.dart';


class MobileDashboardContent extends StatelessWidget {
  const MobileDashboardContent({super.key});

  Widget _buildRevenueChart(Map<String, dynamic>? data) {
    if (data == null || data['semana_actual'] == null || data['semana_anterior'] == null) {
      return const Center(child: Text('No hay datos para mostrar'));
    }

    final semanaActual = data['semana_actual'];
    final semanaAnterior = data['semana_anterior'];

    return RevenueLineChart(
      semanaActual: List<double>.from((semanaActual['por_dia'] as List).map((e) => (e as num).toDouble())),
      semanaAnterior: List<double>.from((semanaAnterior['por_dia'] as List).map((e) => (e as num).toDouble())),
      totalActual: (semanaActual['total'] as num).toDouble(),
      variacion: (data['variacion_porcentual'] as num?)?.toDouble(),
      rango: '${semanaActual['desde']} al ${semanaActual['hasta']}',
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    /// Revenue
                    CardBlock(
                      height: 350,
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
                                  range: '${semanaActual['desde']} al ${semanaActual['hasta']}',
                                  semanaActual: List<double>.from((semanaActual['por_dia'] as List).map((e) => (e as num).toDouble())),
                                  semanaAnterior: List<double>.from((semanaAnterior['por_dia'] as List).map((e) => (e as num).toDouble())),
                                  totalActual: (semanaActual['total'] as num).toDouble(),
                                  totalAnterior: (semanaAnterior['total'] as num).toDouble(),
                                  variacion: (data['variacion_porcentual'] as num?)?.toDouble() ?? 0.0,
                                ),
                              );
                            },
                      child: _buildRevenueChart(provider.revenueData),
                    ),

                    const SizedBox(height: 12),

                    /// Top Categorías
                    CardBlock(
                      height: 320,
                      title: 'Top Categorias',
                      child: provider.categoriasMasVendidas == null
                          ? const Center(child: CircularProgressIndicator())
                          : TopCategoriasBubbles(
                              data: provider.categoriasMasVendidas!,
                              subtitle: 'Top por % de unidades',
                            ),
                    ),

                    const SizedBox(height: 12),

                    /// Most Ordered Food
                    FlipCardWrapper(
                      height: 320,
                      width: double.infinity,
                      front: provider.mostOrderedByUnits == null
                          ? const Center(child: CircularProgressIndicator())
                          : CardBlock(
                              height: 260,
                              title: 'Most Ordered Food',
                              child: SingleChildScrollView(
                                child: MostOrderedByUnits(
                                  productos: provider.mostOrderedByUnits!,
                                ),
                              ),
                            ),
                      back: provider.mostOrderedBySales == null
                          ? const Center(child: CircularProgressIndicator())
                          : CardBlock(
                              height: 260,
                              title: 'Most Ordered Food',
                              child: SingleChildScrollView(
                                child: MostOrderedBySales(
                                  productos: provider.mostOrderedBySales!,
                                ),
                              ),
                            ),
                    ),

                    const SizedBox(height: 12),

                    /// Order Time
                    CardBlock(
                      height: 350,
                      title: 'Order Time',
                      onReportTap: provider.orderTimeData == null
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                builder: (_) => OrderTimeReportModal(
                                  data: provider.orderTimeData!,
                                  rangoFechas: provider.orderTimeData!['rango'] ?? 'Rango desconocido',
                                ),
                              );
                            },
                      child: provider.orderTimeData == null
                          ? const Center(child: CircularProgressIndicator())
                          : OrderTimeDonutChart(
                              data: provider.orderTimeData!,
                              rango: provider.orderTimeData!['rango'] ?? 'Rango desconocido',
                            ),
                    ),

                    const SizedBox(height: 12),

                    /// Order Status
                    CardBlock(
                            height: 350,
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
                  ],
                ),
              ),
            ),
    );
  }
}
