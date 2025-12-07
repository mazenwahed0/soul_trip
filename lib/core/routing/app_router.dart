import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/page_transitions.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/features/experts/data/models/expert_model.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_cubit.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_cubit.dart';

import 'package:soul_trip/features/experts/ui/screen/details_screen.dart';
import 'package:soul_trip/features/experts/ui/screen/experts_screen.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/widget_filter_experts.dart';

import 'package:soul_trip/features/home/ui/screen/home_screen.dart';
import 'package:soul_trip/features/layout/ui/screen/layout_screen.dart';
import 'package:soul_trip/features/profile/ui/screen/profile/profile_screen.dart';

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

      GoRoute(
        path: Routes.expertsDetailsView,
        pageBuilder: (context, state) {
          final id = state.uri.queryParameters['id']!;
          return fadeTransitionPage(DetailsScreen(expertId: id));
        },
      ),

      GoRoute(
        path: Routes.expertsfilterscreen,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final allExperts = extra['allExperts'] as List<ExpertModel>? ?? [];
          final expertCubit = extra['expertCubit'] as ExpertCubit;

          return fadeTransitionPage(
            MultiBlocProvider(
              providers: [
                BlocProvider.value(value: expertCubit),
                BlocProvider(
                  create: (_) => ExpertFilterCubit(allExperts: allExperts),
                ),
              ],
              child: FilterExpertsScreen(),
            ),
          );
        },
      ),
    ],
  );
}
