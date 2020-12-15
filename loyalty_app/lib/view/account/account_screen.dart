import 'package:flutter/material.dart';
import 'package:loyalty_app/view/account/components/body.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body());
  }
}
