import 'package:flutter/material.dart';
import 'package:foody/widgets/title_cate.dart';

class CategoriesStore extends StatefulWidget {
  const CategoriesStore({Key? key}) : super(key: key);

  @override
  State<CategoriesStore> createState() => _CategoriesStoreState();
}

class _CategoriesStoreState extends State<CategoriesStore> {
  Future cateFunc() async{
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
            TitleCate.base(titleCate: "Categories",seeMore: cateFunc,),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index){
                  return CategoriesItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesItem extends StatefulWidget {
  const CategoriesItem({Key? key}) : super(key: key);

  @override
  State<CategoriesItem> createState() => _CategoriesItemState();
}

class _CategoriesItemState extends State<CategoriesItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      alignment: Alignment.centerLeft,
      child: Image.asset("assets/images/ic_highland.png"),
    );
  }
}