import 'package:ecomm/common/icons/circular_icon.dart';
import 'package:ecomm/common/widgets/image/circular_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class VerticalImageAndText extends StatelessWidget {
  const VerticalImageAndText({
    super.key,
    required this.image,
    required this.title,
    this.textcolor = TColors.white,
    this.backgroundColor = TColors.white,
    this.onTap,
    this.isNetworkImage = true,
  });

  final String image, title;
  final Color textcolor;
  final Color backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          right: TSizes.spaceBtwItems,
        ),
        child: Column(
          children: [
            // Circular icon
            CircularImage(
                image: image,
                boxfit: BoxFit.fitWidth,
                padding: TSizes.sm,
                isNetworkImage: isNetworkImage,
                backgroundColor: backgroundColor,
                overlayColor: dark ? TColors.dark : TColors.light),
            // Spacer
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            // Text
            SizedBox(
              width: 56, // Match the width of the circular container
              child: Text(
                title,
                textAlign: TextAlign.center, // Center the text
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textcolor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
