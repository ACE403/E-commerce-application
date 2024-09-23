import 'package:ecomm/common/widgets/text/brand_title_with_icon.dart';
import 'package:ecomm/common/widgets/text/product_title_text.dart';
import 'package:ecomm/features/shop/models/cart_item_model.dart';
import 'package:ecomm/utils/constants/colors.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../utils/helpers/helper_functions.dart';
import '../../image/rounded_image.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.cartItem,
  });
  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        //Image
        RoundedImageContainer(
          isNetworkImage: true,
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          padding: EdgeInsets.all(TSizes.sm),
          backgroundColor: dark ? TColors.darkerGrey : TColors.light,
        ),
        SizedBox(
          width: TSizes.spaceBtwItems,
        ),

        //Title ,price, size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BrandTitleTextWithIcon(title: cartItem.brandName ?? ''),
              Flexible(
                child: ProductTitle(
                  title: cartItem.title,
                  maxlines: 1,
                ),
              ),
              //attributes
              Text.rich(TextSpan(
                children: (cartItem.selectedVariation ?? {})
                    .entries
                    .map((e) => TextSpan(children: [
                          TextSpan(
                              text: ' ${e.key} ',
                              style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(
                              text: '${e.value} ',
                              style: Theme.of(context).textTheme.bodySmall)
                        ]))
                    .toList(),
              ))
            ],
          ),
        )
      ],
    );
  }
}
