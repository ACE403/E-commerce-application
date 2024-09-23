import 'package:ecomm/data/repositories/banner/banner_repository.dart';
import 'package:ecomm/data/repositories/brand/brand_repository.dart';
import 'package:ecomm/data/repositories/product/product_repository.dart';
import 'package:ecomm/data/repositories/relation/relation_repository.dart';
import 'package:ecomm/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/category/category_repository.dart';
import '../../../dummy_data.dart';

class UploadDataController extends GetxController {
  static UploadDataController get instance => Get.find();
  final categoryRepository = Get.put(CategoryRepository());
  final bannerRepository = Get.put(BannerRepository());
  final productRepository = Get.put(ProductRepository());
  final brandsRepository = Get.put(BrandRepository());
  final relationRepository = Get.put(RelationRepository());
  Future<void> uploadCategories() async {
    try {
      Loaders.loadingSnackBar(title: 'Loading...');

      // Upload the dummy data
      await categoryRepository.uploadDummyData(DummyData.categories);
      Get.back();
      Loaders.successSnackBar(title: 'Categories uploaded successfully!');
    } catch (e) {
      Get.back();
      Loaders.errorSnackBar(title: 'Failed to upload categories: $e');
    }
  }

  Future<void> uploadBanners() async {
    try {
      Loaders.loadingSnackBar(title: 'Loading...');

      // Upload the dummy data
      await bannerRepository.uploadDummyData(DummyData.banners);
      Get.back();
      Loaders.successSnackBar(title: 'Banners uploaded successfully!');
    } catch (e) {
      Get.back();
      Loaders.errorSnackBar(title: 'Failed to upload Banners: $e');
    }
  }

  Future<void> uploadProducts() async {
    try {
      Loaders.loadingSnackBar(title: 'Loading...');

      // Upload the dummy data
      await productRepository.uploadDummyData(DummyData.products);
      Get.back();
      Loaders.successSnackBar(title: 'Products uploaded successfully!');
    } catch (e) {
      Get.back();
      Loaders.errorSnackBar(title: 'Failed to upload categories: $e');
    }
  }

  Future<void> uploadBrands() async {
    try {
      Loaders.loadingSnackBar(title: 'Loading...');

      // Upload the dummy data
      await brandsRepository.uploadDummyData(DummyData.brands);
      Get.back();
      Loaders.successSnackBar(title: 'Brands uploaded successfully!');
    } catch (e) {
      Get.back();
      Loaders.errorSnackBar(title: 'Failed to upload Banners: $e');
    }
  }

  Future<void> uploadBrandCategory() async {
    try {
      Loaders.loadingSnackBar(title: 'Loading...');

      // Upload the dummy data
      await relationRepository
          .uploadBrandCategoryDummyData(DummyData.brandCategories);
      Get.back();
      Loaders.successSnackBar(
          title: 'brand category relation uploaded successfully!');
    } catch (e) {
      Get.back();
      Loaders.errorSnackBar(title: 'Failed to upload Banners: $e');
    }
  }

  Future<void> uploadProductCategory() async {
    try {
      Loaders.loadingSnackBar(title: 'Loading...');

      // Upload the dummy data
      await relationRepository
          .uploadProductCategoryDummyData(DummyData.productCategories);
      Get.back();
      Loaders.successSnackBar(
          title: 'product category relation uploaded successfully!');
    } catch (e) {
      Get.back();
      Loaders.errorSnackBar(title: 'Failed to upload Banners: $e');
    }
  }
}
