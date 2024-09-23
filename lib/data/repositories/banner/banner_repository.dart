import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/banner_model.dart';
import '../firebase_storage_service.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  /// Get all banners related to current User
  Future<List<BannerModel>> fetchBanners() async {
    try {
      // Fetch documents from the 'Banners' collection where 'active' is true
      final result = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();

      // Map the documents to BannerModel instances and return the list
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors
      throw FirebaseException(
        plugin: 'fetchBanners',
        code: e.code,
        message: e.message,
      );
    } on FormatException {
      // Handle format-specific errors
      throw const FormatException(
          'Invalid format encountered while fetching banners.');
    } on PlatformException catch (e) {
      // Handle platform-specific errors
      throw PlatformException(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      // Handle any other errors
      throw 'Something went wrong while fetching banners: $e';
    }
  }

  /// Upload Categories to the Cloud Firebase
  Future<void> uploadDummyData(List<BannerModel> banners) async {
    try {
      final storage = Get.put(FirebaseStorageService());
      // Loop through each category
      for (var banner in banners) {
        // Get ImageData Link from the local assets
        final file = await storage.getImageDataFromAssets(banner.imageUrl);

        // Upload Image and Get its URL
        final url = await storage.uploadImageData('Banners', file, banner.name);

        // Assign URL to Category image attribute
        banner.imageUrl = url;

        // Store Category in Firestore
        await _db.collection('Banners').doc(banner.id).set(banner.toJson());
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
