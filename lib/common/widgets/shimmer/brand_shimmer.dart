import 'package:ecomm/common/widgets/layout/grid_layout.dart';
import 'package:ecomm/common/widgets/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

class BrandShimmer extends StatelessWidget {
  const BrandShimmer({super.key, this.itemCount = 4});
  final itemCount;

  @override
  Widget build(BuildContext context) {
    return GridViewLayout(
        mainAxixExtent: 70,
        itemCount: 4,
        itembuilder: (_, __) {
          return ShimmerEffect(width: 300, height: 70);
        });
  }
}
