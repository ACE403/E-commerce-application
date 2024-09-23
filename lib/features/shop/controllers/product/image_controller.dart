import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomm/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {}; // Using Set to ensure no duplicate images

    // Helper method to check for similar images by comparing URLs or names
    bool isSimilar(String image1, String image2) {
      // Example of checking if filenames are the same (can be customized)
      return Uri.parse(image1).pathSegments.last ==
          Uri.parse(image2).pathSegments.last;
    }

    // Add the thumbnail first
    images.add(product.thumbnail);

    // Check to avoid unnecessary updates
    if (selectedProductImage.value.isEmpty) {
      selectedProductImage.value = product.thumbnail;
    }

    // Add product images (unique by similarity check)
    if (product.images != null) {
      for (var img in product.images!) {
        if (images.every((addedImg) => !isSimilar(addedImg, img))) {
          images.add(img);
        }
      }
    }

    // Add product variation images only if there are fewer than 3 total images
    if (product.productVariations != null) {
      for (var variation in product.productVariations!) {
        if (images.length >= 3) break; // Stop once 3 unique images are added
        if (images.every((addedImg) => !isSimilar(addedImg, variation.image))) {
          images.add(variation.image);
        }
      }
    }

    // Ensure only 3 unique images are returned
    return images.take(3).toList();
  }

  /// -- Show Image Popup
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: TSizes.defaultSpace * 2,
                horizontal: TSizes.defaultSpace,
              ),
              child: CachedNetworkImage(imageUrl: image),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () => Get.back(), // Close the dialog
                  child: const Text('Close'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
