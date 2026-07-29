import 'package:flutter/material.dart';
import 'package:habit_tracker/feature/base/base_view/presentation/vm/base_vm.dart';
import 'package:habit_tracker/feature/base/habits/presentation/vm/habit_vm.dart';
import 'package:habit_tracker/feature/base/profile/presentation/vm/profile_vm.dart';
import 'package:habit_tracker/feature/landing/presentation/vm/onboarding_vm.dart';
import 'package:provider/provider.dart';

class Injector extends StatelessWidget {
  final Widget routerWidget;

  const Injector({super.key, required this.routerWidget});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnboardingVm()),
        ChangeNotifierProvider(create: (context) => BaseVm()),
        ChangeNotifierProvider(create: (context) => HabitVm()),
        ChangeNotifierProvider(create: (context) => ProfileVm()),
      ],
      child: routerWidget,
    );
  }
}
