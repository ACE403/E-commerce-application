import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class GridViewLayout extends StatelessWidget {
  const GridViewLayout({
    super.key,
    required this.itemCount,
    this.mainAxixExtent = 288,
    required this.itembuilder,
  });
  final int itemCount;
  final double? mainAxixExtent;
  final Widget? Function(BuildContext, int) itembuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(0),
      itemCount: itemCount,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: TSizes.gridViewSpacing,
        mainAxisSpacing: TSizes.gridViewSpacing,
        mainAxisExtent: mainAxixExtent,
      ),
      itemBuilder: itembuilder,
    );
  }
}
