import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_app/bloc/maintenance_booking_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/maintenance_model.dart';
import 'package:loyalty_app/models/product_model.dart';
import 'package:loyalty_app/view/booking_management/MaintenanceBookingManagement.dart';
import 'package:loyalty_app/view/warranty/edit_booking/edit_booking_screen.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final MaintenanceBookingBloc maintenanceBookingBloc =
      MaintenanceBookingBloc();
  String _time = "8:00";
  String _warrantyCenter = "KTX Khu B";
  String _maintenanceId;
  DateTime _createAt;
  ProductModel product;

  TextEditingController productSku = new TextEditingController();
  TextEditingController date = new TextEditingController();

  @override
  void initState() {
    super.initState();
    maintenanceBookingBloc.fetchListMaintenanceBook();
  }

  @override
  void dispose() {
    maintenanceBookingBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Thông tin đăng kí bảo trì',
          style: TextStyle(
            fontSize: mFontSize,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: maintenanceBookingBloc.maintenanceBook,
        builder: (context, AsyncSnapshot<ListMaintenanceModel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.total == 0) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    Text("Hiện tại bạn chưa có thông tin đăng kí nào!",
                        style:
                            TextStyle(color: Colors.grey, fontSize: mFontSize)),
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
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ListMaintenanceModel> snapshot) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: mDividerColor,
      ),
      itemCount: snapshot.data.total,
      itemBuilder: (context, index) {
        return bookingList(snapshot.data.maintenanceModels[index]);
      },
    );
  }

  Widget bookingList(MaintenanceModel maintenanceModel) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                flex: 10,
                child: Row(
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
                            .format(maintenanceModel.createdAt),
                        style: TextStyle(fontSize: 12, color: Colors.grey))
                  ],
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  "Mã sản phẩm",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 16,
                child: Text(maintenanceModel.productSku,
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  "Thời gian đến",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 16,
                child: Text(
                    DateFormat("dd-MM-yyyy")
                            .format(maintenanceModel.bookingDate) +
                        " " +
                        maintenanceModel.bookingTime,
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Text(
                  "Trung tâm bảo hành",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 16,
                child: Text(maintenanceModel.warrantyCenter,
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Text(
                  "Phí bảo trì",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 16,
                child: Text(maintenanceModel.cost,
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Text(
                  "Mô tả",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 16,
                child: Text(maintenanceModel.discription,
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Text(
                  "Tình trạng thanh toán",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 16,
                child: Text(maintenanceModel.paymentStatus,
                    style: TextStyle(
                        fontSize: mFontListTile, fontWeight: FontWeight.w700)),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  "Tình trạng",
                  style: TextStyle(fontSize: mFontListTile),
                ),
              ),
              Expanded(
                flex: 15,
                child: Text(maintenanceModel.active ? "Chưa đến" : "Đã đến",
                    style: TextStyle(
                        fontSize: mFontListTile,
                        fontWeight: FontWeight.w700,
                        color: maintenanceModel.active
                            ? Colors.red
                            : Colors.grey)),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            TextButton(
                child: const Text('Chỉnh sửa'),
                onPressed: () {
                  setState(() {
                    product = getProduct(maintenanceModel.productSku);
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditBookingScreen(
                        product,
                        maintenanceModel.bookingDate,
                        maintenanceModel.bookingTime,
                        maintenanceModel.warrantyCenter,
                        maintenanceModel.maintenanceId,
                        maintenanceModel.discription,
                        maintenanceModel.cost,
                        maintenanceModel.paymentStatus,
                        2);
                  }));
                }),
            maintenanceModel.paymentStatus == "unpaid"
                ? TextButton(
                    child: const Text('Thanh toán'),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return ProductDetailScreen(product);
                      //     },
                      //   ),
                      // );
                    },
                  )
                : SizedBox(width: 1),
            const SizedBox(width: 8)
          ])
        ]));
  }
}
