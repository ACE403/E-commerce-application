import 'package:ecomm/common/widgets/success_screen/success_screen.dart';
import 'package:ecomm/features/shop/controllers/checkout_controller.dart';
import 'package:ecomm/features/shop/models/order_repository.dart';
import 'package:ecomm/features/shop/screens/home/home.dart';
import 'package:ecomm/navigation_menu.dart';
import 'package:ecomm/utils/popups/full_screen_loader.dart';
import 'package:ecomm/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/constants/enum.dart';
import '../../../utils/constants/image_strings.dart';
import '../../personalization/controllers/address_controller.dart';
import '../models/order_model.dart';
import 'product/cart_controller.dart';

class OrderController extends GetxController {
  // Singleton pattern for accessing the instance of OrderController
  static OrderController get instance => Get.find<OrderController>();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      // Fetch user orders from the repository
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      // Show a warning snackbar on error
      Loaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      // Start Loader
      FullScreenLoader.openloadingDialog(
          'Processing your order', TImages.loading);

      // Get user authentication ID
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      // Create a unique ID for the order
      final orderId = UniqueKey().toString();

      // Create the order
      final order = OrderModel(
        id: orderId,
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now()
            .add(Duration(days: 3)), // Example: Delivery in 3 days
        items: cartController.cartItems.toList(),
      );

      // Save the order to Firestore
      await orderRepository.saveOrder(order, userId);

      // Clear the cart after successful order
      cartController.clearcart();

      // Show Success screen
      Get.off(() => SuccessScreen(
            image: TImages.success,
            title: "Payment Success!",
            subtitle: "Your item will be shipped soon!",
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ));
    } catch (e) {
      // Show error snackbar if something goes wrong
      Loaders.errorSnackBar(
        title: "Oh Snap!",
        message: e.toString(),
      );
    }
  }
}
