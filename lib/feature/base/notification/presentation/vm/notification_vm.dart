import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/notification/data/models/notification_model.dart';

class NotificationVm extends ChangeNotifier {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      title: 'Read 20 Pages',
      body:
          'Time to get your reading in! You are on an 8-day streak — keep it going.',
      icon: R.appImages.readPages,
      iconColor: R.appColors.orange,
      timeLabel: 'Just now',
      category: NotificationCategory.habitReminder,
      section: NotificationSection.today,
      isUnread: true,
    ),
    NotificationModel(
      title: 'Evening Journal',
      body: 'Your evening reflection is waiting. How did today feel?',
      icon: R.appImages.eveningJournal,
      iconColor: R.appColors.violet,
      timeLabel: '4h ago',
      category: NotificationCategory.habitReminder,
      section: NotificationSection.today,
      isUnread: true,
    ),
    NotificationModel(
      title: 'Coach Sarah sent you a message',
      body: '"Your morning meditation streak is impressive! Let\'s talk about…"',
      icon: R.appImages.message,
      iconColor: R.appColors.seaGreen,
      timeLabel: '6h ago',
      category: NotificationCategory.coachMessage,
      section: NotificationSection.today,
      isUnread: true,
    ),
    NotificationModel(
      title: 'Your weekly review is ready',
      body: 'Coach Sarah has prepared insights on your rhythm this week.',
      icon: R.appImages.reminderTime,
      iconColor: R.appColors.blue,
      timeLabel: '19h ago',
      category: NotificationCategory.coachReminder,
      section: NotificationSection.today,
      isUnread: true,
    ),
    NotificationModel(
      title: 'Morning Meditation',
      body: 'Start the day with 10 minutes of mindfulness. Your streak: 12 days.',
      icon: R.appImages.morningMeditation,
      iconColor: R.appColors.indigo,
      timeLabel: 'Yesterday',
      category: NotificationCategory.habitReminder,
      section: NotificationSection.yesterday,
    ),
    NotificationModel(
      title: 'Drink 8 Glasses Water',
      body: 'Stay hydrated! You\'ve completed 5 of 8 glasses so far today.',
      icon: R.appImages.drinkWater,
      iconColor: R.appColors.textLightGreen,
      timeLabel: 'Yesterday',
      category: NotificationCategory.habitReminder,
      section: NotificationSection.yesterday,
    ),
    NotificationModel(
      title: '30-Minute Workout',
      body: 'Time for your workout! Movement is the best medicine.',
      icon: R.appImages.workout,
      iconColor: R.appColors.errorRed,
      timeLabel: 'Yesterday',
      category: NotificationCategory.habitReminder,
      section: NotificationSection.yesterday,
    ),
  ];

  List<NotificationModel> get notifications => _notifications;

  List<NotificationModel> get todayNotifications => _notifications
      .where((n) => n.section == NotificationSection.today)
      .toList();

  List<NotificationModel> get yesterdayNotifications => _notifications
      .where((n) => n.section == NotificationSection.yesterday)
      .toList();
}
