import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/features/layout/data/models/navigation_item_model.dart';

/// Constants and configurations for the layout feature
abstract class LayoutConstants {
  // Navigation Bar Dimensions
  static const double navigationBarHeight = 60.0;
  static const double navigationBarTopRadius = 10.0;

  // Navigation Item Sizes
  static const double activeIconSize = 26.0;
  static const double inactiveIconSize = 24.0;
  static const double iconLabelSpacing = 3.0;
  static const double labelFontSize = 11.0;

  // Animation Durations
  static const Duration itemTransitionDuration = Duration(milliseconds: 300);
  static const Duration controllerDuration = Duration(milliseconds: 300);

  // Navigation Items Configuration
  static const List<NavigationItemModel> navigationItems = [
    NavigationItemModel(
      icon: Soultrip.home,
      label: 'Home',
      route: Routes.homeView,
    ),
    NavigationItemModel(
      icon: Soultrip.customersupport,
      label: 'Experts',
      route: Routes.expertsView,
    ),
    NavigationItemModel(
      icon: Soultrip.hearts,
      label: 'Wishlist',
      route: Routes.wishlistView,
    ),
    NavigationItemModel(
      icon: Soultrip.star,
      label: 'Reviews',
      route: Routes.reviewsView,
    ),
    NavigationItemModel(
      icon: Soultrip.profile,
      label: 'Profile',
      route: Routes.profileView,
    ),
  ];

  /// Gets the index of a route in the navigation items
  static int getRouteIndex(String route) {
    final index = navigationItems.indexWhere((item) => item.route == route);
    return index >= 0 ? index : 0;
  }

  /// Gets the route for a given index
  static String getRouteAtIndex(int index) {
    if (index >= 0 && index < navigationItems.length) {
      return navigationItems[index].route;
    }
    return Routes.homeView;
  }
}
