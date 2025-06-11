import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/models/user.dart';
import '/providers/auth_provider.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideAnimation;

  String? _nombre;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
    _verificarSesion();
  }

  Future<void> _verificarSesion() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final rol = prefs.getString('rol');
    final id = prefs.getInt('id');
    final email = prefs.getString('email');
    final nombre = prefs.getString('nombre');


    setState(() {
      _nombre = nombre;
    });

    await Future.delayed(const Duration(milliseconds: 1800));

    if (!mounted) return;

    if (token != null && id != null && email != null && rol != null && nombre != null) {
      final user = User(
          id: id,
          name: nombre,
          email: email,
          rol: rol,
        );
      Provider.of<AuthProvider>(context, listen: false).login(
        user: user,
        token: token,
      );

      Navigator.pushReplacementNamed(context, '/$rol');
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final saludo = _nombre != null ? 'Bienvenido, $_nombre 👋' : 'Cargando...';

    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/logo_dona_julia.png', width: 500),
                SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    saludo,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
