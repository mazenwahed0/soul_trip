import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/models/category_model.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/features/categories_trips/manager/categories_trips_cubit/categories_trips_cubit.dart';
import 'package:soul_trip/features/categories_trips/manager/categories_trips_cubit/categories_trips_state.dart';
import 'package:soul_trip/features/home/data/home_constants.dart';
import 'package:soul_trip/features/home/ui/widgets/category_item_widget.dart';

class CategoriesListWidget extends StatefulWidget {
  const CategoriesListWidget({super.key});

  @override
  State<CategoriesListWidget> createState() => _CategoriesListWidgetState();
}

class _CategoriesListWidgetState extends State<CategoriesListWidget> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final homeCategory = HomeConstants.categories.first;
    final otherIcons = HomeConstants.categories.length > 1
        ? HomeConstants.categories.sublist(1)
        : <CategoryModel>[];

    return SizedBox(
      height: 70.h,
      child: BlocBuilder<CategoriesTripsCubit, CategoriesTripsState>(
        builder: (context, state) {
          final items = <Widget>[];

          // First static home icon
          items.add(
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: CategoryItemWidget(
                category: homeCategory,
                isSelected: _selectedCategoryIndex == 0,
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = 0;
                  });
                  // No navigation, مجرد home
                },
              ),
            ),
          );

          if (state is CategoriesTripsLoaded) {
            final categories = state.categories;

            for (var i = 0; i < categories.length; i++) {
              final tripCategory = categories[i];

              final uiModel = CategoryModel(
                id: tripCategory.id,
                name: tripCategory.categoryName,
                icon: i < otherIcons.length
                    ? otherIcons[i].icon
                    : homeCategory.icon,
              );

              final uiIndex = i + 1; // عشان 0 للحالة الثابتة

              items.add(
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: CategoryItemWidget(
                    category: uiModel,
                    isSelected: _selectedCategoryIndex == uiIndex,
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = uiIndex;
                      });

                      final name = Uri.encodeComponent(uiModel.name);
                      context.push('${Routes.categoryTripsView}/$name');
                    },
                  ),
                ),
              );
            }
          }

          return ListView(scrollDirection: Axis.horizontal, children: items);
        },
      ),
    );
  }
}
