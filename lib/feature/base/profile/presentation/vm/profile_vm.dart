import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/feature/base/base_view/presentation/pages/base_view.dart';
import 'package:habit_tracker/feature/base/profile/data/models/premium_model.dart';

class ProfileVm extends ChangeNotifier{

  static const PremiumPlanModel standard = PremiumPlanModel(
    type: PlanType.standard,
    title: 'Standard',
    price: '£5.29',
    subtitle: 'Everything you need to build great habits',
    features: [
      'Unlimited habits',
      'Advanced rhythm analytics',
      'Custom habit colours & icons',
      'Weekly review reports',
      'Daily reminders',
    ],
    trialText: '7-day free trial · Cancel anytime',
  );

  static const PremiumPlanModel premium = PremiumPlanModel(
    type: PlanType.premium,
    title: 'Premium',
    price: '£14.99',
    badge: 'POPULAR',
    subtitle: 'Habits + real coaching to accelerate your growth',
    features: [
      'Everything in Standard',
      'Live coach chat access',
      'Optional 15-min weekly coaching call',
      'Personalised coaching insights',
      'Priority coach response',
    ],
    trialText: '7-day free trial · Cancel anytime',
  );

  static const List<PremiumPlanModel> all = [standard, premium];

  // Getter
  List<PremiumPlanModel> get premiumPlan => all;


  // Currently selected plan — defaults to Standard (as in screenshot 1)
  PlanType selectedPlan = PlanType.standard;
  bool isPurchasing = false;

  PremiumPlanModel get selectedPlanModel =>
      all.firstWhere((e) => e.type == selectedPlan);

  void selectPlan(PlanType type) {
    if (selectedPlan == type) return;
    selectedPlan = type;
    notifyListeners();
  }

  bool isExpanded(PlanType type) => selectedPlan == type;

// ---------------- UI-only labels ----------------
  String get purchaseButtonLabel =>
      'Start ${selectedPlanModel.title} · ${selectedPlanModel.price}/mo';

  String get getStartedButtonLabel => 'Get Started';

// ---------------- Actions ----------------
  void purchaseSelectedPlan(BuildContext context) {
    isPurchasing = true;
    notifyListeners();

    isPurchasing = false;
    notifyListeners();
  }

  void proceedWithFreePackage(BuildContext context) {
    Get.offAllNamed(BaseView.route);
  }

  void getStarted(BuildContext context) {
    Get.offAllNamed(BaseView.route);
  }


}