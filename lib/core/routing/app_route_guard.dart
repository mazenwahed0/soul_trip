import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../caching/shared/shared_perf_helper.dart';
import '../../features/authentication/data/authentication_repository.dart';
import '../dependency_injection/set_up_dependencies.dart';
import 'routes.dart';

class AppRouteGuard {
  static String? guard(BuildContext context, GoRouterState state) {
    // 1. Get Dependencies
    final authRepo = getIt<AuthenticationRepository>();

    // 2. Check Status
    final bool isLoggedIn =
        authRepo.currentUser != null && authRepo.isEmailVerified;

    final bool hasSeenOnboarding =
        SharedPrefHelper.instance.getBool('hasSeenOnboarding') ?? false;

    final String location = state.uri.toString();

    // 3. Define Routes
    final bool isSplash = location == Routes.splashView;
    final bool isOnboarding = location == Routes.onboardingView;
    final bool isLogin = location == Routes.loginView;
    final bool isRegister = location == Routes.registerView;
    final bool isForgotPassword = location == Routes.forgotPasswordView;

    // -- Scenario A: Splash
    if (isSplash) return null;

    // -- Scenario B: Onboarding
    if (!hasSeenOnboarding && !isOnboarding) {
      return Routes.onboardingView;
    }
    if (hasSeenOnboarding && isOnboarding) {
      return Routes.loginView;
    }

    // -- Scenario C: Authentication

    // If NOT logged in & trying to access protected pages (Redirected to Login)
    if (!isLoggedIn) {
      if (!isLogin && !isRegister && !isForgotPassword) {
        return Routes.loginView;
      }
    }

    // If Logged in & trying to access auth pages (Redirected to Home)
    if (isLoggedIn) {
      if (isLogin || isRegister || isForgotPassword) {
        return Routes.homeView;
      }
    }

    return null;
  }
}
