import 'package:ecomm/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecomm/common/widgets/image/rounded_image.dart';
import 'package:ecomm/common/widgets/text/brand_title.dart';
import 'package:ecomm/common/widgets/text/product_price.dart';
import 'package:ecomm/common/widgets/text/product_title_text.dart';
import 'package:ecomm/common/widgets/text/section_heading.dart';
import 'package:ecomm/features/shop/controllers/product/variation_controller.dart';
import 'package:ecomm/features/shop/models/product_model.dart';
import 'package:ecomm/utils/constants/colors.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/device/device_utility.dart';
import 'package:ecomm/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/chips/choice_chip.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Obx(
      () => Column(
        children: [
          //Selected attributes pricing and description
          if (controller.selectedVariation.value.id.isNotEmpty)
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
              child: Column(
                children: [
                  //Title,price and stock status
                  Row(
                    children: [
                      const SectionHeading(
                        title: 'Variation',
                        showActionButton: false,
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const ProductTitle(
                                title: 'Price:  ',
                                smallSize: true,
                              ),

                              //Actual price
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  '\$${controller.selectedVariation.value.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),
                              //Sale price
                              ProductPriceText(
                                  price: controller.getVariationPrice())
                            ],
                          ),
                          //Stock
                          Row(
                            children: [
                              const ProductTitle(
                                title: 'Stock:  ',
                                smallSize: true,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),

                  //Variation Description
                  ProductTitle(
                    title: controller.selectedVariation.value.description ?? '',
                    maxlines: 4,
                    smallSize: true,
                  ),
                ],
              ),
            ),

          //Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map((attribute) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        SectionHeading(
                          title: attribute.name ?? '',
                          showActionButton: false,
                        ),
                        // const SizedBox(
                        //   height: TSizes.spaceBtwItems / 4,
                        // ),
                        Obx(
                          () => Wrap(
                              spacing: 8,
                              children: attribute.values!.map((attributeValue) {
                                final isSelected = controller
                                        .selectedAttributes[attribute.name] ==
                                    attributeValue;
                                final available = controller
                                    .getAttributesAvailabilityInVariation(
                                        product.productVariations!,
                                        attribute.name!)
                                    .contains(attributeValue);

                                return TChoiceChip(
                                    selected: isSelected,
                                    text: attributeValue,
                                    onSelected: available
                                        ? (selected) {
                                            if (selected && available) {
                                              controller.onAttributeSelected(
                                                  product,
                                                  attribute.name ?? '',
                                                  attributeValue);
                                            }
                                          }
                                        : null);
                              }).toList()),
                        )
                      ],
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
