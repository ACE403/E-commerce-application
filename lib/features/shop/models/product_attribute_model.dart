class ProductAttributeModel {
  String? name;
  final List<String>? values;

  // Constructor
  ProductAttributeModel({this.name, this.values});

  // Convert model to JSON format for Firebase storage
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Values': values,
    };
  }

  // Map JSON-oriented document snapshot from Firebase to ProductAttributeModel
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
      name: document.containsKey('Name') ? document['Name'] : null,
      values: document.containsKey('Values')
          ? List<String>.from(document['Values'])
          : [],
    );
  }
}
