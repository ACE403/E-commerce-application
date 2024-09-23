import 'package:ecomm/common/widgets/appbar/custom_appbar.dart';
import 'package:ecomm/common/widgets/image/rounded_image.dart';
import 'package:ecomm/common/widgets/products/products_cards/product_card_horzontal.dart';
import 'package:ecomm/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:ecomm/common/widgets/text/section_heading.dart';
import 'package:ecomm/features/shop/screens/all_products/all_products.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../dummy_data.dart';
import '../../controllers/all_product_controller.dart';
import '../../controllers/category_controller.dart';
import '../../models/banner_model.dart';
import '../../models/category_model.dart';

class SubCategories extends StatelessWidget {
  const SubCategories({super.key, required this.selectedCategory});
  final CategoryModel selectedCategory;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    print('Selected category ID: ${selectedCategory.id}');

    final BannerModel? selectedBanner = DummyData.banners.firstWhereOrNull(
      (banner) => banner.name
          .toLowerCase()
          .contains(selectedCategory.name.toLowerCase()),
    );

    return Scaffold(
      appBar: CustomAppbar(
        title: Text(selectedCategory.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Banner Section
              selectedBanner != null
                  ? RoundedImageContainer(
                      imageUrl: selectedBanner.imageUrl,
                      applyImageRadius: true,
                      width: double.infinity,
                    )
                  : const Text("No banner available"),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Subcategories Section
              FutureBuilder(
                future: controller.getSubCategories(selectedCategory.id),
                builder: (context, snapshot) {
                  // final loader = HorizontalProductShimmer();
                  final widget = CloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                  );
                  if (widget != null) return widget;

                  final subcategories = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subcategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final subCategory = subcategories[index];

                      return FutureBuilder(
                        future: controller.getCategoryProducts(
                            searchTerm: subCategory.name),

                        // controller.getCategoryProducts(
                        //   categoryId: subCategory.id,
                        // ),

                        // future: controller.getCategoryProducts(
                        //   categoryId: selectedCategory.id,
                        // ),
                        builder: (context, snapshot) {
                          final widget =
                              CloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,
                          );
                          if (widget != null) return widget;

                          final products = snapshot.data!;

                          return Column(
                            children: [
                              // Heading for Subcategory
                              SectionHeading(
                                title: subCategory.name,
                                onPressed: () {
                                  Get.lazyPut(() => AllProductsController());
                                  Get.to(
                                    AllProducts(
                                      title: subCategory.name,
                                      futureMethod:
                                          controller.getCategoryProducts(
                                              searchTerm: subCategory.name),
                                      //     controller.getCategoryProducts(
                                      //   categoryId: subCategory.id,
                                      //   limit: -1,
                                      // ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwItems / 2,
                              ),

                              // Product Horizontal List
                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: TSizes.spaceBtwItems,
                                  ),
                                  itemCount: products.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      ProductCardHorizontal(
                                    product: products[index],
                                  ),
                                ),
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
