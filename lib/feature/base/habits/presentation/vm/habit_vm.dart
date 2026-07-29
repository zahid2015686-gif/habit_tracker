import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_model.dart';


class HabitVm extends ChangeNotifier {
  // ---------------- Icon selection ----------------
  int selectedIconIndex = 0;

  void selectIcon(int index) {
    selectedIconIndex = index;
    notifyListeners();
  }

  // ---------------- Color selection (top row) ----------------
  int selectedColorIndex = 0;

  void selectColor(int index) {
    selectedColorIndex = index;
    notifyListeners();
  }

  // ---------------- Schedule type ----------------
  HabitScheduleType scheduleType = HabitScheduleType.daily;

  void selectSchedule(HabitScheduleType type) {
    scheduleType = type;
    notifyListeners();
  }

  // ---------------- Weekly - active days ----------------
  final List<String> weekDays = const ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
  Set<int> selectedDays = {};

  void toggleDay(int index) {
    if (selectedDays.contains(index)) {
      selectedDays.remove(index);
    } else {
      selectedDays.add(index);
    }
    notifyListeners();
  }

  // ---------------- Custom schedule ----------------
  int customRepeatDays = 2;

  void incrementCustomRepeat() {
    customRepeatDays++;
    notifyListeners();
  }

  void decrementCustomRepeat() {
    if (customRepeatDays > 1) {
      customRepeatDays--;
      notifyListeners();
    }
  }

  // ---------------- Reminder time ----------------
  TimeOfDay reminderTime = const TimeOfDay(hour: 8, minute: 0);

  Future<void> pickReminderTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: reminderTime,
    );
    if (picked != null) {
      reminderTime = picked;
      notifyListeners();
    }
  }

  String get formattedReminderTime {
    final hour = reminderTime.hour.toString().padLeft(2, '0');
    final minute = reminderTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // ---------------- Target & Duration ----------------
  int target = 5;
  int durationMinutes = 10;

  void incrementTarget() {
    target++;
    notifyListeners();
  }

  void decrementTarget() {
    if (target > 1) {
      target--;
      notifyListeners();
    }
  }

  void incrementDuration() {
    durationMinutes += 5;
    notifyListeners();
  }

  void decrementDuration() {
    if (durationMinutes > 5) {
      durationMinutes -= 5;
      notifyListeners();
    }
  }

  // ---------------- Validation ----------------
  bool get canSave {
    if (scheduleType == HabitScheduleType.weekly && selectedDays.isEmpty) {
      return false;
    }
    return true;
  }

  // ---------------- Save ----------------
  void saveHabit(BuildContext context) {
    if (!canSave) return;

    final habitData = {
      'colorIndex': selectedColorIndex,
      'iconIndex': selectedIconIndex,
      'scheduleType': scheduleType.name,
      'activeDays': (selectedDays.toList()..sort()),
      'customRepeatDays': customRepeatDays,
      'reminderTime': formattedReminderTime,
      'target': target,
      'durationMinutes': durationMinutes,
    };

    // TODO: yahan apna repository/usecase call karke habit save karein
    debugPrint('Habit saved: $habitData');

    Navigator.of(context).pop(habitData);
  }

  final List<HabitModel> _habits = [
    HabitModel(
      image: R.appImages.morningMeditation,
      imageBackground: R.appColors.oliveGreen,
      title: "Morning Meditation",
      scheduleType: HabitScheduleType.daily,
      reminderTime: DateTime(2026, 7, 29, 7, 0),
    ),
    HabitModel(
      image: R.appImages.readPages,
      imageBackground: R.appColors.softOrange,
      title: "Read 20 Pages",
      scheduleType: HabitScheduleType.daily,
      reminderTime: DateTime(2026, 7, 29, 21, 0),
    ),
    HabitModel(
      image: R.appImages.drinkWater,
      imageBackground: R.appColors.oliveGreen,
      title: "Drink 8 Glasses Water",
      scheduleType: HabitScheduleType.daily,
      reminderTime: DateTime(2026, 7, 29, 10, 0),
    ),
    HabitModel(
      image: R.appImages.eveningJournal,
      imageBackground: R.appColors.primary,
      title: "Evening Journal",
      scheduleType: HabitScheduleType.daily,
      reminderTime: DateTime(2026, 7, 29, 22, 0),
    ),
    HabitModel(
      image: R.appImages.workout,
      imageBackground: R.appColors.oliveGreen,
      title: "30-Minute Workout",
      scheduleType: HabitScheduleType.weekly,
      reminderTime: DateTime(2026, 7, 29, 6, 30),
    ),
    HabitModel(
      image: R.appImages.running,
      imageBackground: R.appColors.blue,
      title: "30-Minute Running",
      scheduleType: HabitScheduleType.daily,
      reminderTime: DateTime(2026, 7, 29, 6, 30),
    ),
    HabitModel(
      image: R.appImages.night,
      imageBackground: R.appColors.orange,
      title: "30-Minute Workout Night",
      scheduleType: HabitScheduleType.daily,
      reminderTime: DateTime(2026, 7, 29, 6, 30),
    ),
    HabitModel(
      image: R.appImages.morning,
      imageBackground: R.appColors.textGreen,
      title: "30-Minute Workout Morning",
      scheduleType: HabitScheduleType.daily,
      reminderTime: DateTime(2026, 7, 29, 6, 30),
    ),
    HabitModel(
      image: R.appImages.walk,
      imageBackground: R.appColors.textGreen,
      title: "30-Minute Workout Walk",
      scheduleType: HabitScheduleType.daily,
      reminderTime: DateTime(2026, 7, 29, 6, 30),
    ),
  ];

  List<HabitModel> get habits => _habits;

  /// Completed Habits
  int get completedHabits => _habits.where((e) => e.isDone).length;

  /// Toggle Habit
  void toggleHabit(int index) {
    _habits[index].isDone = !_habits[index].isDone;
    notifyListeners();
  }

  /// Upcoming Reminder
  List<HabitModel> get upcomingHabits {
    final now = DateTime.now();

    return _habits.where((habit) {
      final reminder = DateTime(
        now.year,
        now.month,
        now.day,
        habit.reminderTime.hour,
        habit.reminderTime.minute,
      );

      return reminder.isAfter(now) && !habit.isDone;
    }).toList();
  }
}