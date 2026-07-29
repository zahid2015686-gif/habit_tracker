

import 'package:habit_tracker/core/constants/enums.dart';

class PremiumPlanModel {
  final PlanType type;
  final String title;
  final String price;
  final String? badge;
  final String subtitle;
  final List<String> features;
  final String trialText;

  const PremiumPlanModel({
    required this.type,
    required this.title,
    required this.price,
    this.badge,
    required this.subtitle,
    required this.features,
    required this.trialText,
  });

}