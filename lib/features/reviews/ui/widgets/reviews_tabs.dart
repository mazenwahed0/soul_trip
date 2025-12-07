import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsTabsBoxes extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const ReviewsTabsBoxes({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final List<String> tabs = const ['Discover', 'My Timeline', 'Saved'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(tabs.length, (index) {
        final isSelected = selectedIndex == index;
        return GestureDetector(
          onTap: () => onTabChanged(index),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isSelected ? Colors.black : Colors.grey.shade300,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              tabs[index],
              style: TextStyle(
                fontSize: 19.sp,
                color: isSelected ? Colors.black : Colors.grey.shade400,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }
}
