import 'package:habit_tracker/core/constants/enums.dart';

// TODO Schedule Type's
extension HabitScheduleTypeExtension on HabitScheduleType {
  String get title {
    switch (this) {
      case HabitScheduleType.daily:
        return "Daily";

      case HabitScheduleType.weekly:
        return "Weekly";

      case HabitScheduleType.custom:
        return "Custom";
    }
  }
}