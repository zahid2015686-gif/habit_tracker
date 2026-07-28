import 'package:flutter/material.dart';
import 'package:habit_tracker/core/constants/width_height.dart';
import 'package:habit_tracker/core/resources/resources.dart';
import 'package:sizer/sizer.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  final double? width;
  final double? height;

  final Color? color;

  final bool borderIsMandatory;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? leftIconSpce;
  final double? rightIconSpce;

  final Widget? leftIcon;
  final Widget? rightIcon;

  final TextStyle? textStyle;

  final List<BoxShadow>? boxShadow;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final bool isLoading;
  final bool enabled;

  final Color? splashColor;
  final Color? highlightColor;

  const AppButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.height,
    this.color,
    this.borderIsMandatory = false,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.leftIconSpce,
    this.rightIconSpce,
    this.leftIcon,
    this.rightIcon,
    this.textStyle,
    this.boxShadow,
    this.padding,
    this.margin,
    this.isLoading = false,
    this.enabled = true,
    this.splashColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: width,
        height: height ?? 50.px,
        margin: margin,
        decoration: BoxDecoration(
          color: enabled
              ? (color ?? R.appColors.white)
              : R.appColors.black.withValues(alpha: 0.05),
          borderRadius:
              BorderRadius.circular(borderRadius ?? 100.px),
          border: borderIsMandatory
              ? Border.all(
                  color: borderColor ??
                      R.appColors.black.withValues(alpha: 0.05),
                  width: borderWidth ?? 1,
                )
              : null,
          boxShadow: boxShadow,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled && !isLoading ? onTap : null,
            borderRadius:
                BorderRadius.circular(borderRadius ?? 100.px),
            splashColor: splashColor ??
                R.appColors.black.withValues(alpha: 0.15),
            highlightColor: highlightColor ??
                R.appColors.black.withValues(alpha: 0.08),
            child: Padding(
              padding: padding ?? EdgeInsets.symmetric(horizontal: 16.px),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        width: 20.px,
                        height: 20.px,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: R.appColors.black,
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (leftIcon != null) ...[
                            leftIcon!,
                            hSpacePx(leftIconSpce ?? 8),
                          ],
                          Flexible(
                            child: Text(
                              text,
                              overflow: TextOverflow.ellipsis,
                              style: textStyle ??
                                  R.appTextStyle.poppins(
                                    color: R.appColors.textGreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          if (rightIcon != null) ...[
                            hSpacePx(rightIconSpce ?? 8),
                            rightIcon!,
                          ],
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
