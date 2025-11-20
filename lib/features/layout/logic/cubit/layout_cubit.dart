import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/layout/data/helper/layout_constants.dart';
import 'package:soul_trip/features/layout/logic/cubit/layout_state.dart';

/// Cubit to manage layout navigation state
class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(const LayoutInitial());

  /// Updates the current navigation based on route
  void updateCurrentRoute(String route) {
    final index = LayoutConstants.getRouteIndex(route);
    emit(LayoutNavigationChanged(currentIndex: index, currentRoute: route));
  }

  /// Navigates to a specific index
  void navigateToIndex(int index) {
    final route = LayoutConstants.getRouteAtIndex(index);
    emit(LayoutNavigationChanged(currentIndex: index, currentRoute: route));
  }

  /// Gets the current navigation index
  int getCurrentIndex() {
    final currentState = state;
    if (currentState is LayoutNavigationChanged) {
      return currentState.currentIndex;
    }
    return 0; // Default to home
  }

  /// Gets the current route
  String getCurrentRoute() {
    final currentState = state;
    if (currentState is LayoutNavigationChanged) {
      return currentState.currentRoute;
    }
    return LayoutConstants.navigationItems.first.route;
  }
}
