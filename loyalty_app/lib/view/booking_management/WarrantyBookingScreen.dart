import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_app/bloc/warranty_booking_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/product_model.dart';
import 'package:loyalty_app/models/warranty_model.dart';
import 'package:loyalty_app/view/warranty/edit_booking/edit_booking_screen.dart';

class WarrantyBookingManagement extends StatefulWidget {
  @override
  _WarrantyBookingManagementState createState() =>
      _WarrantyBookingManagementState();
}

class _WarrantyBookingManagementState extends State<WarrantyBookingManagement> {
  final WarrantyBookingBloc warrantyBookingBloc = WarrantyBookingBloc();
  ProductModel product;

  TextEditingController productSku = new TextEditingController();
  TextEditingController date = new TextEditingController();

  @override
  void initState() {
    super.initState();
    warrantyBookingBloc.fetchListWarrantyBook();
  }

  @override
  void dispose() {
    warrantyBookingBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            'Thông tin đăng ký bảo hành',
            style: TextStyle(
              fontSize: mFontSize,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: StreamBuilder(
          stream: warrantyBookingBloc.warrantyBook,
          builder: (context, AsyncSnapshot<ListWarrantyModel> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.total == 0) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                      ),
                      Text("Hiện tại bạn chưa có thông tin đăng kí nào!",
                          style: TextStyle(
                              color: Colors.grey, fontSize: mFontSize)),
                      SizedBox(
                        height: 20.0,
                      ),
                      SvgPicture.asset(
                        "assets/images/empty.svg",
                        height: size.height * 0.3,
                      ),
                    ],
                  ),
                );
              }
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget buildList(AsyncSnapshot<ListWarrantyModel> snapshot) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: mDividerColor,
      ),
      itemCount: snapshot.data.total,
      itemBuilder: (context, index) {
        return bookingList(snapshot.data.warrantyModels[index]);
      },
    );
  }

  Widget bookingList(WarrantyModel warrantyModel) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Column(children: [
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.clock,
                color: Colors.grey,
                size: 13,
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                  DateFormat("dd-MM-yyyy hh:mm a")
                      .format(warrantyModel.createdAt),
                  style: TextStyle(fontSize: 12, color: Colors.grey))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mã sản phẩm",
                    style: TextStyle(fontSize: mFontListTile),
                  ),
                  Text(
                    "Thời gian đến",
                    style: TextStyle(fontSize: mFontListTile),
                  ),
                  Text(
                    "Trung tâm bảo hành",
                    style: TextStyle(fontSize: mFontListTile),
                  ),
                  Text(
                    "Tình trạng",
                    style: TextStyle(fontSize: mFontListTile),
                  ),
                ],
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(warrantyModel.productSku,
                      style: TextStyle(
                          fontSize: mFontListTile,
                          fontWeight: FontWeight.w700)),
                  Text(
                      DateFormat("dd-MM-yyyy")
                              .format(warrantyModel.bookingDate) +
                          " " +
                          warrantyModel.bookingTime,
                      style: TextStyle(
                          fontSize: mFontListTile,
                          fontWeight: FontWeight.w700)),
                  Text(warrantyModel.warrantyCenter,
                      style: TextStyle(
                          fontSize: mFontListTile,
                          fontWeight: FontWeight.w700)),
                  Text(warrantyModel.active ? "Chưa đến" : "Đã đến",
                      style: TextStyle(
                          fontSize: mFontListTile,
                          fontWeight: FontWeight.w700,
                          color:
                              warrantyModel.active ? Colors.red : Colors.grey)),
                ],
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            TextButton(
                child: const Text('Chỉnh sửa'),
                onPressed: () {
                  setState(() {
                    product = getProduct(warrantyModel.productSku);
                  });
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return EditBookingScreen(
                          product,
                          warrantyModel.bookingDate,
                          warrantyModel.bookingTime,
                          warrantyModel.warrantyCenter,
                          warrantyModel.maintenanceId,
                          warrantyModel.discription,
                          warrantyModel.cost,
                          warrantyModel.paymentStatus,
                          1);
                    },
                  ));
                }),
            const SizedBox(width: 8)
          ])
        ]));
  }

  // Row(
  //         children: [
  //           Expanded(
  //             flex: 10,
  //             child:
  //           ),
  //         ],
  //       ),
  //       const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
  //       Row(
  //         children: [
  //           Expanded(
  //             flex: 8,
  //             child: Text(
  //               "Mã sản phẩm",
  //               style: TextStyle(fontSize: mFontListTile),
  //             ),
  //           ),
  //           Expanded(
  //             flex: 16,
  //             child:
  //           )
  //         ],
  //       ),
  //       const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
  //       Row(
  //         children: [
  //           Expanded(
  //             flex: 8,
  //             child:
  //           ),
  //           Expanded(
  //             flex: 16,
  //             child:
  //           )
  //         ],
  //       ),
  //       const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
  //       Row(
  //         children: [
  //           Expanded(
  //             flex: 12,
  //             child:
  //           ),
  //           Expanded(
  //             flex: 16,
  //             child:
  //           )
  //         ],
  //       ),
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.baseline,
  //         children: [
  //           Expanded(
  //             flex: 6,
  //             child:
  //           ),
  //           Expanded(
  //             flex: 15,
  //             child:
  //           ),
  //         ],
  //       ),

  //     ])
}
