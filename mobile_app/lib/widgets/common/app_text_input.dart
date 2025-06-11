// lib/widgets/common/app_text_input.dart
import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';

class AppTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final Widget? suffixIcon;

  const AppTextInput({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppStyles.hintTextStyle,
        prefixIcon: Icon(icon, color: AppStyles.hintColor),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: AppStyles.borderRadius14,
          borderSide: const BorderSide(color: AppStyles.borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppStyles.borderRadius14,
          borderSide: const BorderSide(color: AppStyles.primaryColor, width: 2),
        ),
      ),
    );
  }
}
