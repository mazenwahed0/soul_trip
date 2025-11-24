import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/categories_trips/data/repositories/categories_trips_repository.dart';
import 'package:soul_trip/features/categories_trips/manager/categories_trips_cubit/categories_trips_cubit.dart';
import 'package:soul_trip/features/categories_trips/ui/widgets/categories_trips_list_widget.dart';

class CategoriesTripsScreen extends StatelessWidget {
  const CategoriesTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocProvider(
      create: (_) =>
          CategoriesTripsCubit(CategoriesTripsRepository())..streamCategories(),
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
                    const Spacer(),
                    Text(
                      'Categories',
                      style: AppTextStyles.semiBold20().copyWith(
                        color: colors.blackColor,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 36.w),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(child: const CategoriesTripsListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
