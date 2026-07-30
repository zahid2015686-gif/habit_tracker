import 'package:habit_tracker/core/constants/enums.dart';

class HabitActivityModel {
  final HabitActivityStatus status;

  final DateTime date;

  final String title;
  final String note;

  HabitActivityModel({
    required this.status,
    required this.date,
    required this.title,
    required this.note,
  });
}