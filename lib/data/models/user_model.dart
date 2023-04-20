import 'package:foody/data/models/cart_item.dart';
import 'package:foody/data/models/food.dart';

class UserModel {
  String userID;
  String email;
  String password;
  String name;
  String? mobile;
  String? address;
  List<CartItem>? cart;
  List<Food>? favorite;

  UserModel(
      {required this.userID,
      required this.email,
      required this.password,
      required this.name,
      this.mobile,
      this.address,
      this.cart,
      this.favorite});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json["userID"],
      email: json["email"],
      password: json["password"],
      name: json["name"],
      mobile: json["mobile"],
      address: json["address"],
      cart: json["cart"] != null
          ? (json["cart"] as List).map((e) => CartItem.fromMap(e)).toList()
          : [],
      favorite: json["favorite"] != null
          ? (json["favorite"] as List).map((e) => Food.fromMap(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userID": userID,
      "email": email,
      "password": password,
      "name": name,
      "mobile": mobile,
      "address": address,
      "cart": cart?.map((e) => e.toMap()),
      "favorite": favorite?.map((e) => e.toMap())
    };
  }
}
