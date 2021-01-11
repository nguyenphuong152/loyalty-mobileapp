import 'package:flutter/material.dart';
import 'package:loyalty_app/view/home/components/app_bar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Text("hello"),
    );
  }
}
