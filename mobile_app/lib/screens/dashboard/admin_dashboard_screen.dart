import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/sidebar_menu.dart';
import '../../widgets/dashboard_content/dashboard_content_selector.dart';
import '../../widgets/common/app_logo.dart';



class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  String selectedItem = 'Dashboard';
  String nombreUsuario = '';

  @override
  void initState() {
    super.initState();
    _cargarNombreUsuario();
  }

  Future<void> _cargarNombreUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final nombre = prefs.getString('nombre') ?? '';
    if (mounted) {
      setState(() {
        nombreUsuario = nombre;
      });
    }
  }

  Widget _getContent() {
    switch (selectedItem) {
      case 'Food Order':
        return const Center(child: Text('Food Order Page'));
      case 'Manage Menu':
        return const Center(child: Text('Manage Menu Page'));
      case 'Customer Review':
        return const Center(child: Text('Customer Review Page'));
      case 'Settings':
        return const Center(child: Text('Settings Page'));
      case 'Payment':
        return const Center(child: Text('Payment Page'));
      case 'Accounts':
        return const Center(child: Text('Accounts Page'));
      case 'Help':
        return const Center(child: Text('Help Page'));
      default:
        return const DashboardContentSelector();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: AppLogo(width: 100, height: 100),
          ),
        ],
      ),
      drawer: Drawer(
        child: SidebarMenu(
          selectedItem: selectedItem,
          onItemSelected: (label) {
            setState(() => selectedItem = label);
          },
        ),
      ),
      body: _getContent(),
    );
  }
}
