import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/placeholder_screen.dart';
import 'screens/admin_dashboard_screen.dart'; // ✅ Importa tu dashboard real

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JuliaGo',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      //const AdminDashboardScreen(), // ✅ Si quieres probar directamente el dashboard, cambia por AdminDashboardScreen()
      routes: {
        '/admin': (_) =>
            const AdminDashboardScreen(), // ✅ Reemplazado con el dashboard real
        '/mesero': (_) => const PlaceholderScreen(title: 'Mesero'),
        '/cocinero': (_) => const PlaceholderScreen(title: 'Cocinero'),
        '/cajero': (_) => const PlaceholderScreen(title: 'Cajero'),
      },
    );
  }
}
