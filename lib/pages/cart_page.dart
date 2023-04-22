import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/models/cart_item.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:foody/widgets/widgets.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref('users');
  int sum = 0;
  Map? data;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    DataSnapshot snap = await databaseReference.child(uid).child('cart').get();
    if (snap.value != null) {
      data = snap.value as Map;

      setState(() {
        sum = data?.entries
            .map((e) => e.value['quantity'] * e.value['food']['price'])
            .reduce((a, b) => (a + b));
      });

      //print(sum);
    } else {
      setState(() {
        sum = 0;
      });
    }
  }

  checkOut() async {
    DataSnapshot snap = await databaseReference.child(uid).child('cart').get();
    if (snap.value != null) {
      //print(data);
      var tempDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      //print(tempDate);
      var tempID = generateRandomString();
      var tempQuantity = data?.entries
          .map((e) => e.value['quantity'])
          .reduce((a, b) => (a + b));
      //print(tempQuantity);

      //print(data!.length);
      //print(data!.values.toList().toString());
      List e = data!.values.toList();
      print(e.toString());
      Map? a;
      for (int i = 0; i < data!.length; i++) {
        firebaseDatabase.ref('orders').child(uid).child(tempID).set({
          'orderID': tempID,
          'orderDate': tempDate,
          'orderSum': sum,
          'orderQuantity': tempQuantity,
          'userID': uid,
          'orderFood': e,
        });
      }
      await databaseReference.child(uid).child('cart').remove();
      setState(() {
        loadData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => HomeDetail())).then();
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _cart(),
              ],
            ),
          ),
          _total(),
        ],
      ),
    );
  }

  _total() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green)),
                height: 48,
                child: Text("Total: $sum",
                    style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
              )),
          Expanded(
              child: Container(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    checkOut();
                  },
                  child: Text('Check out'),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        //borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  _cart() {
    return FutureBuilder(
      future: databaseReference.child(uid).child('cart').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Text(''),
          );
        } else {
          return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.children.length,
              itemBuilder: (context, index) {
                CartItem cartItem = CartItem.fromMap(
                    snapshot.data!
                        .children
                        .elementAt(index)
                        .value as Map);
                print(cartItem);
                return SizedBox(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(cartItem.food.image),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(cartItem.food.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextStyle().overflow,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                TextWidget().default_price(
                                    text: cartItem.food.price.toString(),
                                    fontSize: 16),

                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                iconSize: 24,
                                splashRadius: 15,
                                color: Colors.green,
                                icon: const Icon(Icons.remove),
                                onPressed: () async {
                                  if (cartItem.quantity > 1) {
                                    await databaseReference
                                        .child(uid)
                                        .child('cart')
                                        .child(cartItem.food.foodKey)
                                        .update({
                                      'quantity': cartItem.quantity - 1,
                                      'sum': (cartItem.quantity - 1) *
                                          cartItem.food.price,
                                    });
                                    setState(() {
                                      loadData();
                                    });
                                  }
                                },
                              ),
                              Container(
                                width: 30,
                                child: Center(
                                  child: Text(
                                    '${cartItem.quantity}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              IconButton(
                                iconSize: 24,
                                splashRadius: 15,
                                color: Colors.green,
                                icon: const Icon(Icons.add),
                                onPressed: () async {
                                  await databaseReference
                                      .child(uid)
                                      .child('cart')
                                      .child(cartItem.food.foodKey)
                                      .update({
                                    'quantity': cartItem.quantity + 1,
                                    'sum': (cartItem.quantity + 1) *
                                        cartItem.food.price,
                                  });
                                  setState(() {
                                    loadData();
                                  });
                                },
                              ),
                              IconButton(
                                iconSize: 24,
                                splashRadius: 15,
                                color: Colors.grey,
                                icon: const Icon(Icons.delete_forever),
                                onPressed: () async {
                                  await databaseReference
                                      .child(uid)
                                      .child('cart')
                                      .child(cartItem.food.foodKey)
                                      .remove();
                                  setState(() {
                                    loadData();
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              });
        }
      },
    );
  }
}
