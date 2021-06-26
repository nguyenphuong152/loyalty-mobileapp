import 'package:flutter/material.dart';
import 'package:loyalty_app/models/product_model.dart';
import 'package:loyalty_app/view/warranty/components/body.dart';

class WarrantyScreen extends StatefulWidget {
  final ProductModel product;

  WarrantyScreen(this.product);

  @override
  _WarrantyScreenState createState() => _WarrantyScreenState();
}

class _WarrantyScreenState extends State<WarrantyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body(widget.product));
  }
}
