import 'package:flutter/material.dart';

IconData getIconForCategory(String? categoria) {
  switch (categoria) {
    case 'Bebidas':
      return Icons.local_drink;
    case 'Entradas':
      return Icons.eco;
    case 'Platos de fondo':
      return Icons.set_meal;
    case 'Postres':
      return Icons.icecream;
    default:
      return Icons.fastfood;
  }
}
