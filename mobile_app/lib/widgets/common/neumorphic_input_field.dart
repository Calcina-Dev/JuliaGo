import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';

class NeumorphicInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int maxLines;

  const NeumorphicInputField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = AppStyles.backgroundColor;

    return Container(
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.white, offset: Offset(-4, -4), blurRadius: 6),
          BoxShadow(color: Colors.black12, offset: Offset(4, 4), blurRadius: 6),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          labelStyle: const TextStyle(color: AppStyles.hintColor),
        ),
      ),
    );
  }
}
