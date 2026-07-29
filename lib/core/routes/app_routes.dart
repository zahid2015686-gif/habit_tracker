import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/feature/base/base_view/presentation/pages/base_view.dart';
import 'package:habit_tracker/feature/base/habits/presentation/pages/habits_view.dart';
import 'package:habit_tracker/feature/base/home/presentation/pages/home_view.dart';
import 'package:habit_tracker/feature/base/profile/presentation/pages/premium_view.dart';
import 'package:habit_tracker/feature/base/profile/presentation/pages/profile_view.dart';
import 'package:habit_tracker/feature/base/rhythm/presentation/pages/rhythm_view.dart';
import 'package:habit_tracker/feature/landing/presentation/pages/onboarding_view.dart';
import 'package:habit_tracker/feature/landing/presentation/pages/splash_view.dart';
import 'package:habit_tracker/feature/user/presentation/pages/signin_view.dart';

abstract class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: SplashView.route,
      page: () => const SplashView(),
      curve: Curves.easeInOut,
      transition: Transition.noTransition,
    ),
    GetPage(
      name: OnboardingView.route,
      page: () => const OnboardingView(),
      curve: Curves.easeInOut,
      transition: Transition.noTransition,
    ),
    GetPage(
      name: SigninView.route,
      page: () => const SigninView(),
      curve: Curves.easeInOut,
      transition: Transition.noTransition,
    ),
    GetPage(
      name: BaseView.route,
      page: () => const BaseView(),
      curve: Curves.easeInOut,
      transition: Transition.noTransition,
    ),
    GetPage(
      name: HabitsView.route,
      page: () => const HabitsView(),
      curve: Curves.easeInOut,
      transition: Transition.noTransition,
    ),
    GetPage(
      name: HomeView.route,
      page: () => const HomeView(),
      curve: Curves.easeInOut,
      transition: Transition.noTransition,
    ),
    GetPage(
      name: ProfileView.route,
      page: () => const ProfileView(),
      curve: Curves.easeInOut,
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RhythmView.route,
      page: () => const RhythmView(),
      curve: Curves.easeInOut,
      transition: Transition.noTransition,
    ),
    GetPage(
      name: PremiumView.route,
      page: () => const PremiumView(),
      curve: Curves.easeInOut,
      transition: Transition.noTransition,
    ),
  ];
}
