import 'dart:convert';

import 'package:foody/data/models/food.dart';

class CartItem{
  String? id;
  int quantity;
  int sum;
  Food food;
  CartItem({
    this.id,
    required this.quantity,
    required this.sum,
    required this.food,
  });

  void increase() {
    quantity = (quantity+ 1);
    sum = (food.price * quantity);
  }
  void decrease() {
    if (quantity> 0) {
      quantity = (quantity- 1);
      sum = (food.price * quantity);
    }
  }

  CartItem copyWith({
    String? id,
    int? quantity,
    int? sum,
    Food? food,
  }) {
    return CartItem(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      sum: sum ?? this.sum,
      food: food ?? this.food,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'sum': sum,
      'food': food.toMap(),
    };
  }

  factory CartItem.fromMap(Map map) {
    return CartItem(
      id: map['id'] != null ? map['id'] as String : null,
      quantity: map['quantity'] as int,
      sum: map['sum'] as int,
      food: Food.fromMap(map['food'] as Map),
    );
  }
  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItem(id: $id, quantity: $quantity, sum: $sum, food: $food)';
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
          other.quantity == quantity &&
          other.sum == sum &&
          other.food == food;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    quantity.hashCode ^
    sum.hashCode ^
    food.hashCode;
  }
}