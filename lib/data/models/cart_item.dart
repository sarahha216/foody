import 'package:foody/data/models/food.dart';

class CartItem {
  int quantity;
  int sum;
  Food food;

  CartItem({
    required this.quantity,
    required this.sum,
    required this.food,
  });

  void increase() {
    quantity = (quantity + 1);
    sum = (food.price * quantity);
  }

  void decrease() {
    if (quantity > 0) {
      quantity = (quantity - 1);
      sum = (food.price * quantity);
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'sum': sum,
      'food': food.toMap(),
    };
  }

  factory CartItem.fromMap(Map map) {
    return CartItem(
      quantity: map['quantity'] as int,
      sum: map['sum'] as int,
      food: Food.fromMap(map['food'] as Map),
    );
  }
}
