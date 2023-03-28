import 'package:flutter/material.dart';
import 'package:foody/data/models/product_model.dart';
import 'package:foody/widgets/button_continue_widget.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel productData;
  const ProductDetails({Key? key, required this.productData}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
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
           child: Column(
             children: <Widget> [
               Image.network(widget.productData.image,
                 fit: BoxFit.fill,
                 width: size.width * 0.5 ,),
               Container(
                 child: Text(widget.productData.title,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                     fontSize: 24,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
               Container(
                 width: size.width,
                 height: 150,
                 // decoration: BoxDecoration(
                 //     border: Border.all(color: Colors.blueAccent)
                 // ),
                 child: Text(widget.productData.description,
                   overflow: TextOverflow.clip,
                   style: TextStyle(
                     fontSize: 16,
                   ),
                 ),
               ),
               Container(
               child: ContinueButtonWidget.base(label: 'Add to Cart', voidCallback: (){

               }),
               ),
             ],
           ),
         ),
       ),
      ),
    );
  }
}
