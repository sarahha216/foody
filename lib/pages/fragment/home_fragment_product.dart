import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foody/widgets/title_cate.dart';

class ProductPopular extends StatefulWidget {
  const ProductPopular({Key? key}) : super(key: key);

  @override
  State<ProductPopular> createState() => _ProductPopularState();
}

class _ProductPopularState extends State<ProductPopular> {
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
          TitleCate(titleCate: "Popular Products",seeMore: productFunc,),
          SizedBox(height: 10,),
          Container(
            child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index){
                  return ProductItem();
                }),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    double contentWidth = min(MediaQuery.of(context).size.width, 700);
    int count = contentWidth ~/ 100;
    double cardSize = (contentWidth - 8.0 * 2 - (count - 1) * 8.0) / count;
    return GestureDetector(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: cardSize,
              height: cardSize,
              child: Image.asset('assets/images/ic_banh_mi.png',
                fit: BoxFit.fill,
              ),
            ),
            // Expanded(
            //   child: Text('dfddsffffffffffffffffffffffffff',
            //     overflow: TextOverflow.ellipsis,
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.only(left: 4),
              width: cardSize-4,
              child: Text('Bánh mì bơ tỏi đặc biệt',
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
              child: Text('18.000 VNĐ',
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


