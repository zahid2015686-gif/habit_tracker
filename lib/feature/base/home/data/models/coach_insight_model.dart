import 'dart:ui';

class CoachInsightModel {
  final String title;
  final String body;
  final String dateLabel;
  final String tag;
  final String icon;
  final Color iconColor;
  final Color tagColor;

  CoachInsightModel({
    required this.title,
    required this.body,
    required this.dateLabel,
    required this.tag,
    required this.icon,
    required this.iconColor,
    required this.tagColor,
  });
}
