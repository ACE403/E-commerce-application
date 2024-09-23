import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/features/shop/controllers/product/product_controller.dart';
import 'package:ecomm/features/shop/screens/all_products/all_products.dart';
import 'package:ecomm/utils/constants/colors.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';

import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../common/widgets/products/products_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../common/widgets/text/section_heading.dart';
import '../../controllers/all_product_controller.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';
import 'widgets/promo_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PrimaryHeaderContainer(
                child: Column(
              children: [
                //appbar
                HomeAppbar(),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                //searchbar
                // SearchContainer(
                //   text: 'Search in store',
                // ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                //categories

                Padding(
                  padding: EdgeInsets.only(left: TSizes.defaultSpace),
                  child: Column(
                    children: [
                      //headings

                      SectionHeading(
                        title: "Popular Categories",
                        showActionButton: false,
                        textcolor: TColors.white,
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      //categories
                      HomeCategories()
                    ],
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            )),
            //Body
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: TSizes.defaultSpace, vertical: TSizes.sm),
                child: Column(
                  children: [
                    const PromoSlider(),

                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    SectionHeading(
                        title: "Popular products",
                        onPressed: () {
                          Get.lazyPut(() => AllProductsController());
                          Get.to(() => AllProducts(
                                title: 'Popular Products',
                                futureMethod:
                                    controller.fetchAllFeaturedProduct(),
                              ));
                        }),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Obx(() {
                      if (controller.isLoading.value)
                        return VerticalProductShimmer();
                      if (controller.featuredProducts.isEmpty) {
                        return Center(
                          child: Text(
                            'No Data Found!',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }
                      return GridViewLayout(
                        itembuilder: (_, index) => ProductCardVertical(
                            product: controller.featuredProducts[index]),
                        itemCount: controller.featuredProducts.length,
                      );
                    }),

                    //gridview
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
