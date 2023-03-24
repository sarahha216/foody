class ProductModel {
  int id;
  String title;
  String description;
  double price;

  ProductModel(
      {required this.id,
        required this.title,
        required this.description,
        required this.price});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "price": price
    };
  }
}
