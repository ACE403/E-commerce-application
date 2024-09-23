import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: TColors.primary,
        // padding: EdgeInsets.all(0),
        // child: SizedBox(
        //   height: 375,
        //   width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: TCircularContainer(
                backgroundcolor: TColors.textWhite.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: TCircularContainer(
                backgroundcolor: TColors.textWhite.withOpacity(0.1),
              ),
            ),
            // const Image(
            //   image: AssetImage(TImages.shoes2),
            //   fit: BoxFit.contain,
            // ),
            child
          ],
        ),
      ),
    );
  }
}
