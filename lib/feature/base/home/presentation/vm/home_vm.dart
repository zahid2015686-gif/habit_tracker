import 'package:flutter/material.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_chat_message_model.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_insight_model.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_message_model.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_stat_model.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_tip_model.dart';
import 'package:habit_tracker/feature/base/home/data/models/support_topic_model.dart';

class HomeVm extends ChangeNotifier {
  // ---------------- Coach profile ----------------
  final String coachName = 'Sarah';
  final String coachFullTitle = 'Your Coach Sarah';
  final String coachRole = 'Senior Habit Coach';
  final String coachShortBio =
      'Your personal habit coach — here to help you build a rhythm that lasts. Consistency over perfection, always.';
  final String coachAbout =
      'Certified habit-building coach with 6+ years of experience helping people transform their daily routines. I believe in consistency over perfection — your habits should work with your life, not against it. Together we will build a rhythm that feels natural, sustainable, and uniquely yours.';
  final String experienceYears = '8';
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
      iconColor: R.appColors.indigo,
      tagColor: R.appColors.forestOlive,
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
    return tips.where((tip) => tip.category == selectedTipCategory).toList();
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
      avatar: R.appImages.recentMessages,
    ),
    CoachMessageModel(
      text:
          'Morning Coach! Feeling pretty good honestly — meditation streak is going strong',
      timeLabel: 'Jul 21, 08:04 AM',
      avatar: R.appImages.recentMessages,
    ),
  ];

  // ---------------- Chat ----------------
  final TextEditingController chatMessageController = TextEditingController();

  final List<CoachStatModel> coachingStats = [
    CoachStatModel(
      value: '148',
      label: 'messages',
      icon: R.appImages.messages,
      iconColor: R.appColors.successGreen,
    ),
    CoachStatModel(
      value: '12',
      label: 'day_streak',
      icon: R.appImages.dayStreak,
      iconColor: R.appColors.skyBlue,
    ),
    CoachStatModel(
      value: '3m',
      label: 'avg_reply',
      icon: R.appImages.reminderTime,
      iconColor: R.appColors.successGreen,
    ),
  ];

  final List<CoachChatMessageModel> chatMessages = [
    CoachChatMessageModel(
      text:
          'Good morning Ahmad! How are you feeling about your habits this week?',
      timeLabel: '9:32 AM',
      isFromCoach: true,
    ),
    CoachChatMessageModel(
      text:
          'Pretty good! Hit my meditation streak again today — 12 days now. Feeling more focused in the mornings.',
      timeLabel: '9:34 AM',
      isFromCoach: false,
    ),
    CoachChatMessageModel(
      text:
          'That\'s amazing progress! The morning focus is a real sign the habit is sticking. How\'s the evening journal going?',
      timeLabel: '9:35 AM',
      isFromCoach: true,
    ),
    CoachChatMessageModel(
      text:
          'Thanks! I struggled this morning though. Woke up late and almost skipped meditation entirely.',
      timeLabel: '9:36 AM',
      isFromCoach: false,
    ),
    CoachChatMessageModel(
      text:
          'That\'s completely okay. Those mornings happen to everyone — the fact you still showed up says a lot. What ended up getting you back on track?',
      timeLabel: '9:37 AM',
      isFromCoach: true,
    ),
    CoachChatMessageModel(
      text:
          'Honestly? Just starting small. I told myself I would only do 3 minutes of meditation instead of 10, and once I started I ended up doing the full session.',
      timeLabel: '9:38 AM',
      isFromCoach: false,
    ),
    CoachChatMessageModel(
      text:
          'That\'s the secret right there — lowering the barrier. A 3-minute meditation is infinitely better than a skipped one. Let\'s carry that mindset into this afternoon too. What\'s your one small win you\'re aiming for today?',
      timeLabel: '9:39 AM',
      isFromCoach: true,
    ),
    CoachChatMessageModel(
      text:
          'I think getting my evening journal done before dinner this time — not leaving it until I\'m exhausted...',
      timeLabel: '9:40 AM',
      isFromCoach: false,
    ),
    CoachChatMessageModel(
      text:
          'Great focus. Even 2-3 sentences at 5pm counts as a win. You\'ve got this — I\'ll check in later today to see how it went.',
      timeLabel: '9:41 AM',
      isFromCoach: true,
    ),
  ];

  void sendChatMessage() {
    final text = chatMessageController.text.trim();
    if (text.isEmpty) return;

    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';

    chatMessages.add(
      CoachChatMessageModel(
        text: text,
        timeLabel: '$hour:$minute $period',
        isFromCoach: false,
      ),
    );
    chatMessageController.clear();
    notifyListeners();
  }

  // ---------------- Request support ----------------
  final TextEditingController supportMessageController =
      TextEditingController();
  String? selectedSupportTopicId;
  static const int supportMessageMaxLength = 500;

  final List<SupportTopicModel> supportTopics = [
    SupportTopicModel(
      id: 'low_motivation',
      titleKey: 'low_motivation',
      subtitleKey: 'low_motivation_desc',
      icon: Icons.sentiment_dissatisfied_outlined,
    ),
    SupportTopicModel(
      id: 'feeling_overwhelmed',
      titleKey: 'feeling_overwhelmed',
      subtitleKey: 'feeling_overwhelmed_desc',
      icon: Icons.psychology_outlined,
    ),
    SupportTopicModel(
      id: 'breaking_the_routine',
      titleKey: 'breaking_the_routine',
      subtitleKey: 'breaking_the_routine_desc',
      icon: Icons.error_outline_rounded,
    ),
    SupportTopicModel(
      id: 'need_encouragement',
      titleKey: 'need_encouragement',
      subtitleKey: 'need_encouragement_desc',
      icon: Icons.favorite_border_rounded,
    ),
    SupportTopicModel(
      id: 'habit_question',
      titleKey: 'habit_question',
      subtitleKey: 'habit_question_desc',
      icon: Icons.help_outline_rounded,
    ),
    SupportTopicModel(
      id: 'other',
      titleKey: 'other',
      subtitleKey: 'other_desc',
      icon: Icons.more_horiz_rounded,
    ),
  ];

  bool get canSendSupportRequest => selectedSupportTopicId != null;

  void selectSupportTopic(String topicId) {
    selectedSupportTopicId =
        selectedSupportTopicId == topicId ? null : topicId;
    notifyListeners();
  }

  void onSupportMessageChanged() {
    notifyListeners();
  }

  void sendSupportRequest() {
    if (!canSendSupportRequest) return;
    selectedSupportTopicId = null;
    supportMessageController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    chatMessageController.dispose();
    supportMessageController.dispose();
    super.dispose();
  }
}
