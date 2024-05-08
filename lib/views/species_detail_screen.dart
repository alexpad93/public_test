import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpeciesDetailScreen extends StatelessWidget {
  /// Constructs a [SpeciesDetailScreen]
  const SpeciesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to the Species List screen'),
        ),
      ),
    );
  }
}