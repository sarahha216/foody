class FoodBasket{
  int quantity;
  double sum;
  String foodKey;
  String foodName;
  int foodPrice;
  String foodImage;
  int foodRate;
  String resKey;
  FoodBasket({
    required this.foodName, required this.foodImage, required this.foodPrice, required this.foodRate, required this.resKey, required this.foodKey,
    required this.quantity,
    required this.sum,
  });

  factory FoodBasket.fromJson(Map<String, dynamic> json) {
    return FoodBasket(
      foodName: json["foodName"],
      foodImage: json["foodImage"],
      foodPrice: json["foodPrice"],
      foodRate: json["foodRate"],
      resKey: json["resKey"],
      foodKey: json["foodKey"],
      quantity: json["quantity"],
      sum: json["sum"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "foodName": foodName,
      "foodImage": foodImage,
      "foodPrice": foodPrice,
      "foodRate": foodRate,
      "resKey": resKey,
      "foodKey": foodKey,
      "quantity": quantity,
      "sum": sum,
    };
  }


}