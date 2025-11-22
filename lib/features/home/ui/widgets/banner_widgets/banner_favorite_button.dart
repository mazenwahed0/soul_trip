import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';

class BannerFavoriteButton extends StatefulWidget {
  final VoidCallback? onToggle;

  const BannerFavoriteButton({super.key, this.onToggle});

  @override
  State<BannerFavoriteButton> createState() => _BannerFavoriteButtonState();
}

class _BannerFavoriteButtonState extends State<BannerFavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return GestureDetector(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
        });
        widget.onToggle?.call();
      },
      child: Container(
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: colors.whiteColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isFavorite ? Soultrip.hearts : Icons.favorite_border,
          color: isFavorite ? Colors.red : colors.grayDark,
          size: 18.sp,
        ),
      ),
    );
  }
}
