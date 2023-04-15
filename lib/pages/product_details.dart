import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/models/cart.dart';
import 'package:foody/data/models/cart_item.dart';
import 'package:foody/data/models/food.dart';
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
  bool _isLoading = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref('carts');


  _addCart() async {
    setState(() {
      _isLoading = true;
    });
    DataSnapshot snapshot = await databaseReference.get();
    bool flag = false;
    if (snapshot.exists) {
      if (!snapshot.child(uid).hasChild('cartItems')) {
        List<CartItem>? cartItems = List.empty(growable: true);
        CartItem cartItem = CartItem(
            quantity: 1,
            sum: widget.food.price,
            food: widget.food,
            id: generateRandomString());
        cartItems.add(cartItem);
        Cart cart = Cart(
          totalQuantity: cartItem.quantity,
          totalPrice: cartItem.sum,
          cartItems: cartItems,
          userID: uid,
        );
        Map<String, dynamic> map = cart.toMap();
        try {
          await FirebaseDatabase.instance
              .ref('carts')
              .child(uid)
              .set(map)
              .then((value) {
            print("new");
            nextScreen(
                context,
                CartPage(
                  cart: cart,
                  food: widget.food,
                ));
          });
        } on FirebaseException catch (e) {
          showSnackBar(context, Colors.red, e.message.toString());
        }
        setState(() {
          _isLoading = true;
        });
      } else {
        Cart cart = Cart.fromMap(snapshot.child(uid).value as Map);
        int totalPrice = 0;
        int totalQuantity = 0;
        for (int j = 0;
        j < snapshot.child(uid).child('cartItems').children.length;
        j++) {
          var c = cart.cartItems![j];
          totalPrice += c.sum;
          totalQuantity += c.quantity;
        }
        for (int j = 0;
        j < snapshot.child(uid).child('cartItems').children.length;
        j++) {
          var q = snapshot.child(uid).child('cartItems').child(j.toString());
          var c = cart.cartItems![j];
          print(widget.food.foodKey);
          print(
              "firebase: " + q.child('food').child('foodKey').value.toString());
          if (q.child('food').child('foodKey').value.toString() ==
              widget.food.foodKey) {
            print("trung");
            flag = true;
            totalPrice += c.food.price;
            totalQuantity++;
            q.child('quantity').ref.set(c.quantity + 1);
            q.child('sum').ref.set(c.food.price * (c.quantity + 1));
            snapshot.child(uid).child('totalPrice').ref.set(totalPrice);
            snapshot.child(uid).child('totalQuantity').ref.set(totalQuantity);
            nextScreen(
                context,
                CartPage(
                  cart: cart,
                  food: widget.food,
                ));
          }
          setState(() {
            _isLoading = true;
          });
        }
        if (!flag) {
          print("khong trung");
          CartItem cartItem = CartItem(
              quantity: 1,
              sum: widget.food.price,
              food: widget.food,
              id: generateRandomString());
          cart.cartItems!.add(cartItem);
          cart.totalQuantity = totalQuantity + 1;
          cart.totalPrice = totalPrice + widget.food.price;
          print(cart.totalPrice);
          print(cart.totalQuantity);
          Map<String, dynamic> map = cart.toMap();
          try {
            await FirebaseDatabase.instance
                .ref('carts')
                .child(uid)
                .set(map)
                .then((value) => {
              nextScreen(
                  context,
                  CartPage(
                    cart: cart,
                    food: widget.food,
                  ))
            });
          } on FirebaseAuthException catch (e) {
            showSnackBar(context, Colors.red, e.message.toString());
          }
          setState(() {
            _isLoading = true;
          });
        }
      }
    } else {
      return const Text("No data");
    }
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
                 if(_isLoading==true){
                   Center(
                     child: CircularProgressIndicator(),
                   );
                 }
                 else{
                   _addCart();
                   print('add to cart');
                 }
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
