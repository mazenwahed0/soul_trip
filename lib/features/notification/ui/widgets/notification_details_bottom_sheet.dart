import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:soul_trip/core/models/notification_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class NotificationDetailsBottomSheet extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onMarkAsRead;
  final VoidCallback? onDelete;

  const NotificationDetailsBottomSheet({
    super.key,
    required this.notification,
    this.onMarkAsRead,
    this.onDelete,
  });

  static void show(
    BuildContext context,
    NotificationModel notification, {
    VoidCallback? onMarkAsRead,
    VoidCallback? onDelete,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NotificationDetailsBottomSheet(
        notification: notification,
        onMarkAsRead: onMarkAsRead,
        onDelete: onDelete,
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy • hh:mm a').format(dateTime);
  }

  String _getNotificationTypeLabel(String type) {
    switch (type) {
      case 'trip_promotion':
        return 'Trip Promotion';
      case 'system':
        return 'System';
      case 'purchase':
        return 'Purchase';
      default:
        return 'Notification';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.grayLight,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            SizedBox(height: 20.h),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Notification Details',
                      style: AppTextStyles.bold20().copyWith(
                        color: colors.blackColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: colors.grayMedium,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            Divider(color: colors.grayLight.withOpacity(0.3), height: 1),

            // Content
            SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primaryYellow.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      _getNotificationTypeLabel(notification.type),
                      style: AppTextStyles.medium12().copyWith(
                        color: colors.primaryYellow,
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Title
                  Text(
                    notification.title,
                    style: AppTextStyles.bold18().copyWith(
                      color: colors.blackColor,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Timestamp
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16.sp,
                        color: colors.grayMedium,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        _formatDateTime(notification.timestamp),
                        style: AppTextStyles.regular14().copyWith(
                          color: colors.grayMedium,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Description
                  Text(
                    'Description',
                    style: AppTextStyles.semiBold16().copyWith(
                      color: colors.blackColor,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    notification.description,
                    style: AppTextStyles.regular14().copyWith(
                      color: colors.grayMedium,
                      height: 1.5,
                    ),
                  ),

                  // Image if available
                  if (notification.imageUrl != null) ...[
                    SizedBox(height: 20.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        notification.imageUrl!,
                        width: double.infinity,
                        height: 200.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 200.h,
                            color: colors.grayLight.withOpacity(0.3),
                            child: Icon(
                              Icons.image_not_supported,
                              color: colors.grayMedium,
                              size: 48.sp,
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  SizedBox(height: 24.h),

                  // Action Buttons
                  Row(
                    children: [
                      if (!notification.isRead && onMarkAsRead != null)
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              onMarkAsRead?.call();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.mark_email_read, size: 18.sp),
                            label: Text('Mark as Read'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: colors.primaryBlue,
                              side: BorderSide(color: colors.primaryBlue),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                        ),
                      if (!notification.isRead && onMarkAsRead != null)
                        SizedBox(width: 12.w),
                      if (onDelete != null)
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              onDelete?.call();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.delete_outline, size: 18.sp),
                            label: Text('Delete'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: colors.errorColor,
                              side: BorderSide(color: colors.errorColor),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
