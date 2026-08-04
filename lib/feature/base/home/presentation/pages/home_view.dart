import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/core/utils/extension_methods.dart';
import 'package:habit_tracker/core/widgets/app_button.dart';
import 'package:habit_tracker/feature/base/base_view/presentation/vm/base_vm.dart';
import 'package:habit_tracker/feature/base/habits/presentation/vm/habit_vm.dart';
import 'package:habit_tracker/feature/base/profile/presentation/pages/premium_success_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  static const String route = '/home_view';
  final bool? isPremium;

  const HomeView({super.key, this.isPremium});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isWeekSelected = true;
  final int _missedDayIndex = 1; // Tuesday

  @override
  void initState() {
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

    if (widget.isPremium == true) {
      _maybeShowWelcomePremium();
    }
  }

  void _maybeShowWelcomePremium() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final baseVm = context.read<BaseVm>();
      if (baseVm.hasShownWelcomePremium) return;

      baseVm.markWelcomePremiumShown();

      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withValues(alpha: 0.50),
        builder: (_) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: _welcomePremium(context),
          );
        },
      );
    });
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
        child: widget.isPremium == false
            ? const PremiumSuccessContent()
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 16.px),
                child: Consumer<HabitVm>(
                  builder: (context, vm, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _coachCard(),
                        vSpacePx(16),
                        _rhythmCard(),
                        vSpacePx(20),
                        _sectionHeader(
                          title: 'today_habits'.L(),
                          trailing: "${vm.completedHabits}/${vm.habits.length}",
                          trailingColor: R.appColors.seaGreen,
                        ),
                        _todayHabitsCard(vm: vm),
                        _sectionHeader(title: 'upcoming_reminders'.L()),
                        _upcomingRemindersCard(vm: vm),
                        _sectionHeaderWithArrow(
                          title: 'weekly_progress'.L(),
                          trailing: 'view_all'.L(),
                          onTap: () {},
                        ),
                        vSpacePx(10),
                        _weeklyProgressCard(),
                        vSpacePx(20),
                        _quoteCard(),
                        vSpacePx(20),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }

  Widget _customAppBar() {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${'good'.L()} Afternoon',
                style: R.appTextStyle.poppins(
                  fontSize: 12,
                  color: R.appColors.darkBlack.withValues(alpha: 0.33),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Williams',
                    style: R.appTextStyle.poppins(
                      fontSize: 20,
                      color: R.appColors.darkBlack,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (widget.isPremium ?? false) ...[
                    hSpacePx(10),
                    Container(
                      width: 22.px,
                      height: 22.px,
                      padding: EdgeInsets.all(5.px),
                      decoration: R.appDecorations.cardDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            R.appColors.warmCream,
                            R.appColors.warmCream,
                          ],
                        ),
                        border: Border.all(
                          color: R.appColors.softGold,
                          width: 1.5,
                        ),
                      ),
                      child: Image.asset(
                        R.appImages.premium,
                        color: R.appColors.orange,
                      ),
                    ),
                  ],
                ],
              ),
            ],
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

  Widget _coachCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(20.px),
        border: Border.all(
          color: R.appColors.textLightBlack.withValues(alpha: 0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: R.appColors.black.withValues(alpha: 0.04),
            offset: const Offset(0, 8),
            blurRadius: 16,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'your_coach'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 12,
                  color: R.appColors.textLightBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
              hSpacePx(8),
              Container(
                width: 7.px,
                height: 7.px,
                decoration: R.appDecorations.cardDecoration(
                  shape: BoxShape.circle,
                  color: R.appColors.successGreen,
                ),
              ),
              hSpacePx(4),
              Text(
                'online'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 11,
                  color: R.appColors.successGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          vSpacePx(12),
          Row(
            children: [
              Container(
                width: 44.px,
                height: 44.px,
                decoration: R.appDecorations.cardDecoration(
                  shape: BoxShape.circle,
                  color: R.appColors.screenBackground2,
                ),
                child: Icon(
                  Icons.person,
                  color: R.appColors.slateGray,
                  size: 24.px,
                ),
              ),
              hSpacePx(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'coach_sarah'.L(),
                      style: R.appTextStyle.poppins(
                        fontSize: 15,
                        color: R.appColors.darkBlack,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'new_insights_waiting'.L(),
                      style: R.appTextStyle.poppins(
                        fontSize: 11,
                        color: R.appColors.textLightBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              hSpacePx(8),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.px,
                    vertical: 8.px,
                  ),
                  decoration: R.appDecorations.cardDecoration(
                    color: R.appColors.seaGreen,
                    borderRadius: BorderRadius.circular(12.px),
                  ),
                  child: Text(
                    'view'.L(),
                    style: R.appTextStyle.poppins(
                      fontSize: 13,
                      color: R.appColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rhythmCard() {
    final List<double> values = [0.75, 0.25, 0.85, 0.55, 0.9, 0.45, 0.7];
    final List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(20.px),
        border: Border.all(
          color: R.appColors.textLightBlack.withValues(alpha: 0.10),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'your_rhythm'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 12,
                  color: R.appColors.textLightBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              _rhythmPeriodToggle(),
            ],
          ),
          vSpacePx(10),
          Text(
            'steady'.L(),
            style: R.appTextStyle.poppins(
              fontSize: 18,
              color: R.appColors.softOrange,
              fontWeight: FontWeight.w700,
            ),
          ),
          vSpacePx(2),
          Text(
            'steady_description'.L(),
            style: R.appTextStyle.poppins(
              fontSize: 12,
              color: R.appColors.textLightBlack,
              fontWeight: FontWeight.w400,
            ),
          ),
          vSpacePx(16),
          SizedBox(
            height: 120.px,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final tipLeft = (constraints.maxWidth *
                        (_missedDayIndex / (values.length - 1))) -
                    50.px;

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 36.px),
                      child: LineChart(
                        LineChartData(
                          minY: 0,
                          maxY: 1,
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineTouchData: const LineTouchData(enabled: false),
                          lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              curveSmoothness: 0.35,
                              barWidth: 2.5,
                              gradient: LinearGradient(
                                colors: [
                                  R.appColors.oliveGreen,
                                  R.appColors.softOrange,
                                  R.appColors.oliveGreen,
                                ],
                              ),
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, bar, index) {
                                  final isMissed = index == _missedDayIndex;
                                  return FlDotCirclePainter(
                                    radius: isMissed ? 5 : 4,
                                    color: isMissed
                                        ? R.appColors.softOrange
                                        : R.appColors.oliveGreen,
                                    strokeWidth: 2,
                                    strokeColor: R.appColors.white,
                                  );
                                },
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    R.appColors.textGreen.withValues(
                                      alpha: 0.18,
                                    ),
                                    R.appColors.white.withValues(alpha: 0.0),
                                  ],
                                ),
                              ),
                              spots: List.generate(
                                values.length,
                                (i) => FlSpot(i.toDouble(), values[i]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: tipLeft.clamp(0.0, constraints.maxWidth - 150.px),
                      child: _missedDayTip(),
                    ),
                  ],
                );
              },
            ),
          ),
          vSpacePx(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days
                .map(
                  (d) => Text(
                    d,
                    style: R.appTextStyle.poppins(
                      fontSize: 10,
                      color: R.appColors.textLightBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _rhythmPeriodToggle() {
    return Container(
      padding: EdgeInsets.all(3.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.border,
        borderRadius: BorderRadius.circular(100.px),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _periodChip(
            label: 'week'.L(),
            selected: _isWeekSelected,
            onTap: () => setState(() => _isWeekSelected = true),
          ),
          _periodChip(
            label: 'month'.L(),
            selected: !_isWeekSelected,
            onTap: () => setState(() => _isWeekSelected = false),
          ),
        ],
      ),
    );
  }

  Widget _periodChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 5.px),
        decoration: R.appDecorations.cardDecoration(
          color: selected ? R.appColors.white : R.appColors.transparent,
          borderRadius: BorderRadius.circular(100.px),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: R.appColors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: R.appTextStyle.poppins(
            fontSize: 11,
            color: selected
                ? R.appColors.darkBlack
                : R.appColors.textLightBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _missedDayTip() {
    return Container(
      constraints: BoxConstraints(maxWidth: 160.px),
      padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 8.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.warmCream,
        borderRadius: BorderRadius.circular(10.px),
        border: Border.all(color: R.appColors.softGold.withValues(alpha: 0.5)),
      ),
      child: Text(
        'missed_day_tip'.L(),
        style: R.appTextStyle.poppins(
          fontSize: 10,
          color: R.appColors.softOrange,
          fontWeight: FontWeight.w500,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _todayHabitsCard({required HabitVm vm}) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 14.px),
      shrinkWrap: true,
      separatorBuilder: (context, index) => vSpacePx(10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vm.habits.length,
      itemBuilder: (context, index) {
        final habit = vm.habits[index];
        return GestureDetector(
          onTap: () => vm.toggleHabit(index),
          child: _habitCard(
            title: habit.title,
            icon: habit.image,
            iconColor: habit.imageColor,
            subtitle:
                "${habit.scheduleType.title} · ${DateFormat('HH:mm').format(habit.reminderTime)}",
            isDone: habit.isDone,
          ),
        );
      },
    );
  }

  Widget _sectionHeader({
    required String title,
    String? trailing,
    Color? trailingColor,
    Color? trailingBackgroundColor,
    bool showTrailingArrow = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: R.appTextStyle.poppins(
            fontSize: 16,
            color: R.appColors.darkBlack,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (trailing != null)
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.px,
                  vertical: 4.px,
                ),
                decoration: R.appDecorations.cardDecoration(
                  color: trailingBackgroundColor,
                ),
                child: Text(
                  trailing,
                  style: R.appTextStyle.poppins(
                    fontSize: 12,
                    color:
                        trailingColor ??
                        R.appColors.darkBlack.withValues(alpha: 0.5),
                  ),
                ),
              ),
              if (showTrailingArrow) ...[
                Icon(
                  Icons.chevron_right,
                  size: 16.px,
                  color: R.appColors.darkBlack.withValues(alpha: 0.5),
                ),
              ],
            ],
          ),
      ],
    );
  }

  Widget _sectionHeaderWithArrow({
    required String title,
    required String trailing,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: R.appTextStyle.poppins(
            fontSize: 16,
            color: R.appColors.darkBlack,
            fontWeight: FontWeight.w700,
          ),
        ),
        Material(
          color: R.appColors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  trailing,
                  style: R.appTextStyle.poppins(
                    fontSize: 12,
                    color: R.appColors.darkBlack.withValues(alpha: 0.5),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 16.px,
                  color: R.appColors.darkBlack.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _habitCard({
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isDone,
  }) {
    final selected = isDone;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(20.px),
        border: Border.all(color: R.appColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: R.appColors.border.withValues(alpha: 0.04),
            offset: Offset(0, 10),
            blurRadius: 20,
            spreadRadius: -2,
          ),
          BoxShadow(
            color: R.appColors.border.withValues(alpha: 0.07),
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
            alignment: Alignment.center,
            padding: EdgeInsets.all(12.px),
            decoration: R.appDecorations.cardDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14.px),
            ),
            child: Image.asset(icon, color: iconColor),
          ),
          hSpacePx(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: R.appTextStyle.poppins(
                    fontSize: 15,
                    color: selected
                        ? R.appColors.textLightBlack.withValues(alpha: 0.80)
                        : R.appColors.darkBlack,
                    fontWeight: FontWeight.w600,
                    textDecoration: selected
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: R.appColors.textLightBlack,
                  ),
                ),
                Text(
                  subtitle,
                  style: R.appTextStyle.poppins(
                    fontSize: 12,
                    color: R.appColors.textLightBlack,
                    textDecoration: selected
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: R.appColors.textLightBlack,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 24.px,
            height: 24.px,
            alignment: Alignment.center,
            decoration: R.appDecorations.cardDecoration(
              shape: BoxShape.circle,
              color: selected ? R.appColors.seaGreen : R.appColors.white,
              border: Border.all(
                color: selected
                    ? R.appColors.seaGreen
                    : R.appColors.textLightBlack.withValues(alpha: 0.33),
                width: 1.5,
              ),
            ),
            child: selected
                ? Image.asset(
                    R.appImages.tickIcon,
                    width: 12,
                    color: R.appColors.white,
                  )
                : null,
          ),
        ],
      ),
    );
  }

  Widget _upcomingRemindersCard({required HabitVm vm}) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 14.px),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vm.upcomingHabits.length,
      separatorBuilder: (context, index) => vSpacePx(10),
      itemBuilder: (context, index) {
        final habit = vm.upcomingHabits[index];
        return _reminderCard(
          icon: habit.image,
          iconColor: habit.imageColor,
          title: habit.title,
          subtitle:
              "Today at ${DateFormat('HH:mm').format(habit.reminderTime)}",
        );
      },
    );
  }

  Widget _reminderCard({
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(16.px),
      ),
      child: Row(
        children: [
          Container(
            width: 36.px,
            height: 36.px,
            alignment: Alignment.center,
            padding: EdgeInsets.all(9.px),
            decoration: R.appDecorations.cardDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.px),
            ),
            child: Image.asset(icon, color: iconColor),
          ),
          hSpacePx(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: R.appTextStyle.poppins(
                    fontSize: 14,
                    color: R.appColors.darkBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: R.appTextStyle.poppins(
                    fontSize: 12,
                    color: R.appColors.darkBlack.withValues(alpha: 0.35),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 28.px,
            height: 28.px,
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.px),
            decoration: R.appDecorations.cardDecoration(
              color: R.appColors.screenBackground3,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              R.appImages.upcoming,
              color: R.appColors.seaGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _weeklyProgressCard() {
    final List<int> percentages = [80, 60, 100, 40, 80, 60, 50];
    final List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    final List<List<Color>> gradients = [
      [
        R.appColors.textLightGreen,
        R.appColors.textLightGreen.withValues(alpha: 0.6),
      ],
      [R.appColors.indigo, R.appColors.indigo.withValues(alpha: 0.6)],
      [
        R.appColors.textLightGreen,
        R.appColors.textLightGreen.withValues(alpha: 0.6),
      ],
      [R.appColors.orange, R.appColors.orange.withValues(alpha: 0.6)],
      [
        R.appColors.textLightGreen,
        R.appColors.textLightGreen.withValues(alpha: 0.6),
      ],
      [R.appColors.indigo, R.appColors.indigo.withValues(alpha: 0.6)],
      [R.appColors.indigo, R.appColors.indigo.withValues(alpha: 0.6)],
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(20.px),
        border: Border.all(color: R.appColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: R.appColors.black.withValues(alpha: 0.04),
            offset: const Offset(0, 10),
            blurRadius: 20,
            spreadRadius: -2,
          ),
          BoxShadow(
            color: R.appColors.black.withValues(alpha: 0.04),
            offset: const Offset(0, 7),
            blurRadius: 15,
            spreadRadius: -3,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 6.px),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: percentages.map((p) {
                return Text(
                  '$p%',
                  style: R.appTextStyle.poppins(
                    fontSize: 10,
                    color: R.appColors.textLightBlack,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(
            height: 100.px,
            child: BarChart(
              BarChartData(
                maxY: 120,
                minY: 0,
                alignment: BarChartAlignment.spaceAround,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22.px,
                      getTitlesWidget: (value, meta) {
                        final int index = value.toInt();
                        if (index < 0 || index >= days.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: 6.px),
                          child: Text(
                            days[index],
                            style: R.appTextStyle.poppins(
                              fontSize: 10,
                              color: R.appColors.darkBlack.withValues(
                                alpha: 0.35,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(percentages.length, (i) {
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: percentages[i].toDouble(),
                        gradient: LinearGradient(
                          colors: gradients[i],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        width: 30.px,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12.px),
                        ),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: 120,
                          color: R.appColors.white,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quoteCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(21.px),
      decoration: R.appDecorations.cardDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.5, 1.0],
          colors: [
            R.appColors.textLightGreen.withValues(alpha: 0.10),
            R.appColors.indigo.withValues(alpha: 0.10),
            R.appColors.blue.withValues(alpha: 0.10),
          ],
        ),
        borderRadius: BorderRadius.circular(20.px),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -10,
            child: Opacity(
              opacity: 0.12,
              child: Container(
                width: 80.px,
                height: 80.px,
                padding: EdgeInsets.all(10.px),
                child: Image.asset(R.appImages.quoteIcon, fit: BoxFit.contain),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Text(
                  '"Small daily improvements are the key to staggering long-term result…"',
                  style: R.appTextStyle.poppins(
                    color: R.appColors.textBlack,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
              ),
              vSpacePx(10),
              Text(
                '— Robin Sharma',
                style: R.appTextStyle.poppins(
                  fontSize: 12.px,
                  color: R.appColors.textLightBlack,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _welcomePremium(BuildContext context) {
    return Dialog(
      backgroundColor: R.appColors.transparent,
      insetPadding: EdgeInsets.all(32.px),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(32.px),
            decoration: R.appDecorations.cardDecoration(
              color: R.appColors.white,
              borderRadius: BorderRadius.circular(28.px),
              boxShadow: [
                BoxShadow(
                  color: R.appColors.black.withValues(alpha: 0.25),
                  blurRadius: 50,
                  offset: const Offset(0, 25),
                  spreadRadius: -12,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 88.px,
                  height: 88.px,
                  padding: EdgeInsets.all(25.px),
                  decoration: R.appDecorations.cardDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [R.appColors.warmCream, R.appColors.warmCream],
                    ),
                    border: Border.all(color: R.appColors.softGold, width: 1.5),
                  ),
                  child: Image.asset(
                    R.appImages.premium,
                    color: R.appColors.orange,
                  ),
                ),
                vSpacePx(14),
                Text(
                  'welcome_to_premium'.L(),
                  textAlign: TextAlign.center,
                  style: R.appTextStyle.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: R.appColors.darkBlack,
                  ),
                ),
                vSpacePx(10),
                Text(
                  "welcome_premium_subtitle".L(),
                  textAlign: TextAlign.center,
                  style: R.appTextStyle.poppins(
                    color: R.appColors.slate,
                    height: 1.4,
                  ),
                ),
                vSpacePx(15),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.px,
                  runSpacing: 8.px,
                  children: [
                    _featurePill(
                      label: 'unlimited_habits'.L(),
                      textColor: R.appColors.successGreen,
                      bgColor: R.appColors.successGreen.withValues(alpha: 0.12),
                    ),
                    _featurePill(
                      label: 'live_coach'.L(),
                      textColor: R.appColors.royalBlue,
                      bgColor: R.appColors.royalBlue.withValues(alpha: 0.12),
                    ),
                    _featurePill(
                      label: 'deep_analytics'.L(),
                      textColor: R.appColors.skyBlue,
                      bgColor: R.appColors.skyBlue.withValues(alpha: 0.12),
                    ),
                  ],
                ),
                vSpacePx(20),
                AppButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: 'let_go'.L(),
                  textStyle: R.appTextStyle.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: R.appColors.white,
                  ),
                  color: R.appColors.seaGreen,
                  borderRadius: 16,
                ),
              ],
            ),
          ),

          Positioned(
            top: -70.px,
            left: 5.px,
            child: Image.asset(R.appImages.star2, width: 30.px),
          ),
          Positioned(
            bottom: -40.px,
            left: 20.px,
            child: Image.asset(R.appImages.star4, width: 20.px),
          ),
          Positioned(
            bottom: -50.px,
            right: 20.px,
            child: Image.asset(R.appImages.star3, width: 20.px),
          ),
          Positioned(
            top: -90.px,
            right: 10.px,
            child: Image.asset(R.appImages.star1, width: 18.px),
          ),
        ],
      ),
    );
  }

  Widget _featurePill({
    required String label,
    required Color textColor,
    required Color bgColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.px, vertical: 5.px),
      decoration: R.appDecorations.cardDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100.px),
      ),
      child: Text(
        label,
        style: R.appTextStyle.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}