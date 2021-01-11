import 'package:flutter/material.dart';
import 'package:loyalty_app/view/point_transfer/components/body.dart';

class PointTransfer extends StatefulWidget {
  @override
  _PointTransferState createState() => _PointTransferState();
}

class _PointTransferState extends State<PointTransfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
