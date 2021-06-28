import 'package:flutter/material.dart';
import 'package:loyalty_app/constant.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VoucherDetail extends StatefulWidget {
  final String status;
  final String code;
  final String time;
  VoucherDetail(this.status, this.code, this.time);

  @override
  _VoucherDetailState createState() => _VoucherDetailState();
}

class _VoucherDetailState extends State<VoucherDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: mPrimaryColor,
                size: 16,
              ),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  "/home", (Route<dynamic> route) => false)),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Voucher',
            style: TextStyle(
              fontSize: mFontSize,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Card(
                  color: Color(0xffd8e2dc),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              "Giảm 20% tối đa 100.000đ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              "Trạng thái",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              widget.status,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              "Hết hạn",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              widget.time,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      QrImage(
                        data: widget.code,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                      Center(
                        child: Text(widget.code),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
