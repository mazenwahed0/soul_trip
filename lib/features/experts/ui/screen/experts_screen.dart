import 'package:flutter/material.dart';

class ExpertsScreen extends StatelessWidget {
  const ExpertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experts')),
      body: const Center(child: Text('Experts Screen')),
    );
  }
}
