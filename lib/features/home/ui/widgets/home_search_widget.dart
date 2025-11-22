import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart' show Soultrip;
import 'package:soul_trip/core/theme/text_style.dart';

class HomeSearchBarWidget extends StatefulWidget {
  final String hintText;
  final void Function(String)? onChanged;
  final VoidCallback? onFilterPressed;

  const HomeSearchBarWidget({
    super.key,
    this.hintText = 'Search',
    this.onChanged,
    this.onFilterPressed,
  });

  @override
  State<HomeSearchBarWidget> createState() => _HomeSearchBarWidgetState();
}

class _HomeSearchBarWidgetState extends State<HomeSearchBarWidget> {
  late final TextEditingController _searchController;
  final ColorTheme _colors = ColorTheme();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: _colors.backgroundWhite,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: _colors.grayLight.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),

          // Search Icon
          Icon(Soultrip.search, color: _colors.grayMedium, size: 22.sp),

          SizedBox(width: 10.w),

          // Search TextField
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: widget.onChanged,
              style: AppTextStyles.regular14().copyWith(
                color: _colors.blackColor,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: AppTextStyles.regular14().copyWith(
                  color: _colors.grayMedium,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          SizedBox(width: 10.w),
          Container(width: 1, color: _colors.grayVeryLight),
          // Filter Icon Button
          GestureDetector(
            onTap: widget.onFilterPressed,
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.tune, color: _colors.primaryBlue, size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }
}
