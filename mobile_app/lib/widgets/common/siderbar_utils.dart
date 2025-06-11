import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'sidebar_widgets.dart'; // Para SidebarMenuItem y SidebarSectionHeader

/// Sección de menú lateral con múltiples ítems
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

/// Ítem para cerrar sesión
Widget buildLogoutTile(BuildContext context) {
  return ListTile(
    contentPadding: const EdgeInsets.only(left: 24.0, right: 12.0),
    leading: const Icon(
      Icons.logout,
      size: 20,
      color: Color(0xFF9E9E9E),
    ),
    title: const Text(
      'Cerrar sesión',
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF9E9E9E),
        fontWeight: FontWeight.w400,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    onTap: () async {
      await ApiService.logout();
      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );
    },
  );
}
