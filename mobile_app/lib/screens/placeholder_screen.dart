import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Panel de $title')),
      body: Center(
        child: Text(
          'Bienvenido al panel de $title',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
