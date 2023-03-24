import 'package:flutter/material.dart';

class TitleCate {
  static base({
    required String? titleCate,
    VoidCallback? seeMore,
  }) {
    return Row(
      children: [
        Expanded(child: Text(titleCate!,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),)),
        TextButton(
          onPressed: seeMore,
          child: Text("See more", style: TextStyle(fontSize: 16, color: Colors.lightGreen),),
          style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft),
        ),
      ],
    );
  }
}
