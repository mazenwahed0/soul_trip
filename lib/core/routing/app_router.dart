import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/features/experts/data/models/Expert_model.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_cubit.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_cubit.dart';
import 'package:soul_trip/features/experts/ui/screen/details_screen.dart'
    show DetailsScreen;
import 'package:soul_trip/features/experts/ui/screen/experts_screen.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/widget_filter_experts.dart';
import 'package:soul_trip/features/home/ui/screen/home_screen.dart';
import 'package:soul_trip/features/layout/ui/screen/layout_screen.dart';
import 'package:soul_trip/features/notification/ui/notification_screen.dart';
import 'package:soul_trip/features/profile/ui/screen/account_info/account_info_screen.dart';
import 'package:soul_trip/features/profile/ui/screen/load_data/load_data_screen.dart';
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
    initialLocation: Routes.splashView,
    // redirect: AppRouteGuard.guard,
    // refreshListenable: GoRouterRefreshStream(
    //   getIt<AuthenticationRepository>().authStateChanges,
    // ),
    routes: [
      // -- Splash View
      GoRoute(
        path: Routes.splashView,
        builder: (context, state) => const SplashView(),
      ),

      // -- OnBoarding View
      GoRoute(
        path: Routes.onboardingView,
        builder: (context, state) => OnboardingView(),
      ),

      // -- Sign Up View
      GoRoute(
        path: Routes.registerView,
        pageBuilder: (context, state) =>
            slideTransitionPage(child: const SignupView(), key: state.pageKey),
      ),

      // -- Login View
      GoRoute(
        path: Routes.loginView,
        pageBuilder: (context, state) =>
            slideTransitionPage(child: const LoginView(), key: state.pageKey),
      ),

      // -- Forget Password View
      GoRoute(
        path: Routes.forgotPasswordView,
        pageBuilder: (context, state) => slideTransitionPage(
          child: const ForgetPasswordView(),
          key: state.pageKey,
        ),
      ),

      // -- Load Data View
      GoRoute(
        path: Routes.loadDataView,
        pageBuilder: (context, state) => slideTransitionPage(
          child: const LoadDataScreen(),
          key: state.pageKey,
        ),
      ),

      // -- Account Info View
      GoRoute(
        path: Routes.accountInfoView,
        pageBuilder: (context, state) => slideTransitionPage(
          child: const AccountInfoScreen(),
          key: state.pageKey,
        ),
      ),

      // -- Home View
      GoRoute(
        path: Routes.searchView,
        pageBuilder: (context, state) => slideTransitionPage(
          child: const SearchFilterScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: Routes.searchCategoryView,
        pageBuilder: (context, state) {
          final extra = state.extra;
          if (extra is SearchCubit) {
            return slideTransitionPage(
              child: BlocProvider.value(
                value: extra,
                child: const SearchResultsScreen(),
              ),
              key: state.pageKey,
            );
          }
          return slideTransitionPage(
            child: const SearchResultsScreen(),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: Routes.categoriesTripsView,
        pageBuilder: (context, state) => slideTransitionPage(
          child: const CategoriesTripsScreen(),
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: '${Routes.categoryTripsView}/:categoryName',
        pageBuilder: (context, state) {
          final categoryName = state.pathParameters['categoryName'] ?? '';
          return slideTransitionPage(
            child: CategoryTripsScreen(categoryName: categoryName),
            key: state.pageKey,
          );
        },
      ),
      // -- Notifications Screen
      GoRoute(
        path: Routes.notificationView,
        pageBuilder: (context, state) => slideTransitionPage(
          child: const NotificationScreen(),
          key: state.pageKey,
        ),
      ),

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
