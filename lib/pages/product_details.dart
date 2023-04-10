import 'package:flutter/material.dart';
import 'package:foody/data/models/food.dart';
import 'package:foody/widgets/button_continue_widget.dart';
import 'package:foody/widgets/widgets.dart';

class ProductDetails extends StatefulWidget {
  final Food food;
  const ProductDetails({Key? key, required this.food}) : super(key: key);

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
       child: SizedBox(
         height: MediaQuery.of(context).size.height,
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             children: [
               Image.network(widget.food.image,
                 fit: BoxFit.fill,
                 height: 200,
                 width: size.width * 0.5 ,),
               SizedBox(height: 8,),
               TextWidget.name(text: widget.food.name),
               SizedBox(height: 8,),
               TextWidget().price(
                 text: widget.food.price.toString(),
               ),
               SizedBox(height: 8,),
               Expanded(
                 child: Container(
                   width: size.width,
                   height: 150,
                   child: Text(widget.food.description??"",
                     overflow: TextOverflow.clip,
                     style: TextStyle(
                       fontSize: 18,
                     ),
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
