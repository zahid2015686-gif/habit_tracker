import 'dart:ui';

import 'package:habit_tracker/core/constants/enums.dart';

class NotificationModel {
  final String title;
  final String body;
  final String icon;
  final Color iconColor;
  final String timeLabel;
  final NotificationCategory category;
  final NotificationSection section;
  final bool isUnread;

  NotificationModel({
    required this.title,
    required this.body,
    required this.icon,
    required this.iconColor,
    required this.timeLabel,
    required this.category,
    required this.section,
    this.isUnread = false,
  });
}
