import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/features/layout/data/models/navigation_item_model.dart';
import 'package:soul_trip/features/layout/data/helper/layout_constants.dart';

import '../../../../core/theme/text_style.dart';

/// A single bottom navigation item widget
class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final NavigationItemModel item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: LayoutConstants.navigationItemWidth,
        // height: LayoutConstants.navigationItemHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            LayoutConstants.navigationItemRadius,
          ),
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: LayoutConstants.iconLabelSpacing / 2),
            _buildIcon(),
            SizedBox(height: LayoutConstants.iconLabelSpacing),
            _buildLabel(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final double size = isSelected
        ? LayoutConstants.activeIconSize
        : LayoutConstants.inactiveIconSize;

    final Color color = _getColor();
    return AnimatedContainer(
      duration: LayoutConstants.itemTransitionDuration,
      curve: Curves.easeInOut,
      child: item.svgPath != null
          ? SvgPicture.asset(
              item.svgPath!,
              width: size.sp,
              height: size.sp,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            )
          : Icon(item.icon, size: size, color: color),
    );
  }

  Widget _buildLabel() {
    return AnimatedDefaultTextStyle(
      duration: LayoutConstants.itemTransitionDuration,
      curve: Curves.easeInOut,
      style: AppTextStyles.medium12().copyWith(
        color: _getColor(),
        fontSize: LayoutConstants.labelFontSize,
      ),
      child: Text(item.label),
    );
  }

  Color _getColor() {
    return isSelected ? ColorTheme().primaryBlue : ColorTheme().grayMedium;
  }
}
