import 'package:flutter/material.dart';

class ModeratorCard extends StatelessWidget {
  const ModeratorCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/moderator.png")),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 300,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                )),
            child: Row(children: <Widget>[
              Expanded(
                child: Text(
                    'Voluptate esse elit veniam esse sunt nulla consectetur laboris ex mollit officia magna. Officia veniam velit mollit ipsum. Tempor ut consequat exercitation fugiat officia officia laboris elit enim nostrud mollit quis velit eiusmod. Minim deserunt nisi mollit aliquip do. Et exercitation ea magna duis quis cillum occaecat excepteur irure dolore do voluptate incididunt pariatur. Lorem ea pariatur tempor irure elit culpa velit amet ipsum officia qui. Aute ad adipisicing eu occaecat in proident duis consectetur aliqua nisi.'),
              )
            ]),
          )
        ],
      ),
    );
  }
}
