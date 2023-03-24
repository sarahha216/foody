class UserModel {
  late String username;
  late String password;

  UserModel({required this.username, required this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(username: json["username"], password: json["password"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
    };
  }
}
