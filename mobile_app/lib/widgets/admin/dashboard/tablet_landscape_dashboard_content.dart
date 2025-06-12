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

class TabletLandscapeDashboardContent extends StatefulWidget {
  const TabletLandscapeDashboardContent({super.key});

  @override
  State<TabletLandscapeDashboardContent> createState() =>
      _TabletLandscapeDashboardContentState();
}

class _TabletLandscapeDashboardContentState
    extends State<TabletLandscapeDashboardContent> {
  bool _initCalled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initCalled) {
      Provider.of<DashboardProvider>(context, listen: false)
          .fetchDashboardData();
      _initCalled = true;
    }
  }

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
                            onReportTap: provider.revenueData == null
                                ? null
                                : () {
                                    final semanaActual =
                                        provider.revenueData!['semana_actual'];
                                    final semanaAnterior =
                                        provider.revenueData![
                                            'semana_anterior'];
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
                                        totalActual: (semanaActual['total']
                                                as num)
                                            .toDouble(),
                                        totalAnterior: (semanaAnterior['total']
                                                as num)
                                            .toDouble(),
                                        variacion: (provider.revenueData![
                                                    'variacion_porcentual']
                                                as num?)
                                            ?.toDouble() ??
                                            0.0,
                                      ),
                                    );
                                  },
                            child: provider.revenueData == null
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : _buildRevenueChart(provider.revenueData!),
                          ),
                          const SizedBox(height: 10),
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
                            child: provider.orderTimeData == null
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : OrderTimeDonutChart(
                                    data: provider.orderTimeData!,
                                    rango:
                                        provider.orderTimeData!['rango'] ??
                                            'Rango desconocido',
                                  ),
                          ),
                          const SizedBox(height: 10),
                          CardBlock(
                            height: 320,
                            title: 'Order',
                            onReportTap: provider.orderStatusData == null
                                ? null
                                : () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => OrderStatusReportModal(
                                        data: provider.orderStatusData![
                                            'por_estado'],
                                        fecha: provider
                                            .orderStatusData!['fecha'],
                                      ),
                                    );
                                  },
                            child: provider.orderStatusData == null
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : OrderStatusDonutChart(
                                    data: provider.orderStatusData![
                                        'por_estado'],
                                    fecha:
                                        provider.orderStatusData!['fecha'],
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
