import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  setLoginStatus(bool isCheck) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('isCheck', isCheck);
  }

  getLoginStatus() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('isCheck') ?? false;
  }
}
