import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextWidget{
  var formater = NumberFormat('#,###,000');
  static Text white({
    TextStyle? style,
    required String text,
  }){
    return Text(
      text,
      style: const TextStyle(color: Colors.white),
    );
  }
  Text price({
    TextStyle? style,
    required String text,
  }){
    return Text(
      "${formater.format(int.parse(text))} VND",
      style: const TextStyle(color: Colors.red, fontSize: 21),
    );
  }
  Text priceBasket({
    TextStyle? style,
    required String text,
  }){
    return Text(
      "${formater.format(int.parse(text))} VND",
      style: const TextStyle(color: Colors.red, fontSize: 12),
    );
  }
  static Text description({
    TextStyle? style,
    required String text,
  }){
    return Text(
      text,
      style: const TextStyle(fontSize: 18),
    );
  }
  static Text name({
    TextStyle? style,
    required String text,
  }){
    return Text(
      text,
      style: const TextStyle(fontSize: 34, color: Colors.green),
    );
  }

  static Text name21({
    TextStyle? style,
    required String text,
  }){
    return Text(
      text,
      style: const TextStyle(fontSize: 21, color: Colors.green, fontWeight: FontWeight.bold),
    );
  }
}