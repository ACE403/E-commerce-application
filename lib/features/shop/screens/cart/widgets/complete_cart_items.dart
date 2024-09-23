import 'package:ecomm/features/shop/controllers/product/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/text/product_price.dart';
import '../../../../../utils/constants/sizes.dart';

class CompleteCartItems extends StatelessWidget {
  const CompleteCartItems({
    super.key,
    this.showAddremovebuttons = true,
  });

  final bool showAddremovebuttons;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        itemCount: controller.cartItems.length,
        itemBuilder: (_, index) => Obx(() {
          final item = controller.cartItems[index];
          return Column(
            children: [
              TCartItem(
                cartItem: item,
              ),
              if (showAddremovebuttons)
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
              if (showAddremovebuttons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 70),
                        ProductQuantityAddAndRemove(
                          quantity: item.quantity,
                          add: () => controller.addOneToCart(item),
                          remove: () => controller.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    //Total price
                    ProductPriceText(
                        price: (item.price * item.quantity).toStringAsFixed(1))
                  ],
                ),
            ],
          );
        }),
      ),
    );
  }
}
