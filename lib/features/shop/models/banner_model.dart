import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String id;
  String imageUrl;
  final String targetScreen;
  final bool active;
  final String name;

  // Constructor
  BannerModel({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  // Convert BannerModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active,
    };
  }

  // Create BannerModel from Firestore DocumentSnapshot
  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      imageUrl: data['ImageUrl'] ?? '',
      targetScreen: data['TargetScreen'] ?? '',
      active: data['Active'] ?? false,
    );
  }
}
