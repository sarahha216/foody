import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/models/restaurant.dart';
import 'package:foody/pages/restaurant_details.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:foody/widgets/title_cate.dart';

class CategoriesStore extends StatefulWidget {
  const CategoriesStore({Key? key}) : super(key: key);

  @override
  State<CategoriesStore> createState() => _CategoriesStoreState();
}

class _CategoriesStoreState extends State<CategoriesStore> {
  late FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference =
      firebaseDatabase.ref("restaurants");

  //AuthService authService = AuthService();

  Future cateFunc() async {
    print('cate');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TitleCate.base(
              titleCate: "Restaurants",
              seeMore: cateFunc,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: FutureBuilder(
                  future: databaseReference.get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.children.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var value = snapshot.data!.children.elementAt(index);
                          Restaurant restaurant = Restaurant(
                            resKey: value.child("resKey").value.toString(),
                            name: value.child("name").value.toString(),
                            logo: value.child("logo").value.toString(),
                            cover: value.child("cover").value.toString(),
                            address: value.child("address").value.toString(),
                            openHours:
                                value.child("openHours").value.toString(),
                            rate: value.child("rate").value as int,
                          );
                          return Container(
                            width: 150,
                            height: 150,
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                nextScreen(
                                    context,
                                    RestaurantDetails(
                                      restaurant: restaurant,
                                    ));
                              },
                              child: ClipRRect(
                                child: Image.network(
                                  restaurant.logo,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
