import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/view/stores/components/body.dart';

class GetMyStores extends StatefulWidget {
  @override
  _GetMyStoresState createState() => _GetMyStoresState();
}

class _GetMyStoresState extends State<GetMyStores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: mPrimaryColor,
              size: subhead,
            ),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Tìm cửa hàng',
          style: TextStyle(
            fontSize: subhead,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
