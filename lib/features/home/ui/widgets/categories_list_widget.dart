import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return SizedBox(
      height: 70.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: HomeConstants.categories.length,
        itemBuilder: (context, index) {
          final category = HomeConstants.categories[index];
          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: CategoryItemWidget(
              category: category,
              isSelected: _selectedCategoryIndex == index,
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
