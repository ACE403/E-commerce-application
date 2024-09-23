import 'package:ecomm/common/widgets/appbar/custom_appbar.dart';
import 'package:ecomm/common/widgets/appbar/tabbar.dart';
import 'package:ecomm/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecomm/common/widgets/layout/grid_layout.dart';
import 'package:ecomm/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:ecomm/common/widgets/shimmer/brand_shimmer.dart';
import 'package:ecomm/common/widgets/text/section_heading.dart';
import 'package:ecomm/features/shop/controllers/category_controller.dart';
import 'package:ecomm/features/shop/controllers/brand_controller.dart';
import 'package:ecomm/features/shop/screens/brand/brand_products.dart';
import 'package:ecomm/utils/constants/colors.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/brands/brand_card.dart';
import '../brand/all_brand.dart';
import 'widgets/category_tab.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: CustomAppbar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [CartCounterIcon()],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: THelperFunctions.isDarkMode(context)
                        ? TColors.black
                        : TColors.white,
                    expandedHeight: 350,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(TSizes.md),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          //Search bar

                          // const SizedBox(
                          //   height: TSizes.spaceBtwItems,
                          // ),
                          // const SearchContainer(
                          //   text: "Search in store",
                          //   showborder: true,
                          //   showbackground: false,
                          //   padding: EdgeInsets.zero,
                          // ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems / 2,
                          ),
                          //Featured Brands
                          SectionHeading(
                            title: "Featured Brands",
                            onPressed: () => Get.to(() => AllBrand()),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems / 1.5,
                          ),
                          Obx(() {
                            if (brandController.isLoading.value)
                              return BrandShimmer();

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
                                itemCount:
                                    brandController.featuredBrands.length,
                                itembuilder: (_, index) {
                                  final brand =
                                      brandController.featuredBrands[index];

                                  return BrandCard(
                                    showborder: true,
                                    brand: brand,
                                    onTap: () => Get.to(
                                        () => BrandProducts(brand: brand)),
                                  );
                                });
                          })
                        ],
                      ),
                    ),
                    //tabs
                    bottom: TTabbar(
                        tabs: categories
                            .map(
                              (category) => Tab(
                                child: Text(category.name),
                              ),
                            )
                            .toList()))
              ];
            },
            body: TabBarView(
                children: categories
                    .map(
                      (category) => CategoryTab(
                        category: category,
                      ),
                    )
                    .toList())),
      ),
    );
  }
}
