import 'package:flutter/material.dart';
import 'package:mobile_app/constants/app_styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/dashboard_provider.dart';
import '../../widgets/sidebar/admin_sidebar_menu.dart';
import 'dashboard_content_selector.dart';
import '../../widgets/common/app_logo.dart';

import '../productos/producto_content_selector.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cargarDashboardSiNecesario();
    });
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

  void _cargarDashboardSiNecesario() {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    if (!provider.hasData) {
      provider.fetchDashboardData();
    }
  }

  Widget _getContent(DashboardProvider dashboardProvider) {
    if (dashboardProvider.isLoading && !dashboardProvider.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    switch (selectedItem) {
      case 'Productos':
        return const ProductoContentSelector(); // ← aquí llamamos al nuevo widget
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
    return Consumer<DashboardProvider>(
      builder: (context, dashboardProvider, child) {
        return Scaffold(
          backgroundColor: AppStyles.backgroundColor,

          appBar: AppBar(
            title: Text(selectedItem),
            backgroundColor: AppStyles.backgroundColor,
            foregroundColor: Colors.black,
            elevation: 0, // quita sombra
            scrolledUnderElevation: 0,
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
          body: _getContent(dashboardProvider),
        );
      },
    );
  }
}
