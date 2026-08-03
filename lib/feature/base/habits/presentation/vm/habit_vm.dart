import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_activity_model.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_calendar_model.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_model.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_template_model.dart';


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

  void loadFromTemplate(HabitTemplateModel template) {
    scheduleType = HabitScheduleType.daily;
    selectedDays = {};
    customRepeatDays = 2;
    reminderTime = const TimeOfDay(hour: 8, minute: 0);
    target = 3;
    durationMinutes = _parseDurationMinutes(template.duration);
    notifyListeners();
  }

  int _parseDurationMinutes(String duration) {
    final match = RegExp(r'(\d+)\s*m').firstMatch(duration.toLowerCase());
    if (match != null) {
      return int.tryParse(match.group(1)!) ?? 5;
    }
    final digits = RegExp(r'(\d+)').firstMatch(duration);
    if (digits != null) {
      final value = int.tryParse(digits.group(1)!) ?? 5;
      if (duration.toLowerCase().contains('x') || value > 120) {
        return 5;
      }
      return value;
    }
    return 5;
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
      imageColor: R.appColors.indigo,
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
      imageColor: R.appColors.orange,
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
      imageColor: R.appColors.textLightGreen,
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
      imageColor: R.appColors.violet,
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
      imageColor: R.appColors.errorRed,
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

  // ---------------- Discover Habits ----------------
  HabitDiscoverCategory selectedDiscoverCategory = HabitDiscoverCategory.all;
  String discoverSearchQuery = '';

  void selectDiscoverCategory(HabitDiscoverCategory category) {
    selectedDiscoverCategory = category;
    notifyListeners();
  }

  void updateDiscoverSearch(String query) {
    discoverSearchQuery = query;
    notifyListeners();
  }

  final List<HabitTemplateModel> templates = [
    HabitTemplateModel(
      image: R.appImages.eveningJournal,
      imageColor: R.appColors.violet,
      title: "Morning Gratitude",
      duration: "Daily · 5m",
    ),
    HabitTemplateModel(
      image: R.appImages.morningMeditation,
      imageColor: R.appColors.violet,
      title: "5-Minute Meditation",
      duration: "Daily · 5m",
    ),
    HabitTemplateModel(
      image: R.appImages.drinkWater,
      imageColor: R.appColors.violet,
      title: "Drink 8 Glasses Water",
      duration: "Daily · 10m",
    ),
    HabitTemplateModel(
      image: R.appImages.readPages,
      imageColor: R.appColors.violet,
      title: "Read 20 Pages",
      duration: "Daily · 20m",
    ),
    HabitTemplateModel(
      image: R.appImages.eveningJournal,
      imageColor: R.appColors.violet,
      title: "Evening Journal",
      duration: "Daily · 10m",
    ),
    HabitTemplateModel(
      image: R.appImages.workout,
      imageColor: R.appColors.violet,
      title: "30-Minute Workout",
      duration: "Mon · Tue · Wed",
    ),
  ];

  final List<HabitTemplateModel> discoverHabits = [
    // Popular
    HabitTemplateModel(
      image: R.appImages.eveningJournal,
      imageColor: R.appColors.sageGreen,
      title: "Morning Gratitude",
      description:
      "Write down 3 things you are grateful for every morning to ",
      duration: "5 min",
      category: HabitDiscoverCategory.mindset,
      isPopular: true,
      isBeginner: false,
    ),
    HabitTemplateModel(
      image: R.appImages.morningMeditation,
      imageColor: R.appColors.sageGreen,
      title: "5-Minute Meditation",
      description:
          "Sit quietly and focus on your breath. Even 5 minutes of daily meditation reduces stress and improves focus.",
      duration: "5 min",
      category: HabitDiscoverCategory.mindset,
      isPopular: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.stretchRoutine,
      imageColor: R.appColors.sageGreen,
      title: "Stretch Routine",
      description:
          "A gentle 10-minute full-body stretch routine to release tension and improve flexibility.",
      duration: "10 min",
      category: HabitDiscoverCategory.wellness,
      isPopular: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.walk,
      imageColor: R.appColors.sageGreen,
      title: "10K Steps Daily",
      description:
          "Hit 10,000 steps every day. Walking is one of the most underrated forms of exercise.",
      duration: "10000x",
      category: HabitDiscoverCategory.fitness,
      isPopular: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.workout,
      imageColor: R.appColors.sageGreen,
      title: "Bodyweight Workout",
      description:
          "20-minute bodyweight circuit — push-ups, squats, lunges, planks. No equipment needed.",
      duration: "20 min",
      category: HabitDiscoverCategory.fitness,
      isPopular: true,
    ),
    HabitTemplateModel(
      image: R.appImages.morning,
      imageColor: R.appColors.sageGreen,
      title: "Morning Yoga Flow",
      description:
          "A gentle 15-minute yoga flow to wake up your body, improve flexibility and focus.",
      duration: "15 min",
      category: HabitDiscoverCategory.fitness,
      isPopular: true,
    ),
    HabitTemplateModel(
      image: R.appImages.drinkWater,
      imageColor: R.appColors.sageGreen,
      title: "Drink 8 Glasses of Water",
      description:
          "Stay hydrated by drinking at least 8 glasses of water throughout the day.",
      duration: "8x",
      category: HabitDiscoverCategory.health,
      isPopular: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.planTomorrowToNight,
      imageColor: R.appColors.sageGreen,
      title: "Plan Tomorrow Tonight",
      description:
          "Spend 5 minutes each evening planning the next day. List your top priorities.",
      duration: "5 min",
      category: HabitDiscoverCategory.productivity,
      isPopular: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.night,
      imageColor: R.appColors.sageGreen,
      title: "Bedtime Wind-Down",
      description:
          "Start winding down 30 minutes before bed — dim the lights, no screens, relax.",
      duration: "30 min",
      category: HabitDiscoverCategory.sleep,
      isPopular: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.readPages,
      imageColor: R.appColors.sageGreen,
      title: "Read for 20 Minutes",
      description:
          "Read at least 20 pages of any book. Fiction, non-fiction, articles — all count.",
      duration: "20 min",
      category: HabitDiscoverCategory.learning,
      isPopular: true,
    ),
    HabitTemplateModel(
      image: R.appImages.drinkWater,
      imageColor: R.appColors.sageGreen,
      title: "Skincare Routine",
      description:
          "Complete your AM or PM skincare routine — cleanse, tone, serum, moisturize.",
      duration: "10 min",
      category: HabitDiscoverCategory.beauty,
      isPopular: true,
    ),

    // Suggested
    HabitTemplateModel(
      image: R.appImages.digitalDetoxHour,
      imageColor: R.appColors.goldenAmber,
      title: "Digital Detox Hour",
      description:
          "Put your phone away for one full hour. No screens, no notifications — just presence.",
      duration: "60 min",
      category: HabitDiscoverCategory.wellness,
      isSuggested: true,
    ),
    HabitTemplateModel(
      image: R.appImages.stretchRoutine,
      imageColor: R.appColors.goldenAmber,
      title: "Stretch Routine",
      description:
          "A gentle 10-minute full-body stretch routine to release tension and improve flexibility.",
      duration: "10 min",
      category: HabitDiscoverCategory.wellness,
      isSuggested: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.natureWalk,
      imageColor: R.appColors.goldenAmber,
      title: "Nature Walk",
      description:
          "Take a walk outside in nature — no phone, no music. Just observe the world around you.",
      duration: "30 min",
      category: HabitDiscoverCategory.wellness,
      isSuggested: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.walk,
      imageColor: R.appColors.goldenAmber,
      title: "10K Steps Daily",
      description:
          "Hit 10,000 steps every day. Walking is one of the most underrated forms of exercise.",
      duration: "10000x",
      category: HabitDiscoverCategory.fitness,
      isSuggested: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.morning,
      imageColor: R.appColors.goldenAmber,
      title: "Morning Yoga Flow",
      description:
          "A gentle 15-minute yoga flow to wake up your body, improve flexibility and focus.",
      duration: "15 min",
      category: HabitDiscoverCategory.fitness,
      isSuggested: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.drinkWater,
      imageColor: R.appColors.goldenAmber,
      title: "Drink 8 Glasses of Water",
      description:
          "Stay hydrated by drinking at least 8 glasses of water throughout the day.",
      duration: "8x",
      category: HabitDiscoverCategory.health,
      isSuggested: true,
    ),
    HabitTemplateModel(
      image: R.appImages.planTomorrowToNight,
      imageColor: R.appColors.goldenAmber,
      title: "Plan Tomorrow Tonight",
      description:
          "Spend 5 minutes each evening planning the next day. List your top priorities.",
      duration: "5 min",
      category: HabitDiscoverCategory.productivity,
      isSuggested: true,
    ),
    HabitTemplateModel(
      image: R.appImages.inboxZero,
      imageColor: R.appColors.goldenAmber,
      title: "Inbox Zero",
      description:
          "Clear your email inbox to zero. Process, archive, delete, or defer every message.",
      duration: "20 min",
      category: HabitDiscoverCategory.productivity,
      isSuggested: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.night,
      imageColor: R.appColors.goldenAmber,
      title: "Bedtime Wind-Down",
      description:
          "Start winding down 30 minutes before bed — dim the lights, no screens, relax.",
      duration: "30 min",
      category: HabitDiscoverCategory.sleep,
      isSuggested: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.readPages,
      imageColor: R.appColors.goldenAmber,
      title: "Read for 20 Minutes",
      description:
          "Read at least 20 pages of any book. Fiction, non-fiction, articles — all count.",
      duration: "20 min",
      category: HabitDiscoverCategory.learning,
      isSuggested: true,
      isBeginner: true,
    ),
    HabitTemplateModel(
      image: R.appImages.listenToAPodcast,
      imageColor: R.appColors.goldenAmber,
      title: "Listen to a Podcast",
      description:
          "Listen to one educational podcast episode — during your commute or while walking.",
      duration: "30 min",
      category: HabitDiscoverCategory.learning,
      isSuggested: true,
    ),
    HabitTemplateModel(
      image: R.appImages.beauty,
      imageColor: R.appColors.goldenAmber,
      title: "Skincare Routine",
      description:
          "Complete your AM or PM skincare routine — cleanse, tone, serum, moisturize.",
      duration: "10 min",
      category: HabitDiscoverCategory.beauty,
      isSuggested: true,
    ),

    // Mindset
    HabitTemplateModel(
      image: R.appImages.eveningJournal,
      imageColor: R.appColors.oceanBlue,
      title: "Morning Gratitude",
      description: "Write down 3 things you are grateful for every morning",
      duration: "5 min",
      category: HabitDiscoverCategory.mindset,
    ),
    HabitTemplateModel(
      image: R.appImages.morningMeditation,
      imageColor: R.appColors.oceanBlue,
      title: "5-Minute Meditation",
      description: "Sit quietly and focus on your breath. Even 5 minutes helps",
      duration: "5 min",
      category: HabitDiscoverCategory.mindset,
    ),
    HabitTemplateModel(
      image: R.appImages.night,
      imageColor: R.appColors.oceanBlue,
      title: "Evening Reflection",
      description: "Spend 10 minutes reflecting on your day before bed",
      duration: "10 min",
      category: HabitDiscoverCategory.mindset,
    ),
    HabitTemplateModel(
      image: R.appImages.digitalDetoxHour,
      imageColor: R.appColors.oceanBlue,
      title: "Digital Detox Hour",
      description: "Put your phone away for one full hour. No screens",
      duration: "60 min",
      category: HabitDiscoverCategory.mindset,
    ),

    // Wellness
    HabitTemplateModel(
      image: R.appImages.stretchRoutine,
      imageColor: R.appColors.seaGreen,
      title: "Stretch Routine",
      description: "A gentle 10-minute full-body stretch routine",
      duration: "10 min",
      category: HabitDiscoverCategory.wellness,
    ),
    HabitTemplateModel(
      image: R.appImages.morningMeditation,
      imageColor: R.appColors.seaGreen,
      title: "Deep Breathing",
      description: "Practice box breathing or 4-7-8 breathing technique",
      duration: "5 min",
      category: HabitDiscoverCategory.wellness,
    ),
    HabitTemplateModel(
      image: R.appImages.natureWalk,
      imageColor: R.appColors.seaGreen,
      title: "Nature Walk",
      description: "Take a walk outside in nature — no phone, no music",
      duration: "30 min",
      category: HabitDiscoverCategory.wellness,
    ),

    // Fitness
    HabitTemplateModel(
      image: R.appImages.walk,
      imageColor: R.appColors.seaGreen,
      title: "10K Steps Daily",
      description: "Hit 10,000 steps every day. Walking is one of the best habits",
      duration: "60 min",
      category: HabitDiscoverCategory.fitness,
    ),
    HabitTemplateModel(
      image: R.appImages.workout,
      imageColor: R.appColors.seaGreen,
      title: "Bodyweight Workout",
      description: "20-minute bodyweight circuit — push-ups, squats, lunges",
      duration: "20 min",
      category: HabitDiscoverCategory.fitness,
    ),
    HabitTemplateModel(
      image: R.appImages.morning,
      imageColor: R.appColors.seaGreen,
      title: "Morning Yoga Flow",
      description: "A gentle 15-minute yoga flow to wake up your body",
      duration: "15 min",
      category: HabitDiscoverCategory.fitness,
    ),
    HabitTemplateModel(
      image: R.appImages.bicycle,
      imageColor: R.appColors.seaGreen,
      title: "Cycling Session",
      description: "Go for a bike ride — outdoors or on a stationary bike",
      duration: "30 min",
      category: HabitDiscoverCategory.fitness,
    ),

    // Health
    HabitTemplateModel(
      image: R.appImages.drinkWater,
      imageColor: R.appColors.oliveGold,
      title: "Drink 8 Glasses of Water",
      description: "Stay hydrated by drinking at least 8 glasses of water",
      duration: "8x",
      category: HabitDiscoverCategory.health,
    ),
    HabitTemplateModel(
      image: R.appImages.morningMeditation,
      imageColor: R.appColors.oliveGold,
      title: "Take Vitamins",
      description: "Remember to take your daily vitamins with breakfast",
      duration: "1 min",
      category: HabitDiscoverCategory.health,
    ),
    HabitTemplateModel(
      image: R.appImages.health,
      imageColor: R.appColors.oliveGold,
      title: "Meal Prep Sunday",
      description: "Spend an hour on Sunday prepping healthy meals",
      duration: "60 min",
      category: HabitDiscoverCategory.health,
    ),

    // Productivity
    HabitTemplateModel(
      image: R.appImages.planTomorrowToNight,
      imageColor: R.appColors.warmBeige,
      title: "Plan Tomorrow Tonight",
      description: "Spend 5 minutes each evening planning the next day",
      duration: "5 min",
      category: HabitDiscoverCategory.productivity,
    ),
    HabitTemplateModel(
      image: R.appImages.timer,
      imageColor: R.appColors.warmBeige,
      title: "Pomodoro Sessions",
      description: "Complete 4 Pomodoro sessions (25 minutes focused work)",
      duration: "25 min",
      category: HabitDiscoverCategory.productivity,
    ),
    HabitTemplateModel(
      image: R.appImages.inboxZero,
      imageColor: R.appColors.warmBeige,
      title: "Inbox Zero",
      description: "Clear your email inbox to zero. Process, archive, delete",
      duration: "20 min",
      category: HabitDiscoverCategory.productivity,
    ),
    HabitTemplateModel(
      image: R.appImages.productivity,
      imageColor: R.appColors.warmBeige,
      title: "No-Meeting Block",
      description: "Protect a 2-hour block on your calendar for deep work",
      duration: "120 min",
      category: HabitDiscoverCategory.productivity,
    ),

    // Sleep
    HabitTemplateModel(
      image: R.appImages.night,
      imageColor: R.appColors.seaGreen,
      title: "Bedtime Wind-Down",
      description: "Start winding down 30 minutes before bed — dim the lights",
      duration: "30 min",
      category: HabitDiscoverCategory.sleep,
    ),
    HabitTemplateModel(
      image: R.appImages.timer,
      imageColor: R.appColors.seaGreen,
      title: "Consistent Wake-Up Time",
      description: "Wake up at the same time every day — including weekends",
      duration: "1 min",
      category: HabitDiscoverCategory.sleep,
    ),
    HabitTemplateModel(
      image: R.appImages.sleep,
      imageColor: R.appColors.seaGreen,
      title: "No Caffeine After 2pm",
      description: "Cut off caffeine after 2pm for better sleep quality",
      duration: "All day",
      category: HabitDiscoverCategory.sleep,
    ),
    HabitTemplateModel(
      image: R.appImages.night,
      imageColor: R.appColors.seaGreen,
      title: "Sleep Tracking",
      description: "Log your sleep hours and quality each morning",
      duration: "2 min",
      category: HabitDiscoverCategory.sleep,
    ),

    // Learning
    HabitTemplateModel(
      image: R.appImages.readPages,
      imageColor: R.appColors.lightCyan,
      title: "Read for 20 Minutes",
      description: "Read at least 20 pages of any book. Fiction, non-fiction",
      duration: "20 min",
      category: HabitDiscoverCategory.learning,
    ),
    HabitTemplateModel(
      image: R.appImages.learning,
      imageColor: R.appColors.lightCyan,
      title: "Language Practice",
      description: "Practice a new language for 15 minutes every day",
      duration: "15 min",
      category: HabitDiscoverCategory.learning,
    ),
    HabitTemplateModel(
      image: R.appImages.listenToAPodcast,
      imageColor: R.appColors.lightCyan,
      title: "Listen to a Podcast",
      description: "Listen to one educational podcast episode daily",
      duration: "30 min",
      category: HabitDiscoverCategory.learning,
    ),
    HabitTemplateModel(
      image: R.appImages.learning,
      imageColor: R.appColors.lightCyan,
      title: "Skill Practice Session",
      description: "Dedicate 30 minutes to deliberate practice of a skill",
      duration: "30 min",
      category: HabitDiscoverCategory.learning,
    ),

    // Beauty
    HabitTemplateModel(
      image: R.appImages.drinkWater,
      imageColor: R.appColors.mintGreen,
      title: "Skincare Routine",
      description: "Complete your AM or PM skincare routine — cleanse, tone",
      duration: "10 min",
      category: HabitDiscoverCategory.beauty,
    ),
    HabitTemplateModel(
      image: R.appImages.beauty,
      imageColor: R.appColors.mintGreen,
      title: "Hair Care Mask",
      description: "Apply a nourishing hair mask once a week",
      duration: "20 min",
      category: HabitDiscoverCategory.beauty,
    ),
    HabitTemplateModel(
      image: R.appImages.wellness,
      imageColor: R.appColors.mintGreen,
      title: "Nail Care Sunday",
      description: "Trim, file, and moisturize your nails every Sunday",
      duration: "15 min",
      category: HabitDiscoverCategory.beauty,
    ),
  ];

  List<HabitModel> get habits => _habits;
  List<HabitTemplateModel> get templatesHabits => templates;

  List<HabitTemplateModel> get _filteredDiscoverHabits {
    final query = discoverSearchQuery.trim().toLowerCase();
    return discoverHabits.where((habit) {
      final matchesCategory =
          selectedDiscoverCategory == HabitDiscoverCategory.all ||
          habit.category == selectedDiscoverCategory;
      final matchesSearch = query.isEmpty ||
          habit.title.toLowerCase().contains(query) ||
          habit.description.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<HabitTemplateModel> get popularHabits =>
      _filteredDiscoverHabits.where((e) => e.isPopular).toList();

  List<HabitTemplateModel> get suggestedHabits =>
      _filteredDiscoverHabits.where((e) => e.isSuggested).toList();

  List<HabitTemplateModel> habitsByCategory(HabitDiscoverCategory category) {
    return _filteredDiscoverHabits.where((e) {
      if (e.category != category) return false;
      if (selectedDiscoverCategory == HabitDiscoverCategory.all) {
        return !e.isPopular && !e.isSuggested;
      }
      return true;
    }).toList();
  }

  static const List<HabitDiscoverCategory> discoverCategories = [
    HabitDiscoverCategory.all,
    HabitDiscoverCategory.mindset,
    HabitDiscoverCategory.wellness,
    HabitDiscoverCategory.fitness,
    HabitDiscoverCategory.health,
    HabitDiscoverCategory.productivity,
    HabitDiscoverCategory.sleep,
    HabitDiscoverCategory.learning,
    HabitDiscoverCategory.beauty,
  ];

  static const List<HabitDiscoverCategory> discoverSectionCategories = [
    HabitDiscoverCategory.mindset,
    HabitDiscoverCategory.wellness,
    HabitDiscoverCategory.fitness,
    HabitDiscoverCategory.health,
    HabitDiscoverCategory.productivity,
    HabitDiscoverCategory.sleep,
    HabitDiscoverCategory.learning,
    HabitDiscoverCategory.beauty,
  ];

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