import 'package:ecomm/features/shop/models/category_model.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/popups/full_screen_loader.dart';
import 'package:ecomm/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../data/repositories/category/category_repository.dart';
import '../../../data/repositories/product/product_repository.dart';
import '../models/product_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      //show loaders while loading
      isLoading.value = true;

      //fetch categories from data source
      final categories = await _categoryRepository.getAllCategories();

      //Update categories list
      allCategories.assignAll(categories);

      //Filter featured function
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Load category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    print('Fetching subcategories for categoryId: $categoryId');
    try {
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      print('Error fetching subcategories: $e');
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
  // load selected category data

  //get category products
// Get Category or Sub-Category Products.
  Future<List<ProductModel>> getCategoryProductsForStore({
    required String categoryId,
    int limit = -1,
  }) async {
    // Fetch limited (4 by default) products against each subCategory:
    print('Fetching products for categoryId: $categoryId');
    try {
      final products = await ProductRepository.instance.getProductsForCategory(
        categoryId: categoryId,
        limit: limit,
      );
      return products;
    } catch (e) {
      print('Error fetching products: $e');
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryProducts({
    required String searchTerm,
    int limit = 4,
  }) async {
    print('Fetching products for searchTerm: $searchTerm');
    try {
      final products =
          await ProductRepository.instance.getProductsByNameOrDescription(
        searchTerm: searchTerm,
        limit: limit,
      );
      return products;
    } catch (e) {
      print('Error fetching products: $e');
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
