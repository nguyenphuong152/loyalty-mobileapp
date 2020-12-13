import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loyalty_app/constant.dart';

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Loyalty ",
            style: TextStyle(color: mSecondPrimaryColor, fontSize: 18),
          ),
          TextSpan(
            text: "App",
            style: TextStyle(color: mPrimaryColor, fontSize: 18),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: SvgPicture.asset("assets/icons/bell.svg"),
        onPressed: () {},
      ),
    ],
  );
}
