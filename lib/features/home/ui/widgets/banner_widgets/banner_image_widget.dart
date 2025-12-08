import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/utils/images.dart';

class BannerImageWidget extends StatelessWidget {
  final String? imageUrl;

  const BannerImageWidget({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    // If no URL is provided or URL is empty, show default asset image
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildDefaultImage();
    }

    // If URL starts with 'http', it's a network image
    if (imageUrl!.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildLoadingPlaceholder(colors),
        errorWidget: (context, url, error) => _buildDefaultImage(),
      );
    }

    // Otherwise, treat it as an asset image path
    return _buildAssetImage(imageUrl!);
  }

  Widget _buildDefaultImage() {
    return Image.asset(
      Images.banner1,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildErrorPlaceholder();
      },
    );
  }

  Widget _buildAssetImage(String path) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildDefaultImage();
      },
    );
  }

  Widget _buildLoadingPlaceholder(ColorTheme colors) {
    return Container(
      color: colors.grayVeryLight,
      child: Center(
        child: CircularProgressIndicator(color: colors.primaryBlue),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    final colors = ColorTheme();
    return Container(
      color: colors.grayVeryLight,
      child: Icon(
        Icons.image_not_supported,
        color: colors.grayMedium,
        size: 48.sp,
      ),
    );
  }
}
