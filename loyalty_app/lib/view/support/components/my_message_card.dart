import 'package:flutter/material.dart';

class MyMessageCard extends StatelessWidget {
  const MyMessageCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff7F7FD5),
            Color(0xff86A8E7),
            Color(0xff91EAE4),
          ], begin: Alignment.topLeft, end: Alignment.topRight),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
            bottomLeft: Radius.circular(28),
          )),
      child: Row(children: <Widget>[
        Expanded(
          child: Text(
              'Voluptate esse elit veniam esse sunt nulla consectetur laboris ex mollit officia magna. Officia veniam velit mollit ipsum. Tempor ut consequat exercitation fugiat officia officia laboris elit enim nostrud mollit quis velit eiusmod. Minim deserunt nisi mollit aliquip do. Et exercitation ea magna duis quis cillum occaecat excepteur irure dolore do voluptate incididunt pariatur. Lorem ea pariatur tempor irure elit culpa velit amet ipsum officia qui. Aute ad adipisicing eu occaecat in proident duis consectetur aliqua nisi.'),
        )
      ]),
    );
  }
}
