class AppLocalization {
  static Map<String, String> get englishLanguage => {
    'build_better_habits': 'build better habits',
    'build_better_habits_capital_words': 'Build Better Habits',
    "skip": "Skip",
    "back": "Back",
    "next": "Next",
    "continue": "Continue",
    "cancel": "Cancel",
    "build_better_habits_description":
        "Create routines that fit your life instead of forcing perfect streaks.",
    "find_your_rhythm": "Find Your Rhythm",
    "find_your_rhythm_description":
        "Life changes. Your habits should adapt. Keep moving forward at your own pace.",
    "stay_accountable": "Stay Accountable",
    "stay_accountable_description":
        "Upgrade to connect with a dedicated coach for guidance, encouragement, and support.",
    "welcome_to_rhythmi": "Welcome to Rhythmi",
    "sign_in_to_continue_your_rhythm": "Sign in to continue your rhythm",
    "continue_with_google": "Continue with Google",
    "continue_with_apple": "Continue with Apple",
    "sign_in_with_google": "Sign in with Google",
    "choose_an_account_to_continue": "Choose an account to continue",
    "sign_in_with_apple": "Sign in with Google",
    "use_your_apple_id_to_continue": "Use your Apple ID to continue",
    "good": "Good",
    "your_rhythm": "Your Rhythm",
    "today_habits": "Today's Habits",
    "upcoming_reminders": "Upcoming Reminders",
    "weekly_progress": "Weekly Progress",
    "view_all": "View all",
    "your_coach": "Your Coach",
    "online": "Online",
    "coach_sarah": "Coach Sarah",
    "new_insights_waiting": "New insights and tips waiting for",
    "view": "View",
    "steady": "Steady",
    "steady_description": "Consistent and reliable. Keep this rhythm going.",
    "week": "week",
    "month": "month",
    "notification": "Notification",
    "today": "Today",
    "yesterday": "Yesterday",
    "habit_reminder": "Habit Reminder",
    "coach_message": "Coach Message",
    "coach_reminder": "Coach Reminder",
    "create_habit": "Create Habit",
    "icon": "Icon",
    "done": "Done",
    "by_continuing_you_agree_to_our": "By continuing, you agree to our ",
    "terms": "Terms",
    "and": " and\n",
    "privacy_policy": "Privacy Policy",
    "add_another_account": "Add another account",
    "upgrade": "Upgrade",
    "build_better_habits_with_real_coaching":
        "Build Better Habits\nWith Real Coaching",
    "unlock_unlimited_habits_and_deep_analytics":
        "Unlock unlimited habits and deep\nanalytics. Build the life you want — with\na coach in your pocket.",
    "welcome_to_premium": "Welcome to Premium!",
    "welcome_premium_subtitle":
        "You've unlocked unlimited habits, live coach access, and deep analytics. Your rhythm just leveled up.",
    "unlimited_habits": "Unlimited Habits",
    "live_coach": "Live Coach",
    "deep_analytics": "Deep Analytics",
    "let_go": "Let's go!",
    "proceed_with_free_package": "Proceed with Free Package",
    'premium_money_back_guarantee': '30-day money-back guarantee',
    'money_back_description':
        'If you are not building better habits within 30\ndays, we will refund you — no questions asked.',
    'cancel_anytime_no_lock_in': 'Cancel anytime · No lock-in',
    'you_all_set': '''You're all set!''',
    "pick_habits_to_get_started":
        "Pick a few habits to get started, or create\nyour own. Your coach is ready when you are.",
    "quick_start_templates": "Quick-Start Templates",
    "habits": "Habits",
    "light": "Light",
    "discover_habits": "Discover",
    "discover_habits_subtitle":
        "Browse curated habits across\nwellness, fitness, mindset & more",
    "search_habits": "Search habits...",
    "all": "All",
    "mindset": "Mindset",
    "wellness": "Wellness",
    "fitness": "Fitness",
    "health": "Health",
    "productivity": "Productivity",
    "sleep": "Sleep",
    "learning": "Learning",
    "beauty": "Beauty",
    "popular": "Popular",
    "most_added": "Most added",
    "suggested_for_you": "Suggested for You",
    "curated_picks": "Curated picks",
    "add": "Add",
    "beginner": "beginner",
    "customize_before_adding": "Customize before adding",
    "target_count": "Target Count",
    "schedule": "Schedule",
    "duration_minutes": "Duration (minutes)",
    "reminder_time": "Reminder Time",
    "add_habit": "Add Habit",
    "daily": "Daily",
    "weekly": "Weekly",
    "custom": "Custom",
    "active_days": "Active Days",
    "repeat_every": "Repeat Every",
    "build_your_own_habit": "Build Your Own Habit",
    "habit_name": "Habit Name",
    "habit_name_hint": "e.g., Morning Meditation",
    "description": "Description",
    "description_hint": "Why do you want to build this habit?",
    "category": "Category",
    "color": "Color",
    "target": "Target",
    "duration_min": "Duration (min)",
    "minimum_version": "Minimum Version",
    "optional": "Optional",
    "minimum_version_description":
        "Define a lighter version for low-energy days — like a 5-minute walk instead of 30 minutes. If left off, only the regular completion is tracked.",
    "name": "Name",
    "light_version_name_hint": "e.g., Quick walk, 5-min stretch",
    "preview": "Preview:",
    "light_version": "Light version",
    "notes": "Notes",
    "notes_hint": "Any additional notes...",
    "save_habit": "Save Habit",
    "habit_created": "Habit Created!",
    "habit_created_subtitle":
        "Your new habit is ready, keep that rhythm going.",
    "habit_created_successfully": "Habit Created Successfully",
    "custom_schedule": "Custom Schedule",
    "date_selected": "date selected",
    "sarah": "Sarah",
    "senior_habit_coach": "Senior Habit Coach",
    "start_conversation": "Start Conversation",
    "experience": "Experience",
    "yrs": "yrs",
    "request_support": "Request Support",
    "ask_for_help": "Ask for help",
    "schedule_call": "Schedule Call",
    "book_15_min_call": "Book 15 min call",
    "coach_insights": "Coach Insights",
    "last_3_updates": "Last 3 updates",
    "review": "review",
    "suggestion": "suggestion",
    "todays_tip": "Today's Tip",
    "all_tips": "All Tips",
    "routine": "routine",
    "motivation": "motivation",
    "strategy": "strategy",
    "consistency": "consistency",
    "about_your_coach": "About Your Coach",
    "specialties": "Specialties",
    "recent_messages": "Recent messages",
  };

  static Map<String, String> get codesES => {};

  static String _currentLanguage = "en";

  static void setCurrentLanguage(String languageCode) {
    _currentLanguage = languageCode;
  }

  static String getCurrentLanguage() {
    return _currentLanguage;
  }

  static String getTranslatedValues(String key) {
    if (_currentLanguage == 'en') {
      return englishLanguage[key] ?? "Text not found $key";
    } else {
      return codesES[key] ?? "Text not found $key";
    }
  }

  static String getTranslatedValuesForLanguage(
    String key,
    String languageCode,
  ) {
    if (languageCode == 'en') {
      return englishLanguage[key] ?? "Text not found $key";
    }
    return codesES[key] ?? englishLanguage[key] ?? "Text not found $key";
  }
}

extension Localize on String {
  String L() {
    return AppLocalization.getTranslatedValues(this);
  }
}