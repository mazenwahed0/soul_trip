import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionItem extends StatelessWidget {
  final String? svgPath;        // SVG file path
  final IconData? iconData;     // IconData (Material / Cupertino)
  final int count;
  final double size;
  final VoidCallback? onTap;
  final Color? color;

  const ActionItem({
    super.key,
    this.svgPath,
    this.iconData,
    required this.count,
    required this.size,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          // ===== SVG ICON =====
          if (svgPath != null)
            SvgPicture.asset(
              svgPath!,
              width: size,
              height: size,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, BlendMode.srcIn)
                  : null,
            ),

          // ===== ICONDATA ICON =====
          if (iconData != null)
            Icon(
              iconData,
              size: size,
              color: color ?? Colors.grey.shade700,
            ),

          const SizedBox(width: 4),

          // ===== COUNT TEXT =====
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
