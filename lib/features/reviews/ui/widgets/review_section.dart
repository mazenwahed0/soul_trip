import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/post_review_state.dart';
import 'fav_circle_button.dart';
import 'save_circle_button.dart';
import '../../../../../core/utils/action_items.dart';
import '../../../../../core/theme/colors.dart';

class ReviewSection extends StatelessWidget {
  final String currentUserId;
  final Review review;
  final VoidCallback? onLike;
  final VoidCallback? onSave;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  const ReviewSection({
    super.key,
    required this.currentUserId,
    required this.review,
    this.onLike,
    this.onSave,
    this.onComment,
    this.onShare,
  });

  String getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
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
    final hasProfileImage = review.profileImage.isNotEmpty;
    final bool isSaved = review.savedBy.contains(currentUserId);
    final bool isLiked = review.likedBy.contains(currentUserId);

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
              Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.grayVeryLight, width: 2),
                      color: colors.grayVeryLight,
                    ),
                    child: ClipOval(
                      child: hasProfileImage
                          ? Image.network(
                              review.profileImage,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.person, color: colors.primaryBlue),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        review.name,
                        style: TextStyle(
                          color: colors.blackColor,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        getTimeAgo(review.time),
                        style: TextStyle(
                          color: colors.blackColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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

          if (review.reviewImage != null && review.reviewImage!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(
                review.reviewImage!,
                height: 172.h,
                width: double.infinity,
                fit: BoxFit.cover,
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
                iconData: CupertinoIcons.ellipses_bubble_fill,
                color: colors.primaryBlue,
                count: review.comments,
                size: 18,
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
