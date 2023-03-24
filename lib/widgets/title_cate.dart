import 'package:flutter/material.dart';

class TitleCate extends StatelessWidget {
  final String? titleCate;
  final Function()? seeMore;
  const TitleCate({Key? key, required this.titleCate, this.seeMore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(titleCate!,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),)),
        // GestureDetector(onTap: seeMore,child: Text("See more", style: TextStyle(fontSize: 16, color: Colors.lightGreen),),),
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
