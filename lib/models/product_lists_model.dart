class ProductModel {
  final int id;
  final String image;
  final String name;
  final String category;
  final String brand;
  final double price;
  final String description;

  const ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      image: json['thumbnail'] as String? ?? '',
      name: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
    );
  }
}
