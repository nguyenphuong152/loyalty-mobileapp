import 'package:flutter/material.dart';

const mPrimaryColor = Color(0xFF7579e7);
const mSecondPrimaryColor = Color(0xFF2C2C2C);
const mSecondaryColor = Color(0xFFEAEAEA);
const mDividerColor = Color(0xFF14274E);
const mLinear = Color(0xFF848ccf);

const mFontSize = 16.0;
const mFontTitle = 18.0;
const mFontListTile = 14.0;
const baseUrl = 'http://70.37.66.47/app_dev.php/api';
const webSocket = 'ws://70.37.66.47:8080';

TextStyle dayStyle(FontWeight fontWeight) {
  return TextStyle(color: Colors.black, fontWeight: fontWeight);
}

class Constants {
  static final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );

  static final TextStyle titleService = TextStyle(
      fontSize: mFontListTile,
      color: mDividerColor,
      fontWeight: FontWeight.w400);

  static final TextStyle titleProductDetail = TextStyle(
      fontSize: mFontListTile,
      color: Colors.black87,
      fontWeight: FontWeight.w500);

  static final TextStyle contentProductDetail = TextStyle(
      fontSize: mFontSize, color: Colors.black, fontWeight: FontWeight.w700);
}
