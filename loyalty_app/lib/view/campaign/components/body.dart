import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/view/home/components/app_bar.dart';
import 'package:loyalty_app/component/gradient_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: homeAppBar(context), body: buildData());
  }

  Widget buildData() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: GradientCard(
          name: "tui",
          campaignActivity: "tessst ne",
          costInPoints: "54",
          startColor: Color(0xffa1c4fd),
          endColor: Color(0xffc2e9fb),
        ));
  }
}
