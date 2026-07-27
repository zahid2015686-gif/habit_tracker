class AppLocalization {
  static Map<String, String> get englishLanguage => {
    'build_better_habits': 'build better habits',
    "skip": "Skip",
    "back": "Back",
    "next": "Next",
    "build_better_habits_desc": "Create routines that fit your life instead of forcing perfect streaks.",
    "find_your_rhythm": "Find Your Rhythm",
    "find_your_rhythm_desc": "Life changes. Your habits should adapt. Keep moving forward at your own pace.",
    "stay_accountable": "Stay Accountable",
    "stay_accountable_desc": "Upgrade to connect with a dedicated coach for guidance, encouragement, and support."
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
