import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:soul_trip/core/theme/colors.dart';

// كاش مانجر مخصص
class CustomCacheManager extends CacheManager {
  static const key = "customCache";
  static final CustomCacheManager _instance = CustomCacheManager._internal();

  factory CustomCacheManager() {
    return _instance;
  }

  CustomCacheManager._internal()
    : super(
        Config(key, stalePeriod: Duration(days: 7), maxNrOfCacheObjects: 300),
      );
}

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    super.key,
    required this.imageUrl,
    this.height = 140,
    this.width = double.infinity,
    this.changeBorderRadius = false,
  });

  final String imageUrl;
  final double height;
  final double width;
  final bool changeBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: changeBorderRadius
            ? BorderRadius.zero
            : BorderRadius.circular(10),
        border: changeBorderRadius
            ? null
            : Border.all(
                color: ColorTheme().grayMedium.withValues(alpha: 0.3),
                width: 2,
              ),
      ),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.only(
          topLeft: changeBorderRadius ? Radius.zero : Radius.circular(8),
          topRight: changeBorderRadius ? Radius.zero : Radius.circular(8),
          bottomLeft: changeBorderRadius ? Radius.zero : Radius.circular(8),
          bottomRight: changeBorderRadius ? Radius.zero : Radius.circular(8),
        ),
        child: CachedNetworkImage(
          cacheManager: CustomCacheManager(),
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 300),
          placeholder: (context, url) => Container(
            height: height,
            color: ColorTheme().primaryBlue.withValues(alpha: 0.1),
            child: Center(
              child: CircularProgressIndicator(
                color: ColorTheme().primaryBlue,
                strokeWidth: 2,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: height,
            color: ColorTheme().primaryBlue.withValues(alpha: 0.1),
            child: Center(
              child: Icon(
                Icons.image_not_supported,
                size: 40,
                color: ColorTheme().primaryBlue.withValues(alpha: 0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
