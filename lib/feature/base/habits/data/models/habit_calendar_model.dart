import 'package:habit_tracker/core/constants/enums.dart';

class HabitCalendarModel {
  final DateTime date;
  final HabitDayStatus status;

  HabitCalendarModel({
    required this.date,
    required this.status,
  });
}