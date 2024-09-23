import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/data/repositories/firebase_storage_service.dart';
import 'package:ecomm/features/shop/models/brand_category_model.dart';
import 'package:ecomm/features/shop/models/product_category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RelationRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadBrandCategoryDummyData(
      List<BrandCategoryModel> brandCategories) async {
    try {
      // Loop through each BrandCategoryModel
      for (var bc in brandCategories) {
        // Store BrandCategoryModel in Firestore
        await _db
            .collection('BrandCategories')
            .doc('${bc.brandId}_${bc.categoryId}')
            .set(bc.toJson());
      }
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        message: e.message,
        code: e.code,
      );
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> uploadProductCategoryDummyData(
      List<ProductCategoryModel> productCategories) async {
    try {
      // Loop through each ProductCategoryModel
      for (var pc in productCategories) {
        // Store ProductCategoryModel in Firestore
        await _db
            .collection('ProductCategories')
            .doc('${pc.productId}_${pc.categoryId}')
            .set(pc.toJson());
      }
    } on FirebaseException catch (e) {
      throw FirebaseException(
        plugin: e.plugin,
        message: e.message,
        code: e.code,
      );
    } on PlatformException catch (e) {
      throw PlatformException(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
