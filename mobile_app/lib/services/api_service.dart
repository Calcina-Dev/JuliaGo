import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ApiService {
  static const baseUrl = 'http://192.168.0.240/api';

  // === LOGIN ===
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/login');

    print('🔐 Iniciando login...');
    print('📤 URL: $url');
    print('📨 Email: $email');

    try {
      final response = await http.post(
        url,
        body: {'email': email, 'password': password},
      );

      print('📬 Status code: ${response.statusCode}');
      print('📄 Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('rol', data['usuario']['rol']);
        await prefs.setString('nombre', data['usuario']['name']);
        await prefs.setInt('id', data['usuario']['id']); // 👈 Agregado
        await prefs.setString('email', data['usuario']['email']); // 👈 Agregado

        return {
          'success': true,
          'token': data['token'], // ✅ necesario para Provider
          'rol': data['usuario']['rol'],
          'usuario': data['usuario']
        };

      } else {
        return {'success': false, 'message': 'Credenciales incorrectas'};
      }
    } catch (e) {
      print('❌ Error durante login: $e');
      return {'success': false, 'message': 'Error de red: $e'};
    }
  }

  // === DASHBOARD ===
  static Future<List<dynamic>> getMostOrderedProducts(String ordenarPor) async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    final inicio = DateFormat('yyyy-MM-dd').format(startOfWeek);
    final fin = DateFormat('yyyy-MM-dd').format(endOfWeek);

    final res = await get(
      '/dashboard/productos-mas-vendidos?inicio=$inicio&fin=$fin&ordenar_por=$ordenarPor',
    );

    return List<Map<String, dynamic>>.from(decodeResponse(res));
  }

  static Future<Map<String, dynamic>> fetchRevenueData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    print('🔑 TOKEN: $token');

    final url = Uri.parse('$baseUrl/dashboard/revenue-comparativo');
    print('📡 Llamando a: $url');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    print('📬 Status: ${response.statusCode}');
    print('📄 Response: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {'success': true, 'data': data};
    } else {
      return {'success': false, 'message': 'Error al cargar revenue'};
    }
  }

  static Future<Map<String, dynamic>> fetchOrderTimeData(
    DateTime inicio,
    DateTime fin,
  ) async {
    final token = await _getToken();
    final url = Uri.parse(
      '$baseUrl/dashboard/ventas-por-hora?inicio=${inicio.toIso8601String()}&fin=${fin.toIso8601String()}',
    );

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {'success': true, 'data': data};
    } else {
      return {
        'success': false,
        'message': 'Error al cargar datos de ventas por hora',
      };
    }
  }

  // === UTILS ===
  static dynamic decodeResponse(http.Response res) {
    try {
      return json.decode(res.body);
    } catch (_) {
      return {'error': 'Error al decodificar la respuesta'};
    }
  }

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<http.Response> get(String endpoint) async {
    final token = await _getToken();
    final url = Uri.parse('$baseUrl$endpoint');

    return await http.get(
      url,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
  }

  static Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final token = await _getToken();
    final url = Uri.parse('$baseUrl$endpoint');

    return await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    );
  }

  static Future<void> logout() async {
    final token = await _getToken();
    final url = Uri.parse('$baseUrl/logout');

    await http.post(
      url,
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
