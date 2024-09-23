import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomm/common/widgets/products/favourite/favourite_icon.dart';
import 'package:ecomm/features/shop/controllers/product/image_controller.dart';
import 'package:ecomm/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/icons/circular_icon.dart';
import '../../../../../common/widgets/appbar/custom_appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/image/rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/product_model.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // Initialize ImageController lazily with `tag` to make sure it's unique for each product
    final controller = Get.put(ImageController(), tag: product.id);

    // Fetch product images based on the current product
    final images = controller.getAllProductImages(product);

    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            // Main large image display
            SizedBox(
                height: 400,
                child: Padding(
                  padding: EdgeInsets.all(TSizes.productImageRadius * 3),
                  child: Center(
                    child: Obx(() {
                      final image = controller.selectedProductImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (_, __, downloadProgress) =>
                              CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: TColors.primary,
                          ),
                        ),
                      );
                    }),
                  ),
                )),
            // Thumbnail images list
            Positioned(
              left: TDeviceUtils.getScreenWidth(context) / 6,
              bottom: 30,
              child: SizedBox(
                height: 75,
                child: ListView.separated(
                  separatorBuilder: (_, __) => SizedBox(
                    width: TSizes.sm,
                  ),
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => Obx(() {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return RoundedImageContainer(
                        isNetworkImage: true,
                        width: 75,
                        fit: BoxFit.contain,
                        backgroundColor: dark ? TColors.dark : TColors.light,
                        border: Border.all(
                            color: imageSelected
                                ? TColors.primary
                                : Colors.transparent),
                        padding: EdgeInsets.all(TSizes.sm),
                        onPressed: () => controller.selectedProductImage.value =
                            images[index],
                        imageUrl: images[index]);
                  }),
                ),
              ),
            ),
            // Custom app bar with back button and favorite icon
            CustomAppbar(
              showBackArrow: true,
              actions: [
                FavouriteIcon(
                  productId: product.id,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
