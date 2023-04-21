import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/handle/database_service.dart';
import 'package:foody/data/models/food.dart';
import 'package:foody/widgets/app_bar.dart';

class FavoriteDetail extends StatefulWidget {
  const FavoriteDetail({Key? key}) : super(key: key);

  @override
  State<FavoriteDetail> createState() => _FavoriteDetailState();
}

class _FavoriteDetailState extends State<FavoriteDetail> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref('users');

  late Future _future;

  @override
  void initState() {
    super.initState();
    _future = databaseReference.child(uid).child('favorite').get();
  }

  Future<void> refreshList() async {
    setState(() {
      _future = databaseReference.child(uid).child('favorite').get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget.search(context: context),
        body: Container(
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Text(''),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.children.length,
                    itemBuilder: (context, index) {
                      Food food = Food.fromMap(snapshot.data?.children
                          .elementAt(index)
                          .value as Map);
                      return ProductItemList(food);
                    });
              }
            },
          ),
        ));
  }

  ProductItemList(Food food) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          print(FirebaseAuth.instance.currentUser!);
        },
        child: Container(
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  food.image,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(food.name,
                          style: TextStyle(
                            fontSize: 16,
                            overflow: TextStyle().overflow,
                          )),
                    ],
                  ),
                ),
              ),
              IconButton(
                iconSize: 24,
                splashRadius: 15,
                color: Colors.green,
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  DatabaseService databaseService = DatabaseService();
                  databaseService.removeFavorite(foodKey: food.foodKey);
                  refreshList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ProductItemList extends StatelessWidget {
//   final Food food;
//
//   const ProductItemList({Key? key, required this.food}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: GestureDetector(
//         onTap: () {
//           print(FirebaseAuth.instance.currentUser!);
//         },
//         child: Container(
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 100,
//                 height: 100,
//                 child: Image.network(
//                   food.image,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               SizedBox(
//                 width: 5,
//               ),
//               Expanded(
//                 child: SizedBox(
//                   height: 100,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(food.name,
//                           style: TextStyle(
//                             fontSize: 16,
//                             overflow: TextStyle().overflow,
//                           )),
//                     ],
//                   ),
//                 ),
//               ),
//               IconButton(
//                 iconSize: 24,
//                 splashRadius: 15,
//                 color: Colors.green,
//                 icon: const Icon(
//                   Icons.favorite,
//                   color: Colors.red,
//                 ),
//                 onPressed: () {
//                   DatabaseService databaseService = DatabaseService();
//                   databaseService.removeFavorite(foodKey: food.foodKey);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
