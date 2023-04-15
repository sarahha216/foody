import 'package:flutter/material.dart';
import 'package:foody/data/db_helper.dart';
import 'package:foody/data/models/cart.dart';
import 'package:foody/widgets/widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late DBHelper dbHelper;
  List<Cart>? dataList;

  @override
  void initState() {
    dbHelper = DBHelper();
    loadData();
    super.initState();
  }
  loadData() async{
    dataList = await dbHelper.getFoodList();
  }

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
              _cart(),
              SizedBox(height: 8,),
              _total(),
            ],
          ),
        ),
      ),
    );
  }
  _info(){
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Text("Name: ", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),),
    );
  }
  _total(){
    return Container(
        child: Text("Tổng cộng:" ),
    );
  }
  _cart(){
    return FutureBuilder(
      future: dbHelper.getFoodList(),
      builder: (context, AsyncSnapshot<List<Cart>> snapshot){
        if(!snapshot.hasData||snapshot.data==null){
          return Center(child: Text('No item'),);
        }
        else if(snapshot.data?.length==0) {
          return Center(
            child: Text('No item'),
          );
        }
        else{
          return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return SizedBox(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network( snapshot.data![index].foodImage),),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].foodName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      overflow: TextStyle().overflow,
                                    )),
                                SizedBox(height: 4,),
                                Text(snapshot.data![index].foodPrice.toString() + " VND",
                                    style: const TextStyle(
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                iconSize: 24,
                                splashRadius: 15,
                                color: Colors.green,
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if(snapshot.data![index].quantity > 1){
                                      dbHelper.update(snapshot.data![index].id!, snapshot.data![index].quantity-1, snapshot.data![index].foodPrice.toDouble());
                                    }
                                  });
                                },
                              ),
                              Text(
                                snapshot.data![index].quantity.toString(),
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                iconSize: 24,
                                splashRadius: 15,
                                color: Colors.green,
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    dbHelper.update(snapshot.data![index].id!, snapshot.data![index].quantity+1, snapshot.data![index].foodPrice.toDouble());
                                  });
                                },
                              ),
                              IconButton(
                                iconSize: 24,
                                splashRadius: 15,
                                color: Colors.grey,
                                icon: const Icon(Icons.delete_forever),
                                onPressed: () {
                                  setState(() {
                                    dbHelper.delete(snapshot.data![index].id!);
                                    loadData();
                                    snapshot.data!.remove(snapshot.data![index].id!);
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );

          });
        }
      },
    );
  }
}


// class CartPage extends StatelessWidget {
//   const CartPage({Key? key,}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Cart Details"),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 _info(),
//                 SizedBox(height: 8,),
//                 _cart(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   _info(){
//     return SizedBox(
//       width: double.infinity,
//       child: Text("Name: ", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),),
//     );
//   }
//   _cart(){
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   SizedBox(
//                       width: 100,
//                       height: 100,
//                       child: Image.asset("assets/images/dish.png"),),
//                   SizedBox(width: 4,),
//                   Column(
//                     children: [
//                       Text('foodBasket!.name',
//                           style: TextStyle(
//                               fontSize: 16,
//                               overflow: TextStyle().overflow,
//                           )),
//                       Text('foodBasket!.name',
//                           style: const TextStyle(
//                               fontSize: 16)),
//                       // TextWidget()
//                       //     .priceBasket(text: 'foodBasket!.price.toString()'),
//                     ],
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   // Text(
//                   //   "1",
//                   //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   // ),
//                   // SizedBox(width: 14,),
                  // IconButton(
                  //   iconSize: 24,
                  //   splashRadius: 15,
                  //   color: Colors.grey,
                  //   icon: const Icon(Icons.delete_forever),
                  //   onPressed: () {},
                  // )
//                   IconButton(
//                     iconSize: 24,
//                     splashRadius: 15,
//                     color: Colors.green,
//                     icon: const Icon(Icons.remove),
//                     onPressed: () {},
//                   ),
//                   Text(
//                     "1",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   IconButton(
//                     iconSize: 24,
//                     splashRadius: 15,
//                     color: Colors.green,
//                     icon: const Icon(Icons.add),
//                     onPressed: () {},
//                   )
//                 ],
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
