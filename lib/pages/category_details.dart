import 'package:flutter/material.dart';

class CategoryDetails extends StatefulWidget {
  final Map<String, dynamic> cateDetail;
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
      ),
      body: Text(
        widget.cateDetail.toString(),
      ),
    );
  }
}
