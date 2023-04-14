import 'package:flutter/material.dart';
import 'package:foody/data/db_helper.dart';
import 'package:foody/data/models/food.dart';
import 'package:foody/data/models/food_basket.dart';
import 'package:foody/pages/cart_page.dart';
import 'package:foody/widgets/button_continue_widget.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:foody/widgets/widgets.dart';

class ProductDetails extends StatefulWidget {
  final Food food;
  const ProductDetails({Key? key, required this.food}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late DBHelper dbHelper;
  List<FoodBasket>? dataList;
  bool _isLoading = false;

  @override
  void initState() {
    dbHelper = DBHelper();
    loadData();
    super.initState();
  }
  loadData() async{
    dataList = await dbHelper.getFoodList();
  }
  Future<void> _addCart() async{
      var food = widget.food;
      await dbHelper.insertChat(
          FoodBasket(
              quantity: 1,
              sum: food.price.toDouble(),
              name: food.name,
              image: food.image,
              price: food.price,
              rate: food.rate,
              resKey: food.resKey,
              foodKey: food.foodKey)
      );
      loadData();

  }



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
                 // var food = widget.food;
                 // FoodBasket foodBasket = FoodBasket(
                 //     quantity: 1,
                 //     sum: 1,
                 //     name: food.name,
                 //     image: food.image,
                 //     price: food.price,
                 //     rate: food.rate,
                 //     resKey: food.resKey,
                 //     foodKey: food.foodKey);
                 //
                 // nextScreen(context, CartPage(foodBasket: foodBasket,));
                 _addCart();
                 print('ok');
                 nextScreen(context, CartPage());
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
