import 'package:flutter/material.dart';
import 'package:mobile_app/constants/app_styles.dart';

class SidebarSectionHeader extends StatelessWidget {
  final String title;

  const SidebarSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}

class SidebarMenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarMenuItem({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const selectedTextColor = Color(0xFF006A68);
    const unselectedTextColor = Color(0xFF444444);
    const iconColorUnselected = Color(0xFF9E9E9E);

    final neumorphicDecoration = BoxDecoration(
      color: AppStyles.backgroundColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Colors.white,
          offset: Offset(-3, -3),
          blurRadius: 5,
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Color(0x33000000),
          offset: Offset(3, 3),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
    );

    final circleNeumorphism = BoxDecoration(
      shape: BoxShape.circle,
      color: AppStyles.backgroundColor,
      boxShadow: const [
        BoxShadow(
          color: Colors.white,
          offset: Offset(-2, -2),
          blurRadius: 4,
        ),
        BoxShadow(
          color: Color(0x22000000),
          offset: Offset(2, 2),
          blurRadius: 4,
        ),
      ],
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: isSelected ? neumorphicDecoration : null,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: Container(
          decoration: isSelected
              ? circleNeumorphism
              : const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
          padding: const EdgeInsets.all(6),
          child: Icon(
            icon,
            size: 20,
            color: isSelected ? selectedTextColor : iconColorUnselected,
          ),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? selectedTextColor : unselectedTextColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
