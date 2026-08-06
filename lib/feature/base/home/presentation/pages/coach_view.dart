import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/core/widgets/app_button.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_insight_model.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_message_model.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_tip_model.dart';
import 'package:habit_tracker/feature/base/home/presentation/pages/coach_chat_view.dart';
import 'package:habit_tracker/feature/base/home/presentation/pages/request_support_view.dart';
import 'package:habit_tracker/feature/base/home/presentation/vm/home_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CoachView extends StatelessWidget {
  static const String route = '/coach_view';

  const CoachView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.screenBackground2,
      appBar: AppBar(
        backgroundColor: R.appColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 20.px,
        title: Consumer<HomeVm>(builder: (context, vm, _) => _appBar(vm)),
      ),
      body: SafeArea(
        child: Consumer<HomeVm>(
          builder: (context, vm, _) {
            return ListView(
              padding: EdgeInsets.fromLTRB(20.px, 16.px, 20.px, 28.px),
              children: [
                _profileCard(vm),
                vSpacePx(14),
                _quickActions(vm),
                vSpacePx(22),
                _insightsHeader(),
                vSpacePx(12),
                ...vm.insights.map(
                  (insight) => Padding(
                    padding: EdgeInsets.only(bottom: 12.px),
                    child: _insightCard(insight),
                  ),
                ),
                vSpacePx(10),
                Text(
                  'todays_tip'.L(),
                  style: R.appTextStyle.poppins(
                    fontSize: 16,
                    color: R.appColors.darkBlack,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                vSpacePx(12),
                _todayTipCard(vm.todayTip),
                vSpacePx(22),
                Text(
                  'all_tips'.L(),
                  style: R.appTextStyle.poppins(
                    fontSize: 16,
                    color: R.appColors.darkBlack,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                vSpacePx(12),
                _tipFilterChips(vm),
                vSpacePx(14),
                ...vm.filteredTips.map(
                  (tip) => Padding(
                    padding: EdgeInsets.only(bottom: 10.px),
                    child: _tipCard(vm: vm, tip: tip),
                  ),
                ),
                vSpacePx(5),
                Text(
                  'about_your_coach'.L(),
                  style: R.appTextStyle.poppins(
                    fontSize: 16,
                    color: R.appColors.darkBlack,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                vSpacePx(10),
                _aboutCard(vm),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _appBar(HomeVm vm) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 36.px,
            height: 36.px,
            decoration: R.appDecorations.cardDecoration(
              color: R.appColors.border,
              borderRadius: BorderRadius.circular(12.px),
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: R.appColors.slate,
              size: 20.px,
            ),
          ),
        ),
        hSpacePx(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'your_coach'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 10,
                  color: R.appColors.textLightBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                vm.coachName,
                style: R.appTextStyle.poppins(
                  fontSize: 18,
                  color: R.appColors.darkSlate,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed(CoachChatView.route),
          child: Container(
            width: 40.px,
            height: 40.px,
            padding: EdgeInsets.all(10.px),
            decoration: R.appDecorations.cardDecoration(
              color: R.appColors.border,
              borderRadius: BorderRadius.circular(14.px),
            ),
            child: Image.asset(R.appImages.coachMessage),
          ),
        ),
      ],
    );
  }

  Widget _profileCard(HomeVm vm) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(20.px),
        border: Border.all(color: R.appColors.cardBackground, width: 1),
        boxShadow: [
          BoxShadow(
            color: R.appColors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 100.px,
            child: Container(
              decoration: R.appDecorations.cardDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.px),
                  topRight: Radius.circular(20.px),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    R.appColors.herbGreen.withValues(alpha: 0.15),
                    R.appColors.softIndigo.withValues(alpha: 0.15),
                    R.appColors.brightSkyBlue.withValues(alpha: 0.10),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.px, 28.px, 20.px, 20.px),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 82.px,
                      height: 82.px,
                      padding: EdgeInsets.all(3.px),
                      decoration: R.appDecorations.cardDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [R.appColors.herbGreen, R.appColors.indigo],
                        ),
                      ),
                      child: Container(
                        decoration: R.appDecorations.cardDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            vm.coachProfileImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 1.px,
                      bottom: 5.px,
                      child: Container(
                        width: 20.px,
                        height: 20.px,
                        decoration: R.appDecorations.cardDecoration(
                          shape: BoxShape.circle,
                          color: R.appColors.successGreen,
                          border: Border.all(
                            color: R.appColors.white,
                            width: 2.8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                vSpacePx(14),
                Text(
                  vm.coachFullTitle,
                  textAlign: TextAlign.center,
                  style: R.appTextStyle.poppins(
                    fontSize: 18,
                    color: R.appColors.darkSlate,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                vSpacePx(8),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.px,
                    vertical: 2.px,
                  ),
                  decoration: R.appDecorations.cardDecoration(
                    color: R.appColors.softPistachio,
                    borderRadius: BorderRadius.circular(100.px),
                  ),
                  child: Text(
                    'senior_habit_coach'.L(),
                    style: R.appTextStyle.poppins(
                      fontSize: 12,
                      color: R.appColors.forestOlive,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                vSpacePx(12),
                Text(
                  vm.coachShortBio,
                  textAlign: TextAlign.center,
                  style: R.appTextStyle.poppins(
                    fontSize: 12,
                    color: R.appColors.textLightBlack,
                    height: 1.5,
                  ),
                ),
                vSpacePx(18),
                AppButton(
                  height: 46,
                  text: 'start_conversation'.L(),
                  color: R.appColors.seaGreen,
                  borderRadius: 16,
                  onTap: () => Get.toNamed(CoachChatView.route),
                  leftIcon: Image.asset(
                    R.appImages.messages,
                    width: 16.px,
                    height: 16.px,
                    color: R.appColors.white,
                  ),
                  textStyle: R.appTextStyle.poppins(
                    fontSize: 14,
                    color: R.appColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickActions(HomeVm vm) {
    return Row(
      children: [
        Expanded(
          child: _actionCard(
            icon: R.appImages.coachExperience,
            iconColor: R.appColors.skyBlue,
            title: vm.experienceYears,
            titleSuffix: 'yrs'.L(),
            subtitle: 'experience'.L(),
          ),
        ),
        hSpacePx(10),
        Expanded(
          child: _actionCard(
            icon: R.appImages.requestSupport,
            iconColor: R.appColors.orange,
            title: 'request_support'.L(),
            subtitle: 'ask_for_help'.L(),
            onTap: () => Get.toNamed(RequestSupportView.route),
          ),
        ),
        hSpacePx(10),
        Expanded(
          child: _actionCard(
            icon: R.appImages.upcoming,
            iconColor: R.appColors.textGreen,
            title: 'schedule_call'.L(),
            subtitle: 'book_15_min_call'.L(),
          ),
        ),
      ],
    );
  }

  Widget _actionCard({
    required String icon,
    required Color iconColor,
    required String title,
    String? titleSuffix,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 8.px),
        decoration: R.appDecorations.cardDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(16.px),
          border: Border.all(color: R.appColors.cardBackground, width: 1),
          boxShadow: [
            BoxShadow(
              color: R.appColors.black.withValues(alpha: 0.05),
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32.px,
              height: 32.px,
              padding: EdgeInsets.all(10.px),
              decoration: R.appDecorations.cardDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.px),
              ),
              child: Image.asset(icon, color: iconColor),
            ),
            vSpacePx(10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: R.appTextStyle.poppins(
                      fontSize: 10,
                      color: R.appColors.darkSlate,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                  if (titleSuffix != null)
                    TextSpan(
                      text: ' $titleSuffix',
                      style: R.appTextStyle.poppins(
                        fontSize: 10,
                        color: R.appColors.textLightBlack,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                      ),
                    ),
                ],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            vSpacePx(2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: R.appTextStyle.poppins(
                fontSize: 10,
                color: R.appColors.textLightBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _insightsHeader() {
    return Row(
      children: [
        Text(
          'coach_insights'.L(),
          style: R.appTextStyle.poppins(
            fontSize: 16,
            color: R.appColors.darkBlack,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Text(
          'last_3_updates'.L(),
          style: R.appTextStyle.poppins(
            fontSize: 11,
            color: R.appColors.textLightBlack,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _insightCard(CoachInsightModel insight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(16.px),
        border: Border.all(color: R.appColors.cardBackground, width: 1),
        boxShadow: [
          BoxShadow(
            color: R.appColors.black.withValues(alpha: 0.05),
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.px,
                height: 36.px,
                padding: EdgeInsets.all(11.px),
                decoration: R.appDecorations.cardDecoration(
                  color: Color.lerp(R.appColors.white, insight.iconColor, 0.10),
                  borderRadius: BorderRadius.circular(12.px),
                ),
                child: Image.asset(insight.icon, color: insight.iconColor),
              ),
              hSpacePx(10),
              Expanded(
                child: Text(
                  insight.title,
                  style: R.appTextStyle.poppins(
                    fontSize: 14,
                    color: R.appColors.darkSlate,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              hSpacePx(8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.px, vertical: 2.px),
                decoration: R.appDecorations.cardDecoration(
                  color: insight.tagColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(100.px),
                ),
                child: Text(
                  insight.tag.L(),
                  style: R.appTextStyle.poppins(
                    fontSize: 9,
                    color: insight.tagColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          vSpacePx(8),
          Text(
            insight.body,
            style: R.appTextStyle.poppins(
              fontSize: 12,
              color: R.appColors.slate,
              height: 1.45,
            ),
          ),
          vSpacePx(3),
          Text(
            insight.dateLabel,
            style: R.appTextStyle.poppins(
              fontSize: 10,
              color: R.appColors.slateGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _todayTipCard(CoachTipModel tip) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.px),
      decoration: R.appDecorations.cardDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [R.appColors.aliceBlue, R.appColors.indigoMist],
        ),
        borderRadius: BorderRadius.circular(16.px),
        border: Border.all(color: R.appColors.skyMist, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44.px,
            height: 44.px,
            padding: EdgeInsets.all(15.px),
            decoration: R.appDecorations.cardDecoration(
              color: tip.iconColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(16.px),
            ),
            child: Image.asset(tip.icon, color: tip.iconColor),
          ),
          hSpacePx(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      tip.title,
                      style: R.appTextStyle.poppins(
                        color: R.appColors.darkSlate,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    hSpacePx(10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.px,
                        vertical: 2.px,
                      ),
                      decoration: R.appDecorations.cardDecoration(
                        color: R.appColors.skyBlue.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(100.px),
                      ),
                      child: Text(
                        tip.category.L(),
                        style: R.appTextStyle.poppins(
                          fontSize: 9,
                          color: R.appColors.skyBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                vSpacePx(6),
                Text(
                  tip.body,
                  style: R.appTextStyle.poppins(
                    fontSize: 12,
                    color: R.appColors.slate,
                    fontWeight: FontWeight.w400,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tipFilterChips(HomeVm vm) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: vm.tipCategories.map((category) {
          final selected = vm.selectedTipCategory == category;
          return Padding(
            padding: EdgeInsets.only(right: 4.px),
            child: GestureDetector(
              onTap: () => vm.selectTipCategory(category),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.px,
                  vertical: 6.px,
                ),
                decoration: R.appDecorations.cardDecoration(
                  color: selected ? R.appColors.seaGreen : R.appColors.border,
                  borderRadius: BorderRadius.circular(100.px),
                ),
                child: Text(
                  category.L(),
                  style: R.appTextStyle.poppins(
                    fontSize: 11,
                    color: selected
                        ? R.appColors.white
                        : R.appColors.textLightBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _tipCard({required HomeVm vm, required CoachTipModel tip}) {
    final expanded = vm.isTipExpanded(tip.id);

    return GestureDetector(
      onTap: () => vm.toggleTipExpanded(tip.id),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.px),
        decoration: R.appDecorations.cardDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(16.px),
          border: Border.all(color: R.appColors.cardBackground, width: 1),
          boxShadow: [
            BoxShadow(
              color: R.appColors.black.withValues(alpha: 0.05),
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36.px,
                  height: 36.px,
                  padding: EdgeInsets.all(9.px),
                  decoration: R.appDecorations.cardDecoration(
                    color: Color.lerp(R.appColors.white, tip.iconColor, 0.12),
                    borderRadius: BorderRadius.circular(10.px),
                  ),
                  child: Image.asset(tip.icon, color: tip.iconColor),
                ),
                hSpacePx(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tip.title,
                        style: R.appTextStyle.poppins(
                          fontSize: 14,
                          color: R.appColors.darkBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        tip.category.L(),
                        style: R.appTextStyle.poppins(
                          fontSize: 10,
                          color: R.appColors.slateGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: R.appColors.slateGray,
                  size: 22.px,
                ),
              ],
            ),
            if (expanded) ...[
              vSpacePx(10),
              Text(
                tip.body,
                style: R.appTextStyle.poppins(
                  fontSize: 12,
                  color: R.appColors.slate,
                  height: 1.45,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _aboutCard(HomeVm vm) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(16.px),
        border: Border.all(color: R.appColors.cardBackground, width: 1),
        boxShadow: [
          BoxShadow(
            color: R.appColors.black.withValues(alpha: 0.05),
            offset: Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vm.coachAbout,
            style: R.appTextStyle.poppins(
              fontSize: 12,
              color: R.appColors.slate,
              height: 1.5,
            ),
          ),
          vSpacePx(16),
          Divider(height: 1, color: R.appColors.border),
          vSpacePx(16),
          Text(
            'specialties'.L(),
            style: R.appTextStyle.poppins(
              fontSize: 11,
              color: R.appColors.textLightBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
          vSpacePx(10),
          Wrap(
            spacing: 8.px,
            runSpacing: 8.px,
            children: vm.specialties.map((item) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 11.px,
                  vertical: 5.px,
                ),
                decoration: R.appDecorations.cardDecoration(
                  color: R.appColors.screenBackground2,
                  borderRadius: BorderRadius.circular(100.px),
                  border: Border.all(
                    color: R.appColors.cardBackground,
                    width: 1,
                  ),
                ),
                child: Text(
                  item,
                  style: R.appTextStyle.poppins(
                    fontSize: 10,
                    color: R.appColors.slate,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          vSpacePx(16),
          Divider(height: 1, color: R.appColors.border),
          vSpacePx(16),
          Text(
            'recent_messages'.L(),
            style: R.appTextStyle.poppins(
              fontSize: 11,
              color: R.appColors.textLightBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
          vSpacePx(12),
          ...vm.recentMessages.map(
            (message) => Padding(
              padding: EdgeInsets.only(bottom: 12.px),
              child: _messageTile(message),
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageTile(CoachMessageModel message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.px,
          height: 28.px,
          padding: EdgeInsets.all(1.5.px),
          decoration: R.appDecorations.cardDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [R.appColors.herbGreen, R.appColors.indigo],
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(1.5.px),
            decoration: R.appDecorations.cardDecoration(
              shape: BoxShape.circle,
              color: R.appColors.white,
            ),
            child: ClipOval(
              child: Image.asset(message.avatar, fit: BoxFit.cover),
            ),
          ),
        ),

        hSpacePx(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: R.appTextStyle.poppins(
                  fontSize: 12,
                  color: R.appColors.slate,
                  height: 1.4,
                ),
              ),
              vSpacePx(4),
              Text(
                message.timeLabel,
                style: R.appTextStyle.poppins(
                  fontSize: 10,
                  color: R.appColors.slateGray,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}