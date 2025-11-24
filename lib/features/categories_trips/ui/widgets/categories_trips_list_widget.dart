import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/error_state_widget.dart';
import 'package:soul_trip/features/categories_trips/manager/categories_trips_cubit/categories_trips_cubit.dart';
import 'package:soul_trip/features/categories_trips/manager/categories_trips_cubit/categories_trips_state.dart';
import 'package:soul_trip/features/categories_trips/ui/widgets/category_trip_card_widget.dart';

class CategoriesTripsListWidget extends StatelessWidget {
  const CategoriesTripsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocBuilder<CategoriesTripsCubit, CategoriesTripsState>(
      builder: (context, state) {
        if (state is CategoriesTripsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CategoriesTripsError) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ErrorStateWidget(
              message: state.message,
              onRetry: () {
                context.read<CategoriesTripsCubit>().streamCategories();
              },
            ),
          );
        }

        if (state is CategoriesTripsLoaded) {
          final categories = state.categories;

          if (categories.isEmpty) {
            return Center(
              child: Text(
                'No categories found',
                style: AppTextStyles.regular14().copyWith(
                  color: colors.grayMedium,
                ),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryTripCardWidget(
                  category: category,
                  onTap: () {
                    final name = Uri.encodeComponent(category.categoryName);
                    context.push('${Routes.categoryTripsView}/$name');
                  },
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
