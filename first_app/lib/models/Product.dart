class Product {
  final int id;
  final String name;
  final double prix;
  final String image;

  Product({required this.id, required this.name, required this.prix, required this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      prix: json['prix'],
      image: json['image'],
    );
  }
}
