import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const baseUrl =
      'http://10.0.2.2:8000/api'; // cámbialo si usas un dispositivo real

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setString('rol', data['rol']);

      return {'success': true, 'rol': data['rol']};
    } else {
      return {'success': false, 'message': 'Credenciales incorrectas'};
    }
  }
}
