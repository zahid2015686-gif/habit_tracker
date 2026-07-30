import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_activity_model.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_calendar_model.dart';
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
      imageColor: const Color(0xFFEAE9FF),
      title: "Morning Meditation",
      subTitle: "Start the day with 10 minutes of mindfulness",
      tagline: "Mindfulness",

      habitDifficulty: HabitDifficulty.light,
      scheduleType: HabitScheduleType.daily,

      reminderTime: DateTime(2026, 7, 1, 7, 0),

      currentStreak: 12,
      bestStreak: 12,
      completedCount: 18,
      skippedCount: 2,
      completionPercentage: 90,

      hasLightVersion: true,
      lightVersionTitle: "Read 1 Page",
      lightVersionDuration: const Duration(minutes: 2),

      activities: [
        HabitActivityModel(
          status: HabitActivityStatus.completed,
          date: DateTime(2026, 7, 20),
          title: "Completed",
          note: "Felt really calm today",
        ),
        HabitActivityModel(
          status: HabitActivityStatus.completed,
          date: DateTime(2026, 7, 18),
          title: "Completed",
          note: "Morning session was great",
        ),
        HabitActivityModel(
          status: HabitActivityStatus.skipped,
          date: DateTime(2026, 7, 13),
          title: "Skipped",
          note: "Overslept, will do tomorrow",
        ),
      ],

      calendar: [
        HabitCalendarModel(
          date: DateTime(2026, 7, 1),
          status: HabitDayStatus.completed,
        ),
        HabitCalendarModel(
          date: DateTime(2026, 7, 2),
          status: HabitDayStatus.completed,
        ),
        HabitCalendarModel(
          date: DateTime(2026, 7, 7),
          status: HabitDayStatus.skipped,
        ),
        HabitCalendarModel(
          date: DateTime(2026, 7, 27),
          status: HabitDayStatus.completed,
        ),
      ],
    ),

    HabitModel(
      image: R.appImages.readPages,
      imageColor: const Color(0xFFFFF3E6),
      title: "Read 20 Pages",
      subTitle: "Improve your reading habit",
      tagline: "Reading",

      habitDifficulty: HabitDifficulty.medium,
      scheduleType: HabitScheduleType.daily,

      reminderTime: DateTime(2026, 7, 1, 21, 0),

      currentStreak: 8,
      bestStreak: 15,
      completedCount: 25,
      skippedCount: 3,
      completionPercentage: 88,

      activities: [],
      calendar: [],
    ),

    HabitModel(
      image: R.appImages.drinkWater,
      imageColor: const Color(0xFFE9FBF0),
      title: "Drink 8 Glasses Water",
      subTitle: "Stay hydrated every day",
      tagline: "Health",

      habitDifficulty: HabitDifficulty.light,
      scheduleType: HabitScheduleType.daily,

      reminderTime: DateTime(2026, 7, 1, 10, 0),

      currentStreak: 21,
      bestStreak: 30,
      completedCount: 40,
      skippedCount: 1,
      completionPercentage: 98,

      activities: [
        HabitActivityModel(
          status: HabitActivityStatus.completed,
          date: DateTime(2026, 7, 19),
          title: "Completed",
          note: "Reached 8 glasses",
        ),
      ],

      calendar: [
        HabitCalendarModel(
          date: DateTime(2026, 7, 3),
          status: HabitDayStatus.completed,
        ),
        HabitCalendarModel(
          date: DateTime(2026, 7, 8),
          status: HabitDayStatus.skipped,
        ),
      ],
    ),

    HabitModel(
      image: R.appImages.eveningJournal,
      imageColor: const Color(0xFFF2E9FF),
      title: "Evening Journal",
      subTitle: "Reflect on your day",
      tagline: "Journaling",

      habitDifficulty: HabitDifficulty.light,
      scheduleType: HabitScheduleType.custom,

      customDate: DateTime(2026, 6, 12),

      reminderTime: DateTime(2026, 6, 12, 22, 0),

      hasLightVersion: true,
      lightVersionTitle: "Write 3 Lines",
      lightVersionDuration: const Duration(minutes: 3),

      currentStreak: 5,
      bestStreak: 11,
      completedCount: 12,
      skippedCount: 4,
      completionPercentage: 75,

      activities: [
        HabitActivityModel(
          status: HabitActivityStatus.completed,
          date: DateTime(2026, 7, 19),
          title: "Completed",
          note: "Reached 8 glasses",
        ),
      ],

      calendar: [
        HabitCalendarModel(
          date: DateTime(2026, 7, 3),
          status: HabitDayStatus.completed,
        ),
        HabitCalendarModel(
          date: DateTime(2026, 7, 8),
          status: HabitDayStatus.skipped,
        ),
      ],
    ),

    HabitModel(
      image: R.appImages.workout,
      imageColor: const Color(0xFFFFEEEE),
      title: "30-Minute Workout",
      subTitle: "Build strength and endurance",
      tagline: "Fitness",

      habitDifficulty: HabitDifficulty.hard,
      scheduleType: HabitScheduleType.weekly,

      weekDays: [
        DateTime.monday,
        DateTime.tuesday,
        DateTime.wednesday,
      ],

      reminderTime: DateTime(2026, 7, 1, 6, 30),

      currentStreak: 6,
      bestStreak: 20,
      completedCount: 14,
      skippedCount: 5,
      completionPercentage: 73,

      activities: [
        HabitActivityModel(
          status: HabitActivityStatus.completed,
          date: DateTime(2026, 7, 19),
          title: "Completed",
          note: "Reached 8 glasses",
        ),
      ],

      calendar: [
        HabitCalendarModel(
          date: DateTime(2026, 7, 3),
          status: HabitDayStatus.completed,
        ),
        HabitCalendarModel(
          date: DateTime(2026, 7, 8),
          status: HabitDayStatus.skipped,
        ),
      ],
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