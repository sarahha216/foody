class Food{
  String name;
  String image;
  String? description;
  int price;
  int rate;
  String resKey;
  String foodKey;

  Food({
    required this.name,
    required this.image,
    this.description,
    required this.price,
    required this.rate,
    required this.resKey,
    required this.foodKey,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        foodKey : json['foodKey'],
        image : json['image'],
        name : json['name'],
        price : json['price'],
        rate : json['rate'],
        resKey : json['resKey'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "foodKey": foodKey,
      "image": image,
      "name": name,
      "price": price,
      "rate": rate,
      "resKey": resKey,
    };
  }
}