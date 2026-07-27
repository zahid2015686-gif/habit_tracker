import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

SizedBox vSpace(double value) => SizedBox(height: value.h);
SizedBox hSpace(double value) => SizedBox(width: value.w);

SizedBox vSpacePx(double value) => SizedBox(height: value.px);
SizedBox hSpacePx(double value) => SizedBox(width: value.px);