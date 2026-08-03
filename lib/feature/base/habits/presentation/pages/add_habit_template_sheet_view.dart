import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_template_model.dart';
import 'package:habit_tracker/feature/base/habits/presentation/vm/habit_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<dynamic> showAddHabitTemplateSheet(
    BuildContext context, {
      required HabitTemplateModel habit,
    }) {
  final vm = context.read<HabitVm>();
  vm.loadFromTemplate(habit);

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AddHabitTemplateSheet(habit: habit),
  );
}

class AddHabitTemplateSheet extends StatelessWidget {
  final HabitTemplateModel habit;

  const AddHabitTemplateSheet({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Consumer<HabitVm>(
      builder: (context, vm, _) {
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Container(
            decoration: R.appDecorations.cardDecoration(
              color: R.appColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.px)),
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.px, 10.px, 20.px, 16.px),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.px,
                        height: 4.px,
                        margin: EdgeInsets.only(bottom: 16.px),
                        decoration: R.appDecorations.cardDecoration(
                          color: R.appColors.black.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(100.px),
                        ),
                      ),
                    ),
                    _header(),
                    vSpacePx(20),
                    _fieldLabel('target_count'.L()),
                    vSpacePx(8),
                    _stepper(
                      value: '${vm.target}',
                      onMinus: vm.decrementTarget,
                      onPlus: vm.incrementTarget,
                    ),
                    vSpacePx(16),
                    _fieldLabel('schedule'.L()),
                    vSpacePx(8),
                    _scheduleSelector(vm),
                    if (vm.scheduleType == HabitScheduleType.weekly) ...[
                      vSpacePx(16),
                      _fieldLabel('active_days'.L()),
                      vSpacePx(8),
                      _activeDaysRow(vm),
                    ],
                    if (vm.scheduleType == HabitScheduleType.custom) ...[
                      vSpacePx(16),
                      _fieldLabel('repeat_every'.L()),
                      vSpacePx(8),
                      _stepper(
                        value: '${vm.customRepeatDays} day(s)',
                        onMinus: vm.decrementCustomRepeat,
                        onPlus: vm.incrementCustomRepeat,
                      ),
                    ],
                    vSpacePx(16),
                    _fieldLabel('duration_minutes'.L()),
                    vSpacePx(8),
                    _stepper(
                      value: '${vm.durationMinutes}',
                      onMinus: vm.decrementDuration,
                      onPlus: vm.incrementDuration,
                    ),
                    vSpacePx(16),
                    _fieldLabel('reminder_time'.L()),
                    vSpacePx(8),
                    GestureDetector(
                      onTap: () => vm.pickReminderTime(context),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.px,
                          vertical: 14.px,
                        ),
                        decoration: R.appDecorations.cardDecoration(
                          color: R.appColors.screenBackground2,
                          borderRadius: BorderRadius.circular(14.px),
                          border: Border.all(color: R.appColors.cardBackground),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                vm.formattedReminderTime,
                                style: R.appTextStyle.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: R.appColors.darkBlack,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.access_time_rounded,
                              size: 18.px,
                              color: R.appColors.slateGray,
                            ),
                          ],
                        ),
                      ),
                    ),
                    vSpacePx(24),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              height: 48.px,
                              alignment: Alignment.center,
                              decoration: R.appDecorations.cardDecoration(
                                color: R.appColors.cardBackground.withValues(
                                  alpha: 0.55,
                                ),
                                borderRadius: BorderRadius.circular(14.px),
                              ),
                              child: Text(
                                'cancel'.L(),
                                style: R.appTextStyle.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: R.appColors.darkBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                        hSpacePx(12),
                        Expanded(
                          child: GestureDetector(
                            onTap: vm.canSave
                                ? () => vm.saveHabit(context)
                                : null,
                            child: Container(
                              height: 48.px,
                              alignment: Alignment.center,
                              decoration: R.appDecorations.cardDecoration(
                                color: vm.canSave
                                    ? R.appColors.seaGreen
                                    : R.appColors.seaGreen.withValues(
                                        alpha: 0.40,
                                      ),
                                borderRadius: BorderRadius.circular(14.px),
                              ),
                              child: Text(
                                'add_habit'.L(),
                                style: R.appTextStyle.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: R.appColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _header() {
    return Row(
      children: [
        Container(
          width: 48.px,
          height: 48.px,
          padding: EdgeInsets.all(12.px),
          decoration: R.appDecorations.cardDecoration(
            color: R.appColors.warmCream,
            borderRadius: BorderRadius.circular(14.px),
          ),
          child: Image.asset(
            habit.image,
            color: R.appColors.seaGreen,
          ),
        ),
        hSpacePx(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                habit.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: R.appTextStyle.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: R.appColors.darkBlack,
                ),
              ),
              vSpacePx(2),
              Text(
                'customize_before_adding'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 12,
                  color: R.appColors.textLightBlack,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: R.appTextStyle.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: R.appColors.darkBlack,
      ),
    );
  }

  Widget _stepper({
    required String value,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 8.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.screenBackground2,
        borderRadius: BorderRadius.circular(14.px),
        border: Border.all(color: R.appColors.cardBackground),
      ),
      child: Row(
        children: [
          _stepperButton(icon: Icons.remove, onTap: onMinus),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: R.appTextStyle.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: R.appColors.darkBlack,
              ),
            ),
          ),
          _stepperButton(icon: Icons.add, onTap: onPlus),
        ],
      ),
    );
  }

  Widget _stepperButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.px,
        height: 32.px,
        alignment: Alignment.center,
        decoration: R.appDecorations.cardDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(10.px),
          border: Border.all(color: R.appColors.cardBackground),
        ),
        child: Icon(icon, size: 16.px, color: R.appColors.darkBlack),
      ),
    );
  }

  Widget _scheduleSelector(HabitVm vm) {
    final items = {
      HabitScheduleType.daily: 'daily'.L(),
      HabitScheduleType.weekly: 'weekly'.L(),
      HabitScheduleType.custom: 'custom'.L(),
    };

    return Container(
      padding: EdgeInsets.all(4.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.cardBackground.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14.px),
      ),
      child: Row(
        children: items.entries.map((entry) {
          final isSelected = vm.scheduleType == entry.key;
          return Expanded(
            child: GestureDetector(
              onTap: () => vm.selectSchedule(entry.key),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.px),
                decoration: R.appDecorations.cardDecoration(
                  color: isSelected ? R.appColors.white : R.appColors.transparent,
                  borderRadius: BorderRadius.circular(10.px),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: R.appColors.black.withValues(alpha: 0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    entry.value,
                    style: R.appTextStyle.poppins(
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected
                          ? R.appColors.darkBlack
                          : R.appColors.textLightBlack,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _activeDaysRow(HabitVm vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(vm.weekDays.length, (index) {
        final isSelected = vm.selectedDays.contains(index);
        return GestureDetector(
          onTap: () => vm.toggleDay(index),
          child: Container(
            width: 36.px,
            height: 36.px,
            decoration: R.appDecorations.cardDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? R.appColors.seaGreen
                  : R.appColors.seaGreen.withValues(alpha: 0.12),
            ),
            child: Center(
              child: Text(
                vm.weekDays[index],
                style: R.appTextStyle.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? R.appColors.white : R.appColors.darkBlack,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
