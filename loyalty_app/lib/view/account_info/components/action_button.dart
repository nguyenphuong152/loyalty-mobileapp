import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';

class ActionButton extends StatefulWidget {
  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      color: mSecondaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: mPrimaryColor)),
            color: mPrimaryColor,
            textColor: Colors.white,
            child: Text('Chỉnh sửa thông tin',
                style: TextStyle(
                    fontSize: mFontSize, fontWeight: FontWeight.w400)),
            onPressed: () {},
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.deepOrange)),
            color: Colors.deepOrange,
            textColor: Colors.white,
            child: Text('Thay đổi mật khẩu',
                style: TextStyle(
                    fontSize: mFontSize, fontWeight: FontWeight.w400)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
