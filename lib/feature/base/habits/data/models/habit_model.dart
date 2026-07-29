import 'dart:ui';

import 'package:habit_tracker/core/constants/enums.dart';

class HabitModel {
  final String image;
  final Color imageBackground;
  final String title;
  final HabitScheduleType scheduleType;
  final DateTime reminderTime;
  bool isDone;

  HabitModel({
    required this.image,
    required this.imageBackground,
    required this.title,
    required this.scheduleType,
    required this.reminderTime,
    this.isDone = false,
  });
}