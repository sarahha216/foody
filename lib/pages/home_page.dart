import 'package:flutter/material.dart';
import 'package:foody/pages/fragment/account_detail.dart';
import 'package:foody/pages/fragment/favorite_fragment.dart';
import 'package:foody/pages/fragment/home_fragment.dart';
import 'package:foody/pages/fragment/notification_fragment.dart';

import 'header/home_header.dart';
import 'header/menu_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectIndex = 0;
  var flag = true;

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      HomeDetail(),
      FavoriteDetail(),
      NotificationDetail(),
      AccountDetail(),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: flag?HomeHeader():MenuHeader(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectIndex,
        onTap: (index){
          setState(() {
            selectIndex = index;
            if(selectIndex!=3){
              flag=true;
            }
            else{
              flag=false;
            }
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications),label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: "Account"),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10,),
            screen[selectIndex]
          ],
        ),
      ),
    );
  }
}