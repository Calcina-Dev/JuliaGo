import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import 'mobile_dashboard_content.dart';
import 'tablet_landscape_dashboard_content.dart';
import 'tablet_portrait_dashboard_content.dart';

class DashboardContentSelector extends StatelessWidget {
  const DashboardContentSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final screenType = Responsive.getScreenType(context);

    // Devuelve el widget correspondiente según el tipo de dispositivo
    switch (screenType) {
      case ScreenType.mobilePortrait:
        return const MobileDashboardContent();
      case ScreenType.tabletPortrait:
        return const TabletPortraitDashboardContent();
      case ScreenType.tabletLandscape:
      default:
        return const TabletLandscapeDashboardContent();
    }
  }
}
