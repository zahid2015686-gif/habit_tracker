
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/base_view/data/models/base_view_model.dart';

class BaseVm extends ChangeNotifier {
  //Lists
  List<BaseViewModel> _sideItems = [
    BaseViewModel(imagePath: R.appImages.home, label: 'Home'),
    BaseViewModel(imagePath: R.appImages.habits, label: 'Habits'),
    BaseViewModel(imagePath: R.appImages.rhythm, label: 'Rhythm'),
    BaseViewModel(imagePath: R.appImages.profile, label: 'Profile'),
  ];
  // Variables
  int _currentIndex = 0;

  //Getter
  int get currentIndex => _currentIndex;
  List<BaseViewModel> get getBaseVm => _sideItems;

  void changeIndex(int index) {
    if (_currentIndex == index) return;

    _currentIndex = index;
    notifyListeners();
  }
}