import 'package:flutter/material.dart';
import '../../../constants/app_styles.dart';

class CategoriaChip extends StatelessWidget {
  final String nombre;
  final String imagenPath;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoriaChip({
    super.key,
    required this.nombre,
    required this.imagenPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFf0f0f2),
              boxShadow: isSelected
                  ? const [
                      BoxShadow(color: Colors.black12, offset: Offset(-4, -4), blurRadius: 6),
                      BoxShadow(color: Colors.white, offset: Offset(4, 4), blurRadius: 6),
                    ]
                  : const [
                      BoxShadow(color: Colors.white, offset: Offset(-4, -4), blurRadius: 6),
                      BoxShadow(color: Colors.black12, offset: Offset(4, 4), blurRadius: 6),
                    ],
            ),
            child: ClipOval(
              child: Image.asset(imagenPath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            nombre,
            style: TextStyle(
              color: isSelected ? AppStyles.primaryColor : AppStyles.hintColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
