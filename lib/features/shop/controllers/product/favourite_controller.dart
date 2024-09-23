import 'dart:convert';

import 'package:ecomm/data/repositories/product/product_repository.dart';
import 'package:ecomm/features/shop/models/product_model.dart';
import 'package:ecomm/utils/local_storage/storage_utility.dart';
import 'package:ecomm/utils/popups/loaders.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  final favourites = <String, bool>{}.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initFavourites();
  }

  Future<void> initFavourites() async {
    final json = LocalStorage.instance().readData('favourite');
    if (json != null) {
      final storageFavourites = jsonDecode(json) as Map<String, dynamic>;

      favourites.assignAll(
          storageFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProduct(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavouritesToStorage();
      Loaders.customToast(message: 'Product has been added to the Wishlist');
    } else {
      LocalStorage.instance().removeData(productId);
      favourites.remove(productId);

      saveFavouritesToStorage();
      favourites.refresh();
      Loaders.customToast(
          message: 'Product has been removed from the wishlist');
    }
  }

  void saveFavouritesToStorage() {
    final encodedFavourites = json.encode(favourites);
    LocalStorage.instance().saveData('favourite', encodedFavourites);
  }

  Future<List<ProductModel>> favouriteProducts() async {
    return await ProductRepository.instance
        .getFavouriteProducts(favourites.keys.toList());
  }
}
