import 'package:flutter/material.dart';
import 'package:loyalty_app/component/bottom_nav_bar.dart';
import 'package:loyalty_app/view/home/components/body.dart';

import 'components/app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      bottomNavigationBar: BottomNavBar(),
      body: Body(),
    );
  }
}
