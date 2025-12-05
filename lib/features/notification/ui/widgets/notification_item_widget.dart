import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/models/notification_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onMenuTap;

  const NotificationItemWidget({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onMenuTap,
  });

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) return '1 day ago';
      if (difference.inDays < 30) return '${difference.inDays} days ago';
      if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return months == 1 ? '1 month ago' : '$months months ago';
      }
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours}h';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    }
    return 'Just now';
  }

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: notification.isRead
              ? Colors.transparent
              : colors.primaryYellow.withOpacity(0.05),
          border: Border(
            bottom: BorderSide(
              color: colors.grayLight.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bullet point
            Container(
              margin: EdgeInsets.only(top: 4.h, right: 12.w),
              width: 6.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: colors.blackColor,
                shape: BoxShape.circle,
              ),
            ),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    notification.title,
                    style: AppTextStyles.semiBold16().copyWith(
                      color: colors.blackColor,
                      fontWeight: notification.isRead
                          ? FontWeight.w500
                          : FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Description
                  Text(
                    notification.description,
                    style: AppTextStyles.regular14().copyWith(
                      color: colors.grayMedium,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),

            // Time and Menu
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Time
                Text(
                  _getTimeAgo(notification.timestamp),
                  style: AppTextStyles.medium12().copyWith(
                    color: colors.primaryYellow,
                  ),
                ),

                SizedBox(height: 8.h),

                // Menu Icon
                InkWell(
                  onTap: onMenuTap,
                  child: Icon(
                    Icons.more_horiz,
                    color: colors.blackColor,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
