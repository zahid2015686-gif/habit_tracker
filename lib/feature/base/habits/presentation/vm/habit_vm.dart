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
    // Popular / Suggested
    HabitTemplateModel(
      icon: Icons.wb_sunny_outlined,
      imageColor: R.appColors.warmGold,
      title: "Morning Gratitude",
      description:
          "Write down 3 things you are grateful for every morning to start your day with positivity.",
      duration: "5 min",
      category: HabitDiscoverCategory.mindset,
      isPopular: true,
    ),
    HabitTemplateModel(
      icon: Icons.phonelink_erase_outlined,
      imageColor: R.appColors.orange,
      title: "Digital Detox Hour",
      description:
          "Put your phone away for one full hour. No screens, no notifications — just presence.",
      duration: "60 min",
      category: HabitDiscoverCategory.wellness,
      isSuggested: true,
    ),

    // Mindset
    HabitTemplateModel(
      icon: Icons.edit_outlined,
      imageColor: R.appColors.skyBlue,
      title: "Morning Gratitude",
      description: "Write down 3 things you're grateful for each morning",
      duration: "5 min",
      category: HabitDiscoverCategory.mindset,
    ),
    HabitTemplateModel(
      image: R.appImages.morningMeditation,
      imageColor: R.appColors.skyBlue,
      title: "5-Minute Meditation",
      description: "A short guided breathing session to center your mind",
      duration: "5 min",
      category: HabitDiscoverCategory.mindset,
    ),
    HabitTemplateModel(
      icon: Icons.favorite_border,
      imageColor: R.appColors.skyBlue,
      title: "Affirmations Practice",
      description: "Speak 5 positive affirmations out loud each morning",
      duration: "5 min",
      category: HabitDiscoverCategory.mindset,
    ),
    HabitTemplateModel(
      image: R.appImages.eveningJournal,
      imageColor: R.appColors.skyBlue,
      title: "Evening Reflection",
      description: "Journal 3 things that went well today before bed",
      duration: "10 min",
      category: HabitDiscoverCategory.mindset,
    ),
    HabitTemplateModel(
      icon: Icons.visibility_outlined,
      imageColor: R.appColors.skyBlue,
      title: "Visualization Practice",
      description: "Spend 5 minutes visualizing your ideal day ahead",
      duration: "5 min",
      category: HabitDiscoverCategory.mindset,
    ),
    HabitTemplateModel(
      icon: Icons.auto_stories_outlined,
      imageColor: R.appColors.skyBlue,
      title: "Growth Mindset Journal",
      description: "Write about one challenge and what you learned from it",
      duration: "10 min",
      category: HabitDiscoverCategory.mindset,
    ),

    // Wellness
    HabitTemplateModel(
      icon: Icons.self_improvement_outlined,
      imageColor: R.appColors.seaGreen,
      title: "Stretch Routine",
      description: "A gentle 10-minute full-body stretch routine",
      duration: "10 min",
      category: HabitDiscoverCategory.wellness,
    ),
    HabitTemplateModel(
      icon: Icons.air,
      imageColor: R.appColors.seaGreen,
      title: "Deep Breathing",
      description: "4-7-8 breathing technique to reduce stress and anxiety",
      duration: "5 min",
      category: HabitDiscoverCategory.wellness,
    ),
    HabitTemplateModel(
      icon: Icons.eco_outlined,
      imageColor: R.appColors.seaGreen,
      title: "Nature Walk",
      description: "A mindful 20-minute walk outdoors without headphones",
      duration: "20 min",
      category: HabitDiscoverCategory.wellness,
    ),

    // Fitness
    HabitTemplateModel(
      image: R.appImages.walk,
      imageColor: R.appColors.seaGreen,
      title: "10K Steps Daily",
      description: "Hit 10,000 steps every day — walk, climb, or dance",
      duration: "60 min",
      category: HabitDiscoverCategory.fitness,
    ),
    HabitTemplateModel(
      image: R.appImages.workout,
      imageColor: R.appColors.seaGreen,
      title: "Bodyweight Workout",
      description: "20-minute no-equipment strength routine at home",
      duration: "20 min",
      category: HabitDiscoverCategory.fitness,
    ),
    HabitTemplateModel(
      image: R.appImages.morning,
      imageColor: R.appColors.seaGreen,
      title: "Morning Yoga Flow",
      description: "A gentle 15-minute yoga sequence to wake up your body",
      duration: "15 min",
      category: HabitDiscoverCategory.fitness,
    ),
    HabitTemplateModel(
      image: R.appImages.bicycle,
      imageColor: R.appColors.seaGreen,
      title: "Cycling Session",
      description: "30 minutes of outdoor or stationary cycling",
      duration: "30 min",
      category: HabitDiscoverCategory.fitness,
    ),

    // Health
    HabitTemplateModel(
      image: R.appImages.drinkWater,
      imageColor: R.appColors.avocado,
      title: "Drink 8 Glasses of Water",
      description: "Stay hydrated throughout the day with 8 glasses",
      duration: "All day",
      category: HabitDiscoverCategory.health,
    ),
    HabitTemplateModel(
      icon: Icons.medication_outlined,
      imageColor: R.appColors.avocado,
      title: "Take Vitamins",
      description: "Take your daily vitamins with breakfast",
      duration: "1 min",
      category: HabitDiscoverCategory.health,
    ),
    HabitTemplateModel(
      icon: Icons.restaurant_outlined,
      imageColor: R.appColors.avocado,
      title: "Meal Prep Sunday",
      description: "Prep healthy meals for the week ahead every Sunday",
      duration: "90 min",
      category: HabitDiscoverCategory.health,
    ),

    // Productivity
    HabitTemplateModel(
      icon: Icons.event_available_outlined,
      imageColor: R.appColors.peach,
      title: "Plan Tomorrow Tonight",
      description: "Spend 10 minutes planning tomorrow's top 3 priorities",
      duration: "10 min",
      category: HabitDiscoverCategory.productivity,
    ),
    HabitTemplateModel(
      icon: Icons.timer_outlined,
      imageColor: R.appColors.peach,
      title: "Pomodoro Sessions",
      description: "Complete 4 focused 25-minute work sessions daily",
      duration: "25 min",
      category: HabitDiscoverCategory.productivity,
    ),
    HabitTemplateModel(
      icon: Icons.mail_outline,
      imageColor: R.appColors.peach,
      title: "Inbox Zero",
      description: "Clear your email inbox completely once a day",
      duration: "20 min",
      category: HabitDiscoverCategory.productivity,
    ),
    HabitTemplateModel(
      icon: Icons.shield_outlined,
      imageColor: R.appColors.peach,
      title: "No-Meeting Block",
      description: "Protect 2 hours of deep work with no meetings",
      duration: "120 min",
      category: HabitDiscoverCategory.productivity,
    ),

    // Sleep
    HabitTemplateModel(
      image: R.appImages.night,
      imageColor: R.appColors.seaGreen,
      title: "Bedtime Wind-Down",
      description: "A 30-minute screen-free wind-down before sleep",
      duration: "30 min",
      category: HabitDiscoverCategory.sleep,
    ),
    HabitTemplateModel(
      icon: Icons.alarm_outlined,
      imageColor: R.appColors.seaGreen,
      title: "Consistent Wake-Up Time",
      description: "Wake up at the same time every day, including weekends",
      duration: "1 min",
      category: HabitDiscoverCategory.sleep,
    ),
    HabitTemplateModel(
      icon: Icons.coffee_outlined,
      imageColor: R.appColors.seaGreen,
      title: "No Caffeine After 2pm",
      description: "Cut off caffeine after 2pm for better sleep quality",
      duration: "All day",
      category: HabitDiscoverCategory.sleep,
    ),
    HabitTemplateModel(
      icon: Icons.bedtime_outlined,
      imageColor: R.appColors.seaGreen,
      title: "Sleep Tracking",
      description: "Log your sleep hours and quality each morning",
      duration: "2 min",
      category: HabitDiscoverCategory.sleep,
    ),

    // Learning
    HabitTemplateModel(
      image: R.appImages.readPages,
      imageColor: R.appColors.blue,
      title: "Read for 20 Minutes",
      description: "Read a book or article for at least 20 minutes daily",
      duration: "20 min",
      category: HabitDiscoverCategory.learning,
    ),
    HabitTemplateModel(
      icon: Icons.public_outlined,
      imageColor: R.appColors.blue,
      title: "Language Practice",
      description: "Practice a new language for 15 minutes every day",
      duration: "15 min",
      category: HabitDiscoverCategory.learning,
    ),
    HabitTemplateModel(
      icon: Icons.headphones_outlined,
      imageColor: R.appColors.blue,
      title: "Listen to a Podcast",
      description: "Learn something new from a podcast episode daily",
      duration: "30 min",
      category: HabitDiscoverCategory.learning,
    ),
    HabitTemplateModel(
      icon: Icons.code,
      imageColor: R.appColors.blue,
      title: "Skill Practice Session",
      description: "Dedicate 30 minutes to practicing a skill you're learning",
      duration: "30 min",
      category: HabitDiscoverCategory.learning,
    ),

    // Beauty
    HabitTemplateModel(
      icon: Icons.spa_outlined,
      imageColor: R.appColors.mossGreen,
      title: "Skincare Routine",
      description: "Complete your morning and evening skincare routine",
      duration: "10 min",
      category: HabitDiscoverCategory.beauty,
    ),
    HabitTemplateModel(
      icon: Icons.content_cut,
      imageColor: R.appColors.mossGreen,
      title: "Hair Care Mask",
      description: "Apply a nourishing hair mask once a week",
      duration: "20 min",
      category: HabitDiscoverCategory.beauty,
    ),
    HabitTemplateModel(
      icon: Icons.back_hand_outlined,
      imageColor: R.appColors.mossGreen,
      title: "Nail Care Sunday",
      description: "Trim, file, and moisturize your nails every Sunday",
      duration: "15 min",
      category: HabitDiscoverCategory.beauty,
    ),
    HabitTemplateModel(
      icon: Icons.wb_sunny_outlined,
      imageColor: R.appColors.mossGreen,
      title: "SPF Protection",
      description: "Apply sunscreen every morning before leaving home",
      duration: "2 min",
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