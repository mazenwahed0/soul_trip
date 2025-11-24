import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/category_trips/data/repositories/category_trips_repository.dart';
import 'package:soul_trip/features/category_trips/manager/category_trips_cubit/category_trips_cubit.dart';
import 'package:soul_trip/features/category_trips/ui/widgets/category_trips_list_widget.dart';

class CategoryTripsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryTripsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocProvider(
      create: (_) =>
          CategoryTripsCubit(CategoryTripsRepository(), categoryName)
            ..streamTrips(),
      child: Scaffold(
        backgroundColor: colors.backgroundWhite,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.grayVeryLight,
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    SizedBox(width: 12.w), // لإعطاء فاصل بين الأيقونة والنص
                    Expanded(
                      child: Text(
                        categoryName,
                        style: AppTextStyles.semiBold20().copyWith(
                          color: colors.blackColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              const Expanded(child: CategoryTripsListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
