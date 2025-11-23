import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/features/experts/ui/screen/experts_screen.dart';
import 'package:soul_trip/features/home/ui/screen/home_screen.dart';
import 'package:soul_trip/features/layout/ui/screen/layout_screen.dart';
import 'package:soul_trip/features/profile/ui/screen/profile_screen.dart';
import 'package:soul_trip/features/reviews/ui/screen/reviews_screen.dart';
import 'package:soul_trip/features/wishlist/ui/screen/wishlist_screen.dart';

import '../../features/authentication/data/authentication_repository.dart';
import '../../features/authentication/ui/forget_password/forget_password_view.dart';
import '../../features/authentication/ui/login/login_view.dart';
import '../../features/authentication/ui/signup/signup_view.dart';
import '../../features/onboarding/ui/onboarding_view.dart';
import '../../features/splash/ui/splash_view.dart';
import '../dependency_injection/set_up_dependencies.dart';
import 'animation_route.dart';
import 'app_route_guard.dart';
import 'go_router_refresh_stream.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.splashView,
    redirect: AppRouteGuard.guard,
    refreshListenable: GoRouterRefreshStream(
      getIt<AuthenticationRepository>().authStateChanges,
    ),
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
