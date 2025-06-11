// lib/widgets/common/app_logo.dart
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;

  const AppLogo({
    super.key,
    this.width = 240,
    this.height = 160,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AnimatedScale(
        scale: 0.95,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: width,
          height: height,
          child: Image.asset(
            'assets/logo_dona_julia.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Text(
              'Error al cargar logo',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
