import 'package:flutter/material.dart';
import 'package:loyalty_app/models/product_model.dart';
import 'package:loyalty_app/view/warranty/components/booking_confirm.dart';

class WarrantyCenter extends StatefulWidget {
  final DateTime _bookingDate;
  final String _time;
  final ProductModel product;

  WarrantyCenter(this._bookingDate, this._time, this.product);

  @override
  _WarrantyCenterState createState() => _WarrantyCenterState();
}

class _WarrantyCenterState extends State<WarrantyCenter> {
  List<String> centers = [
    'KTX Khu A',
    'KTX Khu B',
    'KTX Khu C',
    'KTX Khu D',
    'KTX Khu E',
    'KTX Khu F',
    'KTX Khu G',
    'KTX Khu H',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn trung tâm bảo hành"),
      ),
      body: ListView.builder(
        itemCount: centers.length,
        itemBuilder: (context, index) {
          return InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BookingConfirmed(widget._bookingDate, widget._time,
                        centers[index], widget.product);
                  },
                ),
              );
            },
            child: ListTile(
              title: Text('${centers[index]}'),
            ),
          );
        },
      ),
    );
  }
}
