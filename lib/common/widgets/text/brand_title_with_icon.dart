import 'package:ecomm/utils/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'brand_title.dart';

class BrandTitleTextWithIcon extends StatelessWidget {
  const BrandTitleTextWithIcon({
    super.key,
    required this.title,
    this.maxlines = 1,
    this.textcolor,
    this.iconcolor = TColors.primary,
    this.textAlign = TextAlign.center,
    this.brandtextSizes = TextSizes.small,
  });
  final String title;
  final int maxlines;
  final Color? textcolor, iconcolor;
  final TextAlign? textAlign;
  final TextSizes brandtextSizes;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: BrandTitleText(
            title: title,
            color: textcolor,
            maxlines: maxlines,
            textAlign: textAlign,
            brandTextSize: brandtextSizes,
          ),
        ),
        SizedBox(
          width: TSizes.xs,
        ),
        Icon(
          Iconsax.verify5,
          color: iconcolor,
          size: TSizes.iconXs,
        )
      ],
    );
  }
}
