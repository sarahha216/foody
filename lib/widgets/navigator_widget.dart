import 'dart:math';

import 'package:flutter/material.dart';

Future<void> nextScreen(context, page) async {
  await Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenRemove(context, page) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page), (route) => false);
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    backgroundColor: color,
  ));
}

String generateRandomString() {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(10, (index) => chars[r.nextInt(chars.length)]).join();
}
