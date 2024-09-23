import 'package:ecomm/common/widgets/text/section_heading.dart';
import 'package:ecomm/features/shop/models/payment_method_model.dart';
import 'package:ecomm/features/shop/screens/checkout/widgets/payment_method_tile.dart';
import 'package:ecomm/utils/constants/enum.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: TImages.paypal);

    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeading(
                      title: 'Select Payment Method',
                      showActionButton: false,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    PaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Paypal', image: TImages.paypal)),
                    SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    PaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Gpay', image: TImages.google1))
                  ],
                ),
              ),
            ));
  }
}
