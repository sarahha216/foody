import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/models/food.dart';
import 'package:foody/data/models/restaurant.dart';
import 'package:foody/pages/product_details.dart';
import 'package:foody/widgets/widgets.dart';

import '../widgets/navigator_widget.dart';

class RestaurantDetails extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantDetails({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  late FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference =
  firebaseDatabase.ref("restaurants").child(widget.restaurant.resKey).child("menu");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Details"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 150,
              child: Image.network(widget.restaurant.cover,
                fit: BoxFit.fill,),
            ),
            _cover(context, size),
            _menu(context, size),
          ],
        ),
      ),
    );
  }

  _cover(context, Size size){
    return Container(
      width: size.width,
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.green),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8,),
            TextWidget.name21(text: widget.restaurant.name),
            SizedBox(height: 8,),
            TextWidget.name16(text: widget.restaurant.address),
            SizedBox(height: 8,),
            TextWidget.name16(text: widget.restaurant.openHours),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
  _menu(context, Size size){
    return Container(
      child: FutureBuilder(
      future: databaseReference.get(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.children.length,
              itemBuilder: (context, index){
                var value = snapshot.data!.children.elementAt(index);
                Food food = Food(
                    name: value.child("name").value.toString(),
                    image: value.child("image").value.toString(),
                    description: value.child("description").value.toString(),
                    price: value.child("price").value as int,
                    rate: value.child("rate").value as int,
                    resKey: value.child("resKey").value.toString(),
                    foodKey: value.child("foodKey").value.toString());
                return GestureDetector(
                  onTap: (){
                    nextScreen(context, ProductDetails(food: food));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                            width: 100,
                            height: 100,
                            child: Image.network(food.image, fit: BoxFit.fill,)),
                        SizedBox(width: 8,),
                        Expanded(child: Text(food.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),)),
                        TextWidget().default_price(text: food.price.toString(), fontSize: 18),
                      ],
                    ),
                  ),
                );
              });
        }
        else{
          return Text('');
        }
      }),
    );
  }
}