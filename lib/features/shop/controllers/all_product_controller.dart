import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/data/repositories/product/product_repository.dart';
import 'package:ecomm/features/shop/models/product_model.dart';
import 'package:ecomm/utils/popups/loaders.dart';
import 'package:get/get.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;

  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];
      final products = await repository.fetchProductsByQuery(query);
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;
    print("Sorting by: $sortOption"); // Debug log
    print("Before sorting: ${products.map((p) => p.title).toList()}");

    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Newest':
        products.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      case 'Sale':
        products.sort((a, b) {
          if (b.salePrice > 0 && a.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (b.salePrice > 0) {
            return -1; // Show items on sale first
          } else if (a.salePrice > 0) {
            return 1; // Push non-sale items lower
          }
          return 0;
        });
        break;
      default:
        products.sort((a, b) => a.title.compareTo(b.title));
    }

    // Log after sorting to confirm
    print("After sorting: ${products.map((p) => p.title).toList()}");

    // Notify the UI to refresh the products list
    products.refresh();
  }

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts('Name');
  }
}
