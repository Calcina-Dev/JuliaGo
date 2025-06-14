import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';

class NeumorphicHeader extends StatelessWidget {
  final String title;

  const NeumorphicHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final baseColor = AppStyles.backgroundColor;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(color: Colors.white, offset: Offset(-4, -4), blurRadius: 6),
            BoxShadow(color: Colors.black12, offset: Offset(4, 4), blurRadius: 6),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: baseColor,
                boxShadow: const [
                  BoxShadow(color: Colors.white, offset: Offset(-2, -2), blurRadius: 4),
                  BoxShadow(color: Colors.black12, offset: Offset(2, 2), blurRadius: 4),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppStyles.textDark),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppStyles.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
