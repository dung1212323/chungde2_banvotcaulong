class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  final String category;
  final String brand;
  final String color;
  final double rating;
  final int reviewCount;
  final bool isPromotion;
  final double? promotionPrice;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.category,
    required this.brand,
    required this.color,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.isPromotion = false,
    this.promotionPrice,
  });
}
