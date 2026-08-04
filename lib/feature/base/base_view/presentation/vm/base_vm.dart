import 'package:flutter/material.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/base_view/data/models/base_view_model.dart';

class BaseVm extends ChangeNotifier {
  //Lists
  final List<BaseViewModel> _sideItems = [
    BaseViewModel(imagePath: R.appImages.home, label: 'Home'),
    BaseViewModel(imagePath: R.appImages.habits, label: 'Habits'),
    BaseViewModel(imagePath: R.appImages.rhythm, label: 'Rhythm'),
    BaseViewModel(imagePath: R.appImages.profile, label: 'Profile'),
  ];
  // Variables
  int _currentIndex = 0;
  bool _showHome = false;
  bool _hasShownWelcomePremium = false;

  //Getter
  int get currentIndex => _currentIndex;
  bool get showHome => _showHome;
  bool get hasShownWelcomePremium => _hasShownWelcomePremium;
  List<BaseViewModel> get getBaseVm => _sideItems;

  void changeIndex(int index) {
    if (_currentIndex == index) return;

    _currentIndex = index;
    notifyListeners();
  }

  void goToHome() {
    _showHome = true;
    _currentIndex = 0;
    notifyListeners();
  }

  void markWelcomePremiumShown() {
    _hasShownWelcomePremium = true;
  }
}