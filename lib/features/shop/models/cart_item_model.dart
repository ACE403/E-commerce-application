class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  /// Constructor
  CartItemModel({
    required this.productId,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.price = 0.0,
    this.title = '',
    this.brandName,
    this.selectedVariation,
  });

  /// Empty Cart
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  /// Convert a CartItem to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  /// Create a CartItemModel from a JSON map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'], // Correct key names based on JSON structure
      title:
          json['title'] ?? '', // Provide default empty string if title is null
      price:
          (json['price'] ?? 0).toDouble(), // Handle null or non-double values
      image: json['image'], // Image can be null
      quantity: json['quantity'] ?? 1, // Default quantity is 1 if missing
      variationId: json['variationId'] ?? '', // Default empty variation ID
      brandName: json['brandName'], // Brand name can be null
      selectedVariation: json['selectedVariation'] != null
          ? Map<String, String>.from(json[
              'selectedVariation']) // Convert from dynamic to Map<String, String>
          : null, // Handle null case for selectedVariation
    );
  }
}
