import 'package:ecomm/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ShadowStyle {
  static final verticalProductShadow = BoxShadow(
      blurRadius: 50,
      offset: Offset(0, 2),
      color: TColors.darkGrey.withOpacity(0.1),
      spreadRadius: 7);
  static final horizontalProductShadow = BoxShadow(
      blurRadius: 50,
      offset: Offset(0, 2),
      color: TColors.darkGrey.withOpacity(0.1),
      spreadRadius: 7);
}
