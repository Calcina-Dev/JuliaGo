import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import 'mobile_productos_content.dart';
import 'tablet_portrait_productos_content.dart';
import 'tablet_landscape_productos_content.dart';

class ProductoContentSelector extends StatelessWidget {
  const ProductoContentSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final screenType = Responsive.getScreenType(context);

    switch (screenType) {
      case ScreenType.mobilePortrait:
        return const MobileProductosContent();
      case ScreenType.tabletPortrait:
        return const TabletPortraitProductosContent();
      case ScreenType.tabletLandscape:
        return const TabletLandscapeProductosContent();
    }
  }
}
