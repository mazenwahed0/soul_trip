import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icon_pack/solar_bold_icons.dart';
import 'package:soul_trip/core/utils/images.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/utils/snackbars/loaders.dart';
import '../../../../../../core/widgets/common/shimmers/shimmer.dart';
import '../../../../../../core/utils/loading_helper.dart';
import '../../../../../authentication/logic/auth/auth_cubit.dart';
import '../../../../../authentication/logic/auth/auth_state.dart';
import '../../../../logic/user/user_cubit.dart';
import '../../../../logic/user/user_state.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // -- Loading Block UI
        if (state is UserLoading) {
          LoadingHelper.show(message: "Uploading...");
        } else {
          // Dismiss on Success or Failure
          LoadingHelper.dismiss();
        }

        // -- Snackbars on Success/Error
        if (state is UserSuccess) {
          Loaders.success(context, title: "Success", message: state.message);

          // Refresh the AuthCubit to get the new image URL
          context.read<AuthCubit>().refreshUserData();
        } else if (state is UserFailure) {
          Loaders.error(context, title: "Error", message: state.message);
        }
      },
      builder: (context, state) {
        return Center(
          child: SizedBox(
            width: 140.w,
            height: 140.w,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. The Image (or Shimmer)
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authState) {
                    final imagePath = authState.userModel?.profilePicture ?? '';
                    final hasImage = imagePath.isNotEmpty;

                    return Container(
                      width: 140.w,
                      height: 140.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          98,
                        ), // borderRadius: 98px
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(98),
                        child: hasImage
                            ? CachedNetworkImage(
                                imageUrl: imagePath,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => CShimmerEffect(
                                  width: 140.w,
                                  height: 140.w,
                                  radius: 98,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                      Images.logo,
                                      fit: BoxFit.contain,
                                    ),
                              )
                            : Container(
                                color: ColorTheme().grayVeryLight,
                                padding: const EdgeInsets.all(30),
                                child: Image.asset(
                                  Images.logo,
                                  color: ColorTheme().grayMedium.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ),
                      ),
                    );
                  },
                ),

                // 2. The Camera Icon (Bottom Right)
                Positioned(
                  bottom: 5, // Adjusted "inside" or on edge
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      final authState = context.read<AuthCubit>().state;
                      if (authState.userModel != null) {
                        context.read<UserCubit>().uploadUserProfilePicture(
                          authState.userModel!,
                        );
                      }
                    },
                    child: Container(
                      width: 30.w,
                      height: 30.w,
                      padding: const EdgeInsets.all(3), // Padding: 3px
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBEBEB), // Background: #EBEBEB
                        borderRadius: BorderRadius.circular(15), // Radius: 15px
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        SolarBoldIcons.camera,
                        color: ColorTheme().navyBlue,
                        size: 20.sp, // Scaled to fit inside 30px box
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
