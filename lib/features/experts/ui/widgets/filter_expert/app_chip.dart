import 'package:flutter/material.dart';

class AppChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  AppChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.selectedColor = const Color(0xFF0D2C5E),
    this.backgroundColor = Colors.grey,
    this.textColor = Colors.white,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: selectedColor,
      backgroundColor: backgroundColor,
      labelStyle: TextStyle(color: textColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: borderColor != null
            ? BorderSide(color: borderColor!)
            : BorderSide.none,
      ),
      onSelected: (_) => onTap(),
    );
  }
}
