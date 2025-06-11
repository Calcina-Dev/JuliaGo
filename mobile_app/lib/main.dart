import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/login/splash_screen.dart'; // ✅ Nuevo inicio
import 'screens/placeholder_screen.dart';
import 'screens/dashboard/admin_dashboard_screen.dart';
import 'screens/login/login_screen.dart';
import 'utils/responsive.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final screenType = Responsive.getScreenType(context);

    if (screenType == ScreenType.mobilePortrait) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'JuliaGo',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(), // ✅ Pantalla inicial
        routes: {
          
          '/admin': (_) => const AdminDashboardScreen(),
          '/mesero': (_) => const PlaceholderScreen(title: 'Mesero'),
          '/cocinero': (_) => const PlaceholderScreen(title: 'Cocinero'),
          '/cajero': (_) => const PlaceholderScreen(title: 'Cajero'),
          '/login': (_) => const LoginScreen(), // 👈 útil si se quiere redirigir manualmente al login
        },
      ),
    );
  }
}
