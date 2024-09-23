import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../utils/constants/sizes.dart';

class SpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppbarHeight = EdgeInsets.only(
      top: TSizes.appBarHeight,
      bottom: TSizes.defaultSpace,
      left: TSizes.defaultSpace,
      right: TSizes.defaultSpace);
}
