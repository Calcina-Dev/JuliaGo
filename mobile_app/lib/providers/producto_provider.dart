import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../services/api_service.dart';

class ProductoProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<Producto> _productos = [];
  String? _categoriaSeleccionada;

  final Map<String, String> imagenesCategoria = {
    'Bebidas': 'assets/images/categorias/bebidas.png',
    'Platos de fondo': 'assets/images/categorias/platos.png',
    'Entradas': 'assets/images/categorias/entradas.png',
    'Postres': 'assets/images/categorias/postres.png',
  };

  // GETTERS
  bool get isLoading => _isLoading;
  List<Producto> get productos => _productos;
  String? get categoriaSeleccionada => _categoriaSeleccionada;

  List<String> get categorias {
    final nombres = _productos.map((p) => p.categoriaNombre).toSet().toList();
    nombres.sort(); // Opcional: orden alfabético
    debugPrint('📦 Categorías disponibles: $nombres');
    return nombres;
  }

  List<Producto> get productosFiltrados {
    if (_categoriaSeleccionada == null || _categoriaSeleccionada == 'Todos') {
      debugPrint('🔍 Mostrando todos los productos');
      return _productos;
    }
    final filtrados = _productos
        .where((p) => p.categoriaNombre == _categoriaSeleccionada)
        .toList();
    debugPrint('🔍 Productos filtrados por: $_categoriaSeleccionada → ${filtrados.length}');
    return filtrados;
  }

  String getImagenCategoria(String nombre) {
    final imagen = imagenesCategoria[nombre] ?? 'assets/images/categorias/default.png';
    debugPrint('🖼 Imagen para "$nombre": $imagen');
    return imagen;
  }

  // MÉTODOS
  void seleccionarCategoria(String? categoria) {
    debugPrint('➡️ Categoría seleccionada: $categoria');
    _categoriaSeleccionada = categoria;
    notifyListeners();
  }

  Future<void> fetchProductos() async {
  _isLoading = true;
  notifyListeners();
  debugPrint('🔄 Cargando productos...');

  try {
    final response = await ApiService.get('/productos');
    final List<dynamic> decoded = ApiService.decodeResponse(response);

    _productos = decoded.map((p) => Producto.fromJson(p)).toList();
    debugPrint('✅ Productos cargados: ${_productos.length}');
  } catch (e) {
    debugPrint('❌ Error al cargar productos: $e');
    _productos = [];
  }

  _isLoading = false;
  notifyListeners();
}

}
