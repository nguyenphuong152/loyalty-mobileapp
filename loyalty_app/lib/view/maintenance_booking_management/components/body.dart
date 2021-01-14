import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_app/bloc/maintenance_booking_bloc.dart';
import 'package:loyalty_app/constant.dart';
import 'package:loyalty_app/models/maintenance_model.dart';
import 'package:loyalty_app/view/home/components/app_bar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final MaintenanceBookingBloc maintenanceBookingBloc =
      MaintenanceBookingBloc();
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
    return Scaffold(
      appBar: homeAppBar(context),
      body: StreamBuilder(
        stream: maintenanceBookingBloc.maintenanceBook,
        builder: (context, AsyncSnapshot<ListMaintenanceModel> snapshot) {
          if (snapshot.hasData) {
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
                flex: 6,
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
          Row(
            children: [
              Expanded(
                flex: 6,
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
          Row(
            children: [
              Expanded(
                flex: 10,
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
          Row(
            children: [
              Expanded(
                flex: 4,
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
              )
            ],
          ),
        ]));
  }
}
