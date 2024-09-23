import 'package:ecomm/common/widgets/text/section_heading.dart';
import 'package:ecomm/features/shop/screens/checkout/checkout.dart';
import 'package:ecomm/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecomm/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:ecomm/features/shop/screens/product_reviews/product_review.dart';
import 'package:ecomm/utils/constants/enum.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../models/product_model.dart';
import 'widgets/bottom_add_to_cart.dart';
import 'widgets/product_image_slider.dart';
import 'widgets/product_meta_data.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(
        product: product,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //product image slider
            ProductImageSlider(
              product: product,
            ),
            //product slider
            Padding(
                padding: EdgeInsets.only(
                    right: TSizes.defaultSpace,
                    left: TSizes.defaultSpace,
                    bottom: TSizes.defaultSpace),
                child: Column(
                  children: [
                    //rating and share
                    RatingAndShare(),
                    //price,title,stock and brand
                    ProductMetaData(
                      product: product,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    if (product.productType == ProductType.variable.toString())
                      //attributes
                      ProductAttributes(
                        product: product,
                      ),

                    //checkout button
                    if (product.productType == ProductType.variable.toString())
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => Get.to((Checkout())),
                            child: Text('Checkout'))),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    //description
                    SectionHeading(
                      title: 'Description',
                      showActionButton: false,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    ReadMoreText(
                      product.description ?? '',
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more text',
                      trimExpandedText: 'Less',
                      moreStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),
                    //reviews
                    Divider(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionHeading(
                          title: 'Review (199)',
                          showActionButton: false,
                        ),
                        IconButton(
                          onPressed: () => Get.to(() => const ProductReview()),
                          icon: Icon(
                            Iconsax.arrow_right_3,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
