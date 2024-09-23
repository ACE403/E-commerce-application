class ProductVariationModel {
  final String id;
  
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  // Constructor with required and optional parameters
  ProductVariationModel({
    required this.id,
   
    this.image = '',
    this.description,
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  // Empty method for creating a clean/default instance
  static ProductVariationModel empty() => ProductVariationModel(
        id: '',
        attributeValues: {},
      );

  // Convert model to JSON format
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
     
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }

  // Map JSON-oriented document snapshot from Firebase to ProductVariationModel
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    // Return an empty model if the document is empty
    if (data.isEmpty) return ProductVariationModel.empty();

    // Return a populated ProductVariationModel instance
    return ProductVariationModel(
      id: data['Id'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
     
      stock: data['Stock'] ?? 0,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      image: data['Image'] ?? '',
      attributeValues: Map<String, String>.from(data['AttributeValues'] ?? {}),
    );
  }
}
