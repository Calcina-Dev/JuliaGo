import 'package:flutter/material.dart';
import '../../../constants/app_styles.dart';

class TextBlockInfo extends StatelessWidget {
  final String label;
  final String value;
  final int maxLines;

  const TextBlockInfo({
    super.key,
    required this.label,
    required this.value,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = AppStyles.backgroundColor;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.white, offset: Offset(-4, -4), blurRadius: 6),
          BoxShadow(color: Colors.black12, offset: Offset(4, 4), blurRadius: 6),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppStyles.hintColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppStyles.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
