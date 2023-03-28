import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/data/handle/auth_service.dart';
import 'package:foody/data/models/category_model.dart';
import 'package:foody/pages/category_details.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:foody/widgets/title_cate.dart';

class CategoriesStore extends StatefulWidget {
  const CategoriesStore({Key? key}) : super(key: key);

  @override
  State<CategoriesStore> createState() => _CategoriesStoreState();
}

class _CategoriesStoreState extends State<CategoriesStore> {

  AuthService authService = AuthService();

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
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapShot){
                  if(snapShot.hasData){
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapShot.data!.docs.length,
                      itemBuilder: (context, index){
                        CategoryModel cate = CategoryModel.fromJson(snapShot.data!.docs[index].data() as Map<String, dynamic>);
                        return Container(
                          width: 150,
                          height: 150,
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () async{
                              Map<String, dynamic>? cateData = await authService.getCateData(cate.id);
                              nextScreen(context, CategoryDetails(cateDetail: cateData!,));
                            },
                            child: ClipRRect(
                              child: Image.network(cate.image),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  else{
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}

// class CategoriesItem extends StatefulWidget {
//   const CategoriesItem({Key? key}) : super(key: key);
//
//   @override
//   State<CategoriesItem> createState() => _CategoriesItemState();
// }
//
// class _CategoriesItemState extends State<CategoriesItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 150,
//       height: 150,
//       alignment: Alignment.centerLeft,
//       child: Image.asset("assets/images/ic_highland.png"),
//     );
//   }
// }