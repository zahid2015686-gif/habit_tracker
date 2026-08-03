import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/base_view/presentation/vm/base_vm.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_template_model.dart';
import 'package:habit_tracker/feature/base/habits/presentation/pages/add_habit_template_sheet_view.dart';
import 'package:habit_tracker/feature/base/habits/presentation/pages/create_habit_sheet_view.dart';
import 'package:habit_tracker/feature/base/habits/presentation/vm/habit_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

class PremiumSuccessContent extends StatelessWidget {
  const PremiumSuccessContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.px, vertical: 20.px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56.px,
                height: 56.px,
                padding: EdgeInsets.all(16.px),
                decoration: R.appDecorations.cardDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [R.appColors.avocado, R.appColors.peach],
                  ),
                ),
                child: Image.asset(R.appImages.tickIcon, color: Colors.white),
              ),
              vSpacePx(10),
              Text(
                'you_all_set'.L(),
                style: R.appTextStyle.poppins(
                  color: R.appColors.darkBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              vSpacePx(10),
              Text(
                'pick_habits_to_get_started'.L(),
                style: R.appTextStyle.poppins(
                  color: R.appColors.dimGray,
                  fontSize: 12,
                ),
              ),
              vSpacePx(20),
              Row(
                children: [
                  Image.asset(
                    R.appImages.quickStartTemplates,
                    color: R.appColors.orange,
                    width: 10.px,
                  ),
                  hSpacePx(10),
                  Expanded(
                    child: Text(
                      'quick_start_templates'.L(),
                      style: R.appTextStyle.poppins(
                        color: R.appColors.darkBlack,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  hSpacePx(10),
                  GestureDetector(
                    onTap: () {
                      context.read<BaseVm>().changeIndex(1);
                    },
                    child: Text(
                      'view_all'.L(),
                      style: R.appTextStyle.poppins(
                        color: R.appColors.azureBlue,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              vSpacePx(16),
              Consumer<HabitVm>(
                builder: (context, vm, _) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: math.min(vm.templatesHabits.length, 2),
                    separatorBuilder: (_, __) => vSpacePx(8),
                    itemBuilder: (context, index) {
                      return _templateHabitCard(
                        context,
                        vm.templatesHabits[index],
                      );
                    },
                  );
                },
              ),
              vSpacePx(12),
              _buildYourOwnHabitCard(context),
              vSpacePx(16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _templateHabitCard(BuildContext context, HabitTemplateModel habit) {
    return Container(
      padding: EdgeInsets.all(13.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        border: Border.all(
          color: R.appColors.cardBackground.withValues(alpha: 0.60),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.px,
            height: 40.px,
            padding: EdgeInsets.all(10.px),
            decoration: R.appDecorations.cardDecoration(
              color: habit.imageColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12.px),
            ),
            child: Image.asset(habit.image, color: habit.imageColor),
          ),
          hSpacePx(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit.title,
                  style: R.appTextStyle.poppins(
                    color: R.appColors.darkSlate,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  habit.duration,
                  style: R.appTextStyle.poppins(
                    color: R.appColors.darkSlate,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          hSpacePx(10),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => showAddHabitTemplateSheet(context, habit: habit),
              borderRadius: BorderRadius.circular(12.px),
              child: Container(
                width: 32.px,
                height: 32.px,
                decoration: R.appDecorations.cardDecoration(
                  color: R.appColors.white,
                  borderRadius: BorderRadius.circular(12.px),
                  border: Border.all(
                    color: R.appColors.cardBackground,
                    width: 2,
                  ),
                ),
                child: Icon(Icons.add, color: R.appColors.seaGreen, size: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourOwnHabitCard(BuildContext context) {
    return GestureDetector(
      onTap: () => showCreateHabitSheetView(context),
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: R.appColors.cardBackground,
          radius: 16.px,
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.px),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit_outlined,
                size: 16.px,
                color: R.appColors.darkBlack,
              ),
              hSpacePx(8),
              Text(
                'build_your_own_habit'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: R.appColors.darkBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(radius),
        ),
      );

    const dashWidth = 5.0;
    const dashSpace = 4.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}

class PremiumSuccessView extends StatelessWidget {
  static const String route = '/premium_success_view';
  const PremiumSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.screenBackground2,
      body: const SafeArea(child: PremiumSuccessContent()),
    );
  }
}
