import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButtonWidget{
  static base(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 48,
          width: 48,
          padding: EdgeInsets.all(8.0),
          child: SvgPicture.asset("assets/svg/facebook.svg"),

        ),
        Container(
          height: 48,
          width: 48,
          padding: EdgeInsets.all(8.0),
          child: SvgPicture.asset("assets/svg/google.svg"),

        ),
        Container(
          height: 48,
          width: 48,
          padding: EdgeInsets.all(8.0),
          child: SvgPicture.asset("assets/svg/twitter.svg"),

        ),
      ],
    );
  }
}