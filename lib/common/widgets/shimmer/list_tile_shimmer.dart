import 'package:ecomm/common/widgets/shimmer/shimmer_effect.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            // Shimmer effect for the leading icon/image
            ShimmerEffect(
              width: 50,
              height: 50,
              radius: 50,
            ),
            SizedBox(width: TSizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmer effect for the title
                ShimmerEffect(
                  width: 100,
                  height: 15,
                ),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                // Shimmer effect for the subtitle
                ShimmerEffect(
                  width: 80,
                  height: 12,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
