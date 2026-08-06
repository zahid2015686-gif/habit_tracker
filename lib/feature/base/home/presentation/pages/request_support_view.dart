import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/core/widgets/app_button.dart';
import 'package:habit_tracker/feature/base/home/data/models/support_topic_model.dart';
import 'package:habit_tracker/feature/base/home/presentation/vm/home_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RequestSupportView extends StatefulWidget {
  static const String route = '/request_support_view';

  const RequestSupportView({super.key});

  @override
  State<RequestSupportView> createState() => _RequestSupportViewState();
}

class _RequestSupportViewState extends State<RequestSupportView> {
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
          title: _appBar(),
        ),
        body: SafeArea(
          child: Consumer<HomeVm>(
            builder: (context, vm, _) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(20.px, 16.px, 20.px, 20.px),
                      children: [
                        _myRequestsCard(),
                        vSpacePx(14),
                        _coachInfoCard(vm),
                        vSpacePx(20),
                        Text(
                          'what_do_you_need_help_with'.L(),
                          style: R.appTextStyle.poppins(
                            fontSize: 13,
                            color: R.appColors.slate,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        vSpacePx(12),
                        ...vm.supportTopics.map(
                          (topic) => Padding(
                            padding: EdgeInsets.only(bottom: 10.px),
                            child: _topicCard(vm: vm, topic: topic),
                          ),
                        ),
                        vSpacePx(10),
                        Text(
                          'additional_message_optional'.L(),
                          style: R.appTextStyle.poppins(
                            fontSize: 13,
                            color: R.appColors.slate,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        vSpacePx(10),
                        _messageField(vm),
                        vSpacePx(6),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${vm.supportMessageController.text.length}/${HomeVm.supportMessageMaxLength}',
                            style: R.appTextStyle.poppins(
                              fontSize: 11,
                              color: R.appColors.slateGray,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _sendBar(vm),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
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
        hSpacePx(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'coach'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 10,
                  color: R.appColors.textLightBlack,
                ),
              ),
              Text(
                'request_support'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 18,
                  color: R.appColors.darkBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _myRequestsCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(17.px),
        decoration: R.appDecorations.cardDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(16.px),
          border: Border.all(color: R.appColors.cardBackground, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 24.px,
              height: 24.px,
              decoration: R.appDecorations.cardDecoration(
                color: R.appColors.border,
                borderRadius: BorderRadius.circular(8.px),
              ),
              child: Icon(
                Icons.history_rounded,
                size: 14.px,
                color: R.appColors.slate,
              ),
            ),
            hSpacePx(12),
            Expanded(
              child: Text(
                'my_requests'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 14,
                  color: R.appColors.darkBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: R.appColors.slateGray,
              size: 22.px,
            ),
          ],
        ),
      ),
    );
  }

  Widget _coachInfoCard(HomeVm vm) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(16.px),
        border: Border.all(color: R.appColors.cardBackground, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'request_support_intro'.L(),
            style: R.appTextStyle.poppins(
              fontSize: 13,
              color: R.appColors.textLightBlack,
              fontWeight: FontWeight.w500,
              height: 1.45,
            ),
          ),
          vSpacePx(12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 12.px),
            decoration: R.appDecorations.cardDecoration(
              color: R.appColors.softLavenderBlue.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(14.px),
            ),
            child: Row(
              children: [
                Container(
                  width: 36.px,
                  height: 36.px,
                  alignment: Alignment.center,
                  decoration: R.appDecorations.cardDecoration(
                    shape: BoxShape.circle,
                    color: R.appColors.herbGreen,
                  ),
                  child: Text(
                    'S',
                    style: R.appTextStyle.poppins(
                      fontSize: 14,
                      color: R.appColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                hSpacePx(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'your_coach_sarah_is_online'.L(),
                        style: R.appTextStyle.poppins(
                          fontSize: 13,
                          color: R.appColors.darkSlate,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      vSpacePx(2),
                      Text(
                        'usually_replies_within_2_hours'.L(),
                        style: R.appTextStyle.poppins(
                          fontSize: 11,
                          color: R.appColors.textLightBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topicCard({required HomeVm vm, required SupportTopicModel topic}) {
    final selected = vm.selectedSupportTopicId == topic.id;

    return GestureDetector(
      onTap: () => vm.selectSupportTopic(topic.id),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.px, vertical: 14.px),
        decoration: R.appDecorations.cardDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(16.px),
          border: Border.all(
            color: selected ? R.appColors.seaGreen : R.appColors.cardBackground,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36.px,
              height: 36.px,
              decoration: R.appDecorations.cardDecoration(
                color: R.appColors.border,
                borderRadius: BorderRadius.circular(10.px),
              ),
              child: Icon(topic.icon, size: 18.px, color: R.appColors.slate),
            ),
            hSpacePx(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.titleKey.L(),
                    style: R.appTextStyle.poppins(
                      fontSize: 13,
                      color: R.appColors.darkSlate,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  vSpacePx(2),
                  Text(
                    topic.subtitleKey.L(),
                    style: R.appTextStyle.poppins(
                      fontSize: 11,
                      color: R.appColors.textLightBlack,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            hSpacePx(10),
            Container(
              width: 20.px,
              height: 20.px,
              decoration: R.appDecorations.cardDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? R.appColors.seaGreen
                    : R.appColors.transparent,
                border: Border.all(
                  color: selected
                      ? R.appColors.seaGreen
                      : R.appColors.cardBackground,
                  width: 1.5,
                ),
              ),
              child: selected
                  ? Icon(Icons.circle, size: 10.px, color: R.appColors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _messageField(HomeVm vm) {
    return TextFormField(
      controller: vm.supportMessageController,
      focusNode: _messageFocusNode,
      maxLines: 5,
      maxLength: HomeVm.supportMessageMaxLength,
      onChanged: (_) => vm.onSupportMessageChanged(),
      style: R.appTextStyle.poppins(
        fontSize: 13,
        color: R.appColors.darkSlate,
        fontWeight: FontWeight.w500,
      ),
      decoration: R.appDecorations
          .textField(
            hintText: 'tell_coach_sarah_more'.L(),
            borderRadius: 16.px,
            enabledBorderColor: R.appColors.cardBackground,
            focusedBorderColor: R.appColors.seaGreen,
            hintStyle: R.appTextStyle.poppins(
              fontSize: 13,
              color: R.appColors.slateGray,
              fontWeight: FontWeight.w500,
            ),
          )
          .copyWith(
            counterText: '',
            filled: true,
            fillColor: R.appColors.white,
          ),
    );
  }

  Widget _sendBar(HomeVm vm) {
    final enabled = vm.canSendSupportRequest;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 1, thickness: 1, color: R.appColors.border),
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20.px, 12.px, 20.px, 12.px),
          decoration: R.appDecorations.cardDecoration(
            color: R.appColors.white,
            borderRadius: BorderRadius.zero,
          ),
          child: AppButton(
            height: 48,
            text: 'send_request'.L(),
            enabled: enabled,
            onTap: enabled
                ? () {
                    vm.sendSupportRequest();
                    Get.back();
                  }
                : null,
            color: enabled ? R.appColors.seaGreen : R.appColors.border,
            borderRadius: 16,
            leftIcon: Image.asset(
              R.appImages.sendMessage,
              width: 16.px,
              height: 16.px,
              color: enabled ? R.appColors.white : R.appColors.slateGray,
            ),
            textStyle: R.appTextStyle.poppins(
              fontSize: 14,
              color: enabled ? R.appColors.white : R.appColors.slateGray,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}