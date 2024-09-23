import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/data/repositories/firebase_storage_service.dart';
import 'package:ecomm/features/shop/models/product_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/constants/enum.dart';

class ProductRepository {
  static ProductRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      final list = snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();

      return list;
    } on FirebaseException catch (e) {
      throw FirebaseException(
          plugin: e.plugin, message: e.message, code: e.code);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    } catch (e) {
      print(e);
      throw 'Something went wrong. Please try again';
    }
  }

// Fetch products based on the list of product IDs
  Future<List<ProductModel>> getFavouriteProducts(
      List<String> productIds) async {
    try {
      // Fetch the products from the 'Products' collection where the document ID is in the list of productIds
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      // Map the query snapshot to a list of ProductModel and return the list
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw FirebaseException(
          plugin: e.plugin, message: e.message, code: e.code);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    } catch (e) {
      print(e);
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();
      final list = snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();

      return list;
    } on FirebaseException catch (e) {
      throw FirebaseException(
          plugin: e.plugin, message: e.message, code: e.code);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    } catch (e) {
      print(e);
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querysnapshot = await query.get();
      final List<ProductModel> productList = querysnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw FirebaseException(
          plugin: e.plugin, message: e.message, code: e.code);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    } catch (e) {
      print(e);
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // Upload all the products along with their images
      final storage = Get.put(FirebaseStorageService());

// Loop through each product
      for (var product in products) {
        // Get image data link from Local assets
        final thumbnail =
            await storage.getImageDataFromAssets(product.thumbnail);

        // Upload image and get its URL
        final thumbnailUrl = await storage.uploadImageData(
            'Products/Images', thumbnail, product.thumbnail.toString());

        // Assign URL to product.thumbnail attribute
        product.thumbnail = thumbnailUrl;

        // Product list of images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imagesUrl = [];

          for (var image in product.images!) {
            // Get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            // Upload image and get its URL
            final imageUrl = await storage.uploadImageData(
                'Products/Images', assetImage, image);

            // Add URL to imagesUrl list
            imagesUrl.add(imageUrl);
          }

          // Clear existing images and add new URLs
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        // Upload Variation Images if the product is of type variable
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            // Get image data link from local assets
            final assetImage =
                await storage.getImageDataFromAssets(variation.image);

            // Upload image and get its URL
            final variationImageUrl = await storage.uploadImageData(
                'Products/Images', assetImage, variation.image);

            // Assign URL to variation.image attribute
            variation.image = variationImageUrl;
          }
        }

        // Store product in Firestore
        await _db.collection("Products").doc(product.id).set(product.toJson());
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

  Future<List<ProductModel>> getProductsForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();

      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw FirebaseException(
          plugin: e.plugin, message: e.message, code: e.code);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    } catch (e) {
      print(e);
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getProductsForCategory({
    required String categoryId,
    int limit = 4,
  }) async {
    try {
      // Fetch product IDs from the 'ProductCategories' collection
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
              .collection('ProductCategories')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategories')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      // Extract product IDs from the fetched documents
      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['productId'] as String)
          .toList();

      // Check if the list of productIds is non-empty before running the 'whereIn' query
      if (productIds.isEmpty) {
        return []; // Return an empty list if no product IDs were found
      }

      // Query to fetch products where the document ID is in the productIds list
      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      // Convert the query result to a list of ProductModel
      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } catch (e) {
      print("eyaau error $e");
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getProductsByNameOrDescription({
    required String searchTerm,
    int limit = 4,
  }) async {
    try {
      // Fetch a larger set of products initially (limit as needed)
      final productsQuery = await _db
          .collection('Products')
          .limit(100) // Fetch more items to ensure you get relevant results
          .get();
      print('Total products fetched: ${productsQuery.docs.length}');
      // Convert the query result to a list of ProductModel
      List<ProductModel> allProducts = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      print('Total products converted: ${allProducts.length}');
      // Filter products where title contains the search term
      List<ProductModel> filteredProducts = allProducts.where((product) {
        final titleLower = product.title.trim();
        final searchTermLower = searchTerm.trim();
        print('Comparing titleLower: $titleLower');

        print('Compparing searchTermLower: $searchTermLower');

        return titleLower.contains(searchTermLower);
      }).toList();
      print('Total filtered products: ${filteredProducts.length}');
      // Return only the required number of products (if limit is set)
      if (limit > 0) {
        return filteredProducts.take(limit).toList();
      }

      return filteredProducts;
    } catch (e) {
      print("Error fetching products: $e");
      throw 'Something went wrong. Please try again';
    }
  }
}
