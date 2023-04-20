import 'package:flutter/material.dart';
import 'package:foody/data/handle/function.dart';
import 'package:foody/pages/cart_page.dart';
import 'package:foody/pages/fragment/home_fragment_product.dart';
import 'package:foody/pages/fragment/home_fragment_restaurant.dart';
import 'package:foody/widgets/navigator_widget.dart';

class HomeDetail extends StatefulWidget {
  const HomeDetail({Key? key}) : super(key: key);

  @override
  State<HomeDetail> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  MyFunction myFunction = MyFunction();
  int quantity = 0;

  @override
  void initState() {
    loadCount();
    super.initState();
  }

  loadCount() async {
    quantity = await myFunction.loadData();
    setState(() {});
    print(quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              CategoriesStore(),
              ProductPopular(),
            ],
          ),
        ),
        Positioned(
          right: 16,
          bottom: 0,
          child: Container(
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
        )
      ],
    );
  }
}
