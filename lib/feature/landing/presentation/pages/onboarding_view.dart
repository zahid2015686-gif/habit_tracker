import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  static const String route = '/onboarding_view';
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding'),
      ),
    );
  }
}
