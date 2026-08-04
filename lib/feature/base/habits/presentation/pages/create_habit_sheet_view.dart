import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/core/widgets/app_button.dart';
import 'package:habit_tracker/core/widgets/app_toast.dart';
import 'package:habit_tracker/feature/base/base_view/presentation/vm/base_vm.dart';
import 'package:habit_tracker/feature/base/habits/presentation/vm/habit_vm.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<dynamic> showCreateHabitSheetView(BuildContext context) async {
  context.read<HabitVm>().resetCreateForm();

  final result = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const CreateHabitSheet(),
  );

  if (result != null && context.mounted) {
    context.read<BaseVm>().goToHome(skipWelcomePremium: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showAppToast('habit_created_successfully'.L());
    });
  }
}

class CreateHabitSheet extends StatefulWidget {
  const CreateHabitSheet({super.key});

  @override
  State<CreateHabitSheet> createState() => _CreateHabitSheetState();
}

class _CreateHabitSheetState extends State<CreateHabitSheet>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _lightNameController = TextEditingController();
  final _notesController = TextEditingController();

  final _nameFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _lightNameFocus = FocusNode();
  final _notesFocus = FocusNode();

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
    _nameController.dispose();
    _descriptionController.dispose();
    _lightNameController.dispose();
    _notesController.dispose();
    _nameFocus.dispose();
    _descriptionFocus.dispose();
    _lightNameFocus.dispose();
    _notesFocus.dispose();
    super.dispose();
  }

  void _hideKeyboard() => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Consumer<HabitVm>(
      builder: (context, vm, _) {
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: GestureDetector(
            onTap: _hideKeyboard,
            behavior: HitTestBehavior.opaque,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.92,
              ),
              decoration: R.appDecorations.cardDecoration(
                color: R.appColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24.px),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    vSpacePx(10),
                    Container(
                      width: 40.px,
                      height: 4.px,
                      decoration: R.appDecorations.cardDecoration(
                        color: R.appColors.border3,
                        borderRadius: BorderRadius.circular(100.px),
                      ),
                    ),
                    vSpacePx(12),
                    Text(
                      'create_habit'.L(),
                      style: R.appTextStyle.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: R.appColors.darkBlack,
                      ),
                    ),
                    vSpacePx(12),
                    Divider(height: 1, thickness: 1, color: R.appColors.border),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          20.px,
                          16.px,
                          20.px,
                          20.px,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _fieldLabel('habit_name'.L()),
                            vSpacePx(8),
                            _habitNameTextFormField(),
                            vSpacePx(16),
                            _fieldLabel('description'.L()),
                            vSpacePx(8),
                            _descriptionTextFormField(vm: vm),
                            vSpacePx(16),
                            _fieldLabel('category'.L()),
                            vSpacePx(10),
                            _categoryChips(vm),
                            vSpacePx(16),
                            _fieldLabel('color'.L()),
                            vSpacePx(10),
                            _colorRow(vm),
                            vSpacePx(16),
                            Row(
                              children: [
                                Expanded(child: _fieldLabel('icon'.L())),
                                GestureDetector(
                                  onTap: _hideKeyboard,
                                  child: Text(
                                    'done'.L(),
                                    style: R.appTextStyle.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: R.appColors.seaGreen,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            vSpacePx(10),
                            _iconGrid(vm),
                            vSpacePx(16),
                            _fieldLabel('schedule'.L()),
                            vSpacePx(8),
                            _scheduleTabBar(),
                            vSpacePx(12),
                            if (vm.scheduleType ==
                                HabitScheduleType.weekly) ...[
                              _fieldLabel('active_days'.L()),
                              vSpacePx(8),
                              _activeDaysRow(vm),
                              vSpacePx(16),
                            ],
                            if (vm.scheduleType ==
                                HabitScheduleType.custom) ...[
                              _fieldLabel('custom_schedule'.L()),
                              vSpacePx(8),
                              _customCalendar(vm),
                              vSpacePx(16),
                              _fieldLabel('active_days'.L()),
                              vSpacePx(8),
                              _activeDaysRow(vm),
                              vSpacePx(16),
                            ],
                            _fieldLabel('reminder_time'.L()),
                            vSpacePx(8),
                            _reminderField(vm),
                            vSpacePx(16),
                            Row(
                              children: [
                                Expanded(
                                  child: _stepperColumn(
                                    label: 'target'.L(),
                                    value: '${vm.target}',
                                    onMinus: vm.decrementTarget,
                                    onPlus: vm.incrementTarget,
                                  ),
                                ),
                                hSpacePx(12),
                                Expanded(
                                  child: _stepperColumn(
                                    label: 'duration_min'.L(),
                                    value: '${vm.durationMinutes}',
                                    onMinus: vm.decrementDuration,
                                    onPlus: vm.incrementDuration,
                                  ),
                                ),
                              ],
                            ),
                            vSpacePx(16),
                            _minimumVersionSection(vm),
                            vSpacePx(16),
                            _fieldLabel('notes'.L()),
                            vSpacePx(8),
                            _noteTextFormField(),
                            vSpacePx(24),
                            AppButton(
                              text: 'save_habit'.L(),
                              color: R.appColors.seaGreen,
                              borderRadius: 16,
                              enabled: vm.canSave,
                              onTap: () {
                                vm.saveHabit(
                                  context,
                                  habitName: _nameController.text.trim(),
                                  description:
                                      _descriptionController.text.trim(),
                                  notes: _notesController.text.trim(),
                                  lightVersionName:
                                      _lightNameController.text.trim(),
                                );
                              },
                              textStyle: R.appTextStyle.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: R.appColors.white,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: R.appColors.black.withValues(
                                    alpha: 0.04,
                                  ),
                                  offset: Offset(0, 10),
                                  blurRadius: 20,
                                  spreadRadius: -2,
                                ),
                                BoxShadow(
                                  color: R.appColors.black.withValues(
                                    alpha: 0.07,
                                  ),
                                  offset: Offset(0, 2),
                                  blurRadius: 15,
                                  spreadRadius: -3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: R.appTextStyle.poppins(
        fontWeight: FontWeight.w600,
        color: R.appColors.textBlack,
      ),
    );
  }

  Widget _habitNameTextFormField() {
    return TextFormField(
      controller: _nameController,
      focusNode: _nameFocus,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _descriptionFocus.requestFocus(),
      style: R.appTextStyle.poppins(fontSize: 16, color: R.appColors.darkBlack),
      decoration: R.appDecorations.textField(
        hintText: 'habit_name_hint'.L(),
        borderRadius: 16.px,
        enabledBorderColor: R.appColors.cardBackground,
        focusedBorderColor: R.appColors.seaGreen,
        hintStyle: R.appTextStyle.poppins(
          fontSize: 16,
          color: R.appColors.slateGray,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _descriptionTextFormField({required HabitVm vm}) {
    return TextFormField(
      controller: _descriptionController,
      focusNode: _descriptionFocus,
      textInputAction: TextInputAction.next,
      maxLines: 3,
      onFieldSubmitted: (_) {
        if (vm.enableMinimumVersion) {
          _lightNameFocus.requestFocus();
        } else {
          _notesFocus.requestFocus();
        }
      },
      style: R.appTextStyle.poppins(fontSize: 16, color: R.appColors.darkBlack),
      decoration: R.appDecorations.textField(
        hintText: 'description_hint'.L(),
        borderRadius: 16.px,
        enabledBorderColor: R.appColors.cardBackground,
        focusedBorderColor: R.appColors.seaGreen,
        hintStyle: R.appTextStyle.poppins(
          fontSize: 13,
          color: R.appColors.slateGray,
        ),
      ),
    );
  }

  Widget _noteTextFormField() {
    return TextFormField(
      controller: _notesController,
      focusNode: _notesFocus,
      textInputAction: TextInputAction.done,
      maxLines: 4,
      onFieldSubmitted: (_) => _hideKeyboard(),
      style: R.appTextStyle.poppins(fontSize: 14, color: R.appColors.darkBlack),
      decoration: R.appDecorations.textField(
        hintText: 'notes_hint'.L(),
        borderRadius: 14.px,
        enabledBorderColor: R.appColors.cardBackground,
        focusedBorderColor: R.appColors.seaGreen,
        hintStyle: R.appTextStyle.poppins(
          fontSize: 13,
          color: R.appColors.slateGray,
        ),
      ),
    );
  }

  Widget _categoryChips(HabitVm vm) {
    return Wrap(
      spacing: 8.px,
      runSpacing: 8.px,
      children: List.generate(HabitVm.habitCategories.length, (index) {
        final selected = vm.selectedCategoryIndex == index;
        return GestureDetector(
          onTap: () => vm.selectCategory(index),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.px, vertical: 8.px),
            decoration: R.appDecorations.cardDecoration(
              color: selected
                  ? R.appColors.seaGreen.withValues(alpha: 0.10)
                  : R.appColors.cardBackground,
              borderRadius: BorderRadius.circular(100.px),
            ),
            child: Text(
              HabitVm.habitCategories[index],
              style: R.appTextStyle.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: selected ? R.appColors.seaGreen : R.appColors.slate,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _colorRow(HabitVm vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(HabitVm.habitColors.length, (index) {
        final selected = vm.selectedColorIndex == index;
        return GestureDetector(
          onTap: () => vm.selectColor(index),
          child: Container(
            width: 30.px,
            height: 30.px,
            decoration: R.appDecorations.cardDecoration(
              color: HabitVm.habitColors[index],
              borderRadius: BorderRadius.circular(8.px),
              boxShadow: [
                BoxShadow(
                  color: R.appColors.black.withValues(alpha: 0.08),
                  offset: Offset(0, 0.5),
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: R.appColors.black.withValues(alpha: 0.10),
                  offset: Offset(0, 0.0),
                  blurRadius: 0.75,
                ),
              ],
              border: selected
                  ? Border.all(color: R.appColors.textLightBlack, width: 2)
                  : null,
            ),
          ),
        );
      }),
    );
  }

  Widget _iconGrid(HabitVm vm) {
    final icons = vm.habitIconImages;
    return Container(
      padding: EdgeInsets.all(16.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.screenBackground2,
        borderRadius: BorderRadius.circular(16.px),
        border: Border.all(color: R.appColors.cardBackground),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: icons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10.px,
          crossAxisSpacing: 10.px,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final selected = vm.selectedIconIndex == index;
          return GestureDetector(
            onTap: () => vm.selectIcon(index),
            child: Container(
              padding: EdgeInsets.all(22.px),
              decoration: R.appDecorations.cardDecoration(
                color: selected
                    ? R.appColors.secondary.withValues(alpha: 0.20)
                    : R.appColors.white,
                borderRadius: BorderRadius.circular(12.px),
              ),
              child: Image.asset(
                icons[index],
                color: selected
                    ? R.appColors.seaGreen
                    : R.appColors.textLightBlack,
              ),
            ),
          );
        },
      ),
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
        indicator: R.appDecorations.cardDecoration(
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
        splashBorderRadius: BorderRadius.circular(100.px),
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
        final selected = vm.selectedDays.contains(index);
        return GestureDetector(
          onTap: () => vm.toggleDay(index),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8.px),
            decoration: R.appDecorations.cardDecoration(
              color: selected
                  ? R.appColors.seaGreen.withValues(alpha: 0.15)
                  : R.appColors.border,
            ),
            child: Center(
              child: Text(
                vm.weekDays[index],
                style: R.appTextStyle.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? R.appColors.seaGreen
                      : R.appColors.textLightBlack,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _reminderField(HabitVm vm) {
    return GestureDetector(
      onTap: () => vm.pickReminderTime(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.px, vertical: 14.px),
        decoration: R.appDecorations.cardDecoration(
          color: R.appColors.white,
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
              width: 16.px,
              height: 16.px,
              color: R.appColors.slateGray,
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepperColumn({
    required String label,
    required String value,
    required VoidCallback onMinus,
    required VoidCallback onPlus,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel(label),
        vSpacePx(8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 10.px),
          decoration: R.appDecorations.cardDecoration(
            color: R.appColors.white,
            borderRadius: BorderRadius.circular(14.px),
            border: Border.all(color: R.appColors.cardBackground),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: onMinus,
                child: Text(
                  '−',
                  style: R.appTextStyle.poppins(
                    fontSize: 18,
                    color: R.appColors.textLightBlack,
                  ),
                ),
              ),
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
              GestureDetector(
                onTap: onPlus,
                child: Text(
                  '+',
                  style: R.appTextStyle.poppins(
                    fontSize: 18,
                    color: R.appColors.textLightBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _minimumVersionSection(HabitVm vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'minimum_version'.L(),
              style: R.appTextStyle.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: R.appColors.textBlack,
              ),
            ),
            hSpacePx(8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.px, vertical: 2.px),
              decoration: R.appDecorations.cardDecoration(
                color: R.appColors.border,
                borderRadius: BorderRadius.circular(100.px),
              ),
              child: Text(
                'optional'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 10,
                  color: R.appColors.slateGray,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            Switch(
              value: vm.enableMinimumVersion,
              activeThumbColor: R.appColors.white,
              activeTrackColor: R.appColors.seaGreen,
              onChanged: vm.toggleMinimumVersion,
              inactiveThumbColor: R.appColors.darkBlack,
              inactiveTrackColor: R.appColors.cardBackground,
            ),
          ],
        ),
        Text(
          'minimum_version_description'.L(),
          style: R.appTextStyle.poppins(
            fontSize: 11,
            color: R.appColors.slateGray,
          ),
        ),
        if (vm.enableMinimumVersion) ...[
          vSpacePx(12),
          DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: Radius.circular(16.px),
              color: R.appColors.herbGreen.withValues(alpha: 0.60),
              dashPattern: const [6, 4],
              strokeWidth: 1.5,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.px),
              decoration: R.appDecorations.cardDecoration(
                color: R.appColors.softPistachio.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(16.px),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldLabel('name'.L()),
                  vSpacePx(8),
                  TextFormField(
                    controller: _lightNameController,
                    focusNode: _lightNameFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _notesFocus.requestFocus(),
                    style: R.appTextStyle.poppins(
                      fontSize: 14,
                      color: R.appColors.darkBlack,
                    ),
                    decoration: R.appDecorations.textField(
                      hintText: 'light_version_name_hint'.L(),
                      borderRadius: 14.px,
                      enabledBorderColor: R.appColors.cardBackground,
                      focusedBorderColor: R.appColors.seaGreen,
                      hintStyle: R.appTextStyle.poppins(
                        fontSize: 12,
                        color: R.appColors.slateGray,
                      ),
                    ),
                  ),
                  vSpacePx(12),
                  Row(
                    children: [
                      Expanded(
                        child: _stepperColumn(
                          label: 'target'.L(),
                          value: '${vm.lightTarget}',
                          onMinus: vm.decrementLightTarget,
                          onPlus: vm.incrementLightTarget,
                        ),
                      ),
                      hSpacePx(12),
                      Expanded(
                        child: _stepperColumn(
                          label: 'duration_min'.L(),
                          value: vm.lightDurationMinutes?.toString() ?? '—',
                          onMinus: vm.decrementLightDuration,
                          onPlus: vm.incrementLightDuration,
                        ),
                      ),
                    ],
                  ),
                  vSpacePx(12),
                  Row(
                    children: [
                      Text(
                        'preview'.L(),
                        style: R.appTextStyle.poppins(
                          fontSize: 10,
                          color: R.appColors.slateGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      hSpacePx(8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.px,
                          vertical: 4.px,
                        ),
                        decoration: R.appDecorations.cardDecoration(
                          color: R.appColors.seaGreen,
                          borderRadius: BorderRadius.circular(100.px),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              R.appImages.health,
                              width: 10.px,
                              height: 10.px,
                              color: R.appColors.white,
                            ),
                            hSpacePx(4),
                            Text(
                              'light_version'.L(),
                              style: R.appTextStyle.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: R.appColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _customCalendar(HabitVm vm) {
    final month = vm.calendarMonth;
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final startWeekday = firstDay.weekday % 7;

    final cells = <Widget>[];
    for (var i = 0; i < startWeekday; i++) {
      cells.add(const SizedBox.shrink());
    }
    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(month.year, month.month, day);
      final selected = vm.isCustomDateSelected(date);
      cells.add(
        GestureDetector(
          onTap: () => vm.toggleCustomDate(date),
          child: Container(
            alignment: Alignment.center,
            decoration: R.appDecorations.cardDecoration(
              color: selected
                  ? R.appColors.textLightGreen
                  : R.appColors.transparent,
              borderRadius: BorderRadius.circular(10.px),
            ),
            child: Text(
              '$day',
              style: R.appTextStyle.poppins(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? R.appColors.white : R.appColors.textBlack,
              ),
            ),
          ),
        ),
      );
    }

    final sortedDates = vm.selectedCustomDates.toList()
      ..sort((a, b) => a.compareTo(b));

    return Container(
      padding: EdgeInsets.all(14.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.screenBackground2,
        borderRadius: BorderRadius.circular(16.px),
        border: Border.all(color: R.appColors.cardBackground, width: 1.px),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => vm.changeCalendarMonth(-1),
                child: Text(
                  '‹',
                  style: R.appTextStyle.poppins(
                    fontSize: 24,
                    color: R.appColors.slate,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  DateFormat('MMMM yyyy').format(month),
                  textAlign: TextAlign.center,
                  style: R.appTextStyle.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: R.appColors.darkSlate,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => vm.changeCalendarMonth(1),
                child: Text(
                  '›',
                  style: R.appTextStyle.poppins(
                    fontSize: 24,
                    color: R.appColors.slate,
                  ),
                ),
              ),
            ],
          ),
          vSpacePx(12),
          Row(
            children: vm.weekDays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: R.appTextStyle.poppins(
                          fontSize: 10,
                          color: R.appColors.slateGray,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          vSpacePx(8),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 7,
            mainAxisSpacing: 6.px,
            crossAxisSpacing: 6.px,
            children: cells,
          ),
          vSpacePx(10),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${sortedDates.length} ',
                  style: R.appTextStyle.poppins(
                    fontSize: 12,
                    color: R.appColors.successGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'date_selected'.L(),
                  style: R.appTextStyle.poppins(
                    fontSize: 12,
                    color: R.appColors.textBlack,
                  ),
                ),
              ],
            ),
          ),
          vSpacePx(5),
          Divider(height: 0, color: R.appColors.cardBackground),
          if (sortedDates.isNotEmpty) ...[
            vSpacePx(8),
            Wrap(
              spacing: 8.px,
              runSpacing: 8.px,
              children: sortedDates.map((date) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.px,
                    vertical: 2.px,
                  ),
                  decoration: R.appDecorations.cardDecoration(
                    color: R.appColors.cardBackground,
                    borderRadius: BorderRadius.circular(100.px),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat('MMM d').format(date),
                        style: R.appTextStyle.poppins(
                          fontSize: 10,
                          color: R.appColors.slate,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      hSpacePx(6),
                      GestureDetector(
                        onTap: () => vm.removeCustomDate(date),
                        child: Text(
                          '×',
                          style: R.appTextStyle.poppins(
                            fontSize: 14,
                            color: R.appColors.slate,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}