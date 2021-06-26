import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/providers/chat/locator.dart';
import 'package:loyalty_app/providers/chat/provider_setup.dart';
import 'package:loyalty_app/view/account/account_screen.dart';
import 'package:loyalty_app/view/home/home_screen.dart';
import 'package:loyalty_app/view/booking_management/MaintenanceBookingManagement.dart';
import 'package:loyalty_app/view/support/supporting_screen.dart';
import 'package:loyalty_app/view/welcome/login/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: providers, child: StartApp());
  }
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Startup Name Generator',
      theme: ThemeData(
          primaryColor: mPrimaryColor, scaffoldBackgroundColor: Colors.white),
      home: LoginScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/maintenance': (context) => MaintenanceBookingManagementScreen(),
        '/account': (context) => AccountScreen(),
      },
    );
  }
}
