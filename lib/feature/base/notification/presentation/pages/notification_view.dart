import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/notification/data/models/notification_model.dart';
import 'package:habit_tracker/feature/base/notification/presentation/vm/notification_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NotificationView extends StatelessWidget {
  static const String route = '/notification_view';

  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Consumer<NotificationVm>(
          builder: (context, vm, _) {
            return ListView(
              padding: EdgeInsets.fromLTRB(20.px, 16.px, 20.px, 24.px),
              children: [
                if (vm.todayNotifications.isNotEmpty) ...[
                  _sectionLabel('today'.L()),
                  vSpacePx(12),
                  ..._notificationItems(vm.todayNotifications),
                ],
                if (vm.yesterdayNotifications.isNotEmpty) ...[
                  vSpacePx(8),
                  _sectionLabel('yesterday'.L()),
                  vSpacePx(12),
                  ..._notificationItems(vm.yesterdayNotifications),
                ],
              ],
            );
          },
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
              color: R.appColors.screenBackground2,
              borderRadius: BorderRadius.circular(12.px),
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: R.appColors.slate,
              size: 22.px,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'notification'.L(),
            textAlign: TextAlign.center,
            style: R.appTextStyle.poppins(
              fontSize: 16,
              color: R.appColors.darkBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: R.appTextStyle.poppins(
        fontSize: 11,
        color: R.appColors.slateGray,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  List<Widget> _notificationItems(List<NotificationModel> items) {
    return List.generate(items.length, (index) {
      return Padding(
        padding: EdgeInsets.only(bottom: 18.px),
        child: _notificationTile(items[index]),
      );
    });
  }

  Widget _notificationTile(NotificationModel item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _leadingIcon(item),
        hSpacePx(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: R.appTextStyle.poppins(
                        fontSize: 13,
                        color: R.appColors.darkBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  hSpacePx(8),
                  Text(
                    item.timeLabel,
                    style: R.appTextStyle.poppins(
                      fontSize: 10,
                      color: R.appColors.slateGray,
                    ),
                  ),
                ],
              ),
              vSpacePx(4),
              Text(
                item.body,
                style: R.appTextStyle.poppins(
                  fontSize: 12,
                  color: R.appColors.slate,
                  height: 1.4,
                ),
              ),
              vSpacePx(8),
              _categoryLabel(item.category),
            ],
          ),
        ),
      ],
    );
  }

  Widget _leadingIcon(NotificationModel item) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 40.px,
          height: 40.px,
          padding: EdgeInsets.all(13.px),
          decoration: R.appDecorations.cardDecoration(
            color: item.iconColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16.px),
          ),
          child: Image.asset(item.icon, color: item.iconColor),
        ),
        if (item.isUnread)
          Positioned(
            top: -2.px,
            right: -2.px,
            child: Container(
              width: 10.px,
              height: 10.px,
              decoration: R.appDecorations.cardDecoration(
                shape: BoxShape.circle,
                color: R.appColors.secondary,
                border: Border.all(color: R.appColors.white, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }

  Widget _categoryLabel(NotificationCategory category) {
    final (label, icon) = switch (category) {
      NotificationCategory.habitReminder => (
        'habit_reminder'.L(),
        R.appImages.reminderTime,
      ),
      NotificationCategory.coachMessage => (
        'coach_message'.L(),
        R.appImages.coachMessage,
      ),
      NotificationCategory.coachReminder => (
        'coach_reminder'.L(),
        R.appImages.coachReminders,
      ),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          icon,
          width: 11.px,
          height: 11.px,
          color: R.appColors.slateGray,
        ),
        hSpacePx(4),
        Text(
          label,
          style: R.appTextStyle.poppins(
            fontSize: 10,
            color: R.appColors.slateGray,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}