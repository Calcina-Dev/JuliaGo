import 'package:flutter/material.dart';

class DonutTooltip extends StatelessWidget {
  final String label;
  final String rango;
  final int count;
  final Color backgroundColor;

  const DonutTooltip({
    super.key,
    required this.label,
    required this.rango,
    required this.count,
    this.backgroundColor = const Color(0xFF2E2C54), // ← default fijo
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          if (rango.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(rango, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
          const SizedBox(height: 6),
          Text('$count pedidos', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
