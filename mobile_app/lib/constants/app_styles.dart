import 'package:flutter/material.dart';

class AppStyles {
  // ========== COLORES GENERALES ==========
  static const Color backgroundColor =   Color(0xFFf0f0f2);
  static const Color cardColor = Color(0xFFf0f0f2);
  static const Color primaryColor = Color(0xFFE67E22);
  static const Color textDark = Color(0xFF2C3E50);
  static const Color hintColor = Color(0xFFB0B0B0);
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color errorText = Colors.red;
  static const Color sectionTitleColor = Color(0xFF1C1C1E);
  static const Color iconSyncColor = Colors.black54;

  // ========== TIPOGRAFÍAS GENERALES ==========
  static const TextStyle cardTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: sectionTitleColor,
  );

  static const TextStyle hintTextStyle = TextStyle(color: hintColor);
  static const TextStyle forgotTextStyle = TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle signInTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // ========== BORDES Y SOMBRAS GENERALES ==========
  static const List<BoxShadow> defaultCardShadow = [
    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
  ];

  static const BorderRadius borderRadius16 = BorderRadius.all(
    Radius.circular(16),
  );
  static const BorderRadius borderRadius14 = BorderRadius.all(
    Radius.circular(14),
  );
  static const BorderRadius borderRadius24 = BorderRadius.all(
    Radius.circular(24),
  );
  static const BorderRadius borderRadius6 = BorderRadius.all(
    Radius.circular(6),
  );

  // ========== MOBILE STYLES ==========
  static const double mobilePagePadding = 20.0;
  static const double mobileCardPadding = 24.0;
  static const double mobileInputSpacing = 16.0;
  static const double mobileSectionSpacing = 32.0;
  static const double mobileButtonVerticalPadding = 14.0;

  static const double mobileCardRadius = 24.0;

  static const BorderRadius mobileCardBorderRadius = BorderRadius.all(
    Radius.circular(mobileCardRadius),
  );

  static const List<BoxShadow> mobileCardBoxShadow = [
    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
  ];

  static const TextStyle mobileForgotTextStyle = TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.w500,
  );

  static const double mobileSmallButtonRadius = 6.0;
  static const TextStyle mobileSignInTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle mobileHintTextStyle = TextStyle(color: hintColor);

  static const TextStyle mobileLoginTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textDark,
  );
  static const double mobileInputRadius = 14.0;

  static const BorderRadius mobileInputBorderRadius = BorderRadius.all(
    Radius.circular(mobileInputRadius),
  );

  // ========== TABLET STYLES ==========
  static const double tabletPagePadding = 25.0;
  static const double tabletCardSpacing = 10.0;
  static const double tabletColumnSpacing = 15.0;

  // ========== ESTILOS PARA CARDS DE PRODUCTO ==========
  static const TextStyle cardLabelStyle = TextStyle(
    fontSize: 13,
    color: Color(0xFF6C6C6C),
  );

  static const TextStyle cardValueStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: textDark,
  );
}
