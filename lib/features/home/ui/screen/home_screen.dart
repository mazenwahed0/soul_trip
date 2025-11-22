import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/home/ui/widgets/home_header_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/home_search_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Scaffold(
      backgroundColor: colors.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              // Header Section
              HomeHeaderWidget(),

              SizedBox(height: 20.h),

              // Search Bar
              HomeSearchBarWidget(),

              SizedBox(height: 24.h),

              // Content Area (You can expand this later)
              Expanded(
                child: Center(
                  child: Text(
                    'Welcome to Soul Trip! 🌟',
                    style: AppTextStyles.medium16().copyWith(
                      color: colors.grayMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the search bar with filter icon
}
