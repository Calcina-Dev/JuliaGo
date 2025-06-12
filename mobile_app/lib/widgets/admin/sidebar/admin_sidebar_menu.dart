import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_styles.dart';
import '../../common/sidebar_widgets.dart';
import '../../common/siderbar_utils.dart';
import '../../../providers/auth_provider.dart';

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
    {'label': 'Food Order', 'icon': Icons.fastfood},
    {'label': 'Manage Menu', 'icon': Icons.menu_book},
    {'label': 'Customer Review', 'icon': Icons.reviews},
  ];

  static const otherItems = [
    {'label': 'Settings', 'icon': Icons.settings},
    {'label': 'Payment', 'icon': Icons.payment},
    {'label': 'Accounts', 'icon': Icons.account_circle},
    {'label': 'Help', 'icon': Icons.help_outline},
  ];

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<AuthProvider>(context).user;
    final nombre = usuario?.name ?? 'Usuario';

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: AppStyles.defaultCardShadow,
      ),
      child: Column(
        children: [
          const SizedBox(height: 36),

          // Imagen redonda con inicial y nombre
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Material(
                  elevation: 6,
                  shape: const CircleBorder(),
                  shadowColor: Colors.black26,
                  child: Container(
                    width: 40,
                    height: 40,
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
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    nombre,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),

          // Lista de opciones
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                const SizedBox(height: 24),
                const SidebarSectionHeader(title: 'Menu'),
                ...buildMenuSection(
                  context: context,
                  items: menuItems,
                  selectedItem: selectedItem,
                  onItemSelected: onItemSelected!,
                ),
                const SizedBox(height: 24),
                const SidebarSectionHeader(title: 'Others'),
                ...buildMenuSection(
                  context: context,
                  items: otherItems,
                  selectedItem: selectedItem,
                  onItemSelected: onItemSelected!,
                ),
              ],
            ),
          ),

          const Divider(),
          buildLogoutTile(context),
        ],
      ),
    );
  }
}
