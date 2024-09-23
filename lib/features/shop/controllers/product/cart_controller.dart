import 'package:ecomm/features/shop/models/cart_item_model.dart';
import 'package:ecomm/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/enum.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';
import 'variation_controller.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
  }
  // Add items to the cart
  void addToCart(ProductModel product) {
    // Quantity Check
    if (productQuantityInCart.value < 1) {
      Loaders.customToast(message: 'Select Quantity');
      return;
    }

    // Variation Selected?
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      Loaders.customToast(message: 'Select Variation');
      return;
    }

    // Out of Stock Status for variable products
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        Loaders.warningSnackBar(
          message: 'Selected variation is out of stock.',
          title: 'Oh Snap!',
        );
        return;
      }
    } else {
      if (product.stock < 1) {
        Loaders.warningSnackBar(
            title: 'Oh Snap!', message: 'Selected Product is out of stock');
      }
    }

    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);
    int index = cartItems.indexWhere((cartitem) =>
        cartitem.productId == selectedCartItem.productId &&
        cartitem.variationId == selectedCartItem.variationId);

    if (index > 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    Loaders.customToast(message: 'Your Products has been added to the cart');
  }

  /// This function converts a ProductModel to a CartItemModel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      // Reset Variation in case of single product type.
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;

    final price = isVariation
        ? (variation.salePrice > 0.0 ? variation.salePrice : variation.price)
        : (product.salePrice > 0.0 ? product.salePrice : product.price);

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : null,
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  /// Update Cart Values
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    // If the item already exists in the cart (i.e., index >= 0)
    if (index >= 0) {
      // Increase the quantity of the item
      cartItems[index].quantity += 1;
    } else {
      // Otherwise, add the item to the cart
      cartItems.add(item);
    }

    // Update the cart state (this could trigger UI updates)
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        // Decrease the quantity if it's greater than 1
        cartItems[index].quantity -= 1;
      } else {
        // If the quantity is 1, confirm before removing the item completely
        if (cartItems[index].quantity == 1) {
          removeFromCartDialog(index); // Show confirmation dialog
        } else {
          cartItems.removeAt(index); // Remove the item from the cart
        }
      }
    }

    // Update the cart state (e.g., trigger UI updates)
    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        // Remove the item from the cart
        cartItems.removeAt(index);
        // Update the cart state
        updateCart();
        // Show a custom toast message to notify the user
        Loaders.customToast(message: 'Product removed from the Cart.');
        // Close the dialog
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    LocalStorage.instance().writeData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings =
        LocalStorage.instance().readData<List<dynamic>>('cartItems');

    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList());
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );

    return foundItem.quantity;
  }

  void clearcart() {
    productQuantityInCart.value = 0;
    cartItems.clear();

    updateCart();
  }

  /// -- Initialize already added Item's Count in the cart.
  void updateAlreadyAddedProductCount(ProductModel product) {
    // If the product has no variations, calculate the total number of cart entries and display them.
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      // If the product has variations, get the selected variation.
      final variationId = variationController.selectedVariation.value.id;

      if (variationId.isNotEmpty) {
        // If a variation is selected, get its quantity in the cart.
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        // If no variation is selected, set quantity to 0.
        productQuantityInCart.value = 0;
      }
    }
  }
}
