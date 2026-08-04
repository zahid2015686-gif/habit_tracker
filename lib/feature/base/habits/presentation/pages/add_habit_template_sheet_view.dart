import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/core/widgets/app_button.dart';
import 'package:habit_tracker/core/widgets/app_toast.dart';
import 'package:habit_tracker/feature/base/base_view/presentation/pages/base_view.dart';
import 'package:habit_tracker/feature/base/base_view/presentation/vm/base_vm.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_template_model.dart';
import 'package:habit_tracker/feature/base/habits/presentation/pages/habit_discover_view.dart';
import 'package:habit_tracker/feature/base/habits/presentation/vm/habit_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<dynamic> showAddHabitTemplateSheet(
  BuildContext context, {
  required HabitTemplateModel habit,
}) async {
  final vm = context.read<HabitVm>();
  vm.loadFromTemplate(habit);

  final result = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AddHabitTemplateSheet(habit: habit),
  );

  if (result == true && context.mounted) {
    context.read<BaseVm>().goToHome(skipWelcomePremium: true);

    if (Get.currentRoute == HabitDiscoverView.route) {
      Get.until((route) => route.settings.name == BaseView.route || route.isFirst);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAppToast('habit_created_successfully'.L());
    });
  }
}

class AddHabitTemplateSheet extends StatefulWidget {
  final HabitTemplateModel habit;

  const AddHabitTemplateSheet({super.key, required this.habit});

  @override
  State<AddHabitTemplateSheet> createState() => _AddHabitTemplateSheetState();
}

class _AddHabitTemplateSheetState extends State<AddHabitTemplateSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const _scheduleTypes = [
    HabitScheduleType.daily,
    HabitScheduleType.weekly,
    HabitScheduleType.custom,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _scheduleTypes.length, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    context.read<HabitVm>().selectSchedule(
      _scheduleTypes[_tabController.index],
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

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
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.px)),
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
                          color: R.appColors.border3,
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
                    _scheduleTabBar(),
                    vSpacePx(12),
                    SizedBox(
                      height: 56.px,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          const SizedBox.shrink(),
                          _activeDaysRow(vm),
                          _stepper(
                            value: '${vm.customRepeatDays} day(s)',
                            onMinus: vm.decrementCustomRepeat,
                            onPlus: vm.incrementCustomRepeat,
                          ),
                        ],
                      ),
                    ),
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
                          borderRadius: BorderRadius.circular(16.px),
                          border: Border.all(color: R.appColors.cardBackground),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                vm.formattedReminderTime,
                                style: R.appTextStyle.poppins(
                                  fontSize: 16,
                                  color: R.appColors.darkSlate,
                                ),
                              ),
                            ),
                            Image.asset(
                              R.appImages.reminderTime,
                              color: R.appColors.slateGray,
                              width: 14.px,
                            ),
                          ],
                        ),
                      ),
                    ),
                    vSpacePx(24),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: 'cancel'.L(),
                            color: R.appColors.border,
                            borderRadius: 12,
                            onTap: () => Navigator.of(context).pop(),
                            textStyle: R.appTextStyle.poppins(
                              color: R.appColors.textBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        hSpacePx(12),
                        Expanded(
                          child: AppButton(
                            text: 'add_habit'.L(),
                            color: R.appColors.seaGreen,
                            borderRadius: 12,
                            onTap: () => Navigator.of(context).pop(true),
                            textStyle: R.appTextStyle.poppins(
                              color: R.appColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
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
          width: 44.px,
          height: 44.px,
          padding: EdgeInsets.all(12.px),
          decoration: R.appDecorations.cardDecoration(
            color: R.appColors.secondary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12.px),
          ),
          child: Image.asset(widget.habit.image, color: R.appColors.seaGreen),
        ),
        hSpacePx(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.habit.title,
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
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: R.appColors.slate,
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
        borderRadius: BorderRadius.circular(16.px),
        border: Border.all(color: R.appColors.cardBackground, width: 2.px),
      ),
      child: Row(
        children: [
          _stepperButton(icon: Icons.remove, onTap: onMinus),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: R.appTextStyle.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: R.appColors.darkSlate,
              ),
            ),
          ),
          _stepperButton(icon: Icons.add, onTap: onPlus),
        ],
      ),
    );
  }

  Widget _stepperButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: 16.px, color: R.appColors.textLightBlack),
    );
  }

  Widget _scheduleTabBar() {
    return Container(
      height: 44.px,
      padding: EdgeInsets.all(4.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.border,
        borderRadius: BorderRadius.circular(100.px),
      ),
      child: TabBar(
        controller: _tabController,
        dividerColor: R.appColors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(100.px),
          boxShadow: [
            BoxShadow(
              color: R.appColors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        labelColor: R.appColors.darkBlack,
        unselectedLabelColor: R.appColors.textLightBlack,
        labelStyle: R.appTextStyle.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: R.appTextStyle.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(text: 'daily'.L()),
          Tab(text: 'weekly'.L()),
          Tab(text: 'custom'.L()),
        ],
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