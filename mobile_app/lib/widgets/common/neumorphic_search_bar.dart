import 'package:flutter/material.dart';

class NeumorphicSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;

  const NeumorphicSearchBar({
    super.key,
    this.controller,
    this.hint = 'Buscar...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFf0f0f2),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Colors.white, offset: Offset(-6, -6), blurRadius: 10),
          BoxShadow(color: Colors.black12, offset: Offset(6, 6), blurRadius: 10),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}
