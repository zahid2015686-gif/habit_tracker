import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    Future.delayed(const Duration(seconds: 3), (){
      Get.toNamed(OnboardingView.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.screenBackground,
      body: SafeArea(child: Center(child: Image.asset(R.appImages.ezRenchLogo, width: 60.w,))),
      bottomNavigationBar: SafeArea(child: Padding(
        padding: EdgeInsets.only(bottom: 20.px),
        child: Text('your_mechanic_on_demand'.L(),
          textAlign: TextAlign.center,
          style: R.appTextStyle.poppins(
          color: R.appColors.black.withValues(alpha: 0.45),
        ),),
      )),
    );
  }
}
