import 'package:flutter/material.dart';
import 'package:foody/data/models/cart_item.dart';

class OrderDetails extends StatefulWidget {
  final List<CartItem> orderFood;
  final String userName, address;

  OrderDetails(
      {Key? key, required this.orderFood, required this.userName, required this.address})
      : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int sum = 0;
  int quantity = 0;
  Map? data;

  @override
  void initState() {
    widget.orderFood.forEach((element) {
      sum += element.sum;
    });
    widget.orderFood.forEach((element) {
      quantity += element.quantity;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _info(size),
                _cart(context),
              ],
            ),
          ),
          _total(context),
        ],
      ),
    );
  }

  _total(BuildContext context) {
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
                child: Text("Quantity: $quantity",
                    style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
              )),
          Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.green)),
                height: 48,
                child: Text("Total: $sum",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
              )),
        ],
      ),
    );
  }

  _info(Size size) {
    return Container(
      width: size.width,
      height: 100,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name: ${widget.userName}",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Address: ${widget.address}",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  _cart(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: ListView.builder(
          itemCount: widget.orderFood.length,
          itemBuilder: (context, index) {
            var item = widget.orderFood.elementAt(index);
            return Row(
              children: [
                SizedBox(
                  width: 90,
                  height: 100,
                  child: Image.network(
                    item.food.image,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.food.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            overflow: TextStyle().overflow,
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(item.food.price.toString() + " VND",
                          style: const TextStyle(fontSize: 16)),
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
                            "${item.quantity}",
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
            );
          }),
    );
  }
}
