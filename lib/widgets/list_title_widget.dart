import 'package:flutter/material.dart';

class ListTitleWidget {
  static base(
      {required String content,
      VoidCallback? onTap,
      IconData? prefixIcon,
      Color? iconColor,
      TextStyle? contentStyle}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                offset: Offset(0, 1),
                spreadRadius: 0,
                blurRadius: 2)
          ]),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        iconColor: iconColor,
        textColor: Colors.black87,
        leading: Icon(prefixIcon),
        title: Text(
          content,
          style: contentStyle ?? const TextStyle(fontSize: 18.0),
        ),
        onTap: onTap,
      ),
    );
  }
}
