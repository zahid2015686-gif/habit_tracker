import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:habit_tracker/feature/base/base_view/presentation/vm/base_vm.dart';
import 'package:habit_tracker/feature/base/habits/presentation/pages/create_habit_sheet_view.dart';
import 'package:habit_tracker/feature/base/habits/presentation/pages/habits_view.dart';
import 'package:habit_tracker/feature/base/home/presentation/pages/home_view.dart';
import 'package:habit_tracker/feature/base/profile/presentation/pages/profile_view.dart';
import 'package:habit_tracker/feature/base/rhythm/presentation/pages/rhythm_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BaseView extends StatefulWidget {
  static const String route = '/base_view';
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,

        // Navigation bar
        systemNavigationBarColor: R.appColors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseVm>(
      builder: (context, vm, _) {
        return Scaffold(
          body: IndexedStack(
            index: vm.currentIndex,
            children: const [
              HomeView(),
              HabitsView(),
              Center(child: Text("Upload")),
              RhythmView(),
              ProfileView(),
            ],
          ),
          bottomNavigationBar: _bottomBar(vm),
        );
      },
    );
  }

  Widget _bottomBar(BaseVm vm) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.px),
      decoration: R.appDecorations.cardDecoration(
        color: R.appColors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(vm, 0),
            _navItem(vm, 1),
            GestureDetector(
              onTap: () {
                showCreateHabitSheetView(context);
              },
              child: Image.asset(
                R.appImages.upload,
                height: 30.px,
              ),
            ),
            _navItem(vm, 3),
            _navItem(vm, 4),
          ],
        ),
      ),
    );
  }

  Widget _navItem(BaseVm vm, int index) {
    final item = vm.getBaseVm[index > 2 ? index - 1 : index];
    final bool isSelected = vm.currentIndex == index;

    return GestureDetector(
      onTap: () => vm.changeIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            item.imagePath,
            height: 26.px,
            width: 26.px,
            color: isSelected ? null : R.appColors.black.withValues(alpha: 0.33),
          ),
          Text(
            item.label,
            style: R.appTextStyle.poppins(
              fontSize: 12,
              color: isSelected
                  ? R.appColors.secondary
                  :  R.appColors.black.withValues(alpha: 0.33),
            ),
          ),
        ],
      ),
    );
  }
}

