import 'package:ecomm/features/shop/controllers/product/cart_controller.dart';
import 'package:ecomm/features/shop/screens/cart/cart.dart';
import 'package:ecomm/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key,
    this.color,
  });

  final Color? color;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    final dark = THelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.to(() => Cart()),
            icon: Icon(Iconsax.shopping_bag, color: color)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: dark
                    ? TColors.white.withOpacity(0.8)
                    : TColors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(100)),
            child: Center(
                child: Obx(() => Text(
                      controller.noOfCartItems.value.toString(),
                      style: Theme.of(context).textTheme.labelLarge!.apply(
                          color: dark ? TColors.black : TColors.white,
                          fontSizeFactor: 0.8),
                    ))),
          ),
        )
      ],
    );
  }
}
