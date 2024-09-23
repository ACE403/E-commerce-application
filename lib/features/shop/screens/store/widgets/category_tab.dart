import 'package:ecomm/common/widgets/layout/grid_layout.dart';
import 'package:ecomm/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:ecomm/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ecomm/common/widgets/text/section_heading.dart';
import 'package:ecomm/features/shop/controllers/category_controller.dart';
import 'package:ecomm/features/shop/models/category_model.dart';
import 'package:ecomm/features/shop/screens/all_products/all_products.dart';
import 'package:ecomm/features/shop/screens/store/widgets/category_brand.dart';
import 'package:ecomm/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/all_product_controller.dart';
import '../../../controllers/product/product_controller.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                //Brands
                CategoryBrand(category: category),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                FutureBuilder(
                    future:
                        // controller.getCategoryProducts(categoryId: category.id),
                        controller.getCategoryProductsForStore(
                            categoryId: category.id),
                    builder: (context, snapshot) {
                      final response =
                          CloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot,
                              loader: VerticalProductShimmer());

                      if (response != null) {
                        return response;
                      }
                      final products = snapshot.data!;
                      return Column(
                        children: [
                          //Products
                          SectionHeading(
                              title: "You might like",
                              onPressed: () {
                                Get.lazyPut(() => AllProductsController());
                                Get.to(AllProducts(
                                  title: category.name,
                                  futureMethod:
                                      controller.getCategoryProductsForStore(
                                    categoryId: category.name,
                                  ),
                                ));
                              }),
                          SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          GridViewLayout(
                            itemCount: products.length,
                            itembuilder: (_, index) =>
                                ProductCardVertical(product: products[index]),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ]);
  }
}
