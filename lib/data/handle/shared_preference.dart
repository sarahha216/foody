import 'package:foody/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  void saveUser(UserModel user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('name', user.name);
    pref.setString('password', user.password);
    pref.setString('email', user.email);
    pref.setString('userID', user.userID);
    pref.setString('address', user.address!);
    pref.setString('mobile', user.mobile!);
  }

  setLoginStatus(bool isCheck) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('isCheck', isCheck);
  }

  getLoginStatus() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('isCheck') ?? false;
  }

  readUser() async {
    final pref = await SharedPreferences.getInstance();
    String? name = pref.getString('name');
    String? password = pref.getString('password');
    String? email = pref.getString('email');
    String? userID = pref.getString('userID');
    String? address = pref.getString('address');
    String? mobile = pref.getString('mobile');
    print(name);
    return UserModel(
        name: name!,
        password: password!,
        email: email!,
        userID: userID!,
        address: address,
        mobile: mobile);
  }
}
