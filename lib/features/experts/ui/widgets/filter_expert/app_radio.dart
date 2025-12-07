import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';

class AppRadio extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  AppRadio({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
            child: selected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color:ColorTheme().primaryBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}
