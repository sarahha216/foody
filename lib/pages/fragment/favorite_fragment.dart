import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteDetail extends StatefulWidget {
  const FavoriteDetail({Key? key}) : super(key: key);

  @override
  State<FavoriteDetail> createState() => _FavoriteDetailState();
}

class _FavoriteDetailState extends State<FavoriteDetail> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index){
            return ProductItemList();
          }),
    ));
  }
}

class ProductItemList extends StatefulWidget {
  const ProductItemList({Key? key}) : super(key: key);

  @override
  State<ProductItemList> createState() => _ProductItemListState();
}

class _ProductItemListState extends State<ProductItemList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          print(FirebaseAuth.instance.currentUser!);
        },
        child: Container(
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/images/ic_black_coffee.png', fit: BoxFit.fill,),
              ),
              SizedBox(width: 5,),
              Expanded(child: SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('product.title'),
                    Expanded(child: Text('product.description', maxLines: 5, overflow: TextOverflow.ellipsis,),),
                  ],
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}

