import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';

class CardBlock extends StatefulWidget {
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
  State<CardBlock> createState() => _CardBlockState();
}

class _CardBlockState extends State<CardBlock> {
  bool _isReportPressed = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = AppStyles.backgroundColor;

    return Container(
      height: widget.height,
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
                widget.title,
                style: AppStyles.cardTitleStyle,
              ),
              const Spacer(),
              if (widget.icon != null)
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
                  child: widget.icon!,
                ),
              if (widget.onReportTap != null)
                GestureDetector(
                  onTapDown: (_) {
                    setState(() => _isReportPressed = true);
                  },
                  onTapUp: (_) {
                    setState(() => _isReportPressed = false);
                    widget.onReportTap?.call();
                  },
                  onTapCancel: () {
                    setState(() => _isReportPressed = false);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: _isReportPressed
                          ? const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(-2, -2),
                                blurRadius: 4,
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ]
                          : const [
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(-2, -2),
                                blurRadius: 4,
                              ),
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                    ),
                    child: const Text(
                      'Ver reporte',
                      style: TextStyle(
                        color: Color(0xFF4A6CF7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
