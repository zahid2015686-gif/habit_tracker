import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_template_model.dart';
import 'package:habit_tracker/feature/base/habits/presentation/pages/add_habit_template_sheet_view.dart';
import 'package:habit_tracker/feature/base/habits/presentation/vm/habit_vm.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HabitDiscoverView extends StatefulWidget {
  static const String route = '/habit_discover_view';

  const HabitDiscoverView({super.key});

  @override
  State<HabitDiscoverView> createState() => _HabitDiscoverViewState();
}

class _HabitDiscoverViewState extends State<HabitDiscoverView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: R.appColors.screenBackground2,
        appBar: AppBar(
          backgroundColor: R.appColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(child: _customAppBar()),
        ),
        body: SafeArea(
          child: Consumer<HabitVm>(
            builder: (context, vm, _) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 16.px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.px),
                      child: _searchBar(vm),
                    ),
                    vSpacePx(14),
                    _categoryChips(vm),
                    vSpacePx(20),
                    if (vm.selectedDiscoverCategory ==
                        HabitDiscoverCategory.all) ...[
                      if (vm.popularHabits.isNotEmpty) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.px),
                          child: _sectionHeader(
                            title: 'popular'.L(),
                            badge: 'most_added'.L(),
                          ),
                        ),
                        vSpacePx(12),
                        _horizontalHabitList(vm.popularHabits),
                        vSpacePx(20),
                      ],
                      if (vm.suggestedHabits.isNotEmpty) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.px),
                          child: _sectionHeader(
                            title: 'suggested_for_you'.L(),
                            badge: 'curated_picks'.L(),
                          ),
                        ),
                        vSpacePx(12),
                        _horizontalHabitList(vm.suggestedHabits),
                        vSpacePx(20),
                      ],
                    ],
                    ..._categorySections(vm),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _searchBar(HabitVm vm) {
    return TextFormField(
      controller: _searchController,
      focusNode: _searchFocusNode,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onChanged: vm.updateDiscoverSearch,
      style: R.appTextStyle.poppins(
        color: R.appColors.darkBlack,
        fontWeight: FontWeight.w500,
      ),
      decoration: R.appDecorations.textField(
        hintText: 'search_habits'.L(),
        hintStyle: R.appTextStyle.poppins(
          color: R.appColors.slateGray,
          fontWeight: FontWeight.w500,
        ),
        enabledBorderColor: R.appColors.cardBackground,
        errorBorderColor: R.appColors.errorRed,
        focusedBorderColor: R.appColors.seaGreen,
        focusedErrorBorderColor: R.appColors.errorRed,
      ),
    );
  }

  Widget _categoryChips(HabitVm vm) {
    return SizedBox(
      height: 40.px,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.px),
        itemCount: HabitVm.discoverCategories.length,
        separatorBuilder: (_, _) => hSpacePx(8),
        itemBuilder: (context, index) {
          final category = HabitVm.discoverCategories[index];
          final isSelected = vm.selectedDiscoverCategory == category;
          return GestureDetector(
            onTap: () => vm.selectDiscoverCategory(category),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 10.px),
              decoration: R.appDecorations.cardDecoration(
                color: isSelected ? R.appColors.seaGreen : R.appColors.border,
                borderRadius: BorderRadius.circular(100.px),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    width: 11,
                    _categoryIcon(category),
                    color: isSelected ? R.appColors.white : R.appColors.slate,
                  ),
                  hSpacePx(6),
                  Text(
                    _categoryLabel(category),
                    style: R.appTextStyle.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? R.appColors.white : R.appColors.slate,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sectionHeader({required String title, String? badge}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: R.appTextStyle.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: R.appColors.darkBlack,
            ),
          ),
        ),
        if (badge != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 2.px),
            decoration: R.appDecorations.cardDecoration(
              color: R.appColors.border,
              borderRadius: BorderRadius.circular(100.px),
            ),
            child: Text(
              badge,
              style: R.appTextStyle.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: R.appColors.slateGray,
              ),
            ),
          ),
      ],
    );
  }

  Widget _horizontalHabitList(List<HabitTemplateModel> habits) {
    return SizedBox(
      height: 180.px,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.px),
        itemCount: habits.length,
        separatorBuilder: (_, _) => hSpacePx(10),
        itemBuilder: (context, index) {
          return _horizontalHabitCard(habits[index]);
        },
      ),
    );
  }

  Widget _horizontalHabitCard(HabitTemplateModel habit) {
    final accent = habit.isSuggested
        ? R.appColors.goldenAmber
        : R.appColors.sageGreen;

    return Container(
      width: 240.px,
      padding: EdgeInsets.all(17.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(16.px),
        border: Border.all(color: R.appColors.cardBackground),
        boxShadow: [
          BoxShadow(
            color: R.appColors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.px,
                height: 40.px,
                padding: EdgeInsets.all(12.px),
                decoration: R.appDecorations.cardDecoration(
                  color: accent.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16.px),
                ),
                child: Image.asset(habit.image, color: accent),
              ),
              const Spacer(),
              if (habit.isBeginner)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.px,
                    vertical: 2.px,
                  ),
                  decoration: R.appDecorations.cardDecoration(
                    color: R.appColors.secondary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(100.px),
                  ),
                  child: Text(
                    'beginner'.L(),
                    style: R.appTextStyle.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: R.appColors.darkOlive,
                    ),
                  ),
                ),
            ],
          ),
          vSpacePx(12),
          Text(
            habit.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: R.appTextStyle.poppins(
              fontWeight: FontWeight.w700,
              color: R.appColors.darkBlack,
            ),
          ),
          vSpacePx(6),
          Expanded(
            child: Text(
              habit.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: R.appTextStyle.poppins(
                fontSize: 11,
                color: R.appColors.textLightBlack,
              ),
            ),
          ),
          vSpacePx(10),
          Row(
            children: [
              Image.asset(
                R.appImages.timer,
                width: 9.px,
                color: R.appColors.slateGray,
              ),
              hSpacePx(4),
              Expanded(
                child: Text(
                  habit.duration,
                  style: R.appTextStyle.poppins(
                    fontSize: 10,
                    color: R.appColors.slateGray,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showAddHabitTemplateSheet(context, habit: habit),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.px,
                    vertical: 6.px,
                  ),
                  decoration: R.appDecorations.cardDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(100.px),
                    boxShadow: [
                      BoxShadow(
                        color: R.appColors.black.withValues(alpha: 0.05),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Text(
                    'add'.L(),
                    style: R.appTextStyle.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: R.appColors.white,
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

  List<Widget> _categorySections(HabitVm vm) {
    final categories = vm.selectedDiscoverCategory == HabitDiscoverCategory.all
        ? HabitVm.discoverSectionCategories
        : [vm.selectedDiscoverCategory];

    final widgets = <Widget>[];

    for (final category in categories) {
      final habits = vm.habitsByCategory(category);
      if (habits.isEmpty) continue;

      widgets.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.px),
          child: _sectionHeader(title: _categoryLabel(category)),
        ),
      );
      widgets.add(vSpacePx(12));
      widgets.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.px),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: habits.length,
            separatorBuilder: (_, _) => vSpacePx(10),
            itemBuilder: (context, index) {
              return _verticalHabitTile(habits[index]);
            },
          ),
        ),
      );
      widgets.add(vSpacePx(20));
    }

    return widgets;
  }

  Widget _customAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Row(
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
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_back_rounded,
                size: 18,
                color: R.appColors.darkBlack,
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                'discover_habits'.L(),
                style: R.appTextStyle.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: R.appColors.darkBlack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalHabitTile(HabitTemplateModel habit) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(16.px),
        border: Border.all(color: R.appColors.cardBackground),
      ),
      child: Row(
        children: [
          Container(
            width: 40.px,
            height: 40.px,
            padding: EdgeInsets.all(12.px),
            decoration: R.appDecorations.cardDecoration(
              color: habit.imageColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14.px),
            ),
            child: Image.asset(habit.image, color: habit.imageColor),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: R.appColors.darkSlate,
                  ),
                ),
                vSpacePx(3),
                Text(
                  habit.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: R.appTextStyle.poppins(
                    fontSize: 11,
                    color: R.appColors.textLightBlack,
                  ),
                ),
              ],
            ),
          ),
          hSpacePx(10),
          GestureDetector(
            onTap: () => showAddHabitTemplateSheet(context, habit: habit),
            child: Container(
              width: 32.px,
              height: 32.px,
              decoration: R.appDecorations.cardDecoration(
                color: habit.imageColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: R.appColors.white, size: 18.px),
            ),
          ),
        ],
      ),
    );
  }

  String _categoryLabel(HabitDiscoverCategory category) {
    switch (category) {
      case HabitDiscoverCategory.all:
        return 'all'.L();
      case HabitDiscoverCategory.mindset:
        return 'mindset'.L();
      case HabitDiscoverCategory.wellness:
        return 'wellness'.L();
      case HabitDiscoverCategory.fitness:
        return 'fitness'.L();
      case HabitDiscoverCategory.health:
        return 'health'.L();
      case HabitDiscoverCategory.productivity:
        return 'productivity'.L();
      case HabitDiscoverCategory.sleep:
        return 'sleep'.L();
      case HabitDiscoverCategory.learning:
        return 'learning'.L();
      case HabitDiscoverCategory.beauty:
        return 'beauty'.L();
    }
  }

  String _categoryIcon(HabitDiscoverCategory category) {
    switch (category) {
      case HabitDiscoverCategory.all:
        return R.appImages.all;
      case HabitDiscoverCategory.mindset:
        return R.appImages.mindset;
      case HabitDiscoverCategory.wellness:
        return R.appImages.wellness;
      case HabitDiscoverCategory.fitness:
        return R.appImages.fitness;
      case HabitDiscoverCategory.health:
        return R.appImages.health;
      case HabitDiscoverCategory.productivity:
        return R.appImages.productivity;
      case HabitDiscoverCategory.sleep:
        return R.appImages.sleep;
      case HabitDiscoverCategory.learning:
        return R.appImages.learning;
      case HabitDiscoverCategory.beauty:
        return R.appImages.beauty;
    }
  }
}