import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class CouponCode extends StatelessWidget {
  const CouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
        showBorder: true,
        backgroundColor: dark ? TColors.dark : TColors.light,
        padding: const EdgeInsets.only(
            left: TSizes.md,
            bottom: TSizes.sm,
            right: TSizes.sm,
            top: TSizes.sm),
        child: Row(
          children: [
            Flexible(
                child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo card? Enter here',
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            )),
            //Button
            SizedBox(
                width: 80,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: dark
                            ? TColors.white.withOpacity(0.5)
                            : TColors.dark.withOpacity(0.5),
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        side: BorderSide(color: Colors.grey.withOpacity(0.1))),
                    onPressed: () {},
                    child: const Text("Apply")))
          ],
        ));
  }
}
