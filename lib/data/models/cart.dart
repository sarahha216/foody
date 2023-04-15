import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:foody/data/models/cart_item.dart';

class Cart{
  String? userID;
  int totalQuantity;
  int totalPrice;
  List<CartItem>? cartItems;
  Cart({
    this.userID,
    required this.totalQuantity,
    required this.totalPrice,
    this.cartItems,
  });
  Cart copyWith({
    String? userID,
    int? totalQuantity,
    int? totalPrice,
    List<CartItem>? cartItems,
  }) {
    return Cart(
      userID: userID ?? this.userID,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      totalPrice: totalPrice ?? this.totalPrice,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'totalQuantity': totalQuantity,
      'totalPrice': totalPrice,
      'cartItems': cartItems?.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map map) {
    return Cart(
      userID: map['userID'] != null ? map['userID'] as String : null,
      totalQuantity: map['totalQuantity'] as int,
      totalPrice: map['totalPrice'] as int,
      cartItems: map['cartItems'] != null ? List<CartItem>.from((map['cartItems'] as List<Object?>).map<CartItem?>((x) => CartItem.fromMap(x as Map),),) : null,
    );
  }

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cart(userID: $userID, totalQuantity: $totalQuantity, totalPrice: $totalPrice, cartItems: $cartItems)';
  }

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;

    return
      other.userID == userID &&
          other.totalQuantity == totalQuantity &&
          other.totalPrice == totalPrice &&
          listEquals(other.cartItems, cartItems);
  }

  @override
  int get hashCode {
    return userID.hashCode ^
    totalQuantity.hashCode ^
    totalPrice.hashCode ^
    cartItems.hashCode;
  }

  String toJson() => json.encode(toMap());

}