class UserModel {
  late String username;
  late String password;
  late String name;
  late String address;
  late String moblie;

  UserModel({required this.username, required this.password, required this.name, required this.address, required this.moblie});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(username: json["username"], password: json["password"], name: json["name"],
    address: json["address"], moblie: json["moblie"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "name": name,
      "address": address,
      "moblie": moblie,
    };
  }
}
