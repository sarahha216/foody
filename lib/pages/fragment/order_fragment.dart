import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/models/order.dart';
import 'package:foody/pages/order_details.dart';
import 'package:foody/widgets/app_bar.dart';
import 'package:foody/widgets/image_path.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:foody/widgets/widgets.dart';

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
    return Scaffold(
        appBar: AppBarWidget.search(context: context),
        body: Container(
          child: FutureBuilder(
            future: databaseReference.child(uid).get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.children.length,
                    itemBuilder: (context, index) {
                      Order order = Order.fromJson(snapshot.data!.children
                          .elementAt(index)
                          .value as Map);
                      return _orderList(order);
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }

  _orderList(Order order) {
    return GestureDetector(
      onTap: () async {
        nextScreen(
            context,
            OrderDetails(
              orderFood: order.orderFood,
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1.2))),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(order.orderDate,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          overflow: TextStyle().overflow,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    TextWidget().default_price(
                        text: order.orderSum.toString(), fontSize: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
