import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomm/common/widgets/shimmer/shimmer_effect.dart';
import 'package:ecomm/features/shop/controllers/banner_controller.dart';
import 'package:ecomm/features/shop/models/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/image/rounded_image.dart';
import '../../../../../dummy_data.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/home_controller.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      if (controller.isLoading.value)
        return ShimmerEffect(width: double.infinity, height: 190);

      if (controller.banners.isEmpty) {
        return Center(
          child: Text('No data found!'),
        );
      } else {
        return Column(
          children: [
            CarouselSlider(
              items: controller.banners
                  .map((banner) => RoundedImageContainer(
                        imageUrl: banner.imageUrl,
                        // onPressed: () => Get.toNamed(banner.targetScreen),
                        isNetworkImage: true,
                        applyImageRadius: true,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) =>
                      controller.pageUpdateIndicator(index)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    TCircularContainer(
                      width: 20,
                      height: 4,
                      backgroundcolor:
                          controller.Carouselcurrentindex.value == i
                              ? TColors.primary
                              : TColors.grey,
                      margin: EdgeInsets.only(right: 10),
                    ),
                ],
              ),
            )
          ],
        );
      }
    });
  }
}
