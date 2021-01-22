import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/providers/chat/locator.dart';
import 'package:loyalty_app/view/welcome/login/login_screen.dart';
import 'package:loyalty_app/view/welcome/welcomee/welcome_screen.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Startup Name Generator',
      theme: ThemeData(
          primaryColor: mPrimaryColor, scaffoldBackgroundColor: Colors.white),
      home: LoginScreen(),
    );
  }
}
