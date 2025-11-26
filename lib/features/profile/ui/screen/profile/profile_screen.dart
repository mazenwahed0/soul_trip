import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icon_pack/solar_bold_icons.dart';

import '../../../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/soultrip_icons.dart';
import '../../../../../core/theme/text_style.dart';
import '../../../../../core/widgets/common/appbar/custom_app_bar.dart';
import '../../../../authentication/logic/auth/auth_cubit.dart';
import '../../../../authentication/logic/auth/auth_state.dart';
import '../../../logic/user/user_cubit.dart';
import 'widgets/logout_status_sheet.dart';
import 'widgets/profile_image_section.dart';
import 'widgets/profile_menu_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserCubit>(),
      child: Scaffold(
        backgroundColor: ColorTheme().whiteColor,
        appBar: CustomAppBar(
          title: 'Profile',
          showBackButton: false,
          actions: [
            // -- Database/Upload button (Developers Feature)
            IconButton(
              onPressed: () => context.push(Routes.loadDataView),
              icon: Icon(
                SolarBoldIcons.database,
                color: ColorTheme().grayDark,
                size: 24,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              // -- Profile Picture Section
              const ProfileImageSection(),

              SizedBox(height: 8.h),

              // -- User Name
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final user = state.userModel;
                  return Text(
                    user?.fullName ?? 'User Name',
                    style: AppTextStyles.semiBold20().copyWith(
                      color: ColorTheme().navyBlue,
                    ),
                  );
                },
              ),

              // Spacing before list
              SizedBox(height: 24.h),

              Column(
                spacing: 12.h,
                children: [
                  // -- Settings List
                  // 1. Account Info
                  ProfileMenuTile(
                    title: "Account Info",
                    icon: Soultrip.settings,
                    onTap: () => context.push(Routes.accountInfoView),
                  ),

                  // 2. Payment Methods
                  ProfileMenuTile(
                    title: "Payment Methods",
                    icon: Soultrip.payment,
                    onTap: () {},
                  ),

                  // 3. Reviews
                  ProfileMenuTile(
                    title: "Reviews",
                    icon: CupertinoIcons.ellipses_bubble_fill,
                    onTap: () => context.push(Routes.reviewsView),
                  ),

                  // 4. Travel Preferences
                  ProfileMenuTile(
                    title: "Travel Preferences",
                    icon: Soultrip.plane,
                    onTap: () {},
                  ),

                  // 5. Notifications
                  ProfileMenuTile(
                    title: "Notifications",
                    icon: Soultrip.notification,
                    onTap: () {},
                  ),

                  // 6. Customer Support
                  ProfileMenuTile(
                    title: "Customer support",
                    icon: Soultrip.customersupport,
                    onTap: () {},
                  ),

                  // 7. Log Out (No Border)
                  ProfileMenuTile(
                    title: "Log Out",
                    icon: Soultrip.logout,
                    isLogout: true,
                    showBorder: false,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => LogoutStatusSheet(
                          title: "Are you sure you want to Logout?",
                          primaryButtonText: "Logout",
                          onPrimaryPressed: () {
                            context.pop();
                            context.read<AuthCubit>().logout();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
