import 'package:flutter/material.dart';
import '../widgets/sidebar_menu.dart';
import '../widgets/dashboard_content.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  String selectedItem = 'Dashboard';

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
        return const DashboardContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
