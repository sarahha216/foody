import 'package:flutter/material.dart';
import 'package:foody/pages/fragment/home_fragment_restaurant.dart';
import 'package:foody/pages/fragment/home_fragment_product.dart';

class HomeDetail extends StatefulWidget {
  const HomeDetail({Key? key}) : super(key: key);

  @override
  State<HomeDetail> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: SingleChildScrollView(
      child: Column(
        children: [
          CategoriesStore(),
          ProductPopular(),
        ],
      ),
    ),);
  }
}