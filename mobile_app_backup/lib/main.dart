import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

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
      routes: {
        '/admin': (_) => const PlaceholderScreen(title: 'Admin'),
        '/mesero': (_) => const PlaceholderScreen(title: 'Mesero'),
        '/cocinero': (_) => const PlaceholderScreen(title: 'Cocinero'),
        '/cajero': (_) => const PlaceholderScreen(title: 'Cajero'),
      },
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Pantalla de $title')),
    );
  }
}
