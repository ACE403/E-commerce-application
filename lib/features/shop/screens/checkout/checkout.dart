import 'package:ecomm/common/widgets/appbar/custom_appbar.dart';
import 'package:ecomm/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecomm/common/widgets/success_screen/success_screen.dart';
import 'package:ecomm/features/shop/controllers/product/cart_controller.dart';
import 'package:ecomm/features/shop/screens/cart/widgets/complete_cart_items.dart';
import 'package:ecomm/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:ecomm/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:ecomm/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:ecomm/navigation_menu.dart';
import 'package:ecomm/utils/constants/colors.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:ecomm/utils/helpers/helper_functions.dart';
import 'package:ecomm/utils/helpers/pricing_calculator.dart';
import 'package:ecomm/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/products/cart/coupon_code.dart';
import '../../controllers/order_controller.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartcontroller = CartController.instance;
    final subtotal = cartcontroller.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = TPricingCalculator.calculateTotalPrice(subtotal, 'GJ');

    return Scaffold(
      appBar: CustomAppbar(
        showBackArrow: true,
        title: Text(
          "Order Review",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Items in cart
              const CompleteCartItems(
                showAddremovebuttons: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Coupon TextField
              const CouponCode(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              //Billing Section
              TRoundedContainer(
                padding: EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: const Column(
                  children: [
                    //Pricing
                    BillingAmountSection(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //Divider
                    Divider(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //Payment Method
                    BillingPaymentSection(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //Address
                    BillingAddressSection(),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: subtotal > 0
                ? () => orderController.processOrder(totalAmount)
                : Loaders.warningSnackBar(
                    title: 'Empty Cart!',
                    message: 'Add items in the cart to proceed'),
            child: Text(
                'Checkout \$${TPricingCalculator.calculateTotalPrice(subtotal, 'GJ')}')),
      ),
    );
  }
}
