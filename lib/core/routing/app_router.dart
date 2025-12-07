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
import 'package:soul_trip/features/categories_trips/ui/screen/categories_trips_screen.dart';
import 'package:soul_trip/features/category_trips/ui/screen/category_trips_screen.dart';
import 'package:soul_trip/features/search/ui/screen/search_filter_screen.dart';
import 'package:soul_trip/features/search/ui/screen/search_results_screen.dart';
import 'package:soul_trip/features/search/manager/search_cubit/search_cubit.dart';

import '../../features/authentication/data/authentication_repository.dart';
import '../../features/authentication/ui/forget_password/forget_password_view.dart';
import '../../features/authentication/ui/login/login_view.dart';
import '../../features/authentication/ui/signup/signup_view.dart';
import '../../features/onboarding/ui/onboarding_view.dart';
import '../../features/reviews/logic/post_review/post_review_cubit.dart';
import '../../features/reviews/logic/write_review/write_review_cubit.dart';
import '../../features/search/manager/search_cubit/search_cubit.dart';
import '../../features/search/ui/screen/search_filter_screen.dart';
import '../../features/search/ui/screen/search_results_screen.dart';
import '../../features/splash/ui/splash_view.dart';
import '../dependency_injection/set_up_dependencies.dart';
import 'animation_route.dart';
import 'app_route_guard.dart';
import 'go_router_refresh_stream.dart';

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
            pageBuilder: (context, state) {
              return fadeTransitionPage(
                MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => getIt<ReviewCubit>()),
                    BlocProvider(
                      create: (context) => getIt<WriteReviewCubit>(),
                    ),
                  ],
                  child: const ReviewsScreen(),
                ),
              );
            },
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
