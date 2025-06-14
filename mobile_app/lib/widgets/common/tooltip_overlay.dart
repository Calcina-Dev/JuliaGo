import 'package:flutter/material.dart';

void showFloatingTooltip(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final entry = OverlayEntry(
    builder: (context) => Positioned(
      top: 80,
      right: 30,
      child: Material(
        color: Colors.transparent,
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.85),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(entry);
  Future.delayed(const Duration(seconds: 2), () => entry.remove());
}
