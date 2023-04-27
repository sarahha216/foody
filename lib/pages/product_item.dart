import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foody/data/handle/database_service.dart';
import 'package:foody/data/models/food.dart';
import 'package:foody/pages/product_details.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:foody/widgets/widgets.dart';

class ProductItem extends StatefulWidget {
  final Food food;

  const ProductItem({Key? key, required this.food}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool favorite = false;

  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    double contentWidth = min(MediaQuery.of(context).size.width, 700);
    int count = contentWidth ~/ 100;
    double cardSize = (contentWidth - 8.0 * 2 - (count - 1) * 8.0) / count;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            nextScreen(
                context,
                ProductDetails(
                  food: widget.food,
                ));
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: cardSize,
                  height: cardSize,
                  child: Image.network(
                    widget.food.image,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 4),
                  width: cardSize - 4,
                  child: Text(
                    widget.food.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 4),
                  width: cardSize - 4,
                  child: TextWidget().default_price(
                      text: widget.food.price.toString(), color: Colors.red),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              updateFavorite(food: widget.food);
            },
            child: Container(
              color: Colors.transparent,
              child: Icon(
                favorite ? Icons.favorite : Icons.favorite_outline,
                color: Colors.red,
                size: 32.0,
              ),
            ),
          ),
        )
      ],
    );
  }

  void updateFavorite({required Food food}) async {
    if (favorite == true) {
      setState(() {
        favorite = false;
      });
      print('remove');
      print(food.foodKey);
      await databaseService.removeFavorite(foodKey: food.foodKey);
    } else {
      setState(() {
        favorite = true;
      });
      print('add');
      print(food.foodKey);
      await databaseService.addFavorite(food: food);
    }
  }
}
