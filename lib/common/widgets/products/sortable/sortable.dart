import 'package:ecomm/common/widgets/products/products_cards/product_card_vertical.dart';
import 'package:ecomm/features/shop/controllers/product/product_controller.dart';
import 'package:ecomm/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/all_product_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layout/grid_layout.dart';

class SortableProducts extends StatelessWidget {
  const SortableProducts({
    super.key,
    required this.products,
  });
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());

    controller.assignProducts(products);
    return Column(
      children: [
        //Dropdown
        DropdownButtonFormField(
            value: controller.selectedSortOption.value,
            decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            items: [
              'Name',
              'Higher Price',
              'Lower Price',
              'Sale',
              'Newest',
              'Popularity'
            ]
                .map((option) => DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    ))
                .toList(),
            onChanged: (value) {
              controller.sortProducts(value!);
            }),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        //Products
        Obx(
          () => GridViewLayout(
            itemCount: controller.products.length,
            itembuilder: (_, index) {
              return ProductCardVertical(product: controller.products[index]);
            },
          ),
        )
      ],
    );
  }
}
