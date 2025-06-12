// 📁 lib/providers/pedidos_provider.dart
import 'package:flutter/material.dart';

class PedidoProducto {
  final int productoId;
  final String nombre;
  final double precio;
  int cantidad;

  PedidoProducto({
    required this.productoId,
    required this.nombre,
    required this.precio,
    this.cantidad = 1,
  });

  double get subtotal => cantidad * precio;
}

class PedidosProvider extends ChangeNotifier {
  int? mesaId;
  List<PedidoProducto> _productos = [];
  String estado = 'pendiente';

  List<PedidoProducto> get productos => _productos;

  double get total => _productos.fold(0, (sum, p) => sum + p.subtotal);

  void seleccionarMesa(int id) {
    mesaId = id;
    _productos = [];
    estado = 'pendiente';
    notifyListeners();
  }

  void agregarProducto(PedidoProducto producto) {
    final index = _productos.indexWhere((p) => p.productoId == producto.productoId);
    if (index != -1) {
      _productos[index].cantidad += producto.cantidad;
    } else {
      _productos.add(producto);
    }
    notifyListeners();
  }

  void eliminarProducto(int productoId) {
    _productos.removeWhere((p) => p.productoId == productoId);
    notifyListeners();
  }

  void cambiarCantidad(int productoId, int nuevaCantidad) {
    final index = _productos.indexWhere((p) => p.productoId == productoId);
    if (index != -1) {
      _productos[index].cantidad = nuevaCantidad;
      notifyListeners();
    }
  }

  void cambiarEstado(String nuevoEstado) {
    estado = nuevoEstado;
    notifyListeners();
  }

  void reset() {
    mesaId = null;
    _productos = [];
    estado = 'pendiente';
    notifyListeners();
  }
}

// 👉 Luego registra este provider en main.dart o admin_dashboard
