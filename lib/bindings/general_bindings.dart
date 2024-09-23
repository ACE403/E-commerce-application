import 'package:ecomm/features/personalization/controllers/address_controller.dart';
import 'package:ecomm/features/shop/controllers/checkout_controller.dart';
import 'package:ecomm/features/shop/controllers/product/image_controller.dart';
import 'package:ecomm/features/shop/controllers/product/variation_controller.dart';
import 'package:ecomm/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(ImageController());
    Get.put(AddressController());
    Get.put(CheckoutController());
  }
}
