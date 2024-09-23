import 'package:ecomm/common/icons/circular_icon.dart';
import 'package:ecomm/common/widgets/appbar/custom_appbar.dart';
import 'package:ecomm/common/widgets/layout/grid_layout.dart';
import 'package:ecomm/common/widgets/loaders/animation_loader.dart';
import 'package:ecomm/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:ecomm/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ecomm/features/shop/controllers/product/favourite_controller.dart';
import 'package:ecomm/features/shop/screens/home/home.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../navigation_menu.dart';
import '../../controllers/product/product_controller.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
    return Scaffold(
      appBar: CustomAppbar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
              icon: Iconsax.add,
              onPressed: () {
                final navigationController = Get.find<
                    NavigationController>(); // Find the existing controller
                navigationController.selectedIndex.value = 0; // Set to HomePage
                Get.off(
                    () => const NavigationMenu()); // Navigate to NavigationMenu
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),

          /// Products Grid using FutureBuilder
          child: Obx(
            () => FutureBuilder(
              future: controller
                  .favouriteProducts(), // The future that fetches favorite products
              builder: (context, snapshot) {
                /// Define the "nothing found" widget in case the wishlist is empty
                final emptyWidget = AnimationLoader(
                    text: 'Whoops! Wishlist is Empty...',
                    animation: TImages.wishlist,
                    showAction: true,
                    actionText: 'Let\'s add some',
                    onActionPressed: () {
                      final navigationController = Get.find<
                          NavigationController>(); // Find the existing controller
                      navigationController.selectedIndex.value =
                          0; // Set to HomePage
                      Get.off(() => const NavigationMenu()); //
                    }
                    //() => Get.off(() =>
                    //     const HomePage()), // Navigate to the main menu when action is pressed
                    );

                // A loading shimmer while the data is being fetched
                const loader = VerticalProductShimmer(itemCount: 6);

                // Check the snapshot's state and determine what to display (loader, error, or empty)
                final widget = CloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                    nothingFound: emptyWidget);

                if (widget != null)
                  return widget; // Return the appropriate widget (loader, empty, or error)

                // If data is fetched successfully, assign it to the products variable
                final products = snapshot.data!;

                // Return a Grid layout displaying each product
                return GridViewLayout(
                  itembuilder: (_, index) =>
                      ProductCardVertical(product: products[index]),
                  itemCount: products.length,
                );
              },
            ),
          ), // FutureBuilder
        ),
      ),
    );
  }
}
