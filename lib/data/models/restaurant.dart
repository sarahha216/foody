import 'package:foody/data/models/food.dart';

class Restaurant{
  String resKey;
  String name;
  String logo;
  String cover;
  String address;
  String openHours;
  List<Food>? menu;
  int rate;

  Restaurant({
    required this.resKey,
    required this.name,
    required this.logo,
    required this.cover,
    required this.address,
    required this.openHours,
    this.menu,
    required this.rate,
  });

  factory Restaurant.fromJson(Map<String, dynamic> map) {
    return Restaurant(
      resKey: map['resKey'],
      name: map['name'],
      logo: map['logo'],
      cover: map['cover'],
      address: map['address'],
      openHours: map['openHours'],
      menu: map['menu']??[],
      rate: map['rate'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "resKey": resKey,
      "name": name,
      "logo": logo,
      "cover": cover,
      "address": address,
      "menu": menu,
      "openHours": openHours,
      "rate": rate,
    };
  }
}