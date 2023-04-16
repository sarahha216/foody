

class Food {
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


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'rate': rate,
      'resKey': resKey,
      'foodKey': foodKey,
    };
  }

  factory Food.fromMap(Map map) {
    return Food(
      name: map['name'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      rate: map['rate'] as int,
      resKey: map['resKey'] as String,
      foodKey: map['foodKey'] as String,
    );
  }
}