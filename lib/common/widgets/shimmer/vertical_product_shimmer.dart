import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../layout/grid_layout.dart';
import 'shimmer_effect.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridViewLayout(
      itemCount: itemCount,
      itembuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image shimmer effect
            ShimmerEffect(width: 180, height: 180),
            SizedBox(height: TSizes.spaceBtwItems),
            // Text shimmer effect
            ShimmerEffect(width: 160, height: 15),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            ShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}
