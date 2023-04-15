import 'dart:convert';

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

  Food copyWith({
    String? name,
    String? image,
    String? des,
    int? price,
    int? rate,
    String? resKey,
    String? foodKey,
  }) {
    return Food(
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? description,
      price: price ?? this.price,
      rate: rate ?? this.rate,
      resKey: resKey ?? this.resKey,
      foodKey: foodKey ?? this.foodKey,
    );
  }

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

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Food(name: $name, image: $image, price: $price, rate: $rate, resKey: $resKey, foodKey: $foodKey)';
  }

  @override
  bool operator ==(covariant Food other) {
    if (identical(this, other)) return true;
    return
      other.name == name &&
          other.image == image &&
          other.description == description &&
          other.price == price &&
          other.rate == rate &&
          other.resKey == resKey &&
          other.foodKey == foodKey;
  }

  @override
  int get hashCode {
    return name.hashCode ^
    image.hashCode ^
    description.hashCode ^
    price.hashCode ^
    rate.hashCode ^
    resKey.hashCode ^
    foodKey.hashCode;
  }
}