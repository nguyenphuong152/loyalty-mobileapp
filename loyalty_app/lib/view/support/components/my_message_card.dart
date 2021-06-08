import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/chat/chat_message_model.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  const MyMessageCard({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.fromLTRB(50, 0, 0, 12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: mPrimaryColor, borderRadius: BorderRadius.circular(10)),
      child: Row(children: <Widget>[
        Expanded(
            child: Text(
          '$message',
          style: TextStyle(color: Colors.white, fontSize: mFontSize),
        ))
      ]),
    );
  }
}
