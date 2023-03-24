import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Shared_Prefs{

  // static const mapSharedPreference = '';

  // static Future setMap(String email, String password) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.setString(
  //       mapSharedPreference,
  //       jsonEncode({
  //         'username': email,
  //         'password': password,
  //   }));
  // }

  // static void getMap() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // return jsonDecode(prefs.getString(mapSharedPreference) ?? "") ?? {};
  //   final rawJson = prefs.getString(mapSharedPreference);
  //   Map<String, dynamic> map = jsonDecode(rawJson!);
  //
  //   print(map['username']);
  // }

  // static saveStr(String username, String password) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   Map<String, dynamic> map = {
  //     'username': username,
  //     'password': password,
  //   };
  //   String rawJson = jsonEncode(map);
  //   prefs.setString('key', rawJson);
  // }

  // static readPrefStr() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final rawJson = prefs.getString('key') ?? '';
  //   Map<String, dynamic> map = jsonDecode(rawJson);
  //
  //   print(map['username']);
  // }

  // static saveStr(String username, String password) async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString('username', username);
  //   pref.setString('password', password);
  // }

  // static readPrefStr() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   print(pref.getString('username'));
  //   print(pref.getString('password'));
  // }

  // static Future<UserModel> readPrefStr() async{
  //   final pref = await SharedPreferences.getInstance();
  //   final username = pref.getString('username');
  //   final password = pref.getString('password');
  //   print(username);
  //   print(password);
  //   return UserModel(username: username!, password: password!);
  // }
}