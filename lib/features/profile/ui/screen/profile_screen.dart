import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/widgets/common/appbar/custom_app_bar.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/soultrip_icons.dart';
import '../../../../core/widgets/common/status_sheet/status_bottom_sheet.dart';
import '../../../authentication/logic/auth/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        showBackButton: false,
        actions: [
          // -- Logout Button
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) => StatusBottomSheet(
                  type: SheetType.failure,
                  title: "Are you sure you want to Logout?",

                  // Secondary (Cancel)
                  secondaryButtonText: "Cancel",
                  onSecondaryPressed: () => context.pop(),

                  // Primary (Logout)
                  primaryButtonText: "Logout",
                  onPrimaryPressed: () {
                    context.pop();
                    // The AppRouter will automatically redirect to Login
                    context.read<AuthCubit>().logout();
                  },
                ),
              );
            },
            icon: Icon(
              Soultrip.logout,
              color: ColorTheme().errorColor,
              size: 24,
            ),
          ),
        ],
      ),
      body: const Center(child: Text('Profile Screen')),
    );
  }
}
