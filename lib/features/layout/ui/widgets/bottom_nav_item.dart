import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/features/layout/data/models/navigation_item_model.dart';
import 'package:soul_trip/features/layout/data/helper/layout_constants.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(),
          SizedBox(height: LayoutConstants.iconLabelSpacing),
          _buildLabel(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return AnimatedContainer(
      duration: LayoutConstants.itemTransitionDuration,
      curve: Curves.easeInOut,
      child: Icon(
        item.icon,
        size: isSelected
            ? LayoutConstants.activeIconSize
            : LayoutConstants.inactiveIconSize,
        color: _getColor(),
      ),
    );
  }

  Widget _buildLabel() {
    return AnimatedDefaultTextStyle(
      duration: LayoutConstants.itemTransitionDuration,
      curve: Curves.easeInOut,
      style: TextStyle(
        color: _getColor(),
        fontSize: LayoutConstants.labelFontSize,
        fontWeight: FontWeight.normal,
      ),
      child: Text(item.label),
    );
  }

  Color _getColor() {
    return isSelected ? ColorTheme().primaryBlue : ColorTheme().grayMedium;
  }
}
