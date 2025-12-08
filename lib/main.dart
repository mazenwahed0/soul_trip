import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/routing/app_router.dart';
import 'package:soul_trip/core/theme/app_theme.dart';
import 'package:soul_trip/features/home/data/repositories/trips_likes_repository.dart';
import 'package:soul_trip/features/home/manager/trips_likes_cubit/trips_likes_cubit.dart';
import 'core/caching/hive/user_hive_helper.dart';
import 'core/caching/shared/shared_perf_helper.dart';
import 'core/dependency_injection/set_up_dependencies.dart';
import 'core/internet_check/cubit/internet_check__cubit.dart';
import 'core/utils/loading_helper.dart';
import 'core/widgets/no_internet_screen.dart';
import 'core/services/fcm_service.dart';
import 'core/caching/hive/notification_hive_helper.dart';
import 'features/authentication/data/authentication_repository.dart';
import 'features/authentication/logic/auth/auth_cubit.dart';
import 'features/notification/data/repositories/notification_repository.dart';
import 'features/profile/data/user/user_repository.dart';
import 'firebase_options.dart';

// --- Imports for Wishlist ---
import 'features/wishlist/logic/cubit/wishlist_cubit.dart';
import 'features/wishlist/data/repository/wishlist_repository.dart';

void main() async {
  // -- Widgets Binding: needed for async main to load widgets first before Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // -- Initialize Firebase & Initialize Authentication
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // -- Initialize Hive
  await UserHiveHelper.init();
  await NotificationHiveHelper.init();

  // -- Initialize SharedPreferences
  await SharedPrefHelper.instance.init();

  // -- Setup GetIt
  setupDependencies();

  // -- Initialize FCM
  await getIt<FCMService>().initialize();

  // -- Connect FCM with Notification Repository
  getIt<FCMService>().setNotificationRepository(
    getIt<NotificationRepository>(),
  );
  // -- Initialize Loading Style
  LoadingHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.subscribeToTopic('all');

    FirebaseMessaging.instance.getToken().then((token) {
      log("FCM Token: $token");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
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

            // -- Wishlist
            BlocProvider(create: (context) => getIt<WishlistCubit>()),

            // -- Trips Likes Provider
            BlocProvider(
              create: (context) {
                final String userId =
                    FirebaseAuth.instance.currentUser?.uid ?? '';
                return TripsLikesCubit(getIt<TripsLikesRepository>(), userId);
              },
            ),
          ],

          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: themeDataFunc(),
            routerConfig: AppRouter.router,
            builder: (context, child) {
              // -- Initialize EasyLoading
              final easyLoadingBuilder = EasyLoading.init();
              child = easyLoadingBuilder(context, child);
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
