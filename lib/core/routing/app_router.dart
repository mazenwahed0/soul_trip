import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.splashView,
    routes: [
      // //Register view
      // GoRoute(
      //   path: Routes.registerView,
      //   pageBuilder: (context, state) => fadeTransitionPage(RegisterView()),
      // ),

      // GoRoute(
      //   path: Routes.loginView,
      //   pageBuilder: (context, state) {
      //     return fadeTransitionPage(LoginView());
      //   },
      // ),

      // GoRoute(
      //   path: Routes.forgotPasswordView,
      //   pageBuilder: (context, state) =>
      //       fadeTransitionPage(ForgetPasswordView()),
      // ),

      // // Shell Route with Bottom Navigation
      // ShellRoute(
      //   pageBuilder: (context, state, child) {
      //     return fadeTransitionPage(
      //       BottomNavigationWidget(
      //         location: state.uri.toString(),
      //         backgroundColor: state.uri.toString() == Routes.reelsView
      //             ? Colors.black
      //             : null,
      //         child: child,
      //       ),
      //     );
      //   },
      //   routes: [
      //     GoRoute(
      //       path: Routes.homeView,
      //       pageBuilder: (context, state) => fadeTransitionPage(HomeView()),
      //       redirect: (context, state) {
      //         // Redirect root to home
      //         if (state.uri.toString() == '/') {
      //           return Routes.homeView;
      //         }
      //         return null;
      //       },
      //     ),
      //     GoRoute(
      //       path: Routes.reelsView,
      //       pageBuilder: (context, state) => fadeTransitionPage(
      //         BlocProvider(
      //           create: (context) => getIt<VideoFeedCubit>(),
      //           child: VideoFeedView(),
      //         ),
      //       ),
      //     ),
      //     GoRoute(
      //       path: Routes.pdfView,
      //       pageBuilder: (context, state) {
      //         final pdfPath = state.extra as String?;
      //         return fadeTransitionPage(PdfView(pdfPath: pdfPath));
      //       },
      //     ),
      //     GoRoute(
      //       path: Routes.tvView,
      //       pageBuilder: (context, state) => fadeTransitionPage(TvView()),
      //     ),
      //   ],
      // ),
    ],
  );
}
