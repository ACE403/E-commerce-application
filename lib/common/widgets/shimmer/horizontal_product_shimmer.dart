import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart'; // Assuming these are your size constants
import 'shimmer_effect.dart'; // Assuming this handles your shimmer animation

class HorizontalProductShimmer extends StatelessWidget {
  const HorizontalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) =>
            const SizedBox(width: TSizes.spaceBtwItems),
        itemBuilder: (_, index) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Placeholder
            ShimmerEffect(width: 120, height: 120),
            SizedBox(width: TSizes.spaceBtwItems),
            // Text Placeholder
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: TSizes.spaceBtwItems / 2),
                ShimmerEffect(width: 160, height: 15),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                ShimmerEffect(width: 110, height: 15),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                ShimmerEffect(width: 80, height: 15),
              ],
            ),
            Spacer(), // Add spacer if needed, otherwise remove this
          ],
        ),
      ),
    );
  }
}
