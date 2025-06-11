import 'package:flutter/material.dart';

enum ScreenType {
  mobilePortrait,
  tabletPortrait,
  tabletLandscape,
}

class Responsive {
  static ScreenType getScreenType(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final shortestSide = size.shortestSide;
    final orientation = MediaQuery.of(context).orientation;

    if (shortestSide < 600) {
      return ScreenType.mobilePortrait;
    } else {
      return orientation == Orientation.portrait
          ? ScreenType.tabletPortrait
          : ScreenType.tabletLandscape;
    }
  }
}
