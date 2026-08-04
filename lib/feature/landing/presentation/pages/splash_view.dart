import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/landing/presentation/pages/onboarding_view.dart';
import 'package:sizer/sizer.dart';

class SplashView extends StatefulWidget {
  static const String route = '/splash_view';

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: R.appColors.screenBackground,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: R.appColors.screenBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(OnboardingView.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.screenBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Column(
                  children: [
                    Image.asset(R.appImages.logo, width: 60.w),
                    vSpacePx(8),
                    Text(
                      'build_better_habits'.L(),
                      style: R.appTextStyle.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        color: R.appColors.black,
                      ),
                    ),
                  ],
                ),
                vSpacePx(100),
                Image.asset(
                  R.appImages.logoLight,
                  width: 60.w,
                  alignment: Alignment.center,
                ),
                vSpacePx(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}