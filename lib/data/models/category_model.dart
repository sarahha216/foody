class CategoryModel {
  String id;
  String title;
  String image;

  CategoryModel({required this.id, required this.title, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json["id"], title: json["title"], image: json["image"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "image": image};
  }
}
