import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/models/review_model.dart';
import '../../../../core/models/user_model/user_model.dart';
import 'fav_circle_button.dart';
import 'save_circle_button.dart';
import '../../../../../core/utils/action_items.dart';
import '../../../../../core/theme/colors.dart';

class ReviewSection extends StatelessWidget {
  final UserModel currentUser;
  final ReviewModel review;
  final VoidCallback? onLike;
  final VoidCallback? onSave;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  const ReviewSection({
    super.key,
    required this.currentUser,
    required this.review,
    this.onLike,
    this.onSave,
    this.onComment,
    this.onShare,
  });

  String getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.isNegative) return 'Just now';
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}mo ago';
    return '${(diff.inDays / 365).floor()}y ago';
  }

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    // -- Live Data Logic
    // If the review belongs to the currently logged-in user,
    // display their CURRENT name/image (from AuthCubit),
    // otherwise display the snapshot stored in the review.
    final bool isMyReview = review.userId == currentUser.id;
    final String displayName = isMyReview ? currentUser.fullName : review.name;
    final String displayImage = isMyReview
        ? currentUser.profilePicture
        : review.profileImage;

    final hasProfileImage = displayImage.isNotEmpty;
    final bool isSaved = review.savedBy.contains(currentUser.id);
    final bool isLiked = review.likedBy.contains(currentUser.id);

    return Container(
      padding: EdgeInsets.all(10.w),
      margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.grey.shade200, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colors.grayVeryLight,
                          width: 2,
                        ),
                        color: colors.grayVeryLight,
                      ),
                      child: ClipOval(
                        child: hasProfileImage
                            ? CachedNetworkImage(
                                imageUrl: displayImage,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: colors.primaryBlue,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.person,
                                  color: colors.primaryBlue,
                                ),
                              )
                            : Icon(Icons.person, color: colors.primaryBlue),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            displayName,
                            style: TextStyle(
                              color: colors.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            getTimeAgo(review.time),
                            style: TextStyle(
                              color: colors.grayMedium,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              SaveCircleButton(
                backgroundColor: colors.whiteColor,
                onTap: onSave,
                isSaved: isSaved,
              ),
            ],
          ),

          SizedBox(height: 12.h),
          Text(
            review.caption,
            style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          ),
          SizedBox(height: 12.h),

          // Image Section
          if (review.reviewImage != null && review.reviewImage!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: CachedNetworkImage(
                imageUrl: review.reviewImage!,
                height: 172.h,
                width: double.infinity,
                fit: BoxFit.cover,
                // 1. Show loader while downloading
                placeholder: (context, url) => Container(
                  height: 172.h,
                  color: colors.grayVeryLight,
                  child: Center(
                    child: CircularProgressIndicator(color: colors.primaryBlue),
                  ),
                ),
                // 2. Show Error Widget if 404 (Image Deleted)
                errorWidget: (context, url, error) => Container(
                  height: 172.h,
                  width: double.infinity,
                  color: colors.grayVeryLight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image_rounded,
                        color: colors.grayMedium,
                        size: 32.sp,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Image unavailable",
                        style: TextStyle(
                          color: colors.grayMedium,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          SizedBox(height: 12.h),

          Row(
            children: [
              FavCircleButton(
                count: review.likes,
                isFavorite: isLiked,
                onToggle: onLike,
              ),
              SizedBox(width: 18.w),
              ActionItem(
                svgPath: 'assets/icons/icon-park-solid_comment.svg',
                color: colors.primaryBlue,
                count: review.comments,
                size: 24.sp,
                onTap: onComment,
              ),

              SizedBox(width: 18.w),
              ActionItem(
                svgPath: 'assets/icons/share.svg',
                count: review.shares,
                size: 18,
                onTap: onShare,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
