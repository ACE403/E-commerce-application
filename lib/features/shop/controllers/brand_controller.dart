import 'package:ecomm/data/repositories/brand/brand_repository.dart';
import 'package:ecomm/data/repositories/product/product_repository.dart';
import 'package:ecomm/features/shop/models/brand_model.dart';
import 'package:ecomm/features/shop/models/product_model.dart';
import 'package:ecomm/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());
  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  // Load brands
  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);
      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //get brands for category
  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try {
      final brands =
          await BrandRepository.instance.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
  //Get brand specific product from database

  Future<List<ProductModel>> getBrandProducts(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
