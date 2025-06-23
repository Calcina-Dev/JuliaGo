import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_styles.dart';
import '../common/neumorphic_sidebar_widgets.dart';
import '../common/neumorphic_bottom_buttons.dart';
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
    {'label': 'Pagos', 'icon': Icons.payment},
    {'label': 'Mesas', 'icon': Icons.table_restaurant},
    {'label': 'Gestión de Menú', 'icon': Icons.menu_book},
    {'label': 'Usuarios', 'icon': Icons.group},
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

          // Avatar con efecto neumorfismo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppStyles.backgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4, -4),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Color(0x30000000),
                        offset: Offset(4, 4),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      nombre.isNotEmpty ? nombre[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        color: Colors.teal,
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
                ),
                const SizedBox(height: 16),
                
              ],
            ),
          ),

          const Divider(height: 1),
         buildBottomActionButtons(context, selectedItem, onItemSelected!),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
