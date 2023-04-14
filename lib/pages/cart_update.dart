import 'package:flutter/material.dart';

class CartUpdate extends StatelessWidget {
  const CartUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset("assets/images/dish.png"),),
                    SizedBox(width: 4,),
                    Column(
                      children: [
                        Text('foodBasket!.name',
                            style: TextStyle(
                              fontSize: 16,
                              overflow: TextStyle().overflow,
                            )),
                        Text('foodBasket!.name',
                            style: const TextStyle(
                                fontSize: 16)),
                        // TextWidget()
                        //     .priceBasket(text: 'foodBasket!.price.toString()'),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      iconSize: 24,
                      splashRadius: 15,
                      color: Colors.green,
                      icon: const Icon(Icons.remove),
                      onPressed: () {},
                    ),
                    Text(
                      "1",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      iconSize: 24,
                      splashRadius: 15,
                      color: Colors.green,
                      icon: const Icon(Icons.add),
                      onPressed: () {},
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
