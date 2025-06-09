import 'package:flutter/material.dart';
import 'RevenueBarChart.dart';
import 'OrderTimeDonutChart.dart';
import 'YourRatingBubbles.dart';
import 'OrderStatusDonutChart.dart';
import 'MostOrderedBySales.dart';
import 'MostOrderedByUnits.dart';
import 'MostOrderedFoodSwitcher.dart';
import '../utils/tooltip_manager.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 1000;

        // Primer bloque en columna
        final leftColumn = Column(
          children: [
            // Revenue
            _cardBlock(
              height: 360,
              title: 'Revenue',
              onReportTap: () => _showSnack('Revenue Report tapped'),
              child: const RevenueLineChart(),
            ),
            const SizedBox(height: 10),
            // Row dentro de la columna: Top Categorias / Most Ordered Food
            Row(
              children: [
                Expanded(
                  child: _cardBlock(
                    height: 320,
                    title: 'Top Categorias',
                    child: const TopCategoriasBubbles(),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: SingleChildScrollView(
                    child: FlipCardWrapper(
                      height: 320,
                      width: double.infinity,
                      front: _cardBlock(
                        height: 320,
                        title: 'Most Ordered Food',
                        child: SingleChildScrollView(
                          child: const MostOrderedByUnits(),
                        ),
                      ),

                      back: _cardBlock(
                        height: 320,
                        title: 'Most Ordered Food',
                        child: SingleChildScrollView(
                          child: const MostOrderedBySales(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );

        // Segundo bloque en columna
        final rightColumn = Column(
          children: [
            // Order Time
            _cardBlock(
              height: 360,
              title: 'Order Time',
              onReportTap: () => _showSnack('Order Time Report tapped'),
              child: const OrderTimeDonutChart(),
            ),
            const SizedBox(height: 10),
            // Order Status
            _cardBlock(
              height: 320,
              title: 'Order',
              onReportTap: () => _showSnack('Order Report tapped'),
              child: const OrderStatusDonutChart(),
            ),
          ],
        );

        // Si hay espacio suficiente, muéstralas en un Row, si no en Column
        return Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => TooltipManager.removeAll(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Expanded(flex: 6, child: leftColumn),
                        const SizedBox(width: 15),
                        Expanded(flex: 4, child: rightColumn),
                      ],
                    )
                  : Column(
                      children: [
                        leftColumn,
                        const SizedBox(height: 15),
                        // Ahora ponemos Order Time y Order en una Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _cardBlock(
                                height: 360,
                                title: 'Order Time',
                                onReportTap: () =>
                                    _showSnack('Order Time Report tapped'),
                                child: const OrderTimeDonutChart(),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _cardBlock(
                                height: 360,
                                title: 'Order',
                                onReportTap: () =>
                                    _showSnack('Order Report tapped'),
                                child: const OrderStatusDonutChart(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget _cardBlock({
    required String title,
    required double height,
    required Widget child,
    VoidCallback? onReportTap,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1C1C1E),
                ),
              ),
              if (title == 'Most Ordered Food') ...[
                const Spacer(),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.sync,
                    color: Colors.black54,
                    size: 20,
                  ),
                ),
              ],
              const Spacer(), // Esto empuja todo lo anterior a la izquierda y coloca el botón (u otro widget) a la derecha
              if (onReportTap != null)
                TextButton(
                  onPressed: onReportTap,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(80, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'View Report',
                    style: TextStyle(
                      color: Color(0xFF4A6CF7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 14),
          Expanded(child: child),
        ],
      ),
    );
  }
}
