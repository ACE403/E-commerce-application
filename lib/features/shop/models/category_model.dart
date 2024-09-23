import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String image;
  String name;
  bool isFeatured;
  String parentId;

  CategoryModel({
    required this.id,
    required this.image,
    required this.name,
    required this.isFeatured,
    this.parentId = '',
  });
//empty helper function
  static CategoryModel empty() =>
      CategoryModel(id: '', image: '', name: '', isFeatured: false);

//convert model to json tostore in firebase

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'isFeatured': isFeatured,
    };
  }

//map json document snapshot from firebase to usermodel

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        image: data['Image'] ?? '',
        name: data['Name'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        parentId: data['ParentId'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
