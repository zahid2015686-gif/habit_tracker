import 'package:flutter/material.dart';
import 'package:habit_tracker/core/resources/resources.dart';

class RhythmView extends StatelessWidget {
  static const String route = '/rhythm_view';
  const RhythmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.screenBackground2,
      body: Center(
        child: Text('RhythmView'),
      ),
    );
  }
}
