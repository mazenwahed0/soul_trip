import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/features/layout/ui/widgets/bottom_nav_item.dart';
import 'package:soul_trip/features/layout/data/helper/layout_constants.dart';

/// Custom bottom navigation bar with smooth animations
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: LayoutConstants.navigationBarHeight,
      decoration: _buildDecoration(),
      child: _buildNavigationItems(),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: ColorTheme().whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 2,
          offset: const Offset(0, -1),
        ),
      ],
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(LayoutConstants.navigationBarTopRadius),
        topRight: Radius.circular(LayoutConstants.navigationBarTopRadius),
      ),
    );
  }

  Widget _buildNavigationItems() {
    return SafeArea(
      top: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          LayoutConstants.navigationItems.length,
          (index) => BottomNavItem(
            item: LayoutConstants.navigationItems[index],
            isSelected: currentIndex == index,
            onTap: () => onTap(index),
          ),
        ),
      ),
    );
  }
}
