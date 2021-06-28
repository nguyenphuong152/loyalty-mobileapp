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
const baseUrl = 'http://65.52.36.214/app_dev.php/api';
const webSocket = 'ws://65.52.36.214:8080';

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
