import 'package:flutter/material.dart';

class SupportTopicModel {
  final String id;
  final String titleKey;
  final String subtitleKey;
  final IconData icon;

  SupportTopicModel({
    required this.id,
    required this.titleKey,
    required this.subtitleKey,
    required this.icon,
  });
}
