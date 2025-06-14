// 📁 lib/screens/productos/producto_editar_screen.dart
import 'package:flutter/material.dart';
import '../../models/producto.dart';
import '../../constants/app_styles.dart';
import '../../widgets/common/neumorphic_switch.dart';
import '../../widgets/common/neumorphic_header.dart';
import '../../widgets/common/neumorphic_input_field.dart';
import '../../widgets/common/neumorphic_button.dart';
import '../../widgets/common/tooltip_overlay.dart';
import '../../widgets/common/neumorphic_circular_producto_image.dart';

class ProductoEditarScreen extends StatefulWidget {
  final Producto producto;

  const ProductoEditarScreen({super.key, required this.producto});

  @override
  State<ProductoEditarScreen> createState() => _ProductoEditarScreenState();
}

class _ProductoEditarScreenState extends State<ProductoEditarScreen> {
  bool _isSavingPressed = false;
  late TextEditingController _nombreController;
  late TextEditingController _precioController;
  late TextEditingController _descripcionController;
  late bool _activo;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.producto.nombre);
    _precioController = TextEditingController(text: widget.producto.precio.toString());
    _descripcionController = TextEditingController(text: widget.producto.descripcion);
    _activo = widget.producto.activo;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _precioController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = AppStyles.backgroundColor;
    final highlight = Colors.white;
    final shadow = Colors.black12;

    return Scaffold(
      backgroundColor: baseColor,
      body: SafeArea(
        child: Column(
          children: [
            const NeumorphicHeader(title: 'Editar Producto'),
            Expanded(
              child: Hero(
                tag: 'producto_${widget.producto.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                          boxShadow: [
                            BoxShadow(color: highlight, offset: const Offset(-6, -6), blurRadius: 10),
                            BoxShadow(color: shadow, offset: const Offset(6, 6), blurRadius: 10),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProductoImage(),
                              const SizedBox(height: 20),
                              NeumorphicInputField(label: 'Nombre del producto', controller: _nombreController),
                              const SizedBox(height: 12),
                              NeumorphicInputField(
                                label: 'Precio (S/.)',
                                controller: _precioController,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 12),
                              NeumorphicInputField(
                                label: 'Descripción',
                                controller: _descripcionController,
                                maxLines: 3,
                              ),
                              const SizedBox(height: 24),
                              NeumorphicButton(
                                label: 'Guardar Cambios',
                                isPressed: _isSavingPressed,
                                onPressedDown: () => setState(() => _isSavingPressed = true),
                                onPressedUp: () => setState(() => _isSavingPressed = false),
                                onTap: () {
                                  debugPrint('Guardar producto...');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 24,
                        child: NeumorphicToggle(
                          value: _activo,
                          onChanged: (val) {
                            setState(() => _activo = val);
                            showFloatingTooltip(context, val ? 'Producto activado' : 'Producto desactivado');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 
}
