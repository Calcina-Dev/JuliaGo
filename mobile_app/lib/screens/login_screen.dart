import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 1000;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF8F4EF), // Fondo suave
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isPortrait = constraints.maxHeight > constraints.maxWidth;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isPortrait
                    ? constraints.maxWidth * 0.95
                    : constraints.maxWidth * 0.75,
                maxHeight: isPortrait
                    ? constraints.maxHeight * 0.95
                    : constraints.maxHeight * 0.75,
              ),
              child: Card(
                color: const Color(0xFFFFFFFF), // Card blanca
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: isTablet && !isPortrait
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: _loginCard(context, isTablet),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              flex: 5,
                              child: _logo(isTablet, isPortrait),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _logo(isTablet, isPortrait),
                              const SizedBox(width: 40),
                              _loginCard(context, isTablet),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _logo(bool isTablet, bool isPortrait) {
    final logoWidth = isTablet ? (isPortrait ? 800.0 : 600.0) : 400.0;
    final logoHeight = isTablet ? (isPortrait ? 500.0 : 900.0) : 250.0;
    final scaleFactor = isPortrait ? 0.95 : 1.1;

    return Align(
      alignment: Alignment.center,
      child: AnimatedScale(
        scale: scaleFactor,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          key: ValueKey('$logoWidth-$logoHeight'),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: logoWidth,
          height: logoHeight,
          child: Image.asset(
            'assets/logo_dona_julia.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Text(
              'Error al cargar logo',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginCard(BuildContext context, bool isTablet) {
    final cardWidth = isTablet ? 420.0 : 340.0;
    final cardPadding = isTablet ? 32.0 : 24.0;
    final scaleFactor = isTablet ? 1.05 : 1.0;

    return AnimatedScale(
      scale: scaleFactor,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: cardPadding,
          vertical: cardPadding + 8,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: SizedBox(
          width: cardWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50), // Gris azulado
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // EMAIL
              TextField(
                controller: _emailController,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'username@gmail.com',
                  hintStyle: const TextStyle(color: Color(0xFFB0B0B0)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE0E0E0), // borde suave
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE67E22), // naranja cálido al enfocar
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              // PASSWORD
              TextField(
                controller: _passwordController,
                obscureText: _obscure,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: '••••••••',
                  hintStyle: const TextStyle(color: Color(0xFFB0B0B0)),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off,
                      color: const Color(0xFFB0B0B0),
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE67E22),
                      width: 2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFFE67E22), // Naranja cálido
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE67E22), // Naranja cálido
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: _loading
                      ? null
                      : () async {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Por favor, completa todos los campos',
                                ),
                              ),
                            );
                            return;
                          }

                          setState(() => _loading = true);
                          final result = await ApiService.login(
                            email,
                            password,
                          );
                          setState(() => _loading = false);

                          if (!mounted) return;

                          if (result['success']) {
                            final rol = result['rol'];
                            Navigator.pushReplacementNamed(context, '/$rol');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result['message'])),
                            );
                          }
                        },
                  child: _loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Sign in',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
