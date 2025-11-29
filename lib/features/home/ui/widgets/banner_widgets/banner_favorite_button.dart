import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import '../../../manager/banner_likes_cubit/banner_likes_cubit.dart';
import '../../../manager/banner_likes_cubit/banner_likes_state.dart';
import '../../../../../features/authentication/logic/auth/auth_cubit.dart';
import '../../../../../features/authentication/logic/auth/auth_state.dart';

class BannerFavoriteButton extends StatelessWidget {
  final String bannerId;
  final VoidCallback? onToggle;

  const BannerFavoriteButton({
    super.key,
    required this.bannerId,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocBuilder<BannerLikesCubit, BannerLikesState>(
      buildWhen: (previous, current) {
        if (current is BannerLikesLoaded && previous is BannerLikesLoaded) {
          return previous.likedBanners[bannerId] !=
              current.likedBanners[bannerId];
        }
        return true;
      },
      builder: (context, state) {
        bool isFavorite = false;
        if (state is BannerLikesLoaded) {
          isFavorite = state.likedBanners[bannerId] ?? false;
        } else {
          // Fallback to cubit's current state if not loaded (e.g. initial)
          isFavorite = context.read<BannerLikesCubit>().isBannerLiked(bannerId);
        }

        return GestureDetector(
          onTap: () {
            // Check if user is authenticated before allowing like
            final authCubit = context.read<AuthCubit>();
            if (authCubit.state.status == AuthStatus.authenticated) {
              context.read<BannerLikesCubit>().toggleLike(bannerId);
              onToggle?.call();
            } else {
              // Show message or navigate to login
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please login to like banners'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: colors.whiteColor,
              shape: BoxShape.circle,
            ),
            child: state is BannerLikesLoading
                ? SizedBox(
                    width: 18.sp,
                    height: 18.sp,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.primaryBlue,
                    ),
                  )
                : Icon(
                    isFavorite ? Soultrip.hearts : Icons.favorite_border,
                    color: isFavorite ? Colors.red : colors.grayDark,
                    size: 18.sp,
                  ),
          ),
        );
      },
    );
  }
}
