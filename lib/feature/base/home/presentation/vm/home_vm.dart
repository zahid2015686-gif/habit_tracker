import 'package:flutter/material.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_insight_model.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_message_model.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_tip_model.dart';

class HomeVm extends ChangeNotifier {
  // ---------------- Coach profile ----------------
  final String coachName = 'Sarah';
  final String coachFullTitle = 'Your Coach Sarah';
  final String coachRole = 'Senior Habit Coach';
  final String coachShortBio =
      'Your personal habit coach — here to help you build a rhythm that lasts. Consistency over perfection, always.';
  final String coachAbout =
      'Certified habit-building coach with 6+ years of experience helping people transform their daily routines. I believe in consistency over perfection — your habits should work with your life, not against it. Together we will build a rhythm that feels natural, sustainable, and uniquely yours.';
  final String experienceYears = '8yrs';
  final String coachProfileImage = R.appImages.coachProfilePic;

  final List<String> specialties = const [
    'Morning Routines',
    'Habit Stacking',
    'Mindfulness',
    'Fitness Consistency',
    'Productivity Systems',
  ];

  // ---------------- Insights ----------------
  final List<CoachInsightModel> insights = [
    CoachInsightModel(
      title: 'Weekly Review Complete',
      body:
          'Coach Sarah reviewed your progress. Your meditation habit is your strongest anchor — protecting it creates a domino effect across your entire day.',
      dateLabel: 'Jul 21',
      tag: 'review',
      icon: R.appImages.weeklyReviewComplete,
      iconColor: R.appColors.violet,
      tagColor: R.appColors.successGreen,
    ),
    CoachInsightModel(
      title: 'Schedule Adjustment Recommended',
      body:
          'Your evening journal completion drops after 9pm. Try shifting it to right after dinner — even 5 minutes counts and protects the streak.',
      dateLabel: 'Jul 18',
      tag: 'suggestion',
      icon: R.appImages.scheduleAdjustmentRecommended,
      iconColor: R.appColors.orange,
      tagColor: R.appColors.skyBlue,
    ),
  ];

  // ---------------- Tips ----------------
  final List<String> tipCategories = const [
    'all',
    'routine',
    'motivation',
    'mindset',
    'strategy',
  ];

  String selectedTipCategory = 'all';
  String? expandedTipId = 'anchor_morning';

  final CoachTipModel todayTip = CoachTipModel(
    id: 'never_miss_twice',
    title: 'Never Miss Twice',
    body:
        'Missing one day is the start of a new pattern. If you skip today, make tomorrow non-negotiable. One missed day does not break a habit — two in a row starts to.',
    category: 'daily',
    icon: R.appImages.neverMissTwice,
    iconColor: R.appColors.errorRed,
  );

  final List<CoachTipModel> tips = [
    CoachTipModel(
      id: 'anchor_morning',
      title: 'Anchor Your Morning',
      body:
          'Pair a new habit with something you already do every morning — like meditating right after brushing your teeth. Existing routines are the strongest anchors.',
      category: 'routine',
      icon: R.appImages.morning,
      iconColor: R.appColors.orange,
    ),
    CoachTipModel(
      id: 'two_minute_rule',
      title: 'The 2-Minute Rule',
      body:
          'Scale any habit down to just two minutes. Want to read more? Start with one page. The goal is to make starting so easy you can\'t say no.',
      category: 'motivation',
      icon: R.appImages.timer,
      iconColor: R.appColors.violet,
    ),
    CoachTipModel(
      id: 'celebrate_minimum',
      title: 'Celebrate the Minimum',
      body:
          'A completed minimum version still counts. Celebrate showing up — progress compounds faster when perfection is not the gatekeeper.',
      category: 'mindset',
      icon: R.appImages.celebrateTheMinimum,
      iconColor: R.appColors.successGreen,
    ),
    CoachTipModel(
      id: 'environment_shapes',
      title: 'Environment Shapes Behavior',
      body:
          'Make good habits obvious and bad habits invisible. Place your journal on your pillow. Put your phone in another room. Design beats willpower.',
      category: 'strategy',
      icon: R.appImages.environmentShapesBehavior,
      iconColor: R.appColors.softCyan,
    ),
    CoachTipModel(
      id: 'never_miss_twice_tip',
      title: 'Never Miss Twice',
      body:
          'Missing one day is the start of a new pattern. If you skip today, make tomorrow non-negotiable. One missed day does not break a habit — two in a row starts to.',
      category: 'consistency',
      icon: R.appImages.neverMissTwice,
      iconColor: R.appColors.errorRed,
    ),
    CoachTipModel(
      id: 'identity_goals',
      title: 'Identity Over Goals',
      body:
          'Don\'t aim to run a marathon — become a runner. Identity-based habits stick because every action is a vote for the person you want to be.',
      category: 'mindset',
      icon: R.appImages.mindset,
      iconColor: R.appColors.violet,
    ),
  ];

  List<CoachTipModel> get filteredTips {
    if (selectedTipCategory == 'all') return tips;
    return tips
        .where((tip) => tip.category == selectedTipCategory)
        .toList();
  }

  void selectTipCategory(String category) {
    if (selectedTipCategory == category) return;
    selectedTipCategory = category;
    notifyListeners();
  }

  void toggleTipExpanded(String tipId) {
    expandedTipId = expandedTipId == tipId ? null : tipId;
    notifyListeners();
  }

  bool isTipExpanded(String tipId) => expandedTipId == tipId;

  // ---------------- Recent messages ----------------
  final List<CoachMessageModel> recentMessages = [
    CoachMessageModel(
      text:
          'Good morning Ahmad! How are you feeling about your habits this week?',
      timeLabel: 'Jul 21, 08:02 AM',
      avatar: R.appImages.coachProfilePic,
    ),
    CoachMessageModel(
      text:
          'Morning Coach! Feeling pretty good honestly — meditation streak is going strong',
      timeLabel: 'Jul 21, 08:04 AM',
      avatar: R.appImages.profile,
    ),
  ];
}
