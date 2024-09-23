import 'package:ecomm/common/widgets/appbar/custom_appbar.dart';
import 'package:ecomm/common/widgets/layout/grid_layout.dart';
import 'package:ecomm/common/widgets/text/section_heading.dart';
import 'package:ecomm/features/shop/controllers/brand_controller.dart';
import 'package:ecomm/features/shop/models/brand_model.dart';
import 'package:ecomm/features/shop/screens/brand/brand_products.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/brands/brand_card.dart';
import '../../../../common/widgets/products/sortable/sortable.dart';
import '../../../../common/widgets/shimmer/brand_shimmer.dart';

class AllBrand extends StatelessWidget {
  const AllBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const CustomAppbar(
        title: Text('Brand'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Heading
              const SectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.defaultSpace,
              ),
              //Brands

              Obx(() {
                if (brandController.isLoading.value) return BrandShimmer();

                if (brandController.featuredBrands.isEmpty) {
                  return Center(
                    child: Text(
                      'No Data Found!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white),
                    ),
                  );
                }
                return GridViewLayout(
                    mainAxixExtent: 70,
                    itemCount: brandController.allBrands.length,
                    itembuilder: (_, index) {
                      final brand = brandController.allBrands[index];

                      return BrandCard(
                        showborder: true,
                        brand: brand,
                        onTap: () => Get.to(() => BrandProducts(brand: brand)),
                      );
                    });
              })
            ],
          ),
        ),
      ),
    );
  }
}
