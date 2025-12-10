class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final bool active;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.active,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      price: (json["price"] as num).toDouble(),
      description: json["description"],
      category: json["category"],
      image: json["image"],
      active: json["active"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "active": active,
        "createdAt": createdAt.toIso8601String(),
      };
}
