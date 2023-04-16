import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/models/food.dart';

class CartPage extends StatefulWidget {
  final Food? food;

  const CartPage({Key? key, this.food}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref('carts');
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //_cart(),
              // SizedBox(height: 8,),
              // _total(),
            ],
          ),
        ),
      ),
    );
  }

  _info() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Text(
        "Name: ",
        style: TextStyle(
            fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
      ),
    );
  }

  _total() {
    return Container(
      child: Text("Tổng cộng:"),
    );
  }
// _cart(){
//   return FutureBuilder(
//     future: databaseReference.get(),
//     builder: (context, snapshot){
//       if(!snapshot.hasData||snapshot.data==null){
//         return Center(child: Text(''),);
//       }
//       else{
//         cart = Cart.fromMap(snapshot.data!.child(uid).value as Map);
//         return ListView.builder(
//             shrinkWrap: true,
//             physics: const BouncingScrollPhysics(),
//             scrollDirection: Axis.vertical,
//             itemCount: snapshot.data!
//                 .child(uid)
//                 .child('cartItems')
//                 .children
//                 .length,
//             itemBuilder: (context, index){
//               var c = cart.cartItems!.elementAt(index);
//               return SizedBox(
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 100,
//                           height: 100,
//                           child: Image.network( c.food.image),),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(c.food.name,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     overflow: TextStyle().overflow,
//                                   )),
//                               SizedBox(height: 4,),
//                               Text(c.food.price.toString()+ " VND",
//                                   style: const TextStyle(
//                                       fontSize: 16)),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             IconButton(
//                               iconSize: 24,
//                               splashRadius: 15,
//                               color: Colors.grey,
//                               icon: const Icon(Icons.delete_forever),
//                               onPressed: () {
//                                 // databaseReference.child(uid).child('cartItems').child(index.toString()).update({
//                                 //   'quantity': c.quantity++,
//                                 //   'sum' : c.quantity * c.food.price,
//                                 // });
//                               },
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//
//         });
//       }
//     },
//   );
// }
}
