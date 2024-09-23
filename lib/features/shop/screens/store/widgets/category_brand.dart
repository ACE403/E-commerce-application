import 'package:ecomm/common/widgets/brands/brand_showcase.dart';
import 'package:ecomm/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:ecomm/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:ecomm/features/shop/controllers/brand_controller.dart';
import 'package:ecomm/features/shop/models/category_model.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';

class CategoryBrand extends StatelessWidget {
  const CategoryBrand({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;

    return FutureBuilder(
      future: controller.getBrandForCategory(category.id),
      builder: (context, snapshot) {
        const loader = Column(
          children: [
            ListTileShimmer(),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            BoxesShimmer(),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
          ],
        );
        final widget = CloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot, loader: loader);
        if (widget != null) return widget;

        final brands = snapshot.data!;
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            itemBuilder: (_, index) {
              final brand = brands[index];
              return FutureBuilder(
                  future: controller.getBrandProducts(
                    brandId: brand.id,
                  ),
                  builder: (context, snapshot) {
                    final widget = CloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    // Separate products by category if needed
                    final filteredProducts = products.where((product) {
                      // Filter logic based on brand and category
                      return product.categoryId == category.id;
                    }).toList();

                    return BrandShowCase(
                        images:
                            filteredProducts.map((e) => e.thumbnail).toList(),
                        brand: brand);
                  });
            });
      },
    );
  }
}
