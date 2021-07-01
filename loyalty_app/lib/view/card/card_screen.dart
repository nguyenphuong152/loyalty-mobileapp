import 'package:flutter/material.dart';
import 'package:loyalty_app/models/customer_model.dart';
import 'package:loyalty_app/view/card/components/body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
