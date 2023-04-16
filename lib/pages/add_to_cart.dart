import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/models/cart_item.dart';
import 'package:foody/widgets/widgets.dart';
import 'package:intl/intl.dart';

class AddToCartPage extends StatefulWidget {
  final CartItem cartItem;

  const AddToCartPage({Key? key, required this.cartItem}) : super(key: key);

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late DatabaseReference databaseReference = firebaseDatabase.ref('users');
  bool _isLoading = false;

  var formater = NumberFormat('#,###,000');

  int quantity = 1;

  @override
  void initState() {
    setState(() {
      quantity = widget.cartItem.quantity;
    });
    super.initState();
  }

  _addOrUpdate() async {
    try {
      CartItem cartItems = CartItem(
          quantity: quantity,
          sum: quantity * widget.cartItem.food.price,
          food: widget.cartItem.food);
      await databaseReference
          .child(uid)
          .child('cart')
          .child(widget.cartItem.food.foodKey)
          .set(cartItems.toMap());
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(widget.cartItem.food.image),
                ),
                SizedBox(
                  width: 4,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      child: Text(widget.cartItem.food.name,
                          style: TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    TextWidget().default_price(
                        text: widget.cartItem.food.price.toString(),
                        fontSize: 16),
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
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) {
                        quantity--;
                      }
                    });
                  },
                ),
                Container(
                  width: 30,
                  child: Center(
                    child: Text(
                      '$quantity',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 24,
                  splashRadius: 15,
                  color: Colors.green,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                )
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                "Total: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "${formater.format(int.parse("${widget.cartItem.food.price * quantity}"))} VND",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48.0,
                  child: ElevatedButton(
                      onPressed: () {
                        _addOrUpdate();
                      },
                      child: Text('Add', style: const TextStyle(fontSize: 16))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
