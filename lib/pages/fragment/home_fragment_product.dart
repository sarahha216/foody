import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/handle/database_service.dart';
import 'package:foody/data/models/food.dart';
import 'package:foody/pages/product_details.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:foody/widgets/title_cate.dart';
import 'package:foody/widgets/widgets.dart';

class ProductPopular extends StatefulWidget {
  const ProductPopular({Key? key}) : super(key: key);

  @override
  State<ProductPopular> createState() => _ProductPopularState();
}

class _ProductPopularState extends State<ProductPopular> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref("foods");
  bool favorite = false;

  DatabaseService databaseService = DatabaseService();

  Future productFunc() async {
    print('product');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TitleCate.base(
              titleCate: "Popular Products",
              seeMore: productFunc,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                child: FutureBuilder(
              future: databaseReference.get(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  return GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapShot.data!.children.length,
                      physics: BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        // mainAxisExtent: 256,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        var value = snapShot.data!.children.elementAt(index);
                        Food food = Food(
                            name: value.child("name").value.toString(),
                            image: value.child("image").value.toString(),
                            description:
                                value.child("description").value.toString(),
                            price: value.child("price").value as int,
                            rate: value.child("rate").value as int,
                            resKey: value.child("resKey").value.toString(),
                            foodKey: value.child("foodKey").value.toString());

                        return _productItem(food);
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  _productItem(Food food) {
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
                  food: food,
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
                    food.image,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 4),
                  width: cardSize - 4,
                  child: Text(
                    food.name,
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
                  child:
                      TextWidget().default_price(text: food.price.toString()),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              updateFavorite(food: food);
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
