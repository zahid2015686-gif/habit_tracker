import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/enums.dart';

class HabitTemplateModel {
  final String? image;
  final IconData? icon;
  final Color imageColor;
  final String title;
  final String description;
  final String duration;
  final HabitDiscoverCategory category;
  final bool isPopular;
  final bool isSuggested;

  HabitTemplateModel({
    this.image,
    this.icon,
    required this.imageColor,
    required this.title,
    this.description = '',
    required this.duration,
    this.category = HabitDiscoverCategory.mindset,
    this.isPopular = false,
    this.isSuggested = false,
  });
}
