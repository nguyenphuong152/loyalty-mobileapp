import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/view/welcome/welcomee/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
        child: SingleChildScrollView(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: size.height * 0.05,
        ),
        SvgPicture.asset(
          "assets/images/Welcome.svg",
          height: size.height * 0.6,
        ),
        SizedBox(
          width: 200,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.white)),
            color: mPrimaryColor,
            textColor: Colors.white,
            onPressed: () {},
            child: Text(
              "SIGN UP".toUpperCase(),
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: mSecondPrimaryColor)),
            color: Colors.white,
            textColor: mSecondPrimaryColor,
            onPressed: () {},
            child: Text(
              "LOGIN".toUpperCase(),
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ],
    )));
  }
}
