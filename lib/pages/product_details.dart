import 'package:flutter/material.dart';
import 'package:foody/data/models/product_model.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel productData;
  const ProductDetails({Key? key, required this.productData}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Text(
        widget.productData.image,
      ),
    );
  }
}
