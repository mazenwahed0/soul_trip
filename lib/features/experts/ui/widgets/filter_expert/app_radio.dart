import 'package:flutter/material.dart';

import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class AppRadio extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double size;

  AppRadio({
    required this.label,
    required this.selected,
    required this.onTap,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: selected
                ? Center(
                    child: Container(
                      width: size * 0.55,
                      height: size * 0.55,
                      decoration: BoxDecoration(
                        color: Color(0xFF0D2C5E),
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          widthSpace(6),
          Text(label),
        ],
      ),
    );
  }
}
