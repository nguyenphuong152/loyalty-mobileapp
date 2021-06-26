import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/view/datepicker/components/body.dart';

class DatePickerScreen extends StatefulWidget {
  @override
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mPrimaryColor,
      // appBar: AppBar(
      //   elevation: 0,
      //   leading: IconButton(
      //       icon: Icon(
      //         Icons.arrow_back_ios,
      //         color: Colors.white,
      //         size: 16,
      //       ),
      //       onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
      //           "/home", (Route<dynamic> route) => false)),
      //   backgroundColor: mPrimaryColor,
      //   centerTitle: true,
      //   title: Text(
      //     'Đặt lịch bảo trì',
      //     style: TextStyle(
      //       fontSize: mFontSize,
      //       color: Colors.white,
      //       fontWeight: FontWeight.w700,
      //     ),
      //   ),
      // ),
      body: Body(),
    );
  }
}
