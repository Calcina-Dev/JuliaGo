import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'neumorphic_sidebar_widgets.dart'; // SidebarMenuItem y SidebarSectionHeader

List<Widget> buildMenuSection({
  required BuildContext context,
  required List<Map<String, dynamic>> items,
  required String selectedItem,
  required void Function(String label) onItemSelected,
}) {
  return items.map((item) {
    final label = item['label'] as String;
    final icon = item['icon'] as IconData;

    return SidebarMenuItem(
      label: label,
      icon: icon,
      isSelected: selectedItem == label,
      onTap: () {
        Navigator.pop(context);
        onItemSelected(label);
      },
    );
  }).toList();
}

Widget buildBottomActionButtons(BuildContext context, String selectedItem, void Function(String label) onItemSelected) {
  const backgroundColor = Color(0xFFF4F4F4);
  const selectedColor = Color(0xFF006A68);
  const iconColor = Color(0xFF9E9E9E);

  Widget neumorphicIconButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: isActive
              ? const [
                  // Presionado (hundido)
                  BoxShadow(
                    color: Color(0x33000000),
                    offset: Offset(-2, -2),
                    blurRadius: 4,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ]
              : const [
                  // Elevado (normal)
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
        ),
        child: Icon(
          icon,
          size: 20,
          color: isActive ? selectedColor : iconColor,
        ),
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        neumorphicIconButton(
          icon: Icons.settings,
          isActive: selectedItem == 'Ajustes',
          onTap: () {
            Navigator.pop(context);
            onItemSelected('Ajustes');
          },
        ),
        neumorphicIconButton(
          icon: Icons.help_outline,
          isActive: selectedItem == 'Ayuda',
          onTap: () {
            Navigator.pop(context);
            onItemSelected('Ayuda');
          },
        ),
        neumorphicIconButton(
          icon: Icons.power_settings_new,
          isActive: false, // Logout nunca está "activo"
          onTap: () async {
            await ApiService.logout();
            Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
              '/login',
              (route) => false,
            );
          },
        ),
      ],
    ),
  );
}
