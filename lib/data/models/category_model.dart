import 'package:foody/data/models/product_model.dart';

class CategoryModel {
  String id;
  String title;
  String image;
  List<ProductModel>? menu;

  CategoryModel({required this.id, required this.title, required this.image, this.menu}){menu = menu??[];}

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json["id"], title: json["title"], image: json["image"], menu : json['menu']??[],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "image": image, "menu": menu};
  }
}
