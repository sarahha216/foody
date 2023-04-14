import 'package:flutter/material.dart';
import 'package:foody/pages/cart_page.dart';
import 'package:foody/widgets/navigator_widget.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Search product",
            prefixIcon: Icon(Icons.search),
          ),
        ),),
        GestureDetector(
          onTap: (){
            nextScreen(context, CartPage());
          },
          child: Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.all(10),
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ),
      ],
    );
  }
}