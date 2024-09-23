import 'package:ecomm/features/shop/controllers/product/cart_controller.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';
import '../../models/product_variation_model.dart';
import 'image_controller.dart';

class VariationController extends GetxController {
  // Singleton instance for easy access
  static VariationController get instance => Get.find<VariationController>();

  /// Selected attributes for the current variation
  RxMap<String, String> selectedAttributes = <String, String>{}.obs;

  /// Stock status of the selected variation
  RxString variationStockStatus = ''.obs;

  /// The currently selected product variation
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;
  void onAttributeSelected(
      ProductModel product, String attributeName, dynamic attributeValue) {
    // When attribute is selected, update the selectedAttributes
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    // Find the matching variation based on selected attributes
    final selectedVariation = product.productVariations!.firstWhere(
      (variation) =>
          _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    // Show the selected Variation image as a Main Image, if available
    if (selectedVariation.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value =
          selectedVariation.image;
    }
    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, selectedVariation.id);
    }
    // Update the selected variation in the controller
    this.selectedVariation.value = selectedVariation;

    getProductVariationStockStatus();
  }

  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    // If the variation has fewer attributes than selected, return false
    if (variationAttributes.length != selectedAttributes.length) return false;

    // Check if each attribute in the variation matches the selected attribute
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) {
        return false;
      }
    }

    // If all attributes match, return true
    return true;
  }

  Set<String?> getAttributesAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    // Filter the variations to check which attributes are available and have stock greater than 0
    final availableVariationAttributeValues = variations
        .where((variation) =>
            // Ensure the attribute is present, non-empty, and the stock is greater than 0
            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        // Map the valid variations to extract the attribute values
        .map((variation) => variation.attributeValues[attributeName])
        .toSet(); // Use a Set to ensure unique values

    return availableVariationAttributeValues;
  }

  //price
  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }

  /// Updates the stock status based on the selected variation's stock
  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  /// Resets the selected attributes when switching to a different product
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
