import 'package:flutter/material.dart';

class AppChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  AppChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: Colors.indigo.shade900,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
      onSelected: (_) => onTap(),
    );
  }
}
