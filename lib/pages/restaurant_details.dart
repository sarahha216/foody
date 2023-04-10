import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/models/restaurant.dart';
import 'package:foody/widgets/widgets.dart';

import '../widgets/navigator_widget.dart';

class RestaurantDetails extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantDetails({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              Container(
                width: size.width,
                height: 150,
                child: Image.network(widget.restaurant.cover,
                  fit: BoxFit.fill,),
              ),
              _cover(context, size),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height,
              //   child: StreamBuilder<QuerySnapshot>(
              //   stream: FirebaseFirestore.instance.collection('categories')
              //       .doc(widget.cateDetail.id).collection('menu').snapshots(),
              //   builder: (context, AsyncSnapshot<QuerySnapshot> snapShot){
              //     if(snapShot.hasData){
              //       return ListView.builder(
              //           itemCount: snapShot.data!.docs.length,
              //           itemBuilder: (context, index){
              //             var value = snapShot.data!.docs[index];
              //             ProductModel product = ProductModel(id: value['foodKey'], title: value['title'], description: value['description'], image: value['image'], price: value['price'].toDouble(), resKey: value['resKey']);
              //             return GestureDetector(
              //               onTap: (){
              //                 nextScreen(context, ProductDetails(productData: product,));
              //               },
              //               child: Container(
              //                 color: Colors.grey.shade200,
              //                 child: Row(
              //                   children: [
              //                     Container(
              //                         width: 100,
              //                         height: 100,
              //                         child: Image.network(product.image, fit: BoxFit.fill,)),
              //                     SizedBox(width: 8,),
              //                     Expanded(child: Text(product.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),)),
              //                     Text(product.price.toString() + " VND", style: TextStyle(color: Colors.red),),
              //                   ],
              //                 ),
              //               ),
              //             );
              //           });
              //     }
              //     else{
              //       return Text('');
              //     }
              //   }),
              // ),

            ],
          ),
        ),
      ),
    );
  }

  _cover(BuildContext context, Size size){
    return Container(
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8,),
            TextWidget.name21(text: widget.restaurant.name),
          ],
        ),
      ),
    );
  }
}