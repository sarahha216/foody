import 'package:flutter/material.dart';

class NotificationDetail extends StatefulWidget {
  const NotificationDetail({Key? key}) : super(key: key);

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index){
            return ProductItemList();
          },),
      ),);
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
                  Expanded(child: Text('product.description',maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),)
                ],
              ),
            ),),
          ],
        ),
      ),
    );
  }
}

