import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/product_model.dart';
import 'package:loyalty_app/view/warranty/edit_booking/edit_booking_confirm.dart';

class EditWarrantyCenter extends StatefulWidget {
  final ProductModel product;
  final DateTime bookingDate;
  final String bookingTime;
  final String center;
  final String bookingNumber;
  final int typeBooking;
  final String dis;
  final String cost;
  final String paymentStatus;

  EditWarrantyCenter(
      this.product,
      this.bookingDate,
      this.bookingTime,
      this.center,
      this.bookingNumber,
      this.dis,
      this.cost,
      this.paymentStatus,
      this.typeBooking);

  @override
  _EditWarrantyCenterState createState() => _EditWarrantyCenterState();
}

class _EditWarrantyCenterState extends State<EditWarrantyCenter> {
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
        title: Text("Chọn trung tâm bảo hành",
            style: TextStyle(fontSize: subhead, fontWeight: FontWeight.w500)),
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
                    return EditBookingConfirm(
                        widget.product,
                        widget.bookingDate,
                        widget.bookingTime,
                        centers[index],
                        widget.bookingNumber,
                        widget.dis,
                        widget.cost,
                        widget.paymentStatus,
                        widget.typeBooking);
                  },
                ),
              );
            },
            child: ListTile(
              title: Text('${centers[index]}',
                  style: TextStyle(fontSize: subhead)),
            ),
          );
        },
      ),
    );
  }
}
