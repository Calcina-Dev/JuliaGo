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
    return Container(
      height: height,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppStyles.cardColor,
        borderRadius: AppStyles.borderRadius16,
        boxShadow: AppStyles.defaultCardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: AppStyles.cardTitleStyle),
              const Spacer(),
              if (icon != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: icon!,
                ),
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
