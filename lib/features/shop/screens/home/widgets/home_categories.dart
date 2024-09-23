import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../common/widgets/shimmer/category_shimmer.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../controllers/category_controller.dart';
import '../../sub_categories/sub_categories.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Obx(() {
      if (controller.isLoading.value) return const CategoryShimmer();
      if (controller.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data found!',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          itemCount: controller.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            final category = controller.featuredCategories[index];
            return VerticalImageAndText(
                image: category.image,
                title: category.name,
                onTap: () =>
                    Get.to(() => SubCategories(selectedCategory: category)));
          },
        ),
      );
    });
  }
}
