import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_styles.dart';
import '../common/sidebar_widgets.dart';
import '../common/siderbar_utils.dart';
import '../../providers/auth_provider.dart';

class SidebarMenu extends StatelessWidget {
  final void Function(String)? onItemSelected;
  final String selectedItem;

  const SidebarMenu({
    super.key,
    this.onItemSelected,
    required this.selectedItem,
  });

  static const menuItems = [
    {'label': 'Dashboard', 'icon': Icons.dashboard},
    {'label': 'Pedidos', 'icon': Icons.receipt_long},
    {'label': 'Productos', 'icon': Icons.inventory_2},
    {'label': 'Mesas', 'icon': Icons.table_restaurant},
    {'label': 'Gestión de Menú', 'icon': Icons.menu_book},
    {'label': 'Usuarios', 'icon': Icons.group},
  ];

  static const otherItems = [
    {'label': 'Ajustes', 'icon': Icons.settings},
    {'label': 'Pagos', 'icon': Icons.payment},
    {'label': 'Ayuda', 'icon': Icons.help_outline},
  ];

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<AuthProvider>(context).user;
    final nombre = usuario?.name ?? 'Usuario';

    return Container(
      decoration: const BoxDecoration(
        color: AppStyles.backgroundColor,
        boxShadow: AppStyles.defaultCardShadow,
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),

          // Avatar con inicial
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Material(
                  elevation: 4,
                  shape: const CircleBorder(),
                  shadowColor: Colors.black12,
                  child: Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal,
                    ),
                    child: Text(
                      nombre.isNotEmpty ? nombre[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    nombre,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          const Divider(height: 1),

          // Secciones
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                const SizedBox(height: 16),
                const SidebarSectionHeader(title: 'MENU'),
                ...buildMenuSection(
                  context: context,
                  items: menuItems,
                  selectedItem: selectedItem,
                  onItemSelected: onItemSelected!,
                  //iconSize: 20,
                  //fontSize: 14,
                ),
                const SizedBox(height: 16),
                const SidebarSectionHeader(title: 'OTHERS'),
                ...buildMenuSection(
                  context: context,
                  items: otherItems,
                  selectedItem: selectedItem,
                  onItemSelected: onItemSelected!,
                  //iconSize: 20,
                  //fontSize: 14,
                ),
              ],
            ),
          ),

          const Divider(height: 1),
          buildLogoutTile(context),
          //, iconSize: 20, fontSize: 14),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
