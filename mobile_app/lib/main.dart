import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/constants/app_styles.dart';
import 'package:provider/provider.dart';
import '../../utils/responsive.dart';

import 'screens/login/splash_screen.dart';
import 'screens/placeholder_screen.dart';
import 'screens/dashboard/admin_dashboard_screen.dart';
import 'screens/login/login_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/dashboard_provider.dart';
import 'providers/producto_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => ProductoProvider()),
      ],
      child: Builder( // Necesitamos un nuevo contexto ya que MaterialApp aún no ha construido su contexto interno
        builder: (context) {
          // Obtener el tipo de pantalla
          final screenType = Responsive.getScreenType(context);

          // Configurar orientación según tipo de dispositivo
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

          return MaterialApp(
            color: AppStyles.backgroundColor,
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
          );
        },
      ),
    );
  }
}
