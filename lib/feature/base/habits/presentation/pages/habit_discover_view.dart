import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/constants/enums.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/habits/data/models/habit_template_model.dart';
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
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.appColors.screenBackground2,
      appBar: AppBar(
        backgroundColor: R.appColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.px,
            color: R.appColors.darkBlack,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          'discover_habits'.L(),
          style: R.appTextStyle.poppins(
            fontSize: 18,
            color: R.appColors.darkBlack,
            fontWeight: FontWeight.w700,
          ),
        ),
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
                  if (vm.selectedDiscoverCategory == HabitDiscoverCategory.all) ...[
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
    );
  }

  Widget _searchBar(HabitVm vm) {
    return TextField(
      controller: _searchController,
      onChanged: vm.updateDiscoverSearch,
      style: R.appTextStyle.poppins(
        fontSize: 13,
        color: R.appColors.darkSlate,
      ),
      decoration: InputDecoration(
        hintText: 'search_habits'.L(),
        hintStyle: R.appTextStyle.poppins(
          fontSize: 13,
          color: R.appColors.slateGray,
        ),
        filled: true,
        fillColor: R.appColors.white,
        prefixIcon: Icon(
          Icons.search_rounded,
          color: R.appColors.slateGray,
          size: 22.px,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.px,
          vertical: 14.px,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.px),
          borderSide: BorderSide(color: R.appColors.border3.withValues(alpha: 0.50)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.px),
          borderSide: BorderSide(color: R.appColors.seaGreen),
        ),
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
        separatorBuilder: (_, __) => hSpacePx(8),
        itemBuilder: (context, index) {
          final category = HabitVm.discoverCategories[index];
          final isSelected = vm.selectedDiscoverCategory == category;
          return GestureDetector(
            onTap: () => vm.selectDiscoverCategory(category),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.px, vertical: 8.px),
              decoration: R.appDecorations.cardDecoration(
                color: isSelected
                    ? R.appColors.seaGreen
                    : R.appColors.cardBackground.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(100.px),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _categoryIcon(category),
                    size: 16.px,
                    color: isSelected
                        ? R.appColors.white
                        : R.appColors.textLightBlack,
                  ),
                  hSpacePx(6),
                  Text(
                    _categoryLabel(category),
                    style: R.appTextStyle.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? R.appColors.white
                          : R.appColors.darkSlate,
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
            padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 4.px),
            decoration: R.appDecorations.cardDecoration(
              color: R.appColors.cardBackground.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(100.px),
            ),
            child: Text(
              badge,
              style: R.appTextStyle.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: R.appColors.textLightBlack,
              ),
            ),
          ),
      ],
    );
  }

  Widget _horizontalHabitList(List<HabitTemplateModel> habits) {
    return SizedBox(
      height: 168.px,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.px),
        itemCount: habits.length,
        separatorBuilder: (_, __) => hSpacePx(12),
        itemBuilder: (context, index) {
          return _horizontalHabitCard(habits[index]);
        },
      ),
    );
  }

  Widget _horizontalHabitCard(HabitTemplateModel habit) {
    return Container(
      width: 220.px,
      padding: EdgeInsets.all(14.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(16.px),
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
          Container(
            width: 36.px,
            height: 36.px,
            padding: EdgeInsets.all(8.px),
            decoration: R.appDecorations.cardDecoration(
              color: habit.imageColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.px),
            ),
            child: _habitIcon(habit, size: 18),
          ),
          vSpacePx(10),
          Text(
            habit.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: R.appTextStyle.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: R.appColors.darkBlack,
            ),
          ),
          vSpacePx(4),
          Expanded(
            child: Text(
              habit.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: R.appTextStyle.poppins(
                fontSize: 11,
                color: R.appColors.textLightBlack,
              ),
            ),
          ),
          vSpacePx(8),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 14.px,
                color: R.appColors.slateGray,
              ),
              hSpacePx(4),
              Expanded(
                child: Text(
                  habit.duration,
                  style: R.appTextStyle.poppins(
                    fontSize: 11,
                    color: R.appColors.textLightBlack,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.px,
                    vertical: 6.px,
                  ),
                  decoration: R.appDecorations.cardDecoration(
                    color: R.appColors.warmGold,
                    borderRadius: BorderRadius.circular(100.px),
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
            separatorBuilder: (_, __) => vSpacePx(10),
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

  Widget _verticalHabitTile(HabitTemplateModel habit) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: BorderRadius.circular(16.px),
        boxShadow: [
          BoxShadow(
            color: R.appColors.black.withValues(alpha: 0.03),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.px,
            height: 44.px,
            padding: EdgeInsets.all(11.px),
            decoration: R.appDecorations.cardDecoration(
              color: habit.imageColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14.px),
            ),
            child: _habitIcon(habit, size: 20),
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
            onTap: () {},
            child: Container(
              width: 32.px,
              height: 32.px,
              decoration: R.appDecorations.cardDecoration(
                color: habit.imageColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: R.appColors.white,
                size: 18.px,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _habitIcon(HabitTemplateModel habit, {required double size}) {
    if (habit.image != null) {
      return Image.asset(
        habit.image!,
        color: habit.imageColor,
      );
    }
    return Icon(
      habit.icon ?? Icons.circle,
      color: habit.imageColor,
      size: size.px,
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

  IconData _categoryIcon(HabitDiscoverCategory category) {
    switch (category) {
      case HabitDiscoverCategory.all:
        return Icons.apps_rounded;
      case HabitDiscoverCategory.mindset:
        return Icons.psychology_outlined;
      case HabitDiscoverCategory.wellness:
        return Icons.favorite_border;
      case HabitDiscoverCategory.fitness:
        return Icons.directions_run_rounded;
      case HabitDiscoverCategory.health:
        return Icons.health_and_safety_outlined;
      case HabitDiscoverCategory.productivity:
        return Icons.work_outline_rounded;
      case HabitDiscoverCategory.sleep:
        return Icons.nightlight_round;
      case HabitDiscoverCategory.learning:
        return Icons.menu_book_outlined;
      case HabitDiscoverCategory.beauty:
        return Icons.spa_outlined;
    }
  }
}
