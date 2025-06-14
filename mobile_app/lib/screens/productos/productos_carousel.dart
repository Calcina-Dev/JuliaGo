import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/producto.dart';
import '../../../providers/producto_provider.dart';
import '../../../constants/app_styles.dart';
import '../../widgets/common/neumorphic_circular_producto_image.dart';
import '../../widgets/common/neumorphic_card_container.dart';
import 'producto_editar_screen.dart';

class ProductosCarousel extends StatefulWidget {
  const ProductosCarousel({super.key});

  @override
  State<ProductosCarousel> createState() => _ProductosCarouselFiltradosState();
}

class _ProductosCarouselFiltradosState extends State<ProductosCarousel> {
  int _selectedIndex = 0;
  int? _pressedIndex;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductoProvider>(context);
    final productos = provider.productosFiltrados;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 390,
              child: PageView.builder(
                itemCount: productos.length,
                controller: PageController(viewportFraction: 0.75),
                onPageChanged: (index) =>
                    setState(() => _selectedIndex = index),
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  final isActive = index == _selectedIndex;
                  final isPressed = index == _pressedIndex;

                  return GestureDetector(
                    onTapDown: (_) => setState(() => _pressedIndex = index),
                    onTapUp: (_) => setState(() => _pressedIndex = null),
                    onTapCancel: () => setState(() => _pressedIndex = null),
                    onTap: () => _mostrarDetalle(context, producto),
                    child: Hero(
                      tag: 'producto_${producto.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: NeumorphicCardContainer(
                          isActive: isActive,
                          isPressed: isPressed,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProductoImage(
                                  imageUrl: producto.imagenUrl,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  producto.nombre,
                                  style: AppStyles.cardTitleStyle,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'S/. ${producto.precio.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  producto.descripcion,
                                  maxLines: isActive ? 3 : 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppStyles.hintColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDetalle(BuildContext context, Producto producto) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => ProductoEditarScreen(producto: producto),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}
