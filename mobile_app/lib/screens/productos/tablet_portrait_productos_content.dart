import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/producto_provider.dart';
import '../../widgets/common/neumorphic_card_block.dart';
import '../../constants/app_styles.dart';

class TabletPortraitProductosContent extends StatefulWidget {
  const TabletPortraitProductosContent({super.key});

  @override
  State<TabletPortraitProductosContent> createState() => _TabletPortraitProductosContentState();
}

class _TabletPortraitProductosContentState extends State<TabletPortraitProductosContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProductoProvider>(context, listen: false);
      provider.fetchProductos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productosProvider = Provider.of<ProductoProvider>(context);

    if (productosProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final productos = productosProvider.productos ?? [];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: CardBlock(
        title: 'Productos',
        height: double.infinity,
        child: ListView.separated(
          itemCount: productos.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final producto = productos[index];
            return ListTile(
              leading: const Icon(Icons.fastfood),
              title: Text(
                producto.nombre,
                style: AppStyles.cardTitleStyle,
              ),
              subtitle: Text('S/. ${producto.precio} — ${producto.categoriaNombre ?? 'Sin categoría'}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            );
          },
        ),
      ),
    );
  }
}
