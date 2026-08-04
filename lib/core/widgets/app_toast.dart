import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:sizer/sizer.dart';

void showAppToast(String message) {
  Get.closeAllSnackbars();
  Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: R.appTextStyle.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: R.appColors.white,
        ),
      ),
      backgroundColor: R.appColors.seaGreen,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.fromLTRB(40.px, 0, 40.px, 24.px),
      padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 14.px),
      borderRadius: 14.px,
      duration: const Duration(seconds: 2),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
    ),
  );
}
