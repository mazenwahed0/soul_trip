import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/page_transitions.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/features/experts/ui/screen/experts_screen.dart';
import 'package:soul_trip/features/home/ui/screen/home_screen.dart';
import 'package:soul_trip/features/layout/ui/screen/layout_screen.dart';
import 'package:soul_trip/features/profile/ui/screen/profile_screen.dart';
import 'package:soul_trip/features/reviews/ui/screen/reviews_screen.dart';
import 'package:soul_trip/features/wishlist/ui/screen/wishlist_screen.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.homeView,
    routes: [
      // Shell Route with Bottom Navigation
      ShellRoute(
        pageBuilder: (context, state, child) {
          return fadeTransitionPage(
            BottomNavigationWidget(
              location: state.uri.toString(),
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            path: Routes.homeView,
            pageBuilder: (context, state) =>
                fadeTransitionPage(const HomeScreen()),
            redirect: (context, state) {
              // Redirect root to home
              if (state.uri.toString() == '/') {
                return Routes.homeView;
              }
              return null;
            },
          ),
          GoRoute(
            path: Routes.expertsView,
            pageBuilder: (context, state) =>
                fadeTransitionPage(const ExpertsScreen()),
          ),
          GoRoute(
            path: Routes.wishlistView,
            pageBuilder: (context, state) =>
                fadeTransitionPage(const WishlistScreen()),
          ),
          GoRoute(
            path: Routes.reviewsView,
            pageBuilder: (context, state) =>
                fadeTransitionPage(const ReviewsScreen()),
          ),
          GoRoute(
            path: Routes.profileView,
            pageBuilder: (context, state) =>
                fadeTransitionPage(const ProfileScreen()),
          ),
        ],
      ),
    ],
  );
}
