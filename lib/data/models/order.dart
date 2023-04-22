import 'package:foody/data/models/cart_item.dart';

class Order {
  String orderID;
  String orderDate;
  int orderSum;
  int orderQuantity;
  String userID;

  List<CartItem> orderFood;

  Order(
      {required this.orderID,
      required this.orderDate,
      required this.orderSum,
      required this.orderQuantity,
      required this.userID,
      required this.orderFood});

  factory Order.fromJson(Map map) {
    return Order(
        orderID: map["orderID"],
        orderDate: map["orderDate"],
        orderSum: map["orderSum"] as int,
        orderQuantity: map["orderQuantity"] as int,
        userID: map["userID"],
        orderFood: map["orderFood"] != null
            ? (map["orderFood"] as List)
                .map((e) => CartItem.fromMap(e))
                .toList()
            : []);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "orderID": orderID,
      "orderDate": orderDate,
      "orderSum": orderSum,
      "orderQuantity": orderQuantity,
      "userID": userID,
      "orderFood": orderFood.map((e) => e.toMap()),
    };
  }
}
