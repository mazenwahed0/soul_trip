import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/routing/app_router.dart';
import 'package:soul_trip/core/theme/app_theme.dart';
import 'package:soul_trip/features/reviews/controller/post_review_cubit.dart';
import 'core/caching/hive/user_hive_helper.dart';
import 'core/caching/shared/shared_perf_helper.dart';
import 'core/dependency_injection/set_up_dependencies.dart';
import 'core/internet_check/cubit/internet_check__cubit.dart';
import 'core/widgets/no_internet_screen.dart';
import 'features/authentication/data/authentication_repository.dart';
import 'features/authentication/logic/auth/auth_cubit.dart';
import 'features/profile/data/user/user_repository.dart';
import 'firebase_options.dart';
import 'features/reviews/controller/write_review_cubit.dart';

void main() async {
  // -- Widgets Binding: needed for async main to load widgets first before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // -- Initialize Firebase & Initialize Authentication
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // -- Initialize Hive
  await UserHiveHelper.init();

  // -- Initialize SharedPreferences
  await SharedPrefHelper.instance.init();

  // -- Setup GetIt
  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // iPhone X size as reference
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            // --- Global
            // -- Connectivity
            BlocProvider(create: (context) => ConnectivityCubit()),

            // -- Auth Provider
            BlocProvider(
              create: (context) => AuthCubit(
                getIt<AuthenticationRepository>(), // Inject AuthRepo
                getIt<UserRepository>(), // Inject UserRepo
              ),
            ),

            BlocProvider(create: (context) => ReviewCubit()), 
            BlocProvider(create: (context) => WriteReviewCubit()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: themeDataFunc(),
            routerConfig: AppRouter.router,
            builder: (context, child) {
              return BlocBuilder<ConnectivityCubit, ConnectivityState>(
                builder: (context, state) {
                  if (state is ConnectivityDisconnected) {
                    return Stack(
                      children: [
                        if (child != null) child,
                        const Positioned.fill(
                          child: Material(child: NoInternetScreen()),
                        ),
                      ],
                    );
                  }
                  return child ?? const SizedBox();
                },
              );
            },
          ),
        );
      },
    );
  }
}
