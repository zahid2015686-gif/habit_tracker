import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_model.dart';
import 'package:habit_tracker/feature/base/habits/presentation/pages/habit_discover_view.dart';
import 'package:habit_tracker/feature/base/habits/presentation/vm/habit_vm.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HabitsView extends StatefulWidget {
  static const String route = '/habits_view';
  const HabitsView({super.key});

  @override
  State<HabitsView> createState() => _HabitsViewState();
}

class _HabitsViewState extends State<HabitsView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: R.appColors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,

        systemNavigationBarColor: R.appColors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

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
        title: _customAppBar(),
      ),
      body: SafeArea(
        child: Consumer<HabitVm>(
          builder: (context, vm, _) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 16.px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _discoverHabitsCard(),
                  vSpacePx(20),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: vm.habits.length,
                    separatorBuilder: (_, _) => vSpacePx(10),
                    itemBuilder: (context, index) {
                      final habit = vm.habits[index];
                      return _habitTile(habit);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _customAppBar() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'habits'.L(),
            style: R.appTextStyle.poppins(
              fontSize: 20,
              color: R.appColors.darkBlack,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        hSpacePx(10),
        Container(
          width: 40.px,
          height: 40.px,
          padding: EdgeInsets.all(12.px),
          decoration: R.appDecorations.cardDecoration(
            color: R.appColors.screenBackground2,
            borderRadius: BorderRadius.circular(14.px),
          ),
          child: Image.asset(R.appImages.message),
        ),
        hSpacePx(10),
        Container(
          width: 40.px,
          height: 40.px,
          padding: EdgeInsets.all(12.px),
          decoration: R.appDecorations.cardDecoration(
            color: R.appColors.screenBackground2,
            borderRadius: BorderRadius.circular(14.px),
          ),
          child: Image.asset(R.appImages.notification),
        ),
      ],
    );
  }

  Widget _discoverHabitsCard() {
    return Material(
      color: R.appColors.transparent,
      child: InkWell(
        onTap: () {
          Get.toNamed(HabitDiscoverView.route);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.px),
          decoration: R.appDecorations.cardDecoration(
            borderRadius: BorderRadius.circular(16.px),
            image: DecorationImage(
              image: AssetImage(R.appImages.discoverHabitsBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.px),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    width: 44.px,
                    height: 44.px,
                    padding: EdgeInsets.all(12.px),
                    decoration: R.appDecorations.cardDecoration(
                      borderRadius: BorderRadius.circular(16.px),
                      color: Colors.white.withValues(alpha: 0.20),
                    ),
                    child: Image.asset(
                      R.appImages.discoverHabits,
                      color: R.appColors.white,
                    ),
                  ),
                ),
              ),
              hSpacePx(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'discover_habits'.L(),
                      style: R.appTextStyle.poppins(
                        color: R.appColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    vSpacePx(4),
                    Text(
                      'discover_habits_subtitle'.L(),
                      style: R.appTextStyle.poppins(
                        fontSize: 11,
                        color: R.appColors.white.withValues(alpha: 0.80),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withValues(alpha: 0.70),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _habitTile(HabitModel habit) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.px),
      decoration: R.appDecorations.cardDecoration(
        borderRadius: BorderRadius.circular(15.px),
        border: Border.all(color: R.appColors.border, width: 1),
        color: R.appColors.white,
        boxShadow: [
          BoxShadow(
            color: R.appColors.black.withValues(alpha: 0.04),
            offset: Offset(0, 10),
            blurRadius: 20,
            spreadRadius: -2,
          ),
          BoxShadow(
            color: R.appColors.black.withValues(alpha: 0.07),
            offset: Offset(0, 2),
            blurRadius: 15,
            spreadRadius: -3,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.px,
            height: 44.px,
            padding: EdgeInsets.all(12.px),
            decoration: R.appDecorations.cardDecoration(
              borderRadius: BorderRadius.circular(16),
              color: habit.imageColor.withValues(alpha: 0.10),
            ),
            alignment: Alignment.center,
            child: Image.asset(habit.image, color: habit.imageColor),
          ),
          hSpacePx(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        habit.title,
                        style: R.appTextStyle.poppins(
                          color: R.appColors.darkSlate,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (habit.hasLightVersion == true) ...[
                      hSpacePx(8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.px,
                          vertical: 2.px,
                        ),
                        decoration: R.appDecorations.cardDecoration(
                          color: R.appColors.secondary.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(100.px),
                        ),
                        child: Text(
                          'light'.L(),
                          style: R.appTextStyle.poppins(
                            color: R.appColors.seaGreen,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                vSpacePx(4),
                Text(
                  _habitScheduleText(habit),
                  style: R.appTextStyle.poppins(
                    fontSize: 12,
                    color: R.appColors.textLightBlack,
                  ),
                ),
              ],
            ),
          ),
          hSpacePx(8),
          Icon(Icons.chevron_right, color: R.appColors.slateGray),
        ],
      ),
    );
  }

  String _habitScheduleText(HabitModel habit) {
    final time = DateFormat('HH:mm').format(habit.reminderTime);

    switch (habit.scheduleType) {
      case HabitScheduleType.daily:
        return 'Daily · $time';

      case HabitScheduleType.weekly:
        final days = (habit.weekDays ?? []).map(_weekDayShort).join(' · ');
        return '$days · $time';

      case HabitScheduleType.custom:
        final date = habit.customDate != null
            ? DateFormat('MMM d').format(habit.customDate!)
            : '';
        return '$date · $time';
    }
  }

  String _weekDayShort(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }
}