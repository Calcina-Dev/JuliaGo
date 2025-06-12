import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/login/splash_screen.dart';
import 'screens/placeholder_screen.dart';
import 'screens/dashboard/admin_dashboard_screen.dart';
import 'screens/login/login_screen.dart';
import 'utils/responsive.dart';
import 'providers/auth_provider.dart';
import 'providers/dashboard_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Definir orientación por defecto: portrait (temporalmente)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()), // 👈 agregado
      ],
      child: MaterialApp(
        title: 'JuliaGo',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          '/admin': (_) => const AdminDashboardScreen(),
          '/mesero': (_) => const PlaceholderScreen(title: 'Mesero'),
          '/cocinero': (_) => const PlaceholderScreen(title: 'Cocinero'),
          '/cajero': (_) => const PlaceholderScreen(title: 'Cajero'),
          '/login': (_) => const LoginScreen(),
        },
      ),
    );
  }
}
