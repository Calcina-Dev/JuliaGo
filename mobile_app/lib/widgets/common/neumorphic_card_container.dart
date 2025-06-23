import 'package:flutter/material.dart';

class NeumorphicCardContainer extends StatelessWidget {
  final Widget child;
  final bool isPressed;
  final bool isActive;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const NeumorphicCardContainer({
    super.key,
    required this.child,
    this.isPressed = false,
    this.isActive = true,
    this.margin,
    this.padding = const EdgeInsets.all(20),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = color ?? const Color(0xFFf0f0f2);
    final shadowColor = Colors.black12;
    final highlight = Colors.white;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: isActive ? Matrix4.identity() : Matrix4.identity()..scale(0.99),
      margin: margin ?? EdgeInsets.symmetric(vertical: isActive ? 10 : 30,horizontal: 5),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isPressed
            ? [
                BoxShadow(color: shadowColor, offset: const Offset(-2, -2), blurRadius: 4),
                BoxShadow(color: highlight, offset: const Offset(2, 2), blurRadius: 4),
              ]
            : [
                BoxShadow(color: highlight, offset: const Offset(-6, -6), blurRadius: 10),
                BoxShadow(color: shadowColor, offset: const Offset(6, 6), blurRadius: 10),
              ],
      ),
      padding: padding,
      child: child,
    );
  }
}
