import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/chat/chat_message_model.dart';

class ModeratorCard extends StatelessWidget {
  final String message;
  const ModeratorCard({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          CircleAvatar(
              backgroundColor: Colors.grey[350],
              backgroundImage: AssetImage("assets/images/moderator.png")),
          SizedBox(
            width: 3,
          ),
          Container(
            width: 300,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10)),
            child: Row(children: <Widget>[
              Expanded(
                  child: Text(
                '$message',
                style: TextStyle(fontSize: mFontSize),
              ))
            ]),
          )
        ],
      ),
    );
  }
}
