import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/handle/database_service.dart';
import 'package:foody/data/models/food.dart';
import 'package:foody/pages/cart_page.dart';
import 'package:foody/pages/fragment/home_fragment_restaurant.dart';
import 'package:foody/pages/product_item.dart';
import 'package:foody/widgets/app_bar.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:foody/widgets/title_cate.dart';

class HomeDetail extends StatefulWidget {
  const HomeDetail({Key? key}) : super(key: key);

  @override
  State<HomeDetail> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference refFood = firebaseDatabase.ref("foods");

  DatabaseService myFunction = DatabaseService();
  int quantity = 0;

  late Future _future;
  List<Food> foodList = [];
  List<Food>? searchList;

  final searchString = TextEditingController();

  @override
  void initState() {
    getAllProduct();
    loadCount();
    super.initState();
  }

  @override
  void dispose() {
    searchString.dispose();
    super.dispose();
  }

  Future<void> loadCount() async {
    quantity = await myFunction.loadCounter();
    setState(() {});
    print(quantity);
  }

  Future<void> getAllProduct() async {
    DataSnapshot snapshot = await refFood.get();
    if (snapshot.value != null) {
      Map map = snapshot.value as Map;
      foodList = map.entries
          .map((e) => Food(
              name: e.value['name'],
              image: e.value['image'],
              price: e.value['price'],
              description: e.value['description'],
              rate: e.value['rate'],
              resKey: e.value['resKey'],
              foodKey: e.value['foodKey']))
          .toList();
    } else {
      foodList = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.search(
          controller: searchString,
          context: context,
          onChanged: (s) {
            setState(() {
              searchList = foodList
                  .where((element) =>
                      element.name.toLowerCase().contains(s.toLowerCase()))
                  .toList();
            });
          }),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            CategoriesStore(),
            _ProductPopular(),
          ],
        ),
      ),
      floatingActionButton: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              FloatingActionButton(
                onPressed: () {
                  nextScreen(context, const CartPage());
                },
                child: const Icon(Icons.shopping_cart),
              ),
              Container(
                margin: const EdgeInsets.only(left: 38),
                alignment: Alignment.center,
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: Text(
                  "$quantity",
                  style: const TextStyle(color: Colors.green),
                ),
              )
            ],
          )),
    );
  }

  _ProductPopular() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TitleCate.base(
              titleCate: "Popular Products",
              seeMore: () {},
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: searchString.text.isNotEmpty
                        ? searchList!.length
                        : foodList.length,
                    physics: BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      // mainAxisExtent: 256,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      var value;
                      if (searchString.text.isNotEmpty) {
                        value = searchList![index];
                      } else {
                        value = foodList[index];
                      }
                      if (value != null) {
                        Food food = Food(
                            name: value.name,
                            image: value.image,
                            description: value.description,
                            price: value.price as int,
                            rate: value.rate as int,
                            resKey: value.resKey,
                            foodKey: value.foodKey);
                        return ProductItem(
                          food: food,
                        );
                      } else {
                        return Center(
                          child: Text(""),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
