import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';



Future<void> handleLogin({
  required BuildContext context,
  required String email,
  required String password,
  required VoidCallback onStart,
  required VoidCallback onFinish,
  required bool Function() mounted,
}) async {
  if (email.isEmpty || password.isEmpty) {
    if (mounted()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    }
    return;
  }

  try {
    onStart();
    if (kDebugMode) debugPrint('🔐 Inicio de login...');
    if (kDebugMode) debugPrint('📡 Llamando a APIService.login...');

    final result = await ApiService.login(email, password);

    if (kDebugMode) debugPrint('📥 Resultado API: $result');

    onFinish();

    if (!context.mounted) return;

   if (result['success']) {
    final usuarioData = result['usuario'];
    final token = result['token']; // ⚠️ Estás devolviendo esto en el backend

    final usuario = User.fromJson(usuarioData);

    // Guardamos en Provider
    Provider.of<AuthProvider>(context, listen: false).login(
      user: usuario,
      token: token,
    );

    // Mostrar saludo
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('¡Bienvenido!'),
        content: Text('Hola, ${usuario.name} 👋'),
      ),
    );

    if (!mounted()) return;
    Navigator.pushReplacementNamed(context, '/${usuario.rol}');
  }
  else {
      if (!mounted()) return;
      debugPrint('❌ Login fallido: ${result['message']}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Error desconocido')),
      );
    }
  } catch (e, stackTrace) {
    onFinish();
    if (kDebugMode) {
      debugPrint('🛑 Excepción durante login: $e');
      debugPrint('📍 StackTrace:\n$stackTrace');
    }
    if (!mounted()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ocurrió un error inesperado')),
    );
  }
}
