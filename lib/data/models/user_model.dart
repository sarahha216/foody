class UserModel {
  String userID;
  String email;
  String password;
  String name;
  String? mobile;
  String? address;

  UserModel({
    required this.userID,
    required this.email,
    required this.password,
    required this.name,
    this.mobile,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userID: json["userID"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
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
    };
  }
}
