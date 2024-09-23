import 'package:ecomm/common/widgets/image/circular_image.dart';
import 'package:ecomm/common/widgets/text/brand_title_with_icon.dart';
import 'package:ecomm/common/widgets/text/product_price.dart';
import 'package:ecomm/common/widgets/text/product_title_text.dart';
import 'package:ecomm/features/shop/controllers/product/product_controller.dart';
import 'package:ecomm/features/shop/models/product_model.dart';
import 'package:ecomm/utils/constants/enum.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/constants/text_strings.dart';
import 'package:ecomm/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    return Column(
      children: [
        //Price & Sale
        Row(
          children: [
            //Sale tag
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: Colors.amber.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                '$salePercentage',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            //Price
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text(
                '\$${product.price}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough),
              ),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
            ProductPriceText(
              price: controller.getProductPrice(product),
              isLarge: true,
            )
          ],
        ),
        //Title
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: ProductTitle(
            title: product.title,
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
        //Stock Status
        Row(
          children: [
            ProductTitle(
              title: 'Status',
            ),
            SizedBox(
              width: TSizes.spaceBtwItems / 1.5,
            ),
            Text(
              controller.getProductStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
        //Brand

        Row(
          children: [
            CircularImage(
              image: product.brand != null ? product.brand!.image : '',
              width: 32,
              height: 32,
              overlayColor: dark ? TColors.white : TColors.black,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            BrandTitleTextWithIcon(
              title: product.brand != null ? product.brand!.name : '',
              brandtextSizes: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
