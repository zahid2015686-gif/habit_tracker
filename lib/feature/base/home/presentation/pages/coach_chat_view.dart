import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_chat_message_model.dart';
import 'package:habit_tracker/feature/base/home/data/models/coach_stat_model.dart';
import 'package:habit_tracker/feature/base/home/presentation/vm/home_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CoachChatView extends StatefulWidget {
  static const String route = '/coach_chat_view';

  const CoachChatView({super.key});

  @override
  State<CoachChatView> createState() => _CoachChatViewState();
}

class _CoachChatViewState extends State<CoachChatView> {
  final FocusNode _messageFocusNode = FocusNode();

  @override
  void dispose() {
    _messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: R.appColors.screenBackground2,
        appBar: AppBar(
          backgroundColor: R.appColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 16.px,
          title: Consumer<HomeVm>(builder: (context, vm, _) => _appBar(vm)),
        ),
        body: SafeArea(
          child: Consumer<HomeVm>(
            builder: (context, vm, _) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(16.px, 14.px, 16.px, 12.px),
                      children: [
                        _coachingStatsCard(vm),
                        vSpacePx(18),
                        _dateDivider(),
                        vSpacePx(16),
                        ...vm.chatMessages.map(
                          (message) => Padding(
                            padding: EdgeInsets.only(bottom: 14.px),
                            child: _chatBubble(vm: vm, message: message),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _messageInputBar(vm),
                ],
              );
            },
          ),
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
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 40.px,
              height: 40.px,
              decoration: R.appDecorations.cardDecoration(
                shape: BoxShape.circle,
                color: R.appColors.white,
              ),
              child: ClipOval(
                child: Image.asset(vm.coachProfileImage, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              right: -2,
              bottom: 0,
              child: Container(
                width: 14.px,
                height: 14.px,
                decoration: R.appDecorations.cardDecoration(
                  shape: BoxShape.circle,
                  color: R.appColors.successGreen,
                  border: Border.all(color: R.appColors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        hSpacePx(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vm.coachFullTitle,
                style: R.appTextStyle.poppins(
                  fontSize: 15,
                  color: R.appColors.darkBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'online_now'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 11,
                  color: R.appColors.textGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _coachingStatsCard(HomeVm vm) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.px),
      decoration: R.appDecorations.cardDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [R.appColors.aliceBlue, R.appColors.indigoMist],
        ),
        borderRadius: BorderRadius.circular(16.px),
        border: Border.all(color: R.appColors.skyMist, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24.px,
                height: 24.px,
                padding: EdgeInsets.all(7.px),
                decoration: R.appDecorations.cardDecoration(
                  color: R.appColors.blue,
                  borderRadius: BorderRadius.circular(8.px),
                ),
                child: Image.asset(
                  R.appImages.coachMessage,
                  color: R.appColors.white,
                ),
              ),
              hSpacePx(8),
              Text(
                'your_coaching_stats'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 12,
                  color: R.appColors.darkSlate,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          vSpacePx(12),
          Row(
            children: [
              for (int i = 0; i < vm.coachingStats.length; i++) ...[
                if (i > 0) hSpacePx(8),
                Expanded(child: _statTile(vm.coachingStats[i])),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _statTile(CoachStatModel stat) {
    return Container(
      padding: EdgeInsets.all(10.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(12.px),
      ),
      child: Column(
        children: [
          Container(
            width: 32.px,
            height: 32.px,
            padding: EdgeInsets.all(10.px),
            decoration: R.appDecorations.cardDecoration(
              shape: BoxShape.circle,
              color: stat.iconColor.withValues(alpha: 0.10),
            ),
            child: Image.asset(stat.icon, color: stat.iconColor),
          ),
          vSpacePx(8),
          Text(
            stat.value,
            style: R.appTextStyle.poppins(
              fontSize: 16,
              color: R.appColors.darkBlack,
              fontWeight: FontWeight.w700,
            ),
          ),
          vSpacePx(2),
          Text(
            stat.label.L(),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: R.appTextStyle.poppins(
              fontSize: 10,
              color: R.appColors.textLightBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: R.appColors.cardBackground, height: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.px),
          child: Text(
            'today'.L(),
            style: R.appTextStyle.poppins(
              fontSize: 10,
              color: R.appColors.textLightBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(child: Divider(color: R.appColors.cardBackground, height: 1)),
      ],
    );
  }

  Widget _chatBubble({
    required HomeVm vm,
    required CoachChatMessageModel message,
  }) {
    if (message.isFromCoach) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26.px,
            height: 26.px,
            decoration: R.appDecorations.cardDecoration(
              shape: BoxShape.circle,
              color: R.appColors.white,
            ),
            child: ClipOval(
              child: Image.asset(vm.coachProfileImage, fit: BoxFit.cover),
            ),
          ),
          hSpacePx(8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.px,
                    vertical: 10.px,
                  ),
                  decoration: R.appDecorations.cardDecoration(
                    color: R.appColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.px),
                      topLeft: Radius.circular(2.px),
                      bottomLeft: Radius.circular(16.px),
                      bottomRight: Radius.circular(16.px),
                    ),
                    border: Border.all(
                      color: R.appColors.cardBackground,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: R.appColors.black.withValues(alpha: 0.05),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: R.appTextStyle.poppins(
                      fontSize: 13,
                      color: R.appColors.darkSlate,
                      height: 1.45,
                    ),
                  ),
                ),
                vSpacePx(2),
                Text(
                  message.timeLabel,
                  style: R.appTextStyle.poppins(
                    fontSize: 10,
                    color: R.appColors.slateGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          hSpace(4.w),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        hSpace(4.w),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.px,
                  vertical: 10.px,
                ),
                decoration: R.appDecorations.cardDecoration(
                  color: R.appColors.seaGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.px),
                    topRight: Radius.circular(2.px),
                    bottomLeft: Radius.circular(16.px),
                    bottomRight: Radius.circular(16.px),
                  ),
                ),

                child: Text(
                  message.text,
                  style: R.appTextStyle.poppins(
                    fontSize: 13,
                    color: R.appColors.white,
                    height: 1.45,
                  ),
                ),
              ),
              vSpacePx(4),
              Text(
                message.timeLabel,
                style: R.appTextStyle.poppins(
                  fontSize: 10,
                  color: R.appColors.slateGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _messageInputBar(HomeVm vm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 1, thickness: 1, color: R.appColors.border),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8),
          decoration: R.appDecorations.cardDecoration(
            color: R.appColors.white,
            borderRadius: BorderRadius.zero,
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(14.px, 4.px, 4.px, 4.px),
            decoration: R.appDecorations.cardDecoration(
              color: R.appColors.border,
              borderRadius: BorderRadius.circular(100.px),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: vm.chatMessageController,
                    focusNode: _messageFocusNode,
                    cursorColor: R.appColors.darkBlack,
                    style: R.appTextStyle.poppins(
                      fontSize: 13,
                      color: R.appColors.darkBlack,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'message_coach_sarah'.L(),
                      hintStyle: R.appTextStyle.poppins(
                        fontSize: 14,
                        color: R.appColors.slateGray,
                        fontWeight: FontWeight.w500,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.px),
                    ),
                    textInputAction: TextInputAction.send,
                    onFieldSubmitted: (_) {
                      vm.sendChatMessage();
                      _messageFocusNode.requestFocus();
                    },
                  ),
                ),
                hSpacePx(8),
                GestureDetector(
                  onTap: () {
                    vm.sendChatMessage();
                    _messageFocusNode.requestFocus();
                  },
                  child: Container(
                    width: 32.px,
                    height: 32.px,
                    padding: EdgeInsets.all(9.px),
                    decoration: R.appDecorations.cardDecoration(
                      shape: BoxShape.circle,
                      color: R.appColors.cardBackground,
                    ),
                    child: Image.asset(
                      R.appImages.sendMessage,
                      color: R.appColors.slateGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}