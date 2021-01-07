import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:loyalty_app/bloc/card_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/customer_model.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // static Future<CustomerModel> cardBloc;
  // cardBloc =CardBloc().fetchCustomer('11111111-0000-474c-b092-b0dd880c07e1');

  @override
  void initState() {
    super.initState();
    CardBloc().fetchCustomer();
  }

  @override
  void dispose() {
    CardBloc().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Image.asset(
                "assets/images/imagecard.png",
                width: size.width * 0.9,
                height: size.width * 0.7,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: mPrimaryColor),
                borderRadius: BorderRadius.all(Radius.circular(10.0) //
                    ),
              ),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15.0),
              margin: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // const ListTile(
                  //   title: Text(
                  //     'Song Thi Meo',
                  //     style: TextStyle(fontSize: 20),
                  //   ),
                  // ),
                  StreamBuilder<CustomerModel>(
                      stream: CardBloc().customer,
                      builder:
                          (context, AsyncSnapshot<CustomerModel> snapshot) {
                        print(snapshot.connectionState);
                        if (snapshot.hasData) {
                          print("snapshot " + snapshot.toString());
                          return const ListTile(
                            title: Text(
                              'Song Thi Meo',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                  Container(
                    child: BarcodeWidget(
                      barcode: Barcode.code128(), // Barcode type and settings
                      data: '1111111321554646456', // Content
                      width: 310,
                      height: 100,
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
