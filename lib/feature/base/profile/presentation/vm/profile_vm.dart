import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/feature/base/base_view/presentation/pages/base_view.dart';
import 'package:habit_tracker/feature/base/profile/data/models/premium_model.dart';

class ProfileVm extends ChangeNotifier{
  // Currently selected plan — defaults to Standard (as in screenshot 1)
  PlanType selectedPlan = PlanType.standard;

  bool isPurchasing = false;

  PremiumPlanModel get selectedPlanModel =>
      selectedPlan == PlanType.standard
          ? PremiumPlanModel.standard
          : PremiumPlanModel.premium;

  void selectPlan(PlanType type) {
    if (selectedPlan == type) return;
    selectedPlan = type;
    notifyListeners();
  }

  bool isExpanded(PlanType type) => selectedPlan == type;

  String get purchaseButtonLabel =>
      'Purchase Now — ${selectedPlanModel.price}/mo';

  String get getStartedButtonLabel =>
      'Get Started — ${PremiumPlanModel.standard.price}/mo';

  // ---------------- Actions ----------------

  Future<void> purchaseSelectedPlan(BuildContext context) async {
    if (isPurchasing) return;
    isPurchasing = true;
    notifyListeners();

    try {
     Get.offAllNamed(BaseView.route);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${selectedPlanModel.title} plan purchase started (${selectedPlanModel.price}/mo)',
            ),
          ),
        );
      }
    } finally {
      isPurchasing = false;
      notifyListeners();
    }
  }

  void proceedWithFreePackage(BuildContext context) {
    // TODO: apni free-tier navigation logic yahan lagayein
    Navigator.of(context).maybePop();
  }

  Future<void> getStarted(BuildContext context) async {
    // "Get Started" hamesha Standard plan par based hai (jaisa screenshots mein)
    selectedPlan = PlanType.standard;
    notifyListeners();
    await purchaseSelectedPlan(context);
  }
}