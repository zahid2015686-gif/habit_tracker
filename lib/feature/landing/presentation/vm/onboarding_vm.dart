import 'package:flutter/foundation.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/landing/data/models/onboarding_model.dart';

class OnboardingVm extends ChangeNotifier {
  // ---------------------------------------------------------------------
  // Data
  // ---------------------------------------------------------------------
  final List<OnboardingModel> _pages = [
    OnboardingModel(
      image: R.appImages.onboardingImage1,
      icon: R.appImages.onboardingIcon1,
      titleKey: 'build_better_habits_capital_words'.L(),
      descKey: 'build_better_habits_description'.L(),
    ),
    OnboardingModel(
      image: R.appImages.onboardingImage2,
      icon: R.appImages.onboardingIcon2,
      titleKey: 'find_your_rhythm'.L(),
      descKey: 'find_your_rhythm_description'.L(),
    ),
    OnboardingModel(
      image: R.appImages.onboardingImage3,
      icon: R.appImages.onboardingIcon3,
      titleKey: 'stay_accountable'.L(),
      descKey: 'stay_accountable_description'.L(),
    ),
  ];

  // ---------------------------------------------------------------------
  // State
  // ---------------------------------------------------------------------
  int _currentIndex = 0;

  // ---------------------------------------------------------------------
  // Getters
  // ---------------------------------------------------------------------
  List<OnboardingModel> get pages => _pages;
  int get currentIndex => _currentIndex;
  int get totalPages => _pages.length;
  bool get isFirstPage => _currentIndex == 0;
  bool get isLastPage => _currentIndex == _pages.length - 1;
  OnboardingModel get currentPage => _pages[_currentIndex];

  // ---------------------------------------------------------------------
  // Actions
  // `onFinished` is supplied by the View (it owns navigation/BuildContext),
  // the VM only decides *when* onboarding is done.
  // ---------------------------------------------------------------------
  void goToNext(VoidCallback onFinished) {
    if (isLastPage) {
      onFinished();
      return;
    }
    _currentIndex++;
    notifyListeners();
  }

  void goToBack() {
    if (isFirstPage) return;
    _currentIndex--;
    notifyListeners();
  }

  void skip() {
    _currentIndex = totalPages - 1;
    notifyListeners();
  }
}