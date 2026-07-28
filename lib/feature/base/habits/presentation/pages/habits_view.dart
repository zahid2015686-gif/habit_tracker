import 'package:flutter/material.dart';
import 'package:habit_tracker/core/resources/resources.dart';

class HabitsView extends StatelessWidget {
  static const String route = '/habits_view';
  const HabitsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.screenBackground2,
      body: Center(
        child: Text('HabitsView'),
      ),
    );
  }
}
