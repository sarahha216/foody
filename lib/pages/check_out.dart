import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:foody/widgets/widgets.dart';
import 'package:intl/intl.dart';

class CheckOut extends StatefulWidget {
  final List e;
  final int sum;
  final int quantity;

  const CheckOut(
      {Key? key, required this.e, required this.sum, required this.quantity})
      : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int? sum;
  int? quan;
  List? list;

  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref('users');

  @override
  void initState() {
    // TODO: implement initState
    sum = widget.sum;
    quan = widget.quantity;
    list = widget.e;
    super.initState();
  }

  order() async {
    var tempDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    var tempID = generateRandomString();
    firebaseDatabase.ref('orders').child(uid).child(tempID).set({
      'orderID': tempID,
      'orderDate': tempDate,
      'orderSum': sum,
      'orderQuantity': quan,
      'userID': uid,
      'orderFood': list,
    });
    await databaseReference.child(uid).child('cart').remove();
    int counter = 3;
    Navigator.of(context).popUntil((route) => counter-- <= 0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Check out"),
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
              onPressed: () {
                order();
              },
              child: Text('Order'),
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
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.e.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(widget.e
                          .elementAt(index)["food"]["image"]
                          .toString()),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              widget.e
                                  .elementAt(index)["food"]["name"]
                                  .toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                overflow: TextStyle().overflow,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          TextWidget().default_price(
                              text: widget.e
                                  .elementAt(index)["food"]["price"]
                                  .toString(),
                              fontSize: 16),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16.0),
                      child: Row(
                        children: [
                          Text("Số lượng:"),
                          Container(
                            width: 30,
                            child: Center(
                              child: Text(
                                "${widget.e.elementAt(index)["quantity"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
