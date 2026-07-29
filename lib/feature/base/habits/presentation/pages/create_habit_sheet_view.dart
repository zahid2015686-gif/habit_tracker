import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/habits/presentation/vm/habit_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

/// Call this to open the Create Habit bottom sheet from anywhere.
Future<dynamic> showCreateHabitSheetView(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ChangeNotifierProvider(
      create: (_) => HabitVm(),
      child: const CreateHabitSheet(),
    ),
  );
}

class CreateHabitSheet extends StatelessWidget {
  const CreateHabitSheet({super.key});

  static const List<Color> _habitColors = [
    Color(0xFF16A34A),
    Color(0xFF22C55E),
    Color(0xFF86EFAC),
    Color(0xFF38BDF8),
    Color(0xFF3B82F6),
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitVm>(
      builder: (context, vm, _) {
        return Container(
          decoration: BoxDecoration(
            color: R.appColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.px)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.px,
                    height: 4.px,
                    margin: EdgeInsets.only(bottom: 12.px),
                    decoration: R.appDecorations.cardDecoration(
                      color: R.appColors.black.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(100.px),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'create_habit'.L(),
                    style: R.appTextStyle.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: R.appColors.darkBlack,
                    ),
                  ),
                ),
                vSpacePx(20),
                Column(
                  children: [
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: R.appColors.textLightBlack.withValues(alpha: 0.20),
                    ),
                    vSpacePx(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(_habitColors.length, (index) {
                        return GestureDetector(
                          onTap: () => vm.selectColor(index),
                          child: Container(
                            width: 30.px,
                            height: 20.px,
                            decoration: BoxDecoration(
                              color: _habitColors[index],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.px),
                                bottomRight: Radius.circular(8.px),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                vSpacePx(20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.px),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'icon'.L(),
                            style: R.appTextStyle.poppins(
                              fontWeight: FontWeight.w600,
                              color: R.appColors.darkBlack,
                            ),
                          ),
                          GestureDetector(
                            //onTap: () => FocusScope.of(context).unfocus(),
                            child: Text(
                              'done'.L(),
                              style: R.appTextStyle.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: R.appColors.textGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                      vSpacePx(10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: vm.habits.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10.px,
                          crossAxisSpacing: 10.px,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final bool isSelected = vm.selectedIconIndex == index;
                          final habits = vm.habits[index];
                          return GestureDetector(
                            onTap: () => vm.selectIcon(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? R.appColors.textGreen.withValues(
                                        alpha: 0.15,
                                      )
                                    : R.appColors.border.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(14.px),
                              ),
                              child: Center(
                                child: Image.asset(
                                  habits.image,
                                  height: 24.px,
                                  width: 24.px,
                                  color: isSelected
                                      ? R.appColors.textGreen
                                      : R.appColors.black.withValues(
                                          alpha: 0.6,
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.px),

                      // ---------------- Schedule ----------------
                      Text(
                        'Schedule',
                        style: R.appTextStyle.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: R.appColors.black,
                        ),
                      ),
                      SizedBox(height: 10.px),
                      _scheduleSelector(vm),
                      SizedBox(height: 20.px),

                      // ---------------- Weekly: Active Days ----------------
                      if (vm.scheduleType == HabitScheduleType.weekly) ...[
                        Text(
                          'Active Days',
                          style: R.appTextStyle.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: R.appColors.black,
                          ),
                        ),
                        SizedBox(height: 10.px),
                        _activeDaysRow(vm),
                        SizedBox(height: 20.px),
                      ],

                      // ---------------- Custom: Repeat every N days ----------------
                      if (vm.scheduleType == HabitScheduleType.custom) ...[
                        Text(
                          'Repeat Every',
                          style: R.appTextStyle.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: R.appColors.black,
                          ),
                        ),
                        SizedBox(height: 10.px),
                        _stepperRow(
                          value: '${vm.customRepeatDays} day(s)',
                          onMinus: vm.decrementCustomRepeat,
                          onPlus: vm.incrementCustomRepeat,
                        ),
                        SizedBox(height: 20.px),
                      ],

                      // ---------------- Reminder Time ----------------
                      Text(
                        'Reminder Time',
                        style: R.appTextStyle.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: R.appColors.black,
                        ),
                      ),
                      SizedBox(height: 10.px),
                      GestureDetector(
                        onTap: () => vm.pickReminderTime(context),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.px,
                            vertical: 14.px,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.px),
                            border: Border.all(color: R.appColors.border),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                vm.formattedReminderTime,
                                style: R.appTextStyle.poppins(
                                  fontSize: 14,
                                  color: R.appColors.black,
                                ),
                              ),
                              Icon(
                                Icons.access_time,
                                size: 18,
                                color: R.appColors.black.withValues(alpha: 0.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.px),

                      // ---------------- Target & Duration ----------------
                      Row(
                        children: [
                          Expanded(
                            child: _stepperColumn(
                              label: 'Target',
                              value: '${vm.target}',
                              onMinus: vm.decrementTarget,
                              onPlus: vm.incrementTarget,
                            ),
                          ),
                          SizedBox(width: 16.px),
                          Expanded(
                            child: _stepperColumn(
                              label: 'Duration (min)',
                              value: '${vm.durationMinutes}',
                              onMinus: vm.decrementDuration,
                              onPlus: vm.incrementDuration,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.px),

                      // ---------------- Save button ----------------
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: vm.canSave
                              ? () => vm.saveHabit(context)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: vm.canSave
                                ? R.appColors.primary
                                : R.appColors.primary.withValues(alpha: 0.4),
                            padding: EdgeInsets.symmetric(vertical: 16.px),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.px),
                            ),
                          ),
                          child: Text(
                            'Save Habit',
                            style: R.appTextStyle.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: R.appColors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.px),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------- Schedule segmented control ----------------
  Widget _scheduleSelector(HabitVm vm) {
    final items = {
      HabitScheduleType.daily: 'Daily',
      HabitScheduleType.weekly: 'Weekly',
      HabitScheduleType.custom: 'Custom',
    };

    return Container(
      padding: EdgeInsets.all(4.px),
      decoration: BoxDecoration(
        color: R.appColors.border.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(14.px),
      ),
      child: Row(
        children: items.entries.map((entry) {
          final bool isSelected = vm.scheduleType == entry.key;
          return Expanded(
            child: GestureDetector(
              onTap: () => vm.selectSchedule(entry.key),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.px),
                decoration: BoxDecoration(
                  color: isSelected ? R.appColors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.px),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: R.appColors.black.withValues(alpha: 0.08),
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
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? R.appColors.black
                          : R.appColors.black.withValues(alpha: 0.5),
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

  // ---------------- Active days row ----------------
  Widget _activeDaysRow(HabitVm vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(vm.weekDays.length, (index) {
        final bool isSelected = vm.selectedDays.contains(index);
        return GestureDetector(
          onTap: () => vm.toggleDay(index),
          child: Container(
            width: 38.px,
            height: 38.px,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? R.appColors.textGreen
                  : R.appColors.textGreen.withValues(alpha: 0.15),
            ),
            child: Center(
              child: Text(
                vm.weekDays[index],
                style: R.appTextStyle.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? R.appColors.white : R.appColors.black,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // ---------------- Reusable stepper row (single, full width) ----------------
  Widget _stepperRow({
    required String value,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.px, vertical: 8.px),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.px),
        border: Border.all(color: R.appColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleButton(icon: Icons.remove, onTap: onMinus),
          Text(
            value,
            style: R.appTextStyle.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          _circleButton(icon: Icons.add, onTap: onPlus),
        ],
      ),
    );
  }

  // ---------------- Reusable stepper column (label + row) ----------------
  Widget _stepperColumn({
    required String label,
    required String value,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: R.appTextStyle.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: R.appColors.black,
          ),
        ),
        SizedBox(height: 10.px),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 6.px),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.px),
            border: Border.all(color: R.appColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _circleButton(icon: Icons.remove, onTap: onMinus),
              Text(
                value,
                style: R.appTextStyle.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _circleButton(icon: Icons.add, onTap: onPlus),
            ],
          ),
        ),
      ],
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: R.appColors.border.withValues(alpha: 0.5),
        ),
        child: Icon(icon, size: 16, color: R.appColors.black),
      ),
    );
  }
}
