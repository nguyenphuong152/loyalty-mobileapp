import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const mPrimaryColor = Color(0xFF7579e7);
const mSecondPrimaryColor = Color(0xFF2C2C2C);
const mSecondaryColor = Color(0xFFEAEAEA);
const mDividerColor = Color(0xFF14274E);
const mLinear = Color(0xFF848ccf);

const mFontSize = 16.0;
const mFontTitle = 18.0;
const mFontListTile = 14.0;
const baseUrl = 'http://20.97.50.91/app_dev.php/api';
const webSocket = 'ws://20.97.50.91:8080';

const title1 = 34.0;
const title2 = 22.0;
const title3 = 20.0;
const body = 17.0;
const subhead = 15.0;
const footnote = 13.0;
const caption1 = 12.0;
const caption2 = 11.0;

const space_height = 6.0;

TextStyle dayStyle(FontWeight fontWeight) {
  return TextStyle(color: Colors.black, fontWeight: fontWeight);
}

/// Function Format DateTime to String with layout string
String formatNumber(double value) {
  final f = new NumberFormat("#,###", "vi_VN");
  return f.format(value);
}

class Constants {
  static final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );

  static final BoxShadow cardShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 1,
    blurRadius: 7,
    offset: Offset(0, 3), // changes position of shadow
  );

  static final TextStyle titleService = TextStyle(
      fontSize: mFontListTile,
      color: mDividerColor,
      fontWeight: FontWeight.w400);

  static final TextStyle titleProductDetail =
      TextStyle(fontSize: footnote, color: Colors.grey[500]);

  static final TextStyle contentProductDetail =
      TextStyle(fontSize: footnote, color: Colors.black);
}
