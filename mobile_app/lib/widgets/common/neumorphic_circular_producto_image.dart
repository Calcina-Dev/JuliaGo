import 'package:flutter/material.dart';
import '../../../constants/app_styles.dart';

class CircularProductoImage extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final EdgeInsets padding;

  const CircularProductoImage({
    super.key,
    this.imageUrl,
    this.size = 120,
    this.padding = const EdgeInsets.all(20.0),
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = AppStyles.backgroundColor;
    final highlight = Colors.white;
    final shadow = Colors.black12;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: baseColor,
        boxShadow: [
          BoxShadow(color: highlight, offset: const Offset(-4, -4), blurRadius: 8),
          BoxShadow(color: shadow, offset: const Offset(4, 4), blurRadius: 8),
        ],
      ),
      child: ClipOval(
        child: Padding(
          padding: padding,
          child: Image.network(
            imageUrl ?? 'https://icons.veryicon.com/png/o/miscellaneous/very-thin-linear-icon/camera-310.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
