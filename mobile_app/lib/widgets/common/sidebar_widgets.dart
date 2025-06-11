import 'package:flutter/material.dart';


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
    final selectedBgColor = const Color(0xFFE5F3F2);
    final selectedTextColor = const Color(0xFF006A68);
    final unselectedTextColor = const Color(0xFF444444);
    final iconBackground = Colors.white;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? selectedBgColor : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: Container(
          decoration: BoxDecoration(
            color: isSelected ? iconBackground : Colors.transparent,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(6),
          child: Icon(
            icon,
            size: 20,
            color: isSelected ? selectedTextColor : const Color(0xFF9E9E9E),
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
