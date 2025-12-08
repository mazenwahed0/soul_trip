import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/core/dependency_injection/set_up_dependencies.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/widgets/common/appbar/custom_app_bar.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_cubit.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_state.dart';
import 'package:soul_trip/features/notification/data/repositories/notification_repository.dart';
import 'package:soul_trip/features/notification/manager/notification_cubit/notification_cubit.dart';
import 'package:soul_trip/features/notification/ui/widgets/notification_list_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        // Get user ID safely
        final String userId =
            authState.userModel?.id ?? authState.user?.uid ?? '';

        if (userId.isEmpty) {
          return Scaffold(
            backgroundColor: colors.backgroundWhite,
            appBar: CustomAppBar(title: 'Notifications', showBackButton: true),
            body: const Center(
              child: Text('Please login to view notifications'),
            ),
          );
        }

        return BlocProvider(
          create: (context) =>
              NotificationCubit(getIt<NotificationRepository>(), userId)
                ..streamNotifications(),
          child: Scaffold(
            backgroundColor: colors.backgroundWhite,
            appBar: CustomAppBar(title: 'Notifications', showBackButton: true),
            body: const SafeArea(child: NotificationListWidget()),
          ),
        );
      },
    );
  }
}
