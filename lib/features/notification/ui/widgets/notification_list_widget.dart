import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/core/models/notification_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/widgets/error_state_widget.dart';
import 'package:soul_trip/features/notification/manager/notification_cubit/notification_cubit.dart';
import 'package:soul_trip/features/notification/manager/notification_cubit/notification_state.dart';
import 'package:soul_trip/features/notification/ui/widgets/notification_item_widget.dart';
import 'package:soul_trip/features/notification/ui/widgets/notification_section_header_widget.dart';
import 'package:soul_trip/features/notification/ui/widgets/notification_details_bottom_sheet.dart';

class NotificationListWidget extends StatelessWidget {
  const NotificationListWidget({super.key});

  Map<String, List<NotificationModel>> _groupNotificationsByDate(
    List<NotificationModel> notifications,
  ) {
    final Map<String, List<NotificationModel>> grouped = {
      'Today': [],
      'Yesterday': [],
    };

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (var notification in notifications) {
      final notificationDate = DateTime(
        notification.timestamp.year,
        notification.timestamp.month,
        notification.timestamp.day,
      );

      if (notificationDate == today) {
        grouped['Today']!.add(notification);
      } else if (notificationDate == yesterday) {
        grouped['Yesterday']!.add(notification);
      } else {
        final key = _formatDate(notification.timestamp);
        if (!grouped.containsKey(key)) {
          grouped[key] = [];
        }
        grouped[key]!.add(notification);
      }
    }

    // Remove empty sections
    grouped.removeWhere((key, value) => value.isEmpty);

    return grouped;
  }

  String _formatDate(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${date.day} ${months[date.month - 1]}';
  }

  void _showNotificationMenu(
    BuildContext context,
    NotificationModel notification,
  ) {
    final colors = ColorTheme();

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.backgroundWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!notification.isRead)
              ListTile(
                leading: Icon(Icons.mark_email_read, color: colors.primaryBlue),
                title: const Text('Mark as read'),
                onTap: () {
                  context.read<NotificationCubit>().markAsRead(notification.id);
                  Navigator.pop(bottomSheetContext);
                },
              ),
            ListTile(
              leading: Icon(Icons.delete, color: colors.errorColor),
              title: const Text('Delete'),
              onTap: () {
                context.read<NotificationCubit>().deleteNotification(
                  notification.id,
                );
                Navigator.pop(bottomSheetContext);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoading) {
          return Center(
            child: CircularProgressIndicator(color: colors.primaryBlue),
          );
        }

        if (state is NotificationError) {
          return ErrorStateWidget(
            message: state.message,
            onRetry: () {
              context.read<NotificationCubit>().streamNotifications();
            },
          );
        }

        if (state is NotificationLoaded) {
          final notifications = state.notifications;

          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 80,
                    color: colors.grayMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: colors.grayMedium,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          final groupedNotifications = _groupNotificationsByDate(notifications);

          return ListView.builder(
            itemCount: groupedNotifications.length * 2,
            itemBuilder: (context, index) {
              if (index.isEven) {
                // Section header
                final sectionIndex = index ~/ 2;
                final sectionKey = groupedNotifications.keys.elementAt(
                  sectionIndex,
                );
                return NotificationSectionHeaderWidget(title: sectionKey);
              } else {
                // Notification items
                final sectionIndex = index ~/ 2;
                final sectionKey = groupedNotifications.keys.elementAt(
                  sectionIndex,
                );
                final sectionNotifications = groupedNotifications[sectionKey]!;

                return Column(
                  children: sectionNotifications.map((notification) {
                    return NotificationItemWidget(
                      notification: notification,
                      onTap: () {
                        // Show notification details in bottom sheet
                        NotificationDetailsBottomSheet.show(
                          context,
                          notification,
                          onMarkAsRead: !notification.isRead
                              ? () {
                                  context.read<NotificationCubit>().markAsRead(
                                    notification.id,
                                  );
                                }
                              : null,
                          onDelete: () {
                            context
                                .read<NotificationCubit>()
                                .deleteNotification(notification.id);
                          },
                        );

                        // Mark as read when viewed
                        if (!notification.isRead) {
                          context.read<NotificationCubit>().markAsRead(
                            notification.id,
                          );
                        }
                      },
                      onMenuTap: () {
                        _showNotificationMenu(context, notification);
                      },
                    );
                  }).toList(),
                );
              }
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
