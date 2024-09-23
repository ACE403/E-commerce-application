import 'package:ecomm/common/styles/shadows.dart';
import 'package:ecomm/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecomm/common/widgets/image/rounded_image.dart';
import 'package:ecomm/common/widgets/products/cart/add_to_cart_button.dart';
import 'package:ecomm/features/shop/controllers/product/product_controller.dart';
import 'package:ecomm/features/shop/models/product_model.dart';
import 'package:ecomm/features/shop/screens/product_details/product_detail.dart';
import 'package:ecomm/utils/constants/colors.dart';
import 'package:ecomm/utils/constants/enum.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/constants/text_strings.dart';
import 'package:ecomm/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../icons/circular_icon.dart';
import '../../text/brand_title_with_icon.dart';
import '../../text/product_price.dart';
import '../../text/product_title_text.dart';
import '../favourite/favourite_icon.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return InkWell(
      onTap: () => Get.to(() => ProductDetail(
            product: product,
          )),
      child: Container(
        width: 180,

        // padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.horizontalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.grey,
        ),
        child: Column(
          children: [
            //thumbnail,wishlist,discount
            TRoundedContainer(
              height: 180,
              width: 250,
              // padding: EdgeInsets.all(TSizes.sm),
              // backgroundColor: dark ? TColors.white : TColors.white,
              child: Stack(
                children: [
                  //thumbnail
                  RoundedImageContainer(
                    backgroundColor: Colors.transparent,
                    // backgroundColor: Colors.white,
                    height: double.infinity,
                    width: double.infinity,
                    imageUrl: product.thumbnail,
                    fit: BoxFit.contain,
                    isNetworkImage: true,
                  ),
                  //sale tag
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
                          '$salePercentage% ',
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
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            //details
            Padding(
              padding: EdgeInsets.only(left: TSizes.sm),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ProductTitle(
                      title: product.title,
                      smallSize: true,
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BrandTitleTextWithIcon(
                      title: product.brand!.name,
                    ),
                  ),
                  //price
                ],
              ),
            ),
            const Spacer(),
            //Price row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //price
                Flexible(
                  child: Column(
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
                                      decoration: TextDecoration.lineThrough),
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
                ProductCardAddToCartButton(
                  product: product,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
