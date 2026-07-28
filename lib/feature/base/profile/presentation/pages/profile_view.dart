import 'package:flutter/material.dart';
import 'package:habit_tracker/core/resources/resources.dart';

class ProfileView extends StatelessWidget {
  static const String route = '/profile_view';
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: R.appColors.screenBackground2,
      body: Center(
        child: Text('ProfileView'),
      ),
    );
  }
}
