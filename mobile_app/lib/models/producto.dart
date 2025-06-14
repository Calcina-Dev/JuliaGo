class Producto {
  final int id;
  final String nombre;
  final String descripcion;
  final String categoriaNombre;
  final int categoriaId;
  final double precio;
  final String? imagenUrl;
  final bool activo;

  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.categoriaNombre,
    required this.categoriaId,
    required this.precio,
    required this.imagenUrl,
    required this.activo,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'] ?? '',
      categoriaNombre: json['categoria_nombre'] ?? 'Sin categoría',
      categoriaId: json['categoria_id'],
      precio: double.tryParse(json['precio'].toString()) ?? 0.0,
      imagenUrl: json['imagen_url'],
      activo: json['activo'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'categoria_nombre': categoriaNombre,
      'categoria_id': categoriaId,
      'precio': precio.toStringAsFixed(2),
      'imagen_url': imagenUrl,
      'activo': activo,
    };
  }
}
