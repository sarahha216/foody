import 'package:flutter/material.dart';
import 'package:foody/pages/fragment/notification_fragment.dart';
import 'package:foody/widgets/navigator_widget.dart';

class AppBarWidget {
  static search({required BuildContext context}) {
    return AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search product",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                nextScreen(context, NotificationDetail());
              },
              child: Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.all(10),
                child: Icon(Icons.notifications_none),
              ),
            ),
          ],
        ));
  }

  static info({required BuildContext context, VoidCallback? voidCallback}) {
    return AppBar(
      backgroundColor: Colors.green,
      elevation: 0,
      centerTitle: true,
      title: Row(
        children: [
          Expanded(
            child: Text(
              "Account Info",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          GestureDetector(
            onTap: voidCallback,
            child: Text(
              "Save",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
