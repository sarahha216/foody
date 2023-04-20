import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/widgets/image_path.dart';

class OrderFragment extends StatefulWidget {
  const OrderFragment({Key? key}) : super(key: key);

  @override
  State<OrderFragment> createState() => _OrderFragmentState();
}

class _OrderFragmentState extends State<OrderFragment> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref('orders');

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: FutureBuilder(
        future: databaseReference.child(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.children.length,
                itemBuilder: (context, index) {
                  var v = snapshot.data!.children.elementAt(index);
                  // Order order = Order.fromJson(
                  //     snapshot.data!.children.elementAt(index).value as Map);
                  print(v.toString());
                  // Order order = Order(
                  //   orderID: v.child("orderID").value.toString(),
                  //   orderDate: v.child("orderDate").value.toString(),
                  //   orderSum: v.child("orderSum").value as int,
                  //   orderQuantity: v.child("orderQuantity").value as int,
                  //   userID: v.child("userID").value.toString(),
                  //   orderFood: v.child('orderFood').value,
                  // );
                  return _orderList();
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    ));
  }

  _orderList() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {},
        child: Container(
          child: Row(
            children: [
              SizedBox(
                width: 90,
                height: 100,
                child: Image.asset(
                  ImagePath.purchased,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('product.title'),
                      Expanded(
                        child: Text(
                          'product.description',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
