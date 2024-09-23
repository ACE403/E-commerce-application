import 'package:ecomm/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecomm/common/widgets/image/rounded_image.dart';
import 'package:ecomm/common/widgets/text/brand_title_with_icon.dart';
import 'package:ecomm/common/widgets/text/product_price.dart';
import 'package:ecomm/common/widgets/text/product_title_text.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enum.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../icons/circular_icon.dart';
import '../../../styles/shadows.dart';
import '../favourite/favourite_icon.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return Container(
      width: 281,
      // padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        // boxShadow: [ShadowStyle.horizontalProductShadow],
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        color: dark ? TColors.darkerGrey : TColors.softGrey,
      ),

      child: Row(
        children: [
          SizedBox(
            width: 5,
          ),
          //thumbnail
          TRoundedContainer(
            height: 110,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                // Thumbnail image

                SizedBox(
                  height: 100,
                  width: 110,
                  child: RoundedImageContainer(
                    backgroundColor: dark ? TColors.dark : TColors.light,
                    imageUrl: product.thumbnail,
                    applyImageRadius: true,
                    isNetworkImage: true,
                  ),
                ),
                //Sale tag

                if (salePercentage != null)
                  Positioned(
                    top: 12,
                    left: 5,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        '$salePercentage%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.white),
                      ),
                    ),
                  ),
                //favorite icon
                Positioned(
                  top: 6,
                  right: 1,
                  child: FavouriteIcon(
                    productId: product.id,
                  ),
                )
              ],
            ),
          ),
          //Details

          SizedBox(
            width: 150,
            child: Padding(
              padding: EdgeInsets.only(
                top: TSizes.sm,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitle(
                          title: product.title,
                          smallSize: true,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems / 2,
                        ),
                        BrandTitleTextWithIcon(title: product.brand!.name)
                      ],
                    ),
                    //Spacer
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //price
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product.productType ==
                                      ProductType.single.toString() &&
                                  product.salePrice > 0)
                                Padding(
                                    padding: EdgeInsets.only(left: TSizes.sm),
                                    child: Text(
                                      product.price.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .apply(
                                              decoration:
                                                  TextDecoration.lineThrough),
                                    )),
                              Padding(
                                padding: EdgeInsets.only(left: TSizes.sm),
                                child: ProductPriceText(
                                  price: controller.getProductPrice(product),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //add to cart
                        Container(
                          decoration: const BoxDecoration(
                              color: TColors.dark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(TSizes.cardRadiusMd),
                                bottomRight:
                                    Radius.circular(TSizes.productImageRadius),
                              )),
                          child: const SizedBox(
                            width: TSizes.iconLg * 1.2,
                            height: TSizes.iconLg * 1.2,
                            child: Center(
                              child: Icon(
                                Iconsax.add,
                                color: TColors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
