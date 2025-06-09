// Widget Flutter: TopCategoriasBubbles con datos dinámicos desde API
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import 'package:intl/date_symbol_data_local.dart';

class TopCategoriasBubbles extends StatefulWidget {
  const TopCategoriasBubbles({super.key});

  @override
  State<TopCategoriasBubbles> createState() => _TopCategoriasBubblesState();
}

class _TopCategoriasBubblesState extends State<TopCategoriasBubbles> {
  late Future<List<dynamic>> futureData;
  String subtitle = '';

  @override
  void initState() {
    super.initState();
    // Asegúrate de haber importado 'package:intl/date_symbol_data_local.dart';
    initializeDateFormatting('es', null).then((_) {
      setState(() {
        // ahora ya puedes usar DateFormat('dd MMM','es') sin error
      });
    });
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    subtitle = _getWeekRangeText(startOfWeek);

    final inicio = DateFormat('yyyy-MM-dd').format(startOfWeek);
    final fin = DateFormat('yyyy-MM-dd').format(endOfWeek);

    futureData =
        ApiService.get(
          '/dashboard/categorias-mas-vendidas?inicio=$inicio&fin=$fin',
        ).then(
          (res) =>
              List<Map<String, dynamic>>.from(ApiService.decodeResponse(res)),
        );
  }

  String _getWeekRangeText(DateTime startOfWeek) {
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final formatter = DateFormat('dd MMM', 'es');
    final yearFormatter = DateFormat('yyyy', 'es');

    final startText = formatter.format(startOfWeek);
    final endText = formatter.format(endOfWeek);

    return 'Del $startText al $endText, ${yearFormatter.format(endOfWeek)}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        FutureBuilder<List<dynamic>>(
          future: futureData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!;

            return SizedBox(
              height: 210,
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(data.length.clamp(0, 3), (i) {
                  final item = data[i];
                  final categoria = item['categoria'] ?? 'Sin nombre';
                  final porcentaje = ((item['porcentaje'] ?? 0) as num).toInt();

                  final colores = [
                    const Color(0xFFF99C30),
                    const Color(0xFF6463D6),
                    const Color(0xFF2FBFDE),
                  ];
                  final sizes = [140.0, 110.0, 90.0];

                  final alignments = [
                    const Alignment(0.9, 0.4),
                    const Alignment(-0.3, -0.8),
                    const Alignment(-0.8, 1), // izquierda abajo
                    // arriba izquierda
                    // derecha abajo
                  ];

                  return Align(
                    alignment: alignments[i],
                    child: _Bubble(
                      size: sizes[i],
                      color: colores[i],
                      percentage: porcentaje,
                      label: categoria,
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  final double size;
  final Color color;
  final int percentage;
  final String label;

  const _Bubble({
    required this.size,
    required this.color,
    required this.percentage,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Container(
          width: size + 8,
          height: size + 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: size * 0.24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: size * 0.10, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
