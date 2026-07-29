class AppImages {
  final String logo = 'assets/images/logo.png';
  final String logoLight = 'assets/images/logo_light.png';
  final String onboardingImage_1 = 'assets/images/onboarding_image_1.png';
  final String onboardingImage_2 = 'assets/images/onboarding_image_2.png';
  final String onboardingImage_3 = 'assets/images/onboarding_image_3.png';
  final String onboardingIcon_1 = 'assets/images/onboarding_icon_1.png';
  final String onboardingIcon_2 = 'assets/images/onboarding_icon_2.png';
  final String onboardingIcon_3 = 'assets/images/onboarding_icon_3.png';
  final String googleIcon = 'assets/images/google_icon.png';
  final String appleIcon = 'assets/images/apple_icon.png';
  final String facebookIcon = 'assets/images/facbook_icon.png';
  final String home = 'assets/images/home.png';
  final String habits = 'assets/images/habits.png';
  final String profile = 'assets/images/profile.png';
  final String rhythm = 'assets/images/rhythm.png';
  final String upload = 'assets/images/upload.png';
  final String message = 'assets/images/message.png';
  final String notification = 'assets/images/notification.png';
  final String drinkWater = 'assets/images/drink_water.png';
  final String eveningJournal = 'assets/images/evening_journal.png';
  final String morningMeditation = 'assets/images/morning_meditation.png';
  final String readPages = 'assets/images/read_pages.png';
  final String workout = 'assets/images/workout.png';
  final String bicycle = 'assets/images/cycle.png';
  final String morning = 'assets/images/morning.png';
  final String night = 'assets/images/night.png';
  final String running = 'assets/images/running.png';
  final String walk = 'assets/images/walk.png';
  final String premium = 'assets/images/premium.png';
  final String star1 = 'assets/images/satr_1.png';
  final String star2 = 'assets/images/satr_2.png';
  final String star3 = 'assets/images/satr_3.png';
  final String star4 = 'assets/images/satr_4.png';
  final String tickIcon = 'assets/images/tick_icon.png';
  final String verifiedIcon = 'assets/images/verfied.png';
  final String upcoming = 'assets/images/upcoming.png';
  final String quoteIcon = 'assets/images/quote_icon.png';
}






import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/premium/presentation/vm/welcome_premium_vm.dart';
import 'package:provider/provider.dart';

/// Call this after a successful purchase / on home screen load.
/// It checks SharedPreferences (via [WelcomePremiumVm]) and only
/// shows the dialog the very first time — never again after that.
Future<void> checkAndShowWelcomePremiumDialog(BuildContext context) async {
  final vm = WelcomePremiumVm();
  final bool shouldShow = await vm.shouldShowWelcomeDialog();
  if (!shouldShow || !context.mounted) return;

  await vm.markWelcomeDialogAsShown();
  if (!context.mounted) return;

  await showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (_) => const WelcomePremiumDialog(),
  );
}

class WelcomePremiumDialog extends StatelessWidget {
  const WelcomePremiumDialog({super.key});

  @override
  Widget build(BuildContext context) {

  }


}