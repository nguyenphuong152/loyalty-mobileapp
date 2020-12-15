import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:loyalty_app/constant.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Image.asset(
                "assets/images/imagecard.png",
                width: size.width * 0.9,
                height: size.width * 0.7,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: mPrimaryColor),
                borderRadius: BorderRadius.all(Radius.circular(10.0) //
                    ),
              ),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15.0),
              margin: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    title: Text(
                      'Song Thi Meo',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    child: BarcodeWidget(
                      barcode: Barcode.code128(), // Barcode type and settings
                      data: '1111111321554646456', // Content
                      width: 310,
                      height: 100,
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
