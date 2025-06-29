import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';

class NeumorphicButton extends StatelessWidget {
  final String label;
  final bool isPressed;
  final VoidCallback onTap;
  final VoidCallback onPressedDown;
  final VoidCallback onPressedUp;

  const NeumorphicButton({
    super.key,
    required this.label,
    required this.isPressed,
    required this.onTap,
    required this.onPressedDown,
    required this.onPressedUp,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = AppStyles.backgroundColor;

    return GestureDetector(
      onTapDown: (_) => onPressedDown(),
      onTapUp: (_) => onPressedUp(),
      onTapCancel: () => onPressedUp(),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: isPressed
              ? const [
                  BoxShadow(color: Colors.black12, offset: Offset(-2, -2), blurRadius: 4),
                  BoxShadow(color: Colors.white, offset: Offset(2, 2), blurRadius: 4),
                ]
              : const [
                  BoxShadow(color: Colors.white, offset: Offset(-4, -4), blurRadius: 8),
                  BoxShadow(color: Colors.black12, offset: Offset(4, 4), blurRadius: 8),
                ],
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}



class NeumorphicButtonSimple extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const NeumorphicButtonSimple({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  State<NeumorphicButtonSimple> createState() => _NeumorphicButtonSimpleState();
}

class _NeumorphicButtonSimpleState extends State<NeumorphicButtonSimple> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = AppStyles.backgroundColor;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: _isPressed
              ? const [
                  BoxShadow(color: Colors.black12, offset: Offset(-2, -2), blurRadius: 4),
                  BoxShadow(color: Colors.white, offset: Offset(2, 2), blurRadius: 4),
                ]
              : const [
                  BoxShadow(color: Colors.white, offset: Offset(-4, -4), blurRadius: 8),
                  BoxShadow(color: Colors.black12, offset: Offset(4, 4), blurRadius: 8),
                ],
        ),
        child: Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
