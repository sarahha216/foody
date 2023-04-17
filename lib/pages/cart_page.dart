import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/models/cart_item.dart';

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

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    DataSnapshot snap = await databaseReference.child(uid).child('cart').get();
    if (snap.value != null) {
      Map data = snap.value as Map;
      // sum = data.entries
      //     .where((e) => e.value('sum'))
      //     .map<int>((e) => e.value('sum'))
      //     .reduce((a, b) => a + b);

      data.entries.forEach((element) {
        setState(() {
          sum += element.value['sum'] as int;
        });
      });
      print(sum);
    }
    //${state.carts.map((e) => e.quantity * e.product.price).reduce((a, b) => a + b)};
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
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
                color: Colors.white, border: Border.all(color: Colors.green)),
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
              onPressed: () {},
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
                    snapshot.data!.children.elementAt(index).value as Map);
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
                                Text(cartItem.food.price.toString() + " VND",
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                iconSize: 24,
                                splashRadius: 15,
                                color: Colors.grey,
                                icon: const Icon(Icons.delete_forever),
                                onPressed: () {
                                  // await cartItem
                                  //     .toMap()
                                  //     .remove(cartItem.food.foodKey);

                                  setState(() {
                                    databaseReference
                                        .child(uid)
                                        .child('cart')
                                        .child(cartItem.food.foodKey)
                                        .remove();
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
