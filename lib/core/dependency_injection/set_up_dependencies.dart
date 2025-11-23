import 'package:get_it/get_it.dart';

import '../../features/authentication/data/authentication_repository.dart';
import '../../features/authentication/logic/login/login_cubit.dart';
import '../../features/authentication/logic/signup/signup_cubit.dart';
import '../../features/authentication/logic/social_auth/social_auth_cubit.dart';
import '../../features/profile/data/user_repository.dart';
import '../../features/profile/logic/user_cubit.dart';
import '../caching/hive/user_hive_helper.dart';
import '../internet_check/cubit/internet_check__cubit.dart';
import '../repositories/storage/cloudinary_service.dart';

final getIt = GetIt.instance;

/// Note: (Factory) so a new Cubit is created every time a screen opens
/// (Good for Screens like (Login/SignUp) which are destroyed when closed)
void setupDependencies() async {
  // getIt.registerSingleton<DioHelper>(DioHelper());

  // -- Core / Helpers
  getIt.registerLazySingleton<UserHiveHelper>(() => UserHiveHelper());
  getIt.registerFactory<ConnectivityCubit>(() => ConnectivityCubit());

  // -- Repositories
  getIt.registerLazySingleton<CloudinaryService>(() => CloudinaryService());
  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepository(),
  );
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());

  // -- Cubits
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<AuthenticationRepository>()),
  );

  getIt.registerFactory<SignupCubit>(
    () =>
        SignupCubit(getIt<AuthenticationRepository>(), getIt<UserRepository>()),
  );

  getIt.registerFactory<SocialAuthCubit>(
    () => SocialAuthCubit(
      getIt<AuthenticationRepository>(),
      getIt<UserRepository>(),
    ),
  );
  getIt.registerFactory<UserCubit>(
    () => UserCubit(getIt<UserRepository>(), getIt<CloudinaryService>()),
  );
}
