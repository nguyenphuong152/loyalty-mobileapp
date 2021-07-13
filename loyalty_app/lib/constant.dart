import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_app/providers/payment.dart';
import 'package:sprintf/sprintf.dart';

const mPrimaryColor = Color(0xFF7579e7);
const mSecondPrimaryColor = Color(0xFF2C2C2C);
const mSecondaryColor = Color(0xFFEAEAEA);
const mDividerColor = Color(0xFF14274E);
const mLinear = Color(0xFF848ccf);

const mFontSize = 16.0;
const mFontTitle = 18.0;
const mFontListTile = 14.0;
const baseUrl = 'http://70.37.98.42/app_dev.php/api';
const webSocket = 'ws://70.37.98.42:8080';

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

///zalopay

String formatDateTime(DateTime dateTime, String layout) {
  return DateFormat(layout).format(dateTime).toString();
}

int transIdDefault = 1;
String getAppTransId() {
  if (transIdDefault >= 100000) {
    transIdDefault = 1;
  }

  transIdDefault += 1;
  var timeString = formatDateTime(DateTime.now(), "yyMMdd_hhmmss");

  return sprintf("%s%06d", [timeString, transIdDefault]);
}

String getBankCode() => "zalopayapp";

String getDescription(String apptransid) =>
    "Merchant Demo thanh toán cho đơn hàng  #$apptransid";

String getMacCreateOrder(String data) {
  var hmac2 = new Hmac(sha256, utf8.encode(ZaloPayConfig.key1));
  var hmac = hmac2;
  return hmac.convert(utf8.encode(data)).toString();
}

class Endpoints {
  static final String createOrderUrl =
      "https://sb-openapi.zalopay.vn/v2/create";
}
