import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/core/widgets/app_button.dart';
import 'package:habit_tracker/feature/base/base_view/presentation/pages/base_view.dart';
import 'package:habit_tracker/feature/base/profile/data/models/premium_model.dart';
import 'package:habit_tracker/feature/base/profile/presentation/vm/profile_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PremiumView extends StatefulWidget {
  static const String route = '/premium_view';

  const PremiumView({super.key});

  @override
  State<PremiumView> createState() => _PremiumViewState();
}

class _PremiumViewState extends State<PremiumView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: R.appColors.screenBackground2,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,

        systemNavigationBarColor: R.appColors.screenBackground2,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.screenBackground2,
      body: Consumer<ProfileVm>(
        builder: (context, vm, _) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 16.px),
              child: Column(
                children: [
                  _upgradeBadge(),
                  vSpacePx(10),
                  _headerText(),
                  vSpacePx(10),
                  // ---------------- Standard Plan ----------------
                  _planCard(
                    context: context,
                    vm: vm,
                    plan: ProfileVm.standard,
                    headerGradient: null,
                    headerColor: R.appColors.white,
                  ),
                  vSpacePx(10),
                  // ---------------- Premium Plan ----------------
                  _planCard(
                    context: context,
                    vm: vm,
                    plan: ProfileVm.premium,
                    headerGradient: LinearGradient(
                      colors: [R.appColors.orange, R.appColors.textGreen],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    headerColor: null,
                  ),
                  vSpacePx(14),
                  _primaryButton(
                    label: vm.purchaseButtonLabel,
                    isLoading: vm.isPurchasing,
                    onTap: () {
                      vm.goToHome(vm);
                    },
                  ),
                  vSpacePx(14),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        vm.selectPlan(PlanType.standard);
                        vm.goToHome(vm);
                      },
                      child: Text(
                        'proceed_with_free_package'.L(),
                        style: R.appTextStyle.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: R.appColors.primary,
                        ),
                      ),
                    ),
                  ),
                  vSpacePx(12),
                  Center(child: _guaranteePill()),
                  vSpacePx(10),
                  Text(
                    'money_back_description'.L(),
                    textAlign: TextAlign.center,
                    style: R.appTextStyle.poppins(
                      fontSize: 12,
                      color: R.appColors.slateGray,
                    ),
                  ),
                  vSpacePx(10),
                  _primaryButton(
                    label: vm.getStartedButtonLabel,
                    isLoading: false,
                    onTap: () {
                      vm.goToHome(vm);
                    },
                  ),
                  vSpacePx(8),
                  Center(
                    child: Text(
                      'cancel_anytime_no_lock_in'.L(),
                      style: R.appTextStyle.poppins(
                        fontSize: 10,
                        color: R.appColors.coolGray,
                      ),
                    ),
                  ),
                  vSpacePx(12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _upgradeBadge() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13.px, vertical: 7.px),
        decoration: R.appDecorations.cardDecoration(
          color: R.appColors.screenBackground4,
          borderRadius: BorderRadius.circular(100.px),
          border: Border.all(
            color: R.appColors.border2.withValues(alpha: 0.50),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              R.appImages.premium,
              width: 11,
              color: R.appColors.successGreen,
            ),
            SizedBox(width: 6.px),
            Text(
              'upgrade'.L(),
              style: R.appTextStyle.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: R.appColors.successGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return Column(
      children: [
        Text(
          'build_better_habits_with_real_coaching'.L(),
          textAlign: TextAlign.center,
          style: R.appTextStyle.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: R.appColors.darkBlack,
            height: 1.3,
          ),
        ),
        vSpacePx(10),
        Text(
          'unlock_unlimited_habits_and_deep_analytics'.L(),
          textAlign: TextAlign.center,
          style: R.appTextStyle.poppins(
            color: R.appColors.textLightBlack,
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
        duration: Duration(milliseconds: 250),
        decoration: R.appDecorations.cardDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(16.px),
          border: Border.all(
            color: isSelected
                ? R.appColors.seaGreen
                : R.appColors.cardBackground,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: R.appColors.black.withValues(alpha: 0.10),
              blurRadius: 4,
              offset: const Offset(0, 2),
              spreadRadius: -4,
            ),
            BoxShadow(
              color: R.appColors.black.withValues(alpha: 0.10),
              blurRadius: 6,
              offset: const Offset(0, 4),
              spreadRadius: -1,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 10.px),
              decoration: R.appDecorations.cardDecoration(
                gradient: isPremium ? headerGradient : null,
                color: isPremium ? null : headerColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.px),
                  topRight: Radius.circular(16.px),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24.px,
                        height: 24.px,
                        padding: EdgeInsets.all(6.px),
                        decoration: R.appDecorations.cardDecoration(
                          color: () {
                            if (isPremium) {
                              return isSelected
                                  ? R.appColors.white.withValues(alpha: 0.25)
                                  : R.appColors.white;
                            }

                            return isSelected
                                ? R.appColors.screenBackground3
                                : R.appColors.border;
                          }(),
                        ),
                        child: Image.asset(
                          isPremium ? R.appImages.premium : R.appImages.star5,
                          width: 12.px,
                          color: () {
                            if (isPremium) {
                              return isSelected
                                  ? R.appColors.white
                                  : R.appColors.warmGold;
                            }

                            return isSelected
                                ? R.appColors.textLightGreen
                                : R.appColors.slateGray;
                          }(),
                        ),
                      ),
                      hSpacePx(10),
                      Text(
                        plan.title,
                        style: R.appTextStyle.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: () {
                            if (isPremium) {
                              return isSelected
                                  ? R.appColors.white
                                  : R.appColors.white.withValues(alpha: 0.90);
                            }
                            return isSelected
                                ? R.appColors.darkBlack
                                : R.appColors.textBlack;
                          }(),
                        ),
                      ),
                      if (plan.badge != null) ...[
                        hSpacePx(8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.px,
                            vertical: 2.px,
                          ),
                          decoration: R.appDecorations.cardDecoration(
                            color: R.appColors.white.withValues(alpha: 0.20),
                            borderRadius: BorderRadius.circular(100.px),
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
                      Spacer(),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: plan.price,
                              style: R.appTextStyle.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: () {
                                  if (isPremium) {
                                    return isSelected
                                        ? R.appColors.white
                                        : R.appColors.white.withValues(
                                            alpha: 0.90,
                                          );
                                  }
                                  return isSelected
                                      ? R.appColors.darkBlack
                                      : R.appColors.textBlack;
                                }(),
                              ),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.top,
                              child: Transform.translate(
                                offset: const Offset(0, -5),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 2.px),
                                  child: Text(
                                    '/mo',
                                    style: R.appTextStyle.poppins(
                                      fontSize: 11,
                                      color: isPremium
                                          ? R.appColors.white.withValues(
                                              alpha: 0.60,
                                            )
                                          : R.appColors.slateGray,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      hSpacePx(8),
                      _selectIndicator(
                        isSelected: isSelected,
                        isPremium: isPremium,
                      ),
                    ],
                  ),
                  if (isPremium && isSelected) ...[
                    vSpacePx(4),
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
              duration: Duration(milliseconds: 250),
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
                            Container(
                              width: 16.px,
                              height: 16.px,
                              padding: EdgeInsets.all(4.px),
                              decoration: R.appDecorations.cardDecoration(
                                color: isPremium
                                    ? R.appColors.screenBackground3
                                    : R.appColors.border,
                              ),
                              child: Image.asset(
                                R.appImages.tickIcon,
                                width: 10,
                                color: isPremium
                                    ? R.appColors.successGreen
                                    : R.appColors.textLightBlack,
                              ),
                            ),
                            hSpacePx(10),
                            Expanded(
                              child: Text(
                                f,
                                style: R.appTextStyle.poppins(
                                  fontSize: 12,
                                  color: R.appColors.textBlack,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    hSpacePx(10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.px,
                        vertical: 6.px,
                      ),
                      decoration: R.appDecorations.cardDecoration(
                        color: R.appColors.screenBackground4,
                        borderRadius: BorderRadius.circular(12.px),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            R.appImages.verifiedIcon,
                            width: 11,
                            color: R.appColors.successGreen,
                          ),
                          hSpacePx(10),
                          Text(
                            plan.trialText,
                            style: R.appTextStyle.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: R.appColors.successGreen,
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
      width: 20.px,
      height: 20.px,
      padding: EdgeInsets.all(4.px),
      decoration: R.appDecorations.cardDecoration(
        shape: BoxShape.circle,
        color: () {
          if (isPremium) {
            return isSelected ? R.appColors.white : R.appColors.transparent;
          }
          return isSelected ? R.appColors.seaGreen : R.appColors.transparent;
        }(),
        border: Border.all(
          color: () {
            if (isPremium) {
              return isSelected ? R.appColors.white : R.appColors.border3;
            }
            return isSelected ? R.appColors.seaGreen : R.appColors.border3;
          }(),
          width: 1.5,
        ),
      ),
      child: isSelected
          ? Image.asset(
              R.appImages.tickIcon,
              width: 20,
              color: isPremium ? R.appColors.mossGreen : R.appColors.white,
            )
          : null,
    );
  }

  // ---------------- Guarantee pill ----------------
  Widget _guaranteePill() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19.px, vertical: 9.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.seaGreen.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(100.px),
        border: Border.all(
          color: R.appColors.seaGreen.withValues(alpha: 0.50),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            R.appImages.verifiedIcon,
            width: 11,
            color: R.appColors.seaGreen,
          ),
          SizedBox(width: 6.px),
          Text(
            'premium_money_back_guarantee'.L(),
            style: R.appTextStyle.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: R.appColors.seaGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _primaryButton({
    required String label,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    return AppButton(
      onTap: onTap,
      text: label,
      textStyle: R.appTextStyle.poppins(
        color: R.appColors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      isLoading: false,
      leftIcon: Image.asset(
        R.appImages.premium,
        width: 14,
        color: R.appColors.white,
      ),
      color: R.appColors.seaGreen,
      borderRadius: 12,
    );
  }
}
