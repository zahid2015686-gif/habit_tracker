import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/core/widgets/app_button.dart';
import 'package:habit_tracker/feature/base/profile/presentation/pages/premium_view.dart';
import 'package:sizer/sizer.dart';

class SigninView extends StatefulWidget {
  static const String route = '/signin_view';

  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            vSpacePx(50),
            Image.asset(R.appImages.logo, width: 50.w),
            vSpacePx(20),
            Text(
              'welcome_to_rhythmi'.L(),
              style: R.appTextStyle.poppins(
                color: R.appColors.darkBlack,
                fontSize: 24.px,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'sign_in_to_continue_your_rhythm'.L(),
              style: R.appTextStyle.poppins(color: R.appColors.textLightBlack),
            ),
            vSpacePx(20),
            _continueWithGoogleButton(),
            vSpacePx(10),
            _continueWithAppleButton(),
            vSpacePx(20),
            _agreeTermsAndPrivacy(),
            vSpacePx(30),
            Image.asset(R.appImages.logoLight, width: 50.w),
          ],
        ),
      ),
    );
  }

  Widget _continueWithGoogleButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.px),
      child: AppButton(
        text: 'continue_with_google'.L(),
        borderRadius: 16.px,
        borderIsMandatory: true,
        borderColor: R.appColors.black.withValues(alpha: 0.09),
        borderWidth: 2,
        textStyle: R.appTextStyle.poppins(
          color: R.appColors.darkBlack,
          fontWeight: FontWeight.w600,
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (_) => _googleBottomSheet(),
          );
        },
        leftIconSpce: 10.px,
        leftIcon: Image.asset(R.appImages.googleIcon, width: 14.px),
      ),
    );
  }

  Widget _continueWithAppleButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: AppButton(
        text: 'continue_with_apple'.L(),
        color: R.appColors.darkBlack,
        borderRadius: 16.px,
        textStyle: R.appTextStyle.poppins(
          color: R.appColors.white,
          fontWeight: FontWeight.w600,
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (_) => _appleBottomSheet(),
          );
        },
        leftIconSpce: 10.px,
        leftIcon: Image.asset(R.appImages.appleIcon, width: 18.px),
      ),
    );
  }

  Widget _agreeTermsAndPrivacy() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: R.appTextStyle.poppins(
          fontSize: 12,
          color: R.appColors.slateGray,
          height: 1.4,
        ),
        children: [
          TextSpan(text: 'by_continuing_you_agree_to_our'.L()),
          TextSpan(
            text: 'terms'.L(),
            style: R.appTextStyle.poppins(
              fontSize: 12,
              color: R.appColors.seaGreen,
            ),
          ),
          TextSpan(text: 'and'.L()),
          TextSpan(
            text: 'privacy_policy'.L(),
            style: R.appTextStyle.poppins(
              fontSize: 12,
              color: R.appColors.seaGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _googleBottomSheet() {
    return Container(
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.px)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              vSpacePx(10),
              Container(
                width: 40.px,
                height: 4.px,
                decoration: R.appDecorations.cardDecoration(
                  color: R.appColors.black.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              vSpacePx(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.px),
                child: Row(
                  children: [
                    Image.asset(
                      R.appImages.googleIcon,
                      color: R.appColors.darkBlack,
                      width: 20.px,
                      height: 20.px,
                    ),
                    hSpacePx(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "sign_in_with_google".L(),
                          style: R.appTextStyle.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: R.appColors.darkBlack,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "choose_an_account_to_continue".L(),
                          style: R.appTextStyle.poppins(
                            fontSize: 12,
                            color: R.appColors.darkBlack.withValues(
                              alpha: 0.33,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              vSpacePx(10),
              Divider(
                height: 1,
                color: R.appColors.darkBlack.withValues(alpha: 0.07),
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 20.px,
                  backgroundColor: R.appColors.textLightGreen,
                  child: Text(
                    "A",
                    style: R.appTextStyle.poppins(
                      color: R.appColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                title: Text(
                  "Williams James",
                  style: R.appTextStyle.poppins(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  "willi.james@gmail.com",
                  style: R.appTextStyle.poppins(
                    color: R.appColors.black.withValues(alpha: 0.33),
                    fontSize: 12,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: R.appColors.black.withValues(alpha: 0.33),
                ),
                onTap: () {
                  Get.offAllNamed(PremiumView.route);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 20.px,
                  backgroundColor: R.appColors.textLightGreen,
                  child: Text(
                    "W",
                    style: R.appTextStyle.poppins(
                      color: R.appColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                title: Text(
                  "Anderson Luke",
                  style: R.appTextStyle.poppins(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  "luke.and@company.co",
                  style: R.appTextStyle.poppins(
                    color: R.appColors.black.withValues(alpha: 0.33),
                    fontSize: 12,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: R.appColors.black.withValues(alpha: 0.33),
                ),
                onTap: () {
                  Get.offAllNamed(PremiumView.route);
                },
              ),
              ListTile(
                leading: DottedBorder(
                  options: OvalDottedBorderOptions(
                    color: R.appColors.slateGray,
                    strokeWidth: 2,
                    dashPattern: [4, 3],
                    padding: EdgeInsets.zero,
                  ),
                  child: CircleAvatar(
                    radius: 20.px,
                    backgroundColor: R.appColors.white,
                    child: Icon(
                      Icons.add,
                      color: R.appColors.black.withValues(alpha: 0.33),
                    ),
                  ),
                ),
                title: Text(
                  "add_another_account".L(),
                  style: R.appTextStyle.poppins(
                    fontWeight: FontWeight.w500,
                    color: R.appColors.darkBlack,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appleBottomSheet() {
    return Container(
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.px)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20.px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              vSpacePx(10),
              Container(
                width: 40.px,
                height: 4.px,
                decoration: R.appDecorations.cardDecoration(
                  color: R.appColors.black.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              vSpacePx(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.px),
                child: Row(
                  children: [
                    Container(
                      width: 40.px,
                      height: 40.px,
                      padding: EdgeInsets.all(10.px),
                      decoration: R.appDecorations.cardDecoration(
                        color: R.appColors.darkBlack,
                      ),
                      child: Image.asset(
                        R.appImages.appleIcon,
                        color: R.appColors.white,
                      ),
                    ),
                    hSpacePx(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "sign_in_with_apple".L(),
                          style: R.appTextStyle.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: R.appColors.darkBlack,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "use_your_apple_id_to_continue".L(),
                          style: R.appTextStyle.poppins(
                            fontSize: 12,
                            color: R.appColors.darkBlack.withValues(
                              alpha: 0.33,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              vSpacePx(10),
              Divider(
                height: 1,
                color: R.appColors.darkBlack.withValues(alpha: 0.07),
              ),
              vSpacePx(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.px),
                child: InkWell(
                  onTap: () {
                    Get.offAllNamed(PremiumView.route);
                  },
                  borderRadius: BorderRadius.circular(16.px),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.px),
                    decoration: R.appDecorations.cardDecoration(
                      color: R.appColors.screenBackground2,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: R.appColors.cardBackground.withValues(
                          alpha: 0.70,
                        ),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40.px,
                          height: 40.px,
                          padding: EdgeInsets.all(10),
                          decoration: R.appDecorations.cardDecoration(
                            shape: BoxShape.circle,
                            color: R.appColors.screenBackground3,
                          ),
                          child: Image.asset(
                            R.appImages.facebookIcon,
                            fit: BoxFit.cover,
                          ),
                        ),
                        hSpacePx(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "willi.jame@icloud.com",
                                style: R.appTextStyle.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: R.appColors.darkBlack,
                                ),
                              ),
                              Text(
                                "Sign in with Face ID",
                                style: R.appTextStyle.poppins(
                                  fontSize: 12,
                                  color: R.appColors.darkBlack.withValues(
                                    alpha: 0.33,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              vSpacePx(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.px),
                child: AppButton(
                  text: 'continue'.L(),
                  color: R.appColors.darkBlack,
                  borderRadius: 16.px,
                  textStyle: R.appTextStyle.poppins(
                    color: R.appColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  onTap: () {
                    Get.offAllNamed(PremiumView.route);
                  },
                ),
              ),
              vSpacePx(10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.px),
                child: AppButton(
                  text: 'cancel'.L(),
                  color: R.appColors.darkBlack.withValues(alpha: 0.05),
                  borderRadius: 16.px,
                  textStyle: R.appTextStyle.poppins(
                    color: R.appColors.darkBlack,
                    fontWeight: FontWeight.w600,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}