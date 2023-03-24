import 'package:flutter/material.dart';
import 'package:foody/pages/home_page.dart';
import 'package:foody/pages/pages.dart';
import 'package:foody/widgets/navigator_widget.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    new Future.delayed(new Duration(seconds: 3),(){
      nextScreenRemove(context, SignInPage());
    });
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 5,
            ),
            SizedBox(height: 15,),
            Text("Loading...",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),)
          ],
        ),
      ),
    );
  }
}