import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/feature/landing/presentation/pages/onboarding_view.dart';
import 'package:habit_tracker/feature/landing/presentation/pages/splash_view.dart';
import 'package:habit_tracker/feature/user/presentation/pages/sign_up_view.dart';


abstract class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: SplashView.route,
      page: () => const SignUpView(),
      curve: Curves.easeInOut,
      transition: Transition.noTransition,
    ),
    GetPage(
      name: OnboardingView.route,
      page: () => const OnboardingView(),
      curve: Curves.easeInOut,
      transition: Transition.noTransition,
    ),
  ];
}
