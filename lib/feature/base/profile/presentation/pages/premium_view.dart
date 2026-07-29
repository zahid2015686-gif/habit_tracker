import 'package:flutter/material.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/profile/data/models/premium_model.dart';
import 'package:habit_tracker/feature/base/profile/presentation/vm/profile_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PremiumView extends StatelessWidget {
  static const String route = '/premium_view';

  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PremiumViewBody();
  }
}

class _PremiumViewBody extends StatelessWidget {
  const _PremiumViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.white,
      body: Consumer<ProfileVm>(
        builder: (context, vm, _) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 16.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _upgradeBadge(),
                  SizedBox(height: 16.px),
                  _headerText(),
                  SizedBox(height: 24.px),

                  // ---------------- Standard Plan ----------------
                  _planCard(
                    context: context,
                    vm: vm,
                    plan: PremiumPlanModel.standard,
                    headerGradient: null,
                    headerColor: R.appColors.white,
                  ),
                  SizedBox(height: 14.px),

                  // ---------------- Premium Plan ----------------
                  _planCard(
                    context: context,
                    vm: vm,
                    plan: PremiumPlanModel.premium,
                    headerGradient: LinearGradient(
                      colors: [R.appColors.orange, R.appColors.textGreen],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    headerColor: null,
                  ),
                  SizedBox(height: 20.px),

                  // ---------------- Purchase Now ----------------
                  _primaryButton(
                    label: vm.purchaseButtonLabel,
                    isLoading: vm.isPurchasing,
                    onTap: () => vm.purchaseSelectedPlan(context),
                  ),
                  SizedBox(height: 14.px),

                  // ---------------- Proceed with Free Package ----------------
                  Center(
                    child: GestureDetector(
                      onTap: () => vm.proceedWithFreePackage(context),
                      child: Text(
                        'Proceed with Free Package',
                        style: R.appTextStyle.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: R.appColors.orange,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14.px),

                  // ---------------- Money-back guarantee pill ----------------
                  Center(child: _guaranteePill()),
                  SizedBox(height: 10.px),

                  Text(
                    'If you are not building better habits within 30 days, we will refund you — no questions asked.',
                    textAlign: TextAlign.center,
                    style: R.appTextStyle.poppins(
                      fontSize: 12,
                      color: R.appColors.black.withValues(alpha: 0.45),
                    ),
                  ),
                  SizedBox(height: 20.px),

                  // ---------------- Get Started ----------------
                  _primaryButton(
                    label: vm.getStartedButtonLabel,
                    isLoading: false,
                    onTap: () => vm.getStarted(context),
                  ),
                  SizedBox(height: 8.px),

                  Center(
                    child: Text(
                      'Cancel anytime · No lock-in',
                      style: R.appTextStyle.poppins(
                        fontSize: 11,
                        color: R.appColors.black.withValues(alpha: 0.35),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.px),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- Upgrade badge ----------------
  Widget _upgradeBadge() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.px, vertical: 6.px),
        decoration: BoxDecoration(
          color: R.appColors.textGreen.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20.px),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.workspace_premium,
              size: 14,
              color: R.appColors.textGreen,
            ),
            SizedBox(width: 6.px),
            Text(
              'Upgrade',
              style: R.appTextStyle.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: R.appColors.textGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Header text ----------------
  Widget _headerText() {
    return Column(
      children: [
        Text(
          'Build Better Habits\nWith Real Coaching',
          textAlign: TextAlign.center,
          style: R.appTextStyle.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: R.appColors.black,
            height: 1.3,
          ),
        ),
        SizedBox(height: 10.px),
        Text(
          'Unlock unlimited habits and deep analytics. Build the life\nyou want — with a coach in your pocket.',
          textAlign: TextAlign.center,
          style: R.appTextStyle.poppins(
            fontSize: 13,
            color: R.appColors.black.withValues(alpha: 0.5),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // ---------------- Plan card (Standard / Premium) ----------------
  Widget _planCard({
    required BuildContext context,
    required ProfileVm vm,
    required PremiumPlanModel plan,
    required Gradient? headerGradient,
    required Color? headerColor,
  }) {
    final bool isSelected = vm.selectedPlan == plan.type;
    final bool isPremium = plan.type == PlanType.premium;

    return GestureDetector(
      onTap: () => vm.selectPlan(plan.type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(18.px),
          border: Border.all(
            color: isSelected ? R.appColors.textGreen : R.appColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // ---------- Header row ----------
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 14.px),
              decoration: BoxDecoration(
                gradient: isPremium ? headerGradient : null,
                color: isPremium ? null : headerColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isPremium ? Icons.workspace_premium : Icons.star_border,
                        size: 18,
                        color: isPremium
                            ? R.appColors.white
                            : R.appColors.black,
                      ),
                      SizedBox(width: 8.px),
                      Text(
                        plan.title,
                        style: R.appTextStyle.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isPremium
                              ? R.appColors.white
                              : R.appColors.black,
                        ),
                      ),
                      if (plan.badge != null) ...[
                        SizedBox(width: 8.px),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.px,
                            vertical: 2.px,
                          ),
                          decoration: BoxDecoration(
                            color: R.appColors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(20.px),
                          ),
                          child: Text(
                            plan.badge!,
                            style: R.appTextStyle.poppins(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: R.appColors.white,
                            ),
                          ),
                        ),
                      ],
                      const Spacer(),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: plan.price,
                              style: R.appTextStyle.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: isPremium
                                    ? R.appColors.white
                                    : R.appColors.black,
                              ),
                            ),
                            TextSpan(
                              text: '/mo',
                              style: R.appTextStyle.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: isPremium
                                    ? R.appColors.white.withValues(alpha: 0.8)
                                    : R.appColors.black.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.px),
                      _selectIndicator(
                        isSelected: isSelected,
                        isPremium: isPremium,
                      ),
                    ],
                  ),
                  if (isPremium) ...[
                    SizedBox(height: 4.px),
                    Text(
                      plan.subtitle,
                      style: R.appTextStyle.poppins(
                        fontSize: 11,
                        color: R.appColors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // ---------- Expanded content ----------
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              crossFadeState: isSelected
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Padding(
                padding: EdgeInsets.fromLTRB(16.px, 14.px, 16.px, 16.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isPremium)
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.px),
                        child: Text(
                          plan.subtitle,
                          style: R.appTextStyle.poppins(
                            fontSize: 12,
                            color: R.appColors.black.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ...plan.features.map(
                      (f) => Padding(
                        padding: EdgeInsets.only(bottom: 6.px),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check,
                              size: 15,
                              color: R.appColors.textGreen,
                            ),
                            SizedBox(width: 8.px),
                            Expanded(
                              child: Text(
                                f,
                                style: R.appTextStyle.poppins(
                                  fontSize: 12.5,
                                  color: R.appColors.black.withValues(
                                    alpha: 0.75,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 6.px),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.px,
                        vertical: 8.px,
                      ),
                      decoration: BoxDecoration(
                        color: R.appColors.textGreen.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10.px),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified_outlined,
                            size: 14,
                            color: R.appColors.textGreen,
                          ),
                          SizedBox(width: 6.px),
                          Text(
                            plan.trialText,
                            style: R.appTextStyle.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: R.appColors.textGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              secondChild: const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectIndicator({required bool isSelected, required bool isPremium}) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? R.appColors.textGreen
            : (isPremium ? Colors.transparent : R.appColors.white),
        border: Border.all(
          color: isSelected
              ? R.appColors.textGreen
              : (isPremium
                    ? R.appColors.white.withValues(alpha: 0.7)
                    : R.appColors.border),
          width: 1.5,
        ),
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 14, color: Colors.white)
          : null,
    );
  }

  // ---------------- Guarantee pill ----------------
  Widget _guaranteePill() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.px, vertical: 8.px),
      decoration: BoxDecoration(
        color: R.appColors.textGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20.px),
        border: Border.all(color: R.appColors.textGreen.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_user_outlined,
            size: 14,
            color: R.appColors.textGreen,
          ),
          SizedBox(width: 6.px),
          Text(
            '30-day money-back guarantee',
            style: R.appTextStyle.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: R.appColors.textGreen,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Primary button ----------------
  Widget _primaryButton({
    required String label,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: R.appColors.textGreen,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.workspace_premium,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.px),
                  Text(
                    label,
                    style: R.appTextStyle.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: R.appColors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
