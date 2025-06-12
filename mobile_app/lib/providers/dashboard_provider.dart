import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';

class DashboardProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool _hasFetched = false;

  Map<String, dynamic>? revenueData;
  Map<String, dynamic>? orderTimeData;
  Map<String, dynamic>? orderStatusData;

  List<Map<String, dynamic>>? mostOrderedByUnits;
  List<Map<String, dynamic>>? mostOrderedBySales;
  List<Map<String, dynamic>>? categoriasMasVendidas;

  String? categoriasSubtitle;

  bool get isLoading => _isLoading;

  bool get hasData =>
      revenueData != null &&
      orderTimeData != null &&
      orderStatusData != null &&
      mostOrderedByUnits != null &&
      mostOrderedBySales != null &&
      categoriasMasVendidas != null;

  Future<void> fetchDashboardData({bool forceRefresh = false}) async {
    if (_hasFetched && !forceRefresh) return;

    _isLoading = true;
    notifyListeners();

    try {
      final now = DateTime.now();
      final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));

      final inicio = DateFormat('yyyy-MM-dd').format(startOfWeek);
      final fin = DateFormat('yyyy-MM-dd').format(endOfWeek);

      final responses = await Future.wait([
        ApiService.get('/dashboard/revenue-comparativo'),
        ApiService.get('/dashboard/ventas-por-hora'),
        ApiService.get('/dashboard/estadisticas-pedidos'),
        ApiService.get('/dashboard/productos-mas-vendidos'),
        ApiService.get('/dashboard/categorias-mas-vendidas?inicio=$inicio&fin=$fin'),
      ]);

      revenueData = ApiService.decodeResponse(responses[0]);
      orderTimeData = ApiService.decodeResponse(responses[1]);
      orderStatusData = ApiService.decodeResponse(responses[2]);

      final productos = List<Map<String, dynamic>>.from(ApiService.decodeResponse(responses[3]));
      mostOrderedByUnits = List<Map<String, dynamic>>.from(productos)
        ..sort((a, b) => (b['total_unidades'] as num).compareTo(a['total_unidades'] as num));
      mostOrderedBySales = List<Map<String, dynamic>>.from(productos)
        ..sort((a, b) => (b['total_ventas'] as num).compareTo(a['total_ventas'] as num));

      categoriasMasVendidas = List<Map<String, dynamic>>.from(ApiService.decodeResponse(responses[4]));

      categoriasSubtitle =
          'Del ${_formatearFecha(startOfWeek)} al ${_formatearFecha(endOfWeek)}';

      _hasFetched = true;
    } catch (e) {
      print('❌ Error al cargar dashboard: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearDashboardData() {
    _hasFetched = false;
    revenueData = null;
    orderTimeData = null;
    orderStatusData = null;
    mostOrderedByUnits = null;
    mostOrderedBySales = null;
    categoriasMasVendidas = null;
    categoriasSubtitle = null;
    notifyListeners();
  }

  String _formatearFecha(DateTime fecha) {
    const meses = [
      'ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic'
    ];
    return '${fecha.day.toString().padLeft(2, '0')} ${meses[fecha.month - 1]}';
  }
}
