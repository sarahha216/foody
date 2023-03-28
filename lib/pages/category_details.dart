import 'package:flutter/material.dart';
import 'package:foody/data/models/category_model.dart';

class CategoryDetails extends StatefulWidget {
  final CategoryModel cateDetail;
  const CategoryDetails({Key? key, required this.cateDetail }) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Text(
        widget.cateDetail.image,
      ),
    );
  }
}
