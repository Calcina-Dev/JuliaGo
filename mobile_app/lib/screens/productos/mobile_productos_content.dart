import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/producto_provider.dart';
import '../../constants/app_styles.dart';
import 'productos_carousel.dart';
import '../../widgets/common/neumorphic_search_bar.dart';
import '../../widgets/common/neumorphic_categoria_chip.dart';

class MobileProductosContent extends StatefulWidget {
  const MobileProductosContent({super.key});

  @override
  State<MobileProductosContent> createState() => _MobileProductosContentState();
}

class _MobileProductosContentState extends State<MobileProductosContent> {
  String? selectedCategoria;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductoProvider>(context, listen: false).fetchProductos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductoProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final categorias = provider.categorias;

    return SafeArea(
      //color: AppStyles.backgroundColor	,child:
      //color: const Color(0xFFf0f0f2),child:
      child: Padding(
        padding: const EdgeInsets.all(AppStyles.mobilePagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Buscador
            // 🔍 Buscador con neomorfismo
            const NeumorphicSearchBar(hint: 'Buscar producto...'),

            const SizedBox(height: 25),

            // 🧭 Categorías
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categorias.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final categoria = categorias[index];
                  final isSelected = selectedCategoria == categoria;
                  final imagen = provider.getImagenCategoria(categoria);
                  return CategoriaChip(
                    nombre: categoria,
                    imagenPath: imagen,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        selectedCategoria = isSelected ? null : categoria;
                        provider.seleccionarCategoria(selectedCategoria);
                      });
                    },
                  );
                },
              ),
            ),
            //const SizedBox(height: 10),

            // 🎯 Contenido: Agrupado o Filtrado
            Flexible(
              fit: FlexFit.tight,
              child: Builder(
                builder: (_) {
                  return const ProductosCarousel();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
