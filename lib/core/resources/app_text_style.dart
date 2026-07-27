import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:sizer/sizer.dart';

class AppTextStyle {
  TextStyle poppins({
    TextDecoration? textDecoration,
    Color? color,
    Color? decorationColor,
    double? fontSize,
    bool shouldApplyTextHeight = false,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: (fontSize ?? 14).px,
      color: color ?? R.appColors.black,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing,
      decoration: textDecoration,
      decorationColor: decorationColor,
      height: shouldApplyTextHeight ? height : null,
    );
  }

}
