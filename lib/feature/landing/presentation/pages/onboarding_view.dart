import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/core/widgets/app_button.dart';
import 'package:habit_tracker/feature/landing/presentation/vm/onboarding_vm.dart';
import 'package:habit_tracker/feature/user/presentation/pages/signin_view.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:sizer/sizer.dart';

class OnboardingView extends StatefulWidget {
  static const String route = '/onboarding_view';

  const OnboardingView({super.key});

  // Swipe sensitivity: minimum horizontal velocity to count as a swipe.
  static const double _swipeVelocityThreshold = 200;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  void _finishOnboarding(BuildContext context) {
    Get.offAllNamed(SigninView.route);
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: R.appColors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,

        systemNavigationBarColor: R.appColors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingVm(),
      child: Consumer<OnboardingVm>(
        builder: (context, vm, _) {
          return Scaffold(
            body: GestureDetector(
              onHorizontalDragEnd: (details) {
                final velocity = details.primaryVelocity ?? 0;
                if (velocity <= -OnboardingView._swipeVelocityThreshold) {
                  vm.goToNext(() => _finishOnboarding(context));
                } else if (velocity >= OnboardingView._swipeVelocityThreshold) {
                  vm.goToBack();
                }
              },
              child: _animatedContent(vm, context),
            ),
          );
        },
      ),
    );
  }

  Widget _animatedContent(OnboardingVm vm, BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.center,
        children: [...previousChildren, if (currentChild != null) currentChild],
      ),
      child: Container(
        key: ValueKey(vm.currentIndex),
        width: double.infinity,
        height: double.infinity,
        decoration: R.appDecorations.cardDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [R.appColors.oliveGreen, R.appColors.softOrange],
            stops: [0.0, 0.55],
            //transform: GradientRotation(30 * math.pi / 180),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _skipButton(vm, context),
              _image(vm, context),
              _card(vm, context),
              _dots(vm),
            ],
          ),
        ),
      ),
    );
  }

  Widget _skipButton(OnboardingVm vm, BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: TextButton(
          onPressed: () => vm.skip(),
          child: Text(
            'skip'.L(),
            style: R.appTextStyle.poppins(
              color: R.appColors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _image(OnboardingVm vm, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      flex: 5,
      child: Center(
        child: Container(
          width: size.width * 0.62,
          height: size.width * 0.62,
          decoration: R.appDecorations.cardDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: R.appColors.white.withValues(alpha: 0.5),
              width: 3,
            ),
            image: DecorationImage(
              image: AssetImage(vm.currentPage.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _card(OnboardingVm vm, BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(20.px, 0.px, 20.px, 16.px),
        padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 28.px),
        decoration: R.appDecorations.cardDecoration(
          color: R.appColors.white.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(32.px),
          boxShadow: [
            BoxShadow(
              color: R.appColors.black.withValues(alpha: 0.08),
              offset: Offset(0, 25),
              blurRadius: 50,
              spreadRadius: -12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 48.px,
                    height: 48.px,
                    decoration: R.appDecorations.cardDecoration(
                      color: R.appColors.white.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(13.px),
                    child: Image.asset(
                      vm.currentPage.icon,
                      color: R.appColors.white,
                    ),
                  ),
                  vSpacePx(5),
                  Text(
                    vm.currentPage.titleKey,
                    textAlign: TextAlign.center,
                    style: R.appTextStyle.poppins(
                      color: R.appColors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  vSpacePx(5),
                  Text(
                    vm.currentPage.descKey,
                    textAlign: TextAlign.center,
                    style: R.appTextStyle.poppins(
                      color: R.appColors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            vSpacePx(10),
            _buttonRow(vm, context),
          ],
        ),
      ),
    );
  }

  Widget _nextButton(OnboardingVm vm, BuildContext context) {
    return AppButton(
      height: 48.px,
      text: 'next'.L(),
      onTap: () => vm.goToNext(() => _finishOnboarding(context)),
    );
  }

  Widget _buttonRow(OnboardingVm vm, BuildContext context) {
    if (vm.isFirstPage) {
      return SizedBox(width: double.infinity, child: _nextButton(vm, context));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: vm.goToBack,
          child: Text(
            'back'.L(),
            style: R.appTextStyle.poppins(
              color: R.appColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 30.w, child: _nextButton(vm, context)),
      ],
    );
  }

  Widget _dots(OnboardingVm vm) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(vm.totalPages, (i) {
          final active = i == vm.currentIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 10.px,
            height: 10.px,
            decoration: R.appDecorations.cardDecoration(
              color: active
                  ? R.appColors.white
                  : R.appColors.white.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
