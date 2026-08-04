import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/app_localization.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:sizer/sizer.dart';

Future<void> showHabitCreatedSuccessDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: R.appColors.black.withValues(alpha: 0.35),
    builder: (dialogContext) {
      Future.delayed(const Duration(seconds: 2), () {
        if (dialogContext.mounted) {
          Navigator.of(dialogContext).pop();
        }
      });

      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: const _HabitCreatedSuccessDialog(),
      );
    },
  );
}

class _HabitCreatedSuccessDialog extends StatelessWidget {
  const _HabitCreatedSuccessDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: R.appColors.transparent,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.px, vertical: 28.px),
        decoration: R.appDecorations.cardDecoration(
          color: R.appColors.white,
          borderRadius: BorderRadius.circular(10.px),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.px,
              height: 80.px,
              padding: EdgeInsets.all(20.px),
              decoration: R.appDecorations.cardDecoration(
                shape: BoxShape.circle,
                color: R.appColors.screenBackground3,
              ),
              child: Image.asset(
                R.appImages.tickIcon,
                color: R.appColors.textLightGreen,
              ),
            ),
            vSpacePx(16),
            Text(
              'habit_created'.L(),
              textAlign: TextAlign.center,
              style: R.appTextStyle.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: R.appColors.darkBlack,
              ),
            ),
            vSpacePx(8),
            Text(
              'habit_created_subtitle'.L(),
              textAlign: TextAlign.center,
              style: R.appTextStyle.poppins(
                color: R.appColors.textLightBlack,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
