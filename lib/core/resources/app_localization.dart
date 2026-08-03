class AppLocalization {
  static Map<String, String> get englishLanguage => {
    'build_better_habits': 'build better habits',
    'build_better_habits_capital_words': 'Build Better Habits',
    "skip": "Skip",
    "back": "Back",
    "next": "Next",
    "continue": "Continue",
    "cancel": "Cancel",
    "build_better_habits_description": "Create routines that fit your life instead of forcing perfect streaks.",
    "find_your_rhythm": "Find Your Rhythm",
    "find_your_rhythm_description": "Life changes. Your habits should adapt. Keep moving forward at your own pace.",
    "stay_accountable": "Stay Accountable",
    "stay_accountable_description": "Upgrade to connect with a dedicated coach for guidance, encouragement, and support.",
    "welcome_to_rhythmi":"Welcome to Rhythmi",
    "sign_in_to_continue_your_rhythm":"Sign in to continue your rhythm",
    "continue_with_google":"Continue with Google",
    "continue_with_apple":"Continue with Apple",
    "sign_in_with_google":"Sign in with Google",
    "choose_an_account_to_continue":"Choose an account to continue",
    "sign_in_with_apple":"Sign in with Google",
    "use_your_apple_id_to_continue":"Use your Apple ID to continue",
    "good":"Good",
    "your_rhythm":"Your Rhythm",
    "today_habits":"Today's Habits",
    "upcoming_reminders":"Upcoming Reminders",
    "weekly_progress":"Weekly Progress",
    "view_all":"View all",
    "create_habit":"Create Habit",
    "icon":"Icon",
    "done":"Done",
    "by_continuing_you_agree_to_our":"By continuing, you agree to our ",
    "terms":"Terms",
    "and":" and\n",
    "privacy_policy":"Privacy Policy",
    "add_another_account":"Add another account",
    "upgrade":"Upgrade",
    "build_better_habits_with_real_coaching":"Build Better Habits\nWith Real Coaching",
    "unlock_unlimited_habits_and_deep_analytics": "Unlock unlimited habits and deep\nanalytics. Build the life you want — with\na coach in your pocket.",
    "welcome_to_premium":"Welcome to Premium!",
    "welcome_premium_subtitle": "You've unlocked unlimited habits, live coach access, and deep analytics. Your rhythm just leveled up.",
    "unlimited_habits":"Unlimited Habits",
    "live_coach":"Live Coach",
    "deep_analytics":"Deep Analytics",
    "let_go":"Let's go!",
    "proceed_with_free_package":"Proceed with Free Package",
    'premium_money_back_guarantee': '30-day money-back guarantee',
    'money_back_description': 'If you are not building better habits within 30\ndays, we will refund you — no questions asked.',
    'cancel_anytime_no_lock_in': 'Cancel anytime · No lock-in',
    'you_all_set': '''You're all set!''',
    "pick_habits_to_get_started": "Pick a few habits to get started, or create\nyour own. Your coach is ready when you are.",
    "quick_start_templates":"Quick-Start Templates",
    "habits":"Habits",
    "light":"Light",
    "discover_habits":"Discover",
    "discover_habits_subtitle":"Browse curated habits across\nwellness, fitness, mindset & more",
    "search_habits":"Search habits...",
    "all":"All",
    "mindset":"Mindset",
    "wellness":"Wellness",
    "fitness":"Fitness",
    "health":"Health",
    "productivity":"Productivity",
    "sleep":"Sleep",
    "learning":"Learning",
    "beauty":"Beauty",
    "popular":"Popular",
    "most_added":"Most added",
    "suggested_for_you":"Suggested for You",
    "curated_picks":"Curated picks",
    "add":"Add",
    "beginner":"beginner",
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
