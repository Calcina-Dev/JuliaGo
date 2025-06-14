import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';

class CardBlock extends StatelessWidget {
  final String title;
  final double height;
  final Widget child;
  final Widget? icon;
  final VoidCallback? onReportTap;

  const CardBlock({
    super.key,
    required this.title,
    required this.height,
    required this.child,
    this.icon,
    this.onReportTap,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = AppStyles.backgroundColor;
    //final baseColor = Colors.white;
    return Container(
      height: height,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            offset: Offset(-6, -6),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(6, 6),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: AppStyles.cardTitleStyle,
              ),
              const Spacer(),
              if (icon != null)
                Container(
                  decoration: BoxDecoration(
                    color: baseColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-3, -3),
                        blurRadius: 5,
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3, 3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: icon!,
                ),
              if (onReportTap != null)
                TextButton(
                  onPressed: onReportTap,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: const Size(0, 36),
                    foregroundColor: const Color(0xFF4A6CF7),
                  ),
                  child: const Text(
                    'Ver reporte',
                    style: TextStyle(fontWeight: FontWeight.w500),
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
