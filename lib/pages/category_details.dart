import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/models/category_model.dart';
import 'package:foody/data/models/product_model.dart';
import 'package:foody/pages/product_details.dart';

import '../widgets/navigator_widget.dart';

class CategoryDetails extends StatefulWidget {
  final CategoryModel cateDetail;
  const CategoryDetails({Key? key, required this.cateDetail}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Details"),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: <Widget> [
                  Image.network(widget.cateDetail.image,
                    fit: BoxFit.fill,
                    width: size.width * 0.5 ,),
                  Container(
                    child: Text(widget.cateDetail.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('categories')
                        .doc(widget.cateDetail.id).collection('menu').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapShot){
                      if(snapShot.hasData){
                        return ListView.builder(
                            itemCount: snapShot.data!.docs.length,
                            itemBuilder: (context, index){
                              var value = snapShot.data!.docs[index];
                              ProductModel product = ProductModel(id: value['foodKey'], title: value['title'], description: value['description'], image: value['image'], price: value['price'].toDouble(), resKey: value['resKey']);
                              return GestureDetector(
                                onTap: (){
                                  nextScreen(context, ProductDetails(productData: product,));
                                },
                                child: Container(
                                  color: Colors.grey.shade200,
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 100,
                                          height: 100,
                                          child: Image.network(product.image, fit: BoxFit.fill,)),
                                      SizedBox(width: 8,),
                                      Expanded(child: Text(product.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),)),
                                      Text(product.price.toString() + " VND", style: TextStyle(color: Colors.red),),
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
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}