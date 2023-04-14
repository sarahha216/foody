class Cart{
  int quantity;
  double sum;
  int? id;
  String foodKey;
  String foodName;
  int foodPrice;
  String foodImage;
  int foodRate;
  String resKey;
  Cart({
    this.id,
    required this.foodName, required this.foodImage, required this.foodPrice, required this.foodRate, required this.resKey, required this.foodKey,
    required this.quantity,
    required this.sum,
  });
  void increase() {
    quantity = (quantity+ 1);
    sum = (foodPrice * quantity).toDouble();
  }

  void decrease() {
    if (quantity> 0) {
      quantity = (quantity- 1);
      sum = (foodPrice * quantity).toDouble();
    }
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        id: json["id"],
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
      "id": id,
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