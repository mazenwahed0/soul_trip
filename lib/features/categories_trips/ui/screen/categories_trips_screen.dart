import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/features/categories_trips/data/repositories/categories_trips_repository.dart';
import 'package:soul_trip/features/categories_trips/manager/categories_trips_cubit/categories_trips_cubit.dart';
import 'package:soul_trip/features/categories_trips/ui/widgets/categories_trips_list_widget.dart';

import '../../../../core/widgets/common/appbar/custom_app_bar.dart';

class CategoriesTripsScreen extends StatelessWidget {
  const CategoriesTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocProvider(
      create: (_) =>
          CategoriesTripsCubit(CategoriesTripsRepository())..streamCategories(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Categories",
          onBackTap: () => context.pop(),
        ),
        backgroundColor: colors.backgroundWhite,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Expanded(child: const CategoriesTripsListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
