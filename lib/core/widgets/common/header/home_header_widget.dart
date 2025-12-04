import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_cubit.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_state.dart';

import '../buttons/custom_circle_button.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
    this.icon = Soultrip.notification,
    this.onTap,
    this.iconColor,
    this.backGroundColor
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backGroundColor;
  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // -- Firestore User Data
        final user = state.userModel;
        final name = user?.firstName ?? 'Soul Trip';
        final image = user?.profilePicture ?? '';
        final hasImage = image.isNotEmpty;

        return SizedBox(
          // Figma: Width 343, Height 48
          width: 343.w,
          height: 48.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // MARK:- Profile Picture & Text Row
              Row(
                children: [
                  // -- Profile Picture
                  Container(
                    width: 48.w, // Figma: 48px
                    height: 48.w, // Figma: 48px
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // Figma: border-radius: 98px (Circular)
                      border: Border.all(color: colors.grayVeryLight, width: 2),
                      color: colors.grayVeryLight,
                    ),
                    child: ClipOval(
                      child: hasImage
                          ? CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator.adaptive(),
                              errorWidget: (context, url, error) => Icon(
                                Soultrip.profile,
                                color: colors.primaryBlue,
                              ),
                            )
                          : Icon(Soultrip.profile, color: colors.primaryBlue),
                    ),
                  ),

                  SizedBox(width: 12.w), // Gap
                  // -- Text Column
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, $name',
                        style: AppTextStyles.regular14().copyWith(
                          color: colors.blackColor, // #000814
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Start Your Wellness Journey',
                        style: AppTextStyles.regular12().copyWith(
                          color: colors.blackColor,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // MARK:- Trailing Button (Notification Bell or Search)
              CustomCircleButton(
                icon: icon,
                size: 44, // 44px closer to Figma than (48px)
                iconSize: 22, // 22px closer to Figma than (20px)
                backgroundColor: backGroundColor ?? colors.backgroundLightGray,
                iconColor: iconColor ?? colors.primaryBlue,
                onTap: onTap ?? () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
