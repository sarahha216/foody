import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/handle/auth_service.dart';
import 'package:foody/data/models/product_model.dart';
import 'package:foody/pages/product_details.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:foody/widgets/title_cate.dart';

class ProductPopular extends StatefulWidget {
  const ProductPopular({Key? key}) : super(key: key);

  @override
  State<ProductPopular> createState() => _ProductPopularState();
}

class _ProductPopularState extends State<ProductPopular> {
  AuthService authService = AuthService();
  Future productFunc() async{
    print('product');
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TitleCate.base(titleCate: "Popular Products",seeMore: productFunc,),
          SizedBox(height: 10,),
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapShot){
                if(snapShot.hasData){
                  return GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapShot.data!.docs.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index){
                        // ProductModel product = ProductModel.fromJson(snapShot.data!.docs[index].data() as Map<String, dynamic>);
                        var value = snapShot.data!.docs[index];
                        ProductModel product = ProductModel(id: value['id'], title: value['title'], description: value['description'], image: value['image'], price: value['price'].toDouble());

                        return _productItem(product);
                      });
                }
                else{
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ),
        ],
      ),
    );
  }
  _productItem(ProductModel productModel){
    double contentWidth = min(MediaQuery.of(context).size.width, 700);
    int count = contentWidth ~/ 100;
    double cardSize = (contentWidth - 8.0 * 2 - (count - 1) * 8.0) / count;
    return GestureDetector(
      onTap: () async{
        ProductModel? productData = await authService.getProductData(productModel.id);
        nextScreen(context, ProductDetails(productData: productData!,));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: cardSize,
              height: cardSize,
              child: Image.network(productModel.image,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 4),
              width: cardSize-4,
              child: Text(productModel.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 4),
              width: cardSize-4,
              child: Text(productModel.price.toString() + " VND",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ProductItem extends StatefulWidget {
//   const ProductItem({Key? key}) : super(key: key);
//
//   @override
//   State<ProductItem> createState() => _ProductItemState();
// }
//
// class _ProductItemState extends State<ProductItem> {
//   @override
//   Widget build(BuildContext context) {
//     double contentWidth = min(MediaQuery.of(context).size.width, 700);
//     int count = contentWidth ~/ 100;
//     double cardSize = (contentWidth - 8.0 * 2 - (count - 1) * 8.0) / count;
//     return GestureDetector(
//       onTap: (){},
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: cardSize,
//               height: cardSize,
//               child: Image.asset('assets/images/ic_banh_mi.png',
//                 fit: BoxFit.fill,
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(left: 4),
//               width: cardSize-4,
//               child: Text('Bánh mì bơ tỏi đặc biệt',
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(left: 4),
//               width: cardSize-4,
//               child: Text('18.000 VNĐ',
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


