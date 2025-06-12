import 'package:flutter/material.dart';
import '../../../utils/icon_mapper.dart'; // función que asigna íconos según categoría

class MostOrderedByUnits extends StatelessWidget {
  final List<dynamic> productos;

  const MostOrderedByUnits({
    super.key,
    required this.productos,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(productos.length, (index) {
        final item = productos[index];
        final isLast = index == productos.length - 1;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 4,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE5E5E5),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      getIconForCategory(item['categoria']),
                      size: 24,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item['producto'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                  ),
                  Text(
                    '${item['total_unidades']} uds.',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                ],
              ),
            ),
            if (!isLast)
              const Divider(
                height: 1,
                thickness: 0.5,
                color: Colors.grey,
                indent: 64,
                endIndent: 0,
              ),
          ],
        );
      }),
    );
  }
}
