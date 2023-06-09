import 'package:flutter/material.dart';
import 'package:foody/data/handle/shared_preference.dart';
import 'package:foody/pages/pages.dart';
import 'package:foody/widgets/navigator_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      SharedPrefs().getLoginStatus().then((data) {
        print(data);
        if (data) {
          nextScreenRemove(context, HomePage());
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, SignInPage.route, (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              height: 15,
            ),
            Text(
              "Loading...",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
