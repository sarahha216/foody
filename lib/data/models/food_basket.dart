import 'package:foody/data/models/food.dart';

class FoodBasket{
  int quantity;
  double sum;
  //Food food;
  String foodKey;
  String name;
  int price;
  String image;
  int rate;
  String resKey;
  FoodBasket({
    required this.name, required this.image, required this.price, required this.rate, required this.resKey, required this.foodKey,
    required this.quantity,
    required this.sum,
  });
  void increase() {
    quantity = (quantity+ 1);
    sum = (price * quantity).toDouble();
  }

  void decrease() {
    if (quantity> 0) {
      quantity = (quantity- 1);
      sum = (price * quantity).toDouble();
    }
  }

  factory FoodBasket.fromJson(Map<String, dynamic> json) {
    return FoodBasket(
        //food: json["food"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        rate: json["rate"],
        resKey: json["resKey"],
        foodKey: json["foodKey"],
        quantity: json["quantity"],
        sum: json["sum"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //"food": food,
      "name": name,
      "image": image,
      "price": price,
      "rate": rate,
      "resKey": resKey,
      "foodKey": foodKey,
      "quantity": quantity,
      "sum": sum,
    };
  }


}