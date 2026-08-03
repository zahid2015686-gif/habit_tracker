import 'package:flutter/material.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:sizer/sizer.dart';

class AppDecorations {
  InputDecoration textField({
    required String hintText,
    double? borderRadius,
    TextStyle? hintStyle,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? focusedErrorBorderColor,
    Color? errorColor,
  }) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: R.appColors.white,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintStyle: hintStyle ??
          R.appTextStyle.poppins(
            color: R.appColors.black,
          ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 16.px),
        borderSide: BorderSide(
          color: enabledBorderColor ?? R.appColors.black,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 16.px),
        borderSide: BorderSide(
          color: focusedBorderColor ?? R.appColors.black,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 16.px),
        borderSide: BorderSide(
          color: errorBorderColor ?? R.appColors.black,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 16.px),
        borderSide: BorderSide(
          color: focusedErrorBorderColor ?? R.appColors.black,
          width: 1.5,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.px,
        vertical: 12.px,
      ),
      errorStyle: R.appTextStyle.poppins(
        fontSize: 11,
        color: errorColor ?? R.appColors.errorRed,
      ),
    );
  }

  BoxDecoration cardDecoration({
    Color? color,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    DecorationImage? image,
    BoxShape shape = BoxShape.rectangle,
    BlendMode? backgroundBlendMode,
  }) {
    return BoxDecoration(
      color: color ?? R.appColors.white,
      borderRadius: shape == BoxShape.rectangle
          ? (borderRadius ?? BorderRadius.circular(16.px))
          : null,
      border: border,
      boxShadow: boxShadow,
      gradient: gradient,
      image: image,
      shape: shape,
      backgroundBlendMode: backgroundBlendMode,
    );
  }
}
