import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatelessWidget {
  static const String route = '/home_view';

  const HomeView({super.key});

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rhythmCard(),
            vSpacePx(20),
            _sectionHeader(
              title: 'todays_habits'.L(),
              trailing: '2/5',
              trailingColor: R.appColors.textGreen,
            ),
            vSpacePx(12),
            _habitCard(
              icon: R.appImages.message,
              title: 'Morning Meditation',
              subtitle: 'Daily · 07:00',
              isDone: true,
            ),
            vSpacePx(12),
            _habitCard(
              icon: R.appImages.notification,
              title: 'Read 20 Pages',
              subtitle: 'Daily · 21:00',
              isDone: false,
            ),
            vSpacePx(12),
            _habitCard(
              icon: R.appImages.notification,
              title: 'Drink 8 Glasses Water',
              subtitle: 'Daily · 10:00',
              isDone: false,
            ),
            vSpacePx(12),
            _habitCard(
              icon: R.appImages.message,
              title: 'Evening Journal',
              subtitle: 'Daily · 22:00',
              isDone: false,
            ),
            vSpacePx(12),
            _habitCard(
              icon: R.appImages.notification,
              title: '30-Minute Workout',
              subtitle: 'Weekly · 06:30',
              isDone: true,
            ),
            vSpacePx(24),
            _sectionHeader(title: 'upcoming_reminders'.L()),
            vSpacePx(12),
            _reminderCard(
              icon: R.appImages.message,
              iconBackground: R.appColors.softOrange.withValues(alpha: 0.12),
              title: 'Read 20 Pages',
              subtitle: 'Today at 21:00',
            ),
            vSpacePx(12),
            _reminderCard(
              icon: R.appImages.notification,
              iconBackground: R.appColors.primary.withValues(alpha: 0.12),
              title: 'Evening Journal',
              subtitle: 'Today at 22:00',
            ),
            vSpacePx(24),
            _sectionHeader(
              title: 'weekly_progress'.L(),
              trailing: 'view_all'.L(),
              showTrailingArrow: true,
            ),
            vSpacePx(12),
            _weeklyProgressCard(),
            vSpacePx(20),
            _quoteCard(),
          ],
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
              Text(
                'Williams',
                style: R.appTextStyle.poppins(
                  fontSize: 20,
                  color: R.appColors.darkBlack,
                  fontWeight: FontWeight.w700,
                ),
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

  Widget _rhythmCard() {
    final List<double> values = [0.55, 0.35, 0.85, 0.4, 0.65, 0.3, 0.6];
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
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'your_rhythm'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 12,
                  color: R.appColors.textLightBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'good'.L(),
                    style: R.appTextStyle.poppins(
                      fontSize: 14,
                      color: R.appColors.softOrange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '7 day rhythm',
                    style: R.appTextStyle.poppins(
                      fontSize: 10,
                      color: R.appColors.textLightBlack.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          vSpacePx(12),
          SizedBox(
            height: 90.px,
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
                    curveSmoothness: 0.4,
                    barWidth: 2.5,
                    color: R.appColors.softOrange,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) {
                        final bool isEdge =
                            index == 0 || index == values.length - 1;
                        return FlDotCirclePainter(
                          radius: isEdge ? 4 : 3,
                          color: R.appColors.white,
                          strokeWidth: 2,
                          strokeColor: R.appColors.oliveGreen,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          R.appColors.textGreen.withValues(alpha: 0.25),
                          R.appColors.white.withValues(alpha: 0.30),
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

  /// Shared header row used for "Today's Habits", "Upcoming Reminders" and
  /// "Weekly Progress" sections.
  Widget _sectionHeader({
    required String title,
    String? trailing,
    Color? trailingColor,
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
              Text(
                trailing,
                style: R.appTextStyle.poppins(
                  fontSize: 13,
                  color: trailingColor ?? R.appColors.darkBlack.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (showTrailingArrow) ...[
                hSpacePx(2),
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

  /// A single row in the "Today's Habits" list.
  Widget _habitCard({
    required String icon,
    required String title,
    required String subtitle,
    required bool isDone,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.px),
      decoration: R.appDecorations.cardDecoration(
        color: isDone
            ? R.appColors.textGreen.withValues(alpha: 0.06)
            : R.appColors.white,
        borderRadius: BorderRadius.circular(16.px),
      ),
      child: Row(
        children: [
          Container(
            width: 38.px,
            height: 38.px,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: R.appColors.screenBackground2,
              borderRadius: BorderRadius.circular(12.px),
            ),
            child: Image.asset(icon, width: 18.px, height: 18.px),
          ),
          hSpacePx(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: R.appTextStyle.poppins(
                    fontSize: 13,
                    color: isDone
                        ? R.appColors.darkBlack.withValues(alpha: 0.45)
                        : R.appColors.darkBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: R.appTextStyle.poppins(
                    fontSize: 11,
                    color: R.appColors.darkBlack.withValues(alpha: 0.35),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 24.px,
            height: 24.px,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDone ? R.appColors.textGreen : R.appColors.white,
              border: Border.all(
                color: isDone
                    ? R.appColors.textGreen
                    : R.appColors.darkBlack.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: isDone
                ? Icon(Icons.check, size: 14.px, color: R.appColors.white)
                : null,
          ),
        ],
      ),
    );
  }

  /// A single row in the "Upcoming Reminders" list.
  Widget _reminderCard({
    required String icon,
    required Color iconBackground,
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
            width: 38.px,
            height: 38.px,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12.px),
            ),
            child: Image.asset(icon, width: 18.px, height: 18.px),
          ),
          hSpacePx(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: R.appTextStyle.poppins(
                    fontSize: 13,
                    color: R.appColors.darkBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: R.appTextStyle.poppins(
                    fontSize: 11,
                    color: R.appColors.darkBlack.withValues(alpha: 0.35),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 26.px,
            height: 26.px,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: R.appColors.textGreen.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.access_time_rounded,
              size: 14.px,
              color: R.appColors.textGreen,
            ),
          ),
        ],
      ),
    );
  }

  /// "Weekly Progress" bar chart card.
  Widget _weeklyProgressCard() {
    final List<int> percentages = [80, 60, 100, 40, 80, 60, 50];
    final List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final List<Color> colors = [
      R.appColors.textGreen,
      R.appColors.primary,
      R.appColors.textGreen,
      R.appColors.textGreen,
      R.appColors.textGreen,
      R.appColors.primary,
      R.appColors.primary,
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 16.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(20.px),
      ),
      child: SizedBox(
        height: 130.px,
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
                          fontSize: 11,
                          color: R.appColors.darkBlack.withValues(alpha: 0.35),
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
                    color: colors[i],
                    width: 16.px,
                    borderRadius: BorderRadius.circular(6.px),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 120,
                      color: R.appColors.screenBackground2,
                    ),
                  ),
                ],
                showingTooltipIndicators: const [],
              );
            }),
          ),
        ),
      ),
    );
  }

  /// Motivational quote card at the bottom of the screen.
  Widget _quoteCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.px),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            R.appColors.textGreen.withValues(alpha: 0.15),
            R.appColors.primary.withValues(alpha: 0.12),
          ],
        ),
        borderRadius: BorderRadius.circular(20.px),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"Small daily improvements are the key to staggering long-term results."',
            style: R.appTextStyle.poppins(
              fontSize: 13,
              color: R.appColors.darkBlack.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
              //fontStyle: FontStyle.italic,
            ),
          ),
          vSpacePx(8),
          Text(
            '— Robin Sharma',
            style: R.appTextStyle.poppins(
              fontSize: 12,
              color: R.appColors.darkBlack.withValues(alpha: 0.45),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}