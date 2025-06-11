// lib/widgets/common/section_title.dart
import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppStyles.cardTitleStyle,
      ),
    );
  }
}
