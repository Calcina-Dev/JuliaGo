import 'package:flutter/material.dart';

class SidebarMenu extends StatelessWidget {
  final void Function(String)? onItemSelected;
  final String selectedItem;

  const SidebarMenu({
    super.key,
    this.onItemSelected,
    required this.selectedItem,
  });

  final menuItems = const [
    {'label': 'Dashboard', 'icon': Icons.dashboard},
    {'label': 'Food Order', 'icon': Icons.fastfood},
    {'label': 'Manage Menu', 'icon': Icons.menu_book},
    {'label': 'Customer Review', 'icon': Icons.reviews},
  ];

  final otherItems = const [
    {'label': 'Settings', 'icon': Icons.settings},
    {'label': 'Payment', 'icon': Icons.payment},
    {'label': 'Accounts', 'icon': Icons.account_circle},
    {'label': 'Help', 'icon': Icons.help_outline},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // LOGO SUPERIOR
        Padding(
          padding: const EdgeInsets.only(top: 32.0, bottom: 16),
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white, // fondo blanco neutro
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(0),
            child: ClipOval(
              child: Image.asset(
                'assets/logo_dona_julia.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        // LISTA PRINCIPAL
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              const SizedBox(height: 24),
              _buildSectionHeader('Menu'),
              ...menuItems.map((item) => _buildItem(context, item)),
              const SizedBox(height: 24),
              _buildSectionHeader('Others'),
              ...otherItems.map((item) => _buildItem(context, item)),
            ],
          ),
        ),
        const Divider(),
        ListTile(
          contentPadding: const EdgeInsets.only(left: 24.0, right: 12.0),
          leading: const Icon(Icons.logout, size: 20, color: Color(0xFF9E9E9E)),
          title: const Text(
            'Cerrar sesión',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF9E9E9E),
              fontWeight: FontWeight.w400,
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Sesión cerrada')));
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
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

  Widget _buildItem(BuildContext context, Map<String, dynamic> item) {
    final label = item['label'] as String;
    final icon = item['icon'] as IconData;
    final isSelected = label == selectedItem;

    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 24.0,
        right: 12.0,
      ), // Sangría visual del contenido
      leading: Icon(
        icon,
        size: 20,
        color: isSelected ? const Color(0xFF007D81) : const Color(0xFF9E9E9E),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: isSelected ? const Color(0xFF007D81) : const Color(0xFF444444),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      tileColor: isSelected ? const Color(0xFFE4F1F1) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () {
        Navigator.pop(context);
        onItemSelected?.call(label);
      },
    );
  }
}
