import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/features/layout/data/helper/layout_constants.dart';
import 'package:soul_trip/features/layout/logic/cubit/layout_cubit.dart';
import 'package:soul_trip/features/layout/logic/cubit/layout_state.dart';
import 'package:soul_trip/features/layout/ui/widgets/bottom_navigation_bar.dart';

/// Main layout screen that wraps all bottom navigation routes
class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
    required this.location,
    required this.child,
    this.backgroundColor,
    super.key,
  });

  final Widget child;
  final String location;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..updateCurrentRoute(location),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          // Handle side effects if needed
        },
        builder: (context, state) {
          return Scaffold(
            body: child,
            backgroundColor: backgroundColor,
            extendBody: true,
            bottomNavigationBar: CustomBottomNavigationBar(
              currentIndex: _getCurrentIndex(context, state),
              onTap: (index) => _handleNavigationTap(context, index),
            ),
          );
        },
      ),
    );
  }

  int _getCurrentIndex(BuildContext context, LayoutState state) {
    if (state is LayoutNavigationChanged) {
      return state.currentIndex;
    }
    return LayoutConstants.getRouteIndex(location);
  }

  void _handleNavigationTap(BuildContext context, int index) {
    final cubit = context.read<LayoutCubit>();
    final currentIndex = cubit.getCurrentIndex();

    // Prevent navigation to the same tab
    if (currentIndex == index) return;

    // Update cubit state
    cubit.navigateToIndex(index);

    // Navigate using GoRouter
    final route = LayoutConstants.getRouteAtIndex(index);
    context.go(route);
  }
}
