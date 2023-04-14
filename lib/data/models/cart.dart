class Cart {
  int id;
  String foodKey;
  String foodName;
  int foodPrice;
  String foodImage;
  int foodRate;
  String resKey;
  int quantity;
  double sum;
  Cart({
    required this.id,
    required this.foodKey,
    required this.foodName,
    required this.foodPrice,
    required this.foodImage,
    required this.foodRate,
    required this.resKey,
    required this.quantity,
    required this.sum,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'foodKey': foodKey,
      'foodName': foodName,
      'foodPrice': foodPrice,
      'foodImage': foodImage,
      'foodRate': foodRate,
      'resKey': resKey,
      'quantity': quantity,
      'sum': sum,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'],
      foodKey: map['foodKey'],
      foodName: map['foodName'],
      foodPrice: map['foodPrice'],
      foodImage: map['foodImage'],
      foodRate: map['foodRate'],
      resKey: map['resKey'],
      quantity: map['quantity'],
      sum: map['sum'],
    );
  }
}