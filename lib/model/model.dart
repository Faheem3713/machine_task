class Product {
  final String title;
  final String description;
  final num price;
  final String image;

  Product(
      {required this.title,
      required this.description,
      required this.price,
      required this.image});

  factory Product.fromJson(Map json) {
    return Product(
        title: json['title'],
        description: json['description'],
        price: json['price'],
        image: json['image']);
  }
}
