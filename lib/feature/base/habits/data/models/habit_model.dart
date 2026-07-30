import 'dart:ui';

import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_activity_model.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_calendar_model.dart';

class HabitModel {
  final String image;
  final Color imageColor;

  final String title;
  final String subTitle;
  final String tagline;

  final HabitDifficulty habitDifficulty;
  final HabitScheduleType scheduleType;

  /// Daily => null
  /// Weekly => [DateTime.monday, DateTime.tuesday]
  /// Custom => null
  final List<int>? weekDays;

  /// Custom schedule only
  final DateTime? customDate;

  /// Reminder
  final DateTime reminderTime;

  /// Statistics
  final int currentStreak;
  final int bestStreak;
  final int completedCount;
  final int skippedCount;
  final double completionPercentage;

  /// Light Version
  final bool hasLightVersion;
  final String? lightVersionTitle;
  final Duration? lightVersionDuration;

  bool isDone;

  final List<HabitActivityModel> activities;

  final List<HabitCalendarModel> calendar;

  HabitModel({
    required this.image,
    required this.imageColor,
    required this.title,
    required this.subTitle,
    required this.tagline,
    required this.habitDifficulty,
    required this.scheduleType,
    required this.reminderTime,

    this.weekDays,
    this.customDate,

    this.currentStreak = 0,
    this.bestStreak = 0,
    this.completedCount = 0,
    this.skippedCount = 0,
    this.completionPercentage = 0,

    this.hasLightVersion = false,
    this.lightVersionTitle,
    this.lightVersionDuration,

    this.isDone = false,

    required this.activities,
    required this.calendar,
  });
}