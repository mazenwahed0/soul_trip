import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/widgets/common/appbar/custom_app_bar.dart';
import 'package:soul_trip/features/category_trips/data/repositories/category_trips_repository.dart';
import 'package:soul_trip/features/category_trips/manager/category_trips_cubit/category_trips_cubit.dart';
import 'package:soul_trip/features/category_trips/ui/widgets/category_trips_list_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:soul_trip/features/category_trips/data/repositories/category_trips_likes_repository.dart';
import 'package:soul_trip/features/category_trips/manager/category_trips_likes_cubit/category_trips_likes_cubit.dart';

class CategoryTripsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryTripsScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              CategoryTripsCubit(CategoryTripsRepository(), categoryName)
                ..streamTrips(),
        ),
        BlocProvider(
          create: (_) =>
              CategoryTripsLikesCubit(CategoryTripsLikesRepository(), userId),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(title: categoryName, showBackButton: true),
        backgroundColor: colors.backgroundWhite,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              const Expanded(child: CategoryTripsListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
