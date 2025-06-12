import 'package:flutter/material.dart';

class TopCategoriasBubbles extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final String subtitle;

  const TopCategoriasBubbles({
    super.key,
    required this.data,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colores = [
      const Color(0xFFF99C30),
      const Color(0xFF6463D6),
      const Color(0xFF2FBFDE),
    ];
    final sizes = [140.0, 110.0, 90.0];
    final alignments = [
      const Alignment(0.9, 0.4),
      const Alignment(-0.3, -0.8),
      const Alignment(-0.8, 1),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 210,
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(data.length.clamp(0, 3), (i) {
              final item = data[i];
              final categoria = item['categoria'] ?? 'Sin nombre';
              final porcentaje = ((item['porcentaje'] ?? 0) as num).toInt();

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
