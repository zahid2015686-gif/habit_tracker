import 'dart:ui';

import 'package:habit_tracker/core/constants/enums.dart';

class HabitTemplateModel {
  final String image;
  final Color imageColor;
  final String title;
  final String description;
  final String duration;
  final HabitDiscoverCategory category;
  final bool isPopular;
  final bool isSuggested;
  final bool isBeginner;

  HabitTemplateModel({
    required this.image,
    required this.imageColor,
    required this.title,
    this.description = '',
    required this.duration,
    this.category = HabitDiscoverCategory.mindset,
    this.isPopular = false,
    this.isSuggested = false,
    this.isBeginner = false,
  });
}
