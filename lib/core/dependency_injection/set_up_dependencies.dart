import 'package:get_it/get_it.dart';

import '../../features/authentication/data/authentication_repository.dart';
import '../../features/authentication/logic/forget_password/forget_password_cubit.dart';
import '../../features/authentication/logic/login/login_cubit.dart';
import '../../features/authentication/logic/signup/signup_cubit.dart';
import '../../features/authentication/logic/social_auth/social_auth_cubit.dart';
import '../../features/onboarding/data/onboarding_repository.dart';
import '../../features/onboarding/logic/onboarding_cubit.dart';
import '../../features/profile/data/data_upload/data_upload_repository.dart';
import '../../features/profile/data/user/user_repository.dart';
import '../../features/profile/logic/data_upload/data_upload_cubit.dart';
import '../../features/profile/logic/user/user_cubit.dart';
import '../caching/hive/user_hive_helper.dart';
import '../repositories/storage/cloudinary_service.dart';

final getIt = GetIt.instance;

void setupDependencies() async {
  // getIt.registerSingleton<DioHelper>(DioHelper());

  /// 1. (Singletons)
  /// "registerLazySingleton" = Create it ONCE and keep it alive forever.
  // -- Core / Helpers
  getIt.registerLazySingleton<UserHiveHelper>(() => UserHiveHelper());

  /// Note: (ConnectivityCubit) Hashed to avoid Dual-Injection
  // getIt.registerFactory<ConnectivityCubit>(() => ConnectivityCubit());

  // -- Repositories
  // - Cloudinary (Storage)
  getIt.registerLazySingleton<CloudinaryService>(() => CloudinaryService());
  // - Authentication Repository
  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepository(),
  );
  // - User Repository
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  // - OnBoarding
  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepository(),
  );

  /// 2. (Factories)
  /// "registerFactory" = so a new Cubit is created every time a screen opens
  /// (Good for Screens like (Login/SignUp) which are destroyed when closed)
  // -- Logic/State (Cubits)

  // - Login
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<AuthenticationRepository>()),
  );
  // - Sign Up
  getIt.registerFactory<SignupCubit>(
    () =>
        SignupCubit(getIt<AuthenticationRepository>(), getIt<UserRepository>()),
  );
  // - Google Login/SignUp
  getIt.registerFactory<SocialAuthCubit>(
    () => SocialAuthCubit(getIt<AuthenticationRepository>()),
  );
  // - Forget Password
  getIt.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(getIt<AuthenticationRepository>()),
  );
  // - User
  getIt.registerFactory<UserCubit>(
    () => UserCubit(getIt<UserRepository>(), getIt<CloudinaryService>()),
  );
  // - OnBoarding
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<OnboardingRepository>()),
  );
  // - Data Upload
  getIt.registerLazySingleton<DataUploadRepository>(
    () => DataUploadRepository(getIt<CloudinaryService>()),
  );
  getIt.registerFactory<DataUploadCubit>(
    () => DataUploadCubit(getIt<DataUploadRepository>()),
  );
}
